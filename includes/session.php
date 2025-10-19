<?php
require_once __DIR__ . '/../config/constants.php';  // ← 추가

if (session_status() !== PHP_SESSION_ACTIVE) session_start();

// 로그인 페이지/시드 스크립트에서는 체크 생략
$path = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '');
$isLoginPage = (strpos($path, '/modules/auth/login.php') !== false);
$isTool      = (strpos($path, '/tools/create_admin.php') !== false);

if (!$isLoginPage && !$isTool) {
  if (empty($_SESSION['user'])) {
    header('Location: ' . BASE_URL . '/modules/auth/login.php');
    exit;
  }
}
