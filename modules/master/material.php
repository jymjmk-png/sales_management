<?php
// C:\xampp\htdocs\sales_management\modules\master\material.php
require_once __DIR__ . '/../../includes/session.php';
require_once __DIR__ . '/../../includes/header.php';
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../config/constants.php';

csrf_check();
$pdo = db();

$mode   = $_POST['mode']   ?? $_GET['mode']   ?? '';
$search = trim($_GET['q'] ?? '');
$msg = '';
$err = '';

try {
  if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['csrf']) && $_POST['csrf'] === ($_SESSION['csrf'] ?? '')) {
    $분류코드   = trim($_POST['분류코드'] ?? '');
    $세부코드   = trim($_POST['세부코드'] ?? '');
    $자재명     = trim($_POST['자재명'] ?? '');
    $규격       = trim($_POST['규격'] ?? '');
    $단위       = trim($_POST['단위'] ?? '');
    $과세구분   = (int)($_POST['과세구분'] ?? 1);  // 1 과세, 0 면세
    $사용구분   = (int)($_POST['사용구분'] ?? 1);  // 1 사용, 0 미사용

    if ($분류코드 === '' || $세부코드 === '' || $자재명 === '') {
      throw new Exception('분류코드, 세부코드, 자재명은 필수입니다.');
    }

    if ($mode === 'create') {
      $sql = "INSERT INTO 자재 (분류코드,세부코드,자재명,규격,단위,과세구분,사용구분)
                    VALUES (?,?,?,?,?,?,?)";
      $stmt = $pdo->prepare($sql);
      $stmt->execute([$분류코드, $세부코드, $자재명, $규격, $단위, $과세구분, $사용구분]);
      $msg = '자재가 등록되었습니다.';
    } elseif ($mode === 'update') {
      $old분류코드 = trim($_POST['old분류코드'] ?? '');
      $old세부코드 = trim($_POST['old세부코드'] ?? '');
      if ($old분류코드 === '' || $old세부코드 === '') throw new Exception('수정 대상 키가 없습니다.');

      $sql = "UPDATE 자재
                       SET 분류코드=?, 세부코드=?, 자재명=?, 규격=?, 단위=?, 과세구분=?, 사용구분=?
                     WHERE 분류코드=? AND 세부코드=?";
      $stmt = $pdo->prepare($sql);
      $stmt->execute([$분류코드, $세부코드, $자재명, $규격, $단위, $과세구분, $사용구분, $old분류코드, $old세부코드]);
      $msg = '자재가 수정되었습니다.';
    }
  } elseif ($mode === 'delete') {
    $분류코드 = trim($_GET['분류코드'] ?? '');
    $세부코드 = trim($_GET['세부코드'] ?? '');
    if ($분류코드 === '' || $세부코드 === '') throw new Exception('삭제 대상 키가 없습니다.');
    $stmt = $pdo->prepare("DELETE FROM 자재 WHERE 분류코드=? AND 세부코드=?");
    $stmt->execute([$분류코드, $세부코드]);
    $msg = '자재가 삭제되었습니다.';
  }
} catch (Throwable $e) {
  $err = $e->getMessage();
}

// 조회
$params = [];
$sqlList = "SELECT 분류코드,세부코드,자재명,규격,단위,과세구분,사용구분
            FROM 자재 ";
if ($search !== '') {
  $sqlList .= "WHERE 자재명 LIKE ? OR 세부코드 LIKE ? OR 분류코드 LIKE ? ";
  $params = ["%$search%", "%$search%", "%$search%"];
}
$sqlList .= "ORDER BY 분류코드, 세부코드 LIMIT 200";
$rows = $pdo->prepare($sqlList);
$rows->execute($params);
$list = $rows->fetchAll();
?>
<div class="d-flex justify-content-between align-items-center mb-3">
  <h3 class="m-0">자재 관리</h3>
  <form class="d-flex" method="get">
    <input class="form-control form-control-sm me-2" name="q" placeholder="자재명/코드 검색" value="<?= htmlspecialchars($search) ?>">
    <button class="btn btn-sm btn-outline-secondary">검색</button>
  </form>
</div>

