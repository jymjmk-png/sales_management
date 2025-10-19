<?php
// 세션 및 인증 확인
include_once "../session.php";
?>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><?= $pageTitle ?? 'Sales Management System' ?></title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 flex">

  <!-- 사이드바 -->
  <aside class="w-64 bg-gray-800 text-white flex flex-col h-screen">
    <div class="p-4 text-xl font-bold border-b border-gray-700">
      판매관리시스템
    </div>
    <nav class="flex-1 p-2 space-y-2">
      <a href="/customer.php" class="block px-4 py-2 rounded hover:bg-gray-700">거래처관리</a>
      <a href="/product.php" class="block px-4 py-2 rounded hover:bg-gray-700">제품관리</a>
      <a href="/employee.php" class="block px-4 py-2 rounded hover:bg-gray-700">사원관리</a>
      <a href="/sales.php" class="block px-4 py-2 rounded hover:bg-gray-700">매출관리</a>
      <a href="/purchase.php" class="block px-4 py-2 rounded hover:bg-gray-700">매입관리</a>
    </nav>
    <div class="p-4 border-t border-gray-700">
      <a href="/logout.php" class="text-sm text-gray-300 hover:text-white">로그아웃</a>
    </div>
  </aside>

  <!-- 메인 컨텐츠 -->
  <main class="flex-1 p-6 overflow-y-auto">
    <header class="flex justify-between items-center mb-6">
      <h1 class="text-2xl font-semibold text-gray-700"><?= $pageTitle ?? '' ?></h1>
      <span class="text-sm text-gray-500">사용자: <?= $_SESSION['user_name'] ?? '관리자' ?></span>
    </header>

    <!-- 컨텐츠 영역 -->
    <section class="bg-white p-6 rounded-2xl shadow-md">
      <?php if (isset($content)) echo $content; ?>
    </section>

  </main>
</body>

</html>