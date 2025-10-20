<?php
// C:\xampp\htdocs\sales_management\classes\Functions.php
require_once __DIR__ . '/../config/database.php';

final class Functions
{
  public static function getParam(string $key, $default = null)
  {
    static $cache = null;
    // DB 연결
    $db = new Database();
    $conn = $db->getConnection();
    $pdo = $conn;
    $pdo->beginTransaction();
    if ($cache === null) {
      $cache = [];
      try {
        $stmt = $pdo->query("SELECT 키, 값 FROM 시스템설정");
        foreach ($stmt as $r) $cache[$r['키']] = $r['값'];
        $nxt = (int)$stmt->fetchColumn();
        $pdo->commit();
      } catch (\Throwable $e) {
        // 시스템설정 테이블이 없으면 기본값 사용
        if ($pdo->inTransaction()) $pdo->rollBack();
        throw $e;
      }
    }
    return $cache[$key] ?? $default;
  }

  public static function taxRate(): float
  {
    return (float) self::getParam('TAX_RATE', 0.1); // 기본 10%
  }

  /** 반올림 규칙: ROUND|FLOOR|CEIL, scale: 소수 자릿수 */
  public static function r($v, string $what = 'AMT', int $scale = 0): float
  {
    $mode = strtoupper(self::getParam("ROUND_{$what}", 'ROUND'));
    $m = pow(10, $scale);
    $x = (float)$v * $m;
    if ($mode === 'FLOOR') $x = floor($x);
    elseif ($mode === 'CEIL') $x = ceil($x);
    else $x = round($x);
    return $x / $m;
  }

  /** (수량, 단가, 과세구분) → [공급가, 세액, 총액] */
  public static function splitSupplyTax(float $qty, float $price, int $vatFlag = 1): array
  {
    $qty   = self::r($qty,   'QTY',   4);
    $price = self::r($price, 'PRICE', 4);
    $amt   = self::r($qty * $price,   'AMT',   0);
    if ($vatFlag === 0) return [$amt, 0.0, $amt];
    $tax = self::r($amt * self::taxRate(), 'AMT', 0);
    return [$amt, $tax, $amt + $tax];
  }

  /** 총액 입력형(수량, 총액, 과세구분) → [공급가, 세액, 총액] */
  public static function splitFromGross(float $qty, float $gross, int $vatFlag = 1): array
  {
    $qty   = self::r($qty,   'QTY', 4);
    $gross = self::r($gross, 'AMT', 0);
    if ($vatFlag === 0) return [$gross, 0.0, $gross];
    $rate    = self::taxRate();
    $supply  = self::r($gross / (1 + $rate), 'AMT', 0);
    $tax     = $gross - $supply;
    return [$supply, $tax, $gross];
  }
}
