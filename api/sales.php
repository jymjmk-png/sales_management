<?php
header("Content-Type: application/json; charset=utf-8");
require_once "../config/database.php";
require_once "../classes/Functions.php";
require_once "../classes/Numbering.php";

$action = $_REQUEST['action'] ?? '';
$page = intval($_GET['page'] ?? 1);
$limit = intval($_GET['limit'] ?? 10);
$offset = ($page - 1) * $limit;

$database = new Database();
$pdo = $database->getConnection();

if ($action === 'create') {
  try {
    $raw = file_get_contents('php://input');
    $data = json_decode($raw, true);
    if (!is_array($data)) throw new Exception('Invalid JSON');
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
    echo json_encode(['message' => '매출전표가 등록되었습니다.', '전표번호' => $no]);
    exit;
  } catch (Throwable $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    http_response_code(400);
    echo json_encode(['error' => $e->getMessage()]);
    exit;
  }
}

// 매출전표 목록
if ($action === 'list') {
  try {
    $stmt = $pdo->prepare("SELECT SQL_CALC_FOUND_ROWS 
                            h.사업장코드, h.전표일자, h.전표번호, h.매출처코드, 
                            c.상호 as 매출처명, h.합계공급가, h.합계세액, h.합계총액, 
                            h.작성자코드, h.작성일시 
                          FROM sales_header h 
                          LEFT JOIN customer c ON h.매출처코드 = c.거래처코드 
                          ORDER BY h.전표일자 DESC, h.전표번호 DESC 
                          LIMIT :offset, :limit");
    $stmt->bindValue(":offset", $offset, PDO::PARAM_INT);
    $stmt->bindValue(":limit", $limit, PDO::PARAM_INT);
    $stmt->execute();
    
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $total = $pdo->query("SELECT FOUND_ROWS() as total")->fetch()['total'];
    
    echo json_encode(["data" => $data, "total" => $total]);
    exit;
  } catch (Throwable $e) {
    http_response_code(400);
    echo json_encode(['error' => $e->getMessage()]);
    exit;
  }
}

// 매출전표 상세조회
if ($action === 'detail') {
  try {
    $biz = $_GET['사업장코드'] ?? '';
    $date = $_GET['전표일자'] ?? '';
    $no = $_GET['전표번호'] ?? '';
    
    if (!$biz || !$date || !$no) throw new Exception('필수 파라미터가 누락되었습니다.');

    $header = $pdo->prepare("SELECT h.*, c.상호 as 매출처명 
                            FROM sales_header h 
                            LEFT JOIN customer c ON h.매출처코드 = c.거래처코드 
                            WHERE h.사업장코드 = ? AND h.전표일자 = ? AND h.전표번호 = ?");
    $header->execute([$biz, $date, $no]);
    $headerData = $header->fetch(PDO::FETCH_ASSOC);

    if (!$headerData) throw new Exception('존재하지 않는 전표입니다.');

    $detail = $pdo->prepare("SELECT * FROM sales_detail 
                            WHERE 사업장코드 = ? AND 전표일자 = ? AND 전표번호 = ? 
                            ORDER BY 순번");
    $detail->execute([$biz, $date, $no]);
    $detailData = $detail->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
      'header' => $headerData,
      'detail' => $detailData
    ]);
    exit;
  } catch (Throwable $e) {
    http_response_code(400);
    echo json_encode(['error' => $e->getMessage()]);
    exit;
  }
}

// 잘못된 action 처리
echo json_encode(["error" => "잘못된 요청입니다."]);
exit;
