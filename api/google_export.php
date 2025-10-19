<?php
header("Content-Type: application/json; charset=utf-8");
require_once '../vendor/autoload.php'; // Google API Client

use Google\Client;
use Google\Service\Sheets;

$data = json_decode(file_get_contents("php://input"), true);

if (!$data || !isset($data['data'])) {
  echo json_encode(["error" => "데이터가 없습니다."]);
  exit;
}

$client = new Client();
$client->setApplicationName('Sales Management Export');
$client->setScopes([Sheets::SPREADSHEETS]);
$client->setAuthConfig('../config/google-service-account.json');

$service = new Sheets($client);

$spreadsheetId = "여기에_구글_시트_ID_입력";
$sheetName = $data['sheetName'];

$values = [];
foreach ($data['data'] as $row) {
  $values[] = array_values($row);
}

$body = new Sheets\ValueRange(['values' => $values]);
$params = ['valueInputOption' => 'RAW'];

$service->spreadsheets_values->update(
  $spreadsheetId,
  "{$sheetName}!A1",
  $body,
  $params
);

echo json_encode(["message" => "Google Sheets로 데이터 전송 완료"]);
