<?php
function db(): PDO
{
  static $pdo = null;
  if ($pdo) return $pdo;
  $host = getenv('DB_HOST') ?: '127.0.0.1';
  $db   = getenv('DB_NAME') ?: 'sales_management';
  $user = getenv('DB_USER') ?: 'root';
  $pass = getenv('DB_PASS') ?: '1234';  // Default only for development
  $dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";
  $opt = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
  ];
  $pdo = new PDO($dsn, $user, $pass, $opt);
  $pdo->query("SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci");
  return $pdo;
}
