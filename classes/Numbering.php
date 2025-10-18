<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/Functions.php';

final class Numbering
{
    private static $allowedTables = [
        '매출전표',
        '매입전표',
        '견적서'
    ];

    public static function next(string $table, string $biz, string $ymd): int {
        // Validate table name
        if (!in_array($table, self::$allowedTables, true)) {
            throw new InvalidArgumentException('유효하지 않은 테이블명입니다');
        }

        $scope = strtoupper(Functions::getParam('DOC_SEQ_SCOPE','DATE')); // DATE|YEAR
        $pdo = db();
        $pdo->beginTransaction();
        try {
            if ($scope === 'YEAR') {
                $stmt = $pdo->prepare("SELECT IFNULL(MAX(전표번호),0)+1 FROM {$table} WHERE 사업장코드=? AND LEFT(전표일자,4)=LEFT(?,4)");
                $stmt->execute([$biz,$ymd]);
            } else {
                $stmt = $pdo->prepare("SELECT IFNULL(MAX(전표번호),0)+1 FROM {$table} WHERE 사업장코드=? AND 전표일자=?");
                $stmt->execute([$biz,$ymd]);
            }
            $nxt = (int)$stmt->fetchColumn();
            $pdo->commit();
            return $nxt ?: 1;
        } catch(Exception $e){
            $pdo->rollBack(); throw $e;
        }
    }
}
