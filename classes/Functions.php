<?php
require_once __DIR__ . '/../config/database.php';

final class Functions
{
  public static function getParam(string $key, $default = null)
  {
    static $cache = null;
    if ($cache === null) {
      $cache = [];
      // 시스템설정 테이블이 없으면 기본값만 사용
      try {
        $stmt = db()->query("SELECT 키, 값 FROM 시스템설정");
        foreach ($stmt as $r) $cache[$r['키']] = $r['값'];
      } catch (Throwable $e) { /* ignore */
      }
    }
    return $cache[$key] ?? $default;
  }

  public static function taxRate(): float
  {
    return (float) self::getParam('TAX_RATE', 0.1); // 기본 10%
  }

  public static function r($v, string $what = 'AMT', int $scale = 0): float
  {
    $mode = strtoupper(self::getParam("ROUND_{$what}", 'ROUND')); // ROUND|FLOOR|CEIL
    $m = pow(10, $scale);
    $x = (float)$v * $m;
    if ($mode === 'FLOOR') $x = floor($x);
    elseif ($mode === 'CEIL') $x = ceil($x);
    else $x = round($x);
    return $x / $m;
  }

  public static function splitSupplyTax(float $qty, float $price, int $vatFlag = 1): array
  {
    $qty  = self::r($qty,  'QTY',   4);
    $price = self::r($price, 'PRICE', 4);
    $amt  = self::r($qty * $price, 'AMT', 0);
    if ($vatFlag === 0) return [$amt, 0.0, $amt];
    $rate = self::taxRate();
    $tax  = self::r($amt * $rate, 'AMT', 0);
    return [$amt, $tax, $amt + $tax];
  }

  public static function splitFromGross(float $qty, float $gross, int $vatFlag = 1): array
  {
    $qty = self::r($qty, 'QTY', 4);
    $gross = self::r($gross, 'AMT', 0);
    if ($vatFlag === 0) return [$gross, 0.0, $gross];
    $rate = self::taxRate();
    $supply = self::r($gross / (1 + $rate), 'AMT', 0);
    $tax = $gross - $supply;
    return [$supply, $tax, $gross];
  }
}
