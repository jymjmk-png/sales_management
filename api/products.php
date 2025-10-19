<?php
header("Content-Type: application/json; charset=utf-8");
include_once "../config/database.php";

$action = $_REQUEST['action'] ?? '';
$page = intval($_GET['page'] ?? 1);
$limit = intval($_GET['limit'] ?? 10);
$offset = ($page - 1) * $limit;

$db = new Database();
$conn = $db->getConnection();

// 제품 목록
if ($action === "list") {
  $stmt = $conn->prepare("SELECT SQL_CALC_FOUND_ROWS * FROM products ORDER BY id DESC LIMIT :offset, :limit");
  $stmt->bindValue(":offset", $offset, PDO::PARAM_INT);
  $stmt->bindValue(":limit", $limit, PDO::PARAM_INT);
  $stmt->execute();
  $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
  $total = $conn->query("SELECT FOUND_ROWS() as total")->fetch()['total'];
  echo json_encode(["data" => $data, "total" => $total]);
  exit;
}

// 등록
if ($action === "add") {
  $stmt = $conn->prepare("INSERT INTO products (product_name, category, price, stock)
                            VALUES (:product_name, :category, :price, :stock)");
  $stmt->bindParam(":product_name", $_POST['product_name']);
  $stmt->bindParam(":category", $_POST['category']);
  $stmt->bindParam(":price", $_POST['price']);
  $stmt->bindParam(":stock", $_POST['stock']);
  $stmt->execute();
  echo json_encode(["message" => "제품이 등록되었습니다."]);
  exit;
}

// 수정
if ($action === "update") {
  $stmt = $conn->prepare("UPDATE products 
                            SET product_name=:product_name, category=:category, price=:price, stock=:stock 
                            WHERE id=:id");
  $stmt->bindParam(":product_name", $_POST['product_name']);
  $stmt->bindParam(":category", $_POST['category']);
  $stmt->bindParam(":price", $_POST['price']);
  $stmt->bindParam(":stock", $_POST['stock']);
  $stmt->bindParam(":id", $_POST['id']);
  $stmt->execute();
  echo json_encode(["message" => "제품 정보가 수정되었습니다."]);
  exit;
}

// 삭제
if ($action === "delete") {
  $stmt = $conn->prepare("DELETE FROM products WHERE id=:id");
  $stmt->bindParam(":id", $_POST['id']);
  $stmt->execute();
  echo json_encode(["message" => "제품이 삭제되었습니다."]);
  exit;
}

echo json_encode(["error" => "잘못된 요청입니다."]);
