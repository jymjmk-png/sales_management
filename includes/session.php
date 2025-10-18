<?php
if (session_status() !== PHP_SESSION_ACTIVE) session_start();

// Check if user is logged in, redirect to login if not
if (empty($_SESSION['user'])) {
    // Allow bypassing auth only in development
    if (getenv('APP_ENV') === 'development') {
        $_SESSION['user'] = ['사용자코드' => 'dev-admin', '이름' => '개발자'];
    } else {
        header('Location: ' . BASE_URL . '/modules/auth/login.php');
        exit();
    }
}
