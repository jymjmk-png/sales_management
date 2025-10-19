<?php
// C:\xampp\htdocs\sales_management\api\sales.php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../classes/Functions.php';
require_once __DIR__ . '/../classes/Numbering.php';

header('Content-Type: application/json; charset=utf-8');

try {
  if ($_SERVER['REQUEST_METHOD'] !== 'POST') throw new Exception('POST only');

  $raw = file_get_contents('php://input');
  $data = json_decode($raw, true);
  if (!is_array($data)) throw new Exception('Invalid JSON');

  $pdo = db();
  $pdo->beginTransaction();

  $biz = $data['사업장코드'] ?? '01';
  $ymd = preg_replace('/[^0-9]/', '', $data['전표일자'] ?? date('Ymd'));
  $cust = trim($data['매출처코드'] ?? '');
  $memo = trim($data['비고'] ?? '');
  $user = 'APIU';

  if ($cust === '') throw new Exception('매출처코드 누락');

  $lines = $data['lines'] ?? [];
  if (!is_array($lines) || count($lines) === 0) throw new Exception('lines 누락');

  $sumS = $sumT = $sumG = 0;
  foreach ($lines as &$L) {
    $qty = (float)($L['수량'] ?? 0);
    $prc = (float)($L['단가'] ?? 0);
    $vat = (int)($L['과세구분'] ?? 1);
    list($s, $t, $g) = Functions::splitSupplyTax($qty, $prc, $vat);
    $L['공급가'] = $s;
    $L['세액'] = $t;
    $L['총액'] = $g;
    $sumS += $s;
    $sumT += $t;
    $sumG += $g;
  }

  $no = Numbering::next('sales_header', $biz, $ymd);

  $pdo->prepare("INSERT INTO sales_header(사업장코드,전표일자,전표번호,매출처코드,비고,합계공급가,합계세액,합계총액,작성자코드)
                 VALUES (?,?,?,?,?,?,?,?,?)")
    ->execute([$biz, $ymd, $no, $cust, $memo, $sumS, $sumT, $sumG, $user]);

  $seq = 1;
  $ins = $pdo->prepare("INSERT INTO sales_detail
    (사업장코드,전표일자,전표번호,순번,자재코드,자재명,규격,단위,수량,단가,공급가,세액,총액,과세구분,비고)
    VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
  foreach ($lines as $L) {
    $ins->execute([
      $biz,
      $ymd,
      $no,
      $seq++,
      $L['자재코드'] ?? '',
      $L['자재명'] ?? '',
      $L['규격'] ?? '',
      $L['단위'] ?? '',
      (float)$L['수량'],
      (float)$L['단가'],
      (int)$L['공급가'],
      (int)$L['세액'],
      (int)$L['총액'],
      (int)$L['과세구분'],
      $L['비고'] ?? ''
    ]);
  }

  $pdo->commit();
  echo json_encode(['ok' => true, '전표번호' => $no]);
} catch (Throwable $e) {
  if (isset($pdo) && $pdo->inTransaction()) $pdo->rollBack();
  http_response_code(400);
  echo json_encode(['ok' => false, 'error' => $e->getMessage()]);
}
