<?php
require_once __DIR__ . '/includes/session.php';
require_once __DIR__ . '/includes/header.php';
?>
<div class="row g-3">
  <div class="col-md-4">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title">마스터</h5>
        <a class="btn btn-sm btn-outline-primary me-2" href="<?= BASE_URL ?>/modules/master/material.php">자재</a>
        <a class="btn btn-sm btn-outline-primary me-2" href="<?= BASE_URL ?>/modules/master/sales_customer.php">매출처</a>
        <a class="btn btn-sm btn-outline-primary" href="<?= BASE_URL ?>/modules/master/purchase_supplier.php">매입처</a>
      </div>
    </div>
  </div>
  <div class="col-md-4">
    <div class="card shadow-sm">
      <div class="card-body">
        <h5 class="card-title">매출</h5>
        <a class="btn btn-sm btn-outline-success me-2" href="<?= BASE_URL ?>/modules/sales/order_form.php">매출전표입력</a>
        <a class="btn btn-sm btn-outline-success" href="<?= BASE_URL ?>/modules/sales/quote.php">견적서</a>
      </div>
    </div>
  </div>
</div>
<?php include __DIR__ . '/includes/footer.php'; ?>