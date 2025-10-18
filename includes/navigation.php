<?php
$links = [
  ['자재',            BASE_URL . '/modules/master/material.php'],
  ['매출처',          BASE_URL . '/modules/master/sales_customer.php'],
  ['매입처',          BASE_URL . '/modules/master/purchase_supplier.php'],
  ['매출전표입력',    BASE_URL . '/modules/sales/order_form.php'],
  ['견적서',          BASE_URL . '/modules/sales/quote.php'],
];
foreach ($links as [$name, $href]) {
  echo '<li class="nav-item"><a class="nav-link" href="' . $href . '">' . htmlspecialchars($name) . '</a></li>';
}
