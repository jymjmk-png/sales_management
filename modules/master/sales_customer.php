<?php
// C:\xampp\htdocs\sales_management\modules\master\sales_customer.php
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
  if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['csrf'] ?? '') === ($_SESSION['csrf'] ?? '')) {
    $사업장코드 = trim($_POST['사업장코드'] ?? '01');
    $매출처코드 = trim($_POST['매출처코드'] ?? '');
    $매출처명   = trim($_POST['매출처명'] ?? '');
    $전화       = trim($_POST['전화'] ?? '');
    $주소1      = trim($_POST['주소1'] ?? '');
    $주소2      = trim($_POST['주소2'] ?? '');
    $사용구분   = (int)($_POST['사용구분'] ?? 1);

    if ($매출처코드 === '' || $매출처명 === '') throw new Exception('매출처코드/매출처명은 필수입니다.');

    if ($mode === 'create') {
      $sql = "INSERT INTO 매출처 (사업장코드,매출처코드,매출처명,전화,주소1,주소2,사용구분)
                    VALUES (?,?,?,?,?,?,?)";
      $pdo->prepare($sql)->execute([$사업장코드, $매출처코드, $매출처명, $전화, $주소1, $주소2, $사용구분]);
      $msg = '매출처가 등록되었습니다.';
    } elseif ($mode === 'update') {
      $old사업장코드 = trim($_POST['old사업장코드'] ?? '');
      $old매출처코드 = trim($_POST['old매출처코드'] ?? '');
      if ($old사업장코드 === '' || $old매출처코드 === '') throw new Exception('수정 대상 키가 없습니다.');
      $sql = "UPDATE 매출처
                       SET 사업장코드=?, 매출처코드=?, 매출처명=?, 전화=?, 주소1=?, 주소2=?, 사용구분=?
                     WHERE 사업장코드=? AND 매출처코드=?";
      $pdo->prepare($sql)->execute([$사업장코드, $매출처코드, $매출처명, $전화, $주소1, $주소2, $사용구분, $old사업장코드, $old매출처코드]);
      $msg = '매출처가 수정되었습니다.';
    }
  } elseif ($mode === 'delete') {
    $사업장코드 = trim($_GET['사업장코드'] ?? '');
    $매출처코드 = trim($_GET['매출처코드'] ?? '');
    if ($사업장코드 === '' || $매출처코드 === '') throw new Exception('삭제 대상 키가 없습니다.');
    $pdo->prepare("DELETE FROM 매출처 WHERE 사업장코드=? AND 매출처코드=?")->execute([$사업장코드, $매출처코드]);
    $msg = '매출처가 삭제되었습니다.';
  }
} catch (Throwable $e) {
  $err = $e->getMessage();
}

// 조회
$params = [];
$sql = "SELECT 사업장코드,매출처코드,매출처명,전화,주소1,주소2,사용구분 FROM 매출처 ";
if ($search !== '') {
  $sql .= "WHERE 매출처명 LIKE ? OR 매출처코드 LIKE ? ";
  $params = ["%$search%", "%$search%"];
}
$sql .= "ORDER BY 매출처명 LIMIT 200";
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$list = $stmt->fetchAll();
?>
<div class="d-flex justify-content-between align-items-center mb-3">
  <h3 class="m-0">매출처 관리</h3>
  <form class="d-flex" method="get">
    <input class="form-control form-control-sm me-2" name="q" placeholder="매출처명/코드 검색" value="<?= htmlspecialchars($search) ?>">
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
        <label class="form-label">사업장코드</label>
        <input name="사업장코드" value="01" maxlength="2" class="form-control form-control-sm" required>
      </div>
      <div class="col-3">
        <label class="form-label">매출처코드</label>
        <input name="매출처코드" maxlength="8" class="form-control form-control-sm" required>
      </div>
      <div class="col-4">
        <label class="form-label">매출처명</label>
        <input name="매출처명" class="form-control form-control-sm" required>
      </div>
      <div class="col-3">
        <label class="form-label">전화</label>
        <input name="전화" class="form-control form-control-sm">
      </div>
      <div class="col-4">
        <label class="form-label">주소1</label>
        <input name="주소1" class="form-control form-control-sm">
      </div>
      <div class="col-4">
        <label class="form-label">주소2</label>
        <input name="주소2" class="form-control form-control-sm">
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
        <th>사업장</th>
        <th>코드</th>
        <th>명</th>
        <th>전화</th>
        <th>주소</th>
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
            <input type="hidden" name="old사업장코드" value="<?= htmlspecialchars($r['사업장코드']) ?>">
            <input type="hidden" name="old매출처코드" value="<?= htmlspecialchars($r['매출처코드']) ?>">

            <td><input name="사업장코드" value="<?= htmlspecialchars($r['사업장코드']) ?>" class="form-control form-control-sm" maxlength="2" required></td>
            <td><input name="매출처코드" value="<?= htmlspecialchars($r['매출처코드']) ?>" class="form-control form-control-sm" maxlength="8" required></td>
            <td><input name="매출처명" value="<?= htmlspecialchars($r['매출처명']) ?>" class="form-control form-control-sm" required></td>
            <td><input name="전화" value="<?= htmlspecialchars($r['전화']) ?>" class="form-control form-control-sm"></td>
            <td>
              <div class="row g-1">
                <div class="col"><input name="주소1" value="<?= htmlspecialchars($r['주소1']) ?>" class="form-control form-control-sm"></div>
                <div class="col"><input name="주소2" value="<?= htmlspecialchars($r['주소2']) ?>" class="form-control form-control-sm"></div>
              </div>
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
                href="?mode=delete&사업장코드=<?= urlencode($r['사업장코드']) ?>&매출처코드=<?= urlencode($r['매출처코드']) ?>"
                onclick="return confirm('삭제하시겠습니까?')">삭제</a>
            </td>
          </form>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>

<?php include __DIR__ . '/../../includes/footer.php'; ?>