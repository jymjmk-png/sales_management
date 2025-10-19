<?php
require_once __DIR__ . '/../../config/constants.php';
if (session_status() !== PHP_SESSION_ACTIVE) session_start();
$_SESSION = [];
session_destroy();
header('Location: ' . BASE_URL . '/modules/auth/login.php');
exit;