<?php if ($msg): ?><div class="alert alert-success py-2"><?= htmlspecialchars($msg) ?></div><?php endif; ?>
<?php if ($err): ?><div class="alert alert-danger py-2"><?= htmlspecialchars($err) ?></div><?php endif; ?>

<div class="card mb-3">
  <div class="card-body">
    <form method="post" class="row g-2">
      <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
      <input type="hidden" name="mode" value="create">
      <div class="col-2">
        <label class="form-label">분류코드</label>
        <input name="분류코드" maxlength="2" class="form-control form-control-sm" required>
      </div>
      <div class="col-3">
        <label class="form-label">세부코드</label>
        <input name="세부코드" maxlength="16" class="form-control form-control-sm" required>
      </div>
      <div class="col-4">
        <label class="form-label">자재명</label>
        <input name="자재명" class="form-control form-control-sm" required>
      </div>
      <div class="col-3">
        <label class="form-label">규격</label>
        <input name="규격" class="form-control form-control-sm">
      </div>
      <div class="col-2">
        <label class="form-label">단위</label>
        <input name="단위" class="form-control form-control-sm">
      </div>
      <div class="col-2">
        <label class="form-label">과세구분</label>
        <select name="과세구분" class="form-select form-select-sm">
          <option value="1">과세</option>
          <option value="0">면세</option>
        </select>
      </div>
      <div class="col-2">
        <label class="form-label">사용구분</label>
        <select name="사용구분" class="form-select form-select-sm">
          <option value="1">사용</option>
          <option value="0">미사용</option>
        </select>
      </div>
      <div class="col-2 align-self-end">
        <button class="btn btn-sm btn-primary w-100">등록</button>
      </div>
    </form>
  </div>
</div>

<div class="table-responsive">
  <table class="table table-sm table-striped align-middle">
    <thead class="table-light">
      <tr>
        <th>분류</th>
        <th>세부</th>
        <th>자재명</th>
        <th>규격</th>
        <th>단위</th>
        <th>과세</th>
        <th>사용</th>
        <th style="width:180px">작업</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($list as $r): ?>
        <tr>
          <form method="post" class="row g-1">
            <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
            <input type="hidden" name="mode" value="update">
            <input type="hidden" name="old분류코드" value="<?= htmlspecialchars($r['분류코드']) ?>">
            <input type="hidden" name="old세부코드" value="<?= htmlspecialchars($r['세부코드']) ?>">

            <td><input name="분류코드" value="<?= htmlspecialchars($r['분류코드']) ?>" class="form-control form-control-sm" maxlength="2" required></td>
            <td><input name="세부코드" value="<?= htmlspecialchars($r['세부코드']) ?>" class="form-control form-control-sm" maxlength="16" required></td>
            <td><input name="자재명" value="<?= htmlspecialchars($r['자재명']) ?>" class="form-control form-control-sm" required></td>
            <td><input name="규격" value="<?= htmlspecialchars($r['규격']) ?>" class="form-control form-control-sm"></td>
            <td><input name="단위" value="<?= htmlspecialchars($r['단위']) ?>" class="form-control form-control-sm"></td>
            <td>
              <select name="과세구분" class="form-select form-select-sm">
                <option value="1" <?= $r['과세구분'] ? 'selected' : '' ?>>과세</option>
                <option value="0" <?= !$r['과세구분'] ? 'selected' : '' ?>>면세</option>
              </select>
            </td>
            <td>
              <select name="사용구분" class="form-select form-select-sm">
                <option value="1" <?= $r['사용구분'] ? 'selected' : '' ?>>사용</option>
                <option value="0" <?= !$r['사용구분'] ? 'selected' : '' ?>>미사용</option>
              </select>
            </td>
            <td class="text-nowrap">
              <button class="btn btn-sm btn-outline-primary">저장</button>
              <a class="btn btn-sm btn-outline-danger"
                href="?mode=delete&분류코드=<?= urlencode($r['분류코드']) ?>&세부코드=<?= urlencode($r['세부코드']) ?>"
                onclick="return confirm('삭제하시겠습니까?')">삭제</a>
            </td>
          </form>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<?php include __DIR__ . '/../../includes/footer.php'; ?>