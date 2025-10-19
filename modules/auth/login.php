<?php
require_once __DIR__ . '/../../includes/session.php';
require_once __DIR__ . '/../../config/constants.php';
require_once __DIR__ . '/../../config/database.php';

$err = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $id = trim($_POST['id'] ?? '');
  $pw = trim($_POST['pw'] ?? '');
  try {
    if ($id === '' || $pw === '') throw new Exception('아이디/비밀번호를 입력하세요.');
    $pdo = db();
    $stmt = $pdo->prepare("SELECT 사용자코드,아이디,비밀번호,이름,권한,사용여부 FROM 사용자 WHERE 아이디=?");
    $stmt->execute([$id]);
    $u = $stmt->fetch();
    if (!$u) throw new Exception('존재하지 않는 아이디입니다.');
    if ((int)$u['사용여부'] !== 1) throw new Exception('사용중지 계정입니다.');
    if (!password_verify($pw, $u['비밀번호'])) throw new Exception('비밀번호가 일치하지 않습니다.');

    $_SESSION['user'] = [
      '사용자코드' => $u['사용자코드'],
      '아이디'     => $u['아이디'],
      '이름'       => $u['이름'],
      '권한'       => $u['권한'],
    ];
    header('Location: ' . BASE_URL . '/index.php');
    exit;
  } catch (Throwable $e) {
    $err = $e->getMessage();
  }
}
?>
<!doctype html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <title>로그인 - 판매관리</title>
  <link rel="stylesheet" href="<?= BASE_URL ?>/assets/css/bootstrap.min.css">
  <style>
    body {
      background: #f6f7fb;
    }

    .login-card {
      max-width: 380px;
      margin: 10vh auto;
      padding: 24px;
      border-radius: 12px;
      background: #fff;
      box-shadow: 0 6px 18px rgba(0, 0, 0, .06);
    }
  </style>
</head>

<body>
  <div class="login-card">
    <h5 class="mb-3">판매관리 로그인</h5>
    <?php if ($err): ?><div class="alert alert-danger py-2"><?= htmlspecialchars($err) ?></div><?php endif; ?>
    <form method="post">
      <div class="mb-2">
        <label class="form-label">아이디</label>
        <input name="id" class="form-control" autofocus>
      </div>
      <div class="mb-3">
        <label class="form-label">비밀번호</label>
        <input type="password" name="pw" class="form-control">
      </div>
      <button class="btn btn-primary w-100">로그인</button>
    </form>
    <div class="text-muted small mt-3">초기 계정: admin / 1234 (시드 스크립트 실행)</div>
  </div>
</body>

</html>