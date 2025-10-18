<?php
// 프로젝트 루트/URL
define('BASE_PATH', 'C:/xampp/htdocs/sales_management');
define('BASE_URL',  'http://localhost/sales_management');

// 공통 출력 인코딩
mb_internal_encoding('UTF-8');

// CSRF 간단 토큰
function csrf_token()
{
  if (session_status() !== PHP_SESSION_ACTIVE) session_start();
  if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(16));
  return $_SESSION['csrf'];
}
function csrf_check()
{
  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (session_status() !== PHP_SESSION_ACTIVE) session_start();
    if (empty($_POST['csrf']) || $_POST['csrf'] !== ($_SESSION['csrf'] ?? '')) {
      http_response_code(400);
      header('Content-Type: application/json');
      exit(json_encode(['error' => 'Invalid CSRF token']));
    }
  }
}
