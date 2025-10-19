<?php
// C:\xampp\htdocs\sales_management\modules\sales\order_form.php
require_once __DIR__ . '/../../includes/session.php';
require_once __DIR__ . '/../../includes/header.php';
require_once __DIR__ . '/../../config/constants.php';
require_once __DIR__ . '/../../config/database.php';
require_once __DIR__ . '/../../classes/Functions.php';
require_once __DIR__ . '/../../classes/Numbering.php';

csrf_check();
$pdo = db();

$msg = '';
$err = '';

// 기본값
$사업장코드 = '01';
$오늘 = date('Ymd');
$전표일자 = $_POST['전표일자'] ?? $오늘;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['csrf'] ?? '') === ($_SESSION['csrf'] ?? '')) {
  try {
    // 1) 헤더 입력값
    $사업장코드   = trim($_POST['사업장코드'] ?? '01');
    $전표일자     = preg_replace('/[^0-9]/', '', $_POST['전표일자'] ?? $오늘);
    $매출처코드   = trim($_POST['매출처코드'] ?? '');
    $비고         = trim($_POST['비고'] ?? '');
    $작성자코드   = $_SESSION['user']['사용자코드'] ?? 'ADMN';

    if ($사업장코드 === '' || strlen($전표일자) !== 8 || $매출처코드 === '') {
      throw new Exception('사업장코드 / 전표일자(YYYYMMDD) / 매출처코드는 필수입니다.');
    }

    // 2) 라인 입력값
    $자재코드 = $_POST['자재코드'] ?? [];
    $자재명   = $_POST['자재명'] ?? [];
    $규격     = $_POST['규격'] ?? [];
    $단위     = $_POST['단위'] ?? [];
    $수량     = $_POST['수량'] ?? [];
    $단가     = $_POST['단가'] ?? [];
    $과세구분 = $_POST['과세구분'] ?? [];

    if (count($자재코드) === 0) throw new Exception('한 줄 이상의 품목을 입력하세요.');

    $라인 = [];
    for ($i = 0; $i < count($자재코드); $i++) {
      $code = trim($자재코드[$i] ?? '');
      if ($code === '') continue; // 빈 줄 스킵
      $qty  = (float)($수량[$i] ?? 0);
      $prc  = (float)($단가[$i] ?? 0);
      $vatf = (int)($과세구분[$i] ?? 1);
      list($공급가, $세액, $총액) = Functions::splitSupplyTax($qty, $prc, $vatf);
      $라인[] = [
        '자재코드' => $code,
        '자재명'   => trim($자재명[$i] ?? ''),
        '규격'     => trim($규격[$i] ?? ''),
        '단위'     => trim($단위[$i] ?? ''),
        '수량'     => $qty,
        '단가'     => $prc,
        '공급가'   => $공급가,
        '세액'     => $세액,
        '총액'     => $총액,
        '과세구분' => $vatf,
        '비고'     => '',
      ];
    }
    if (count($라인) === 0) throw new Exception('유효한 품목이 없습니다.');

    // 3) 합계
    $합계공급가 = array_sum(array_column($라인, '공급가'));
    $합계세액   = array_sum(array_column($라인, '세액'));
    $합계총액   = array_sum(array_column($라인, '총액'));

    // 4) 전표번호 채번
    $전표번호 = Numbering::next('sales_header', $사업장코드, $전표일자);

    // 5) 저장 (트랜잭션)
    $pdo->beginTransaction();

    $insH = $pdo->prepare("
            INSERT INTO sales_header
            (사업장코드,전표일자,전표번호,매출처코드,비고,합계공급가,합계세액,합계총액,작성자코드)
            VALUES (?,?,?,?,?,?,?,?,?)
        ");
    $insH->execute([
      $사업장코드,
      $전표일자,
      $전표번호,
      $매출처코드,
      $비고,
      $합계공급가,
      $합계세액,
      $합계총액,
      $작성자코드
    ]);

    $insD = $pdo->prepare("
            INSERT INTO sales_detail
            (사업장코드,전표일자,전표번호,순번,자재코드,자재명,규격,단위,수량,단가,공급가,세액,총액,과세구분,비고)
            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        ");
    $seq = 1;
    foreach ($라인 as $L) {
      $insD->execute([
        $사업장코드,
        $전표일자,
        $전표번호,
        $seq++,
        $L['자재코드'],
        $L['자재명'],
        $L['규격'],
        $L['단위'],
        $L['수량'],
        $L['단가'],
        $L['공급가'],
        $L['세액'],
        $L['총액'],
        $L['과세구분'],
        $L['비고']
      ]);
    }

    $pdo->commit();
    $msg = "저장되었습니다. 전표번호: {$전표번호}";
    // 폼 초기화
    $전표일자 = $오늘;
  } catch (Throwable $e) {
    if ($pdo->inTransaction()) $pdo->rollBack();
    $err = $e->getMessage();
  }
}
?>
<div class="d-flex justify-content-between align-items-center mb-3">
  <h3 class="m-0">매출전표 입력</h3>
  <a class="btn btn-sm btn-outline-secondary" href="<?= BASE_URL ?>/index.php">메인</a>
</div>

<?php if ($msg): ?><div class="alert alert-success py-2"><?= htmlspecialchars($msg) ?></div><?php endif; ?>
<?php if ($err): ?><div class="alert alert-danger py-2"><?= htmlspecialchars($err) ?></div><?php endif; ?>

<form method="post" class="card mb-3">
  <input type="hidden" name="csrf" value="<?= csrf_token() ?>">
  <div class="card-body">
    <div class="row g-2">
      <div class="col-2">
        <label class="form-label">사업장코드</label>
        <input name="사업장코드" value="<?= htmlspecialchars($사업장코드) ?>" maxlength="2" class="form-control form-control-sm" required>
      </div>
      <div class="col-3">
        <label class="form-label">전표일자</label>
        <input name="전표일자" value="<?= htmlspecialchars($전표일자) ?>" class="form-control form-control-sm" placeholder="YYYYMMDD" required>
      </div>
      <div class="col-4">
        <label class="form-label">매출처코드</label>
        <input name="매출처코드" class="form-control form-control-sm" placeholder="예: C0000001" required>
        <div class="form-text">※ 추후 자동완성(API) 연동 가능</div>
      </div>
      <div class="col-12">
        <label class="form-label">비고</label>
        <input name="비고" class="form-control form-control-sm">
      </div>
    </div>
  </div>

  <div class="table-responsive px-3">
    <table class="table table-sm align-middle" id="lineTable">
      <thead class="table-light">
        <tr>
          <th style="width:12%">자재코드</th>
          <th style="width:20%">자재명</th>
          <th>규격</th>
          <th style="width:8%">단위</th>
          <th style="width:10%">수량</th>
          <th style="width:10%">단가</th>
          <th style="width:10%">과세</th>
          <th style="width:10%">총액(미리보기)</th>
          <th style="width:8%"></th>
        </tr>
      </thead>
      <tbody>
        <?php for ($i = 0; $i < 5; $i++): ?>
          <tr>
            <td><input name="자재코드[]" class="form-control form-control-sm"></td>
            <td><input name="자재명[]" class="form-control form-control-sm"></td>
            <td><input name="규격[]" class="form-control form-control-sm"></td>
            <td><input name="단위[]" class="form-control form-control-sm"></td>
            <td><input name="수량[]" class="form-control form-control-sm qty" value="0"></td>
            <td><input name="단가[]" class="form-control form-control-sm price" value="0"></td>
            <td>
              <select name="과세구분[]" class="form-select form-select-sm vat">
                <option value="1">과세</option>
                <option value="0">면세</option>
              </select>
            </td>
            <td><input class="form-control form-control-sm total" value="0" readonly></td>
            <td><button type="button" class="btn btn-sm btn-outline-danger del">-</button></td>
          </tr>
        <?php endfor; ?>
      </tbody>
    </table>
    <button type="button" id="addRow" class="btn btn-sm btn-outline-secondary ms-2 mb-3">+ 행 추가</button>
  </div>

  <div class="card-body border-top">
    <div class="row g-2">
      <div class="col-auto ms-auto">
        <button class="btn btn-primary">저장</button>
      </div>
    </div>
  </div>
</form>

<script>
  (function() {
    const T = document.getElementById('lineTable').getElementsByTagName('tbody')[0];
    const taxRate = 0.1; // 미리보기용(실제 계산은 서버 FN가 확정)

    function recalcRow(tr) {
      const qty = parseFloat(tr.querySelector('.qty')?.value || '0');
      const price = parseFloat(tr.querySelector('.price')?.value || '0');
      const vat = parseInt(tr.querySelector('.vat')?.value || '1', 10);
      const amt = Math.round(qty * price);
      const total = vat ? (amt + Math.round(amt * taxRate)) : amt;
      tr.querySelector('.total').value = isFinite(total) ? total : 0;
    }

    function bind(tr) {
      tr.querySelectorAll('.qty,.price,.vat').forEach(el => {
        el.addEventListener('input', () => recalcRow(tr));
        el.addEventListener('change', () => recalcRow(tr));
      });
      tr.querySelector('.del').addEventListener('click', () => {
        if (T.rows.length > 1) tr.remove();
      });
    }
    Array.from(T.rows).forEach(bind);

    document.getElementById('addRow').addEventListener('click', () => {
      const tr = T.rows[0].cloneNode(true);
      tr.querySelectorAll('input').forEach(i => {
        i.value = (i.classList.contains('qty') || i.classList.contains('price')) ? '0' : '';
      });
      tr.querySelector('.vat').value = '1';
      tr.querySelector('.total').value = '0';
      T.appendChild(tr);
      bind(tr);
    });
  })();
</script>

<?php include __DIR__ . '/../../includes/footer.php'; ?>