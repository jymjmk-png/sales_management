<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/Functions.php';

final class Numbering
{
  /** 테이블명 안전 검증(영문/숫자/언더스코어만) + 백틱 감싸기 */
  private static function safeTable(string $table): string
  {
    if (!preg_match('/^[A-Za-z0-9_]+$/', $table)) {
      throw new InvalidArgumentException('유효하지 않은 테이블명입니다');
    }
    return "`{$table}`";
  }

  /** 전표번호 채번: DOC_SEQ_SCOPE = DATE | YEAR (시스템설정 키) */
  public static function next(string $table, string $biz, string $ymd): int
  {
    // DB 연결
    $db = new Database();
    $conn = $db->getConnection();
    $pdo = $conn;
    $tableSafe = self::safeTable($table);
    $scope = strtoupper(Functions::getParam('DOC_SEQ_SCOPE', 'DATE'));

    $pdo->beginTransaction();
    try {
      if ($scope === 'YEAR') {
        $sql  = "SELECT IFNULL(MAX(전표번호),0)+1
                         FROM {$tableSafe}
                         WHERE 사업장코드=? AND LEFT(전표일자,4)=LEFT(?,4)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$biz, $ymd]);
      } else {
        $sql  = "SELECT IFNULL(MAX(전표번호),0)+1
                         FROM {$tableSafe}
                         WHERE 사업장코드=? AND 전표일자=?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$biz, $ymd]);
      }
      $nxt = (int)$stmt->fetchColumn();
      $pdo->commit();
      return $nxt ?: 1;
    } catch (\Throwable $e) {
      if ($pdo->inTransaction()) $pdo->rollBack();
      throw $e;
    }
  }
}
