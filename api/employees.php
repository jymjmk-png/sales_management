<?php
header("Content-Type: application/json; charset=utf-8");
include_once "../config/database.php";

$action = $_REQUEST['action'] ?? '';
$page = intval($_GET['page'] ?? 1);
$limit = intval($_GET['limit'] ?? 10);
$offset = ($page - 1) * $limit;

$db = new Database();
$conn = $db->getConnection();

// 사원 목록
if ($action === "list") {
  $stmt = $conn->prepare("SELECT SQL_CALC_FOUND_ROWS * FROM employees ORDER BY id DESC LIMIT :offset, :limit");
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
  $stmt = $conn->prepare("INSERT INTO employees (emp_name, dept, position, phone, email)
                            VALUES (:emp_name, :dept, :position, :phone, :email)");
  $stmt->bindParam(":emp_name", $_POST['emp_name']);
  $stmt->bindParam(":dept", $_POST['dept']);
  $stmt->bindParam(":position", $_POST['position']);
  $stmt->bindParam(":phone", $_POST['phone']);
  $stmt->bindParam(":email", $_POST['email']);
  $stmt->execute();
  echo json_encode(["message" => "사원이 등록되었습니다."]);
  exit;
}

// 수정
if ($action === "update") {
  $stmt = $conn->prepare("UPDATE employees 
                            SET emp_name=:emp_name, dept=:dept, position=:position, phone=:phone, email=:email 
                            WHERE id=:id");
  $stmt->bindParam(":emp_name", $_POST['emp_name']);
  $stmt->bindParam(":dept", $_POST['dept']);
  $stmt->bindParam(":position", $_POST['position']);
  $stmt->bindParam(":phone", $_POST['phone']);
  $stmt->bindParam(":email", $_POST['email']);
  $stmt->bindParam(":id", $_POST['id']);
  $stmt->execute();
  echo json_encode(["message" => "사원 정보가 수정되었습니다."]);
  exit;
}

// 삭제
if ($action === "delete") {
  $stmt = $conn->prepare("DELETE FROM employees WHERE id=:id");
  $stmt->bindParam(":id", $_POST['id']);
  $stmt->execute();
  echo json_encode(["message" => "사원이 삭제되었습니다."]);
  exit;
}

echo json_encode(["error" => "잘못된 요청입니다."]);
