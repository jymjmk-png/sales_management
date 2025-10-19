<?php
require_once __DIR__ . '/../config/constants.php';
?>
<!doctype html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <title>판매관리 시스템</title>

  <!-- ✅ CSS 경로 수정 -->
  <link href="<?= BASE_URL ?>/assets/css/bootstrap.min.css" rel="stylesheet">
  <link href="<?= BASE_URL ?>/assets/css/custom.css" rel="stylesheet">
  <link href="<?= BASE_URL ?>/assets/css/responsive.css" rel="stylesheet">
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
      <a class="navbar-brand" href="<?= BASE_URL ?>/index.php">판매관리</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <?php require_once __DIR__ . '/navigation.php'; ?>
        </ul>

        <!-- ✅ 로그인/로그아웃 표시 -->
        <ul class="navbar-nav ms-auto">
          <?php if (!empty($_SESSION['user'])): ?>
            <li class="nav-item">
              <span class="nav-link">안녕하세요, <?= htmlspecialchars($_SESSION['user']['이름']) ?>님</span>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="<?= BASE_URL ?>/modules/auth/logout.php">로그아웃</a>
            </li>
          <?php else: ?>
            <li class="nav-item">
              <a class="nav-link" href="<?= BASE_URL ?>/modules/auth/login.php">로그인</a>
            </li>
          <?php endif; ?>
        </ul>
      </div>
    </div>
  </nav>