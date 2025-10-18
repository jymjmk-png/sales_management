<?php require_once __DIR__ . '/../config/constants.php'; ?>
<!doctype html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>판매관리 웹</title>
  <link href="<?= BASE_URL ?>/assets/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="<?= BASE_URL ?>/index.php">판매관리</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div id="nav" class="collapse navbar-collapse">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <?php include __DIR__ . '/navigation.php'; ?>
        </ul>
        <span class="navbar-text text-light small">
          <?= htmlspecialchars($_SESSION['user']['이름'] ?? 'Guest') ?>
        </span>
      </div>
    </div>
  </nav>
  <main class="container py-3">