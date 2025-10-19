<?php
// CLI/브라우저 모두 가능: http://localhost/sales_management/tools/create_admin.php
require_once __DIR__ . '/../config/database.php';

try {
  $pdo = db();
  // 이미 있으면 패스
  $exists = $pdo->query("SELECT COUNT(*) FROM 사용자 WHERE 아이디='admin'")->fetchColumn();
  if ($exists > 0) {
    echo "admin 계정이 이미 존재합니다.\n";
    exit;
  }
  $hash = password_hash('1234', PASSWORD_BCRYPT);
  $stmt = $pdo->prepare("INSERT INTO 사용자(사용자코드,아이디,비밀번호,이름,권한,사용여부) VALUES(?,?,?,?,?,1)");
  $stmt->execute(['0001', 'admin', $hash, '관리자', 'admin']);
  echo "admin/1234 계정 생성 완료\n";
} catch (Throwable $e) {
  http_response_code(500);
  echo $e->getMessage();
}
