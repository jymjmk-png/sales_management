<?php
header("Content-Type: application/json; charset=utf-8");
include_once "../config/database.php";

$action = $_REQUEST['action'] ?? '';
$page = intval($_GET['page'] ?? 1);
$limit = intval($_GET['limit'] ?? 10);
$offset = ($page - 1) * $limit;

// DB 연결
$db = new Database();
$conn = $db->getConnection();

// 거래처 목록 조회
if ($action === "list") {
    $stmt = $conn->prepare("SELECT SQL_CALC_FOUND_ROWS * FROM customers ORDER BY id DESC LIMIT :offset, :limit");
    $stmt->bindValue(":offset", $offset, PDO::PARAM_INT);
    $stmt->bindValue(":limit", $limit, PDO::PARAM_INT);
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $total = $conn->query("SELECT FOUND_ROWS() as total")->fetch()['total'];

    echo json_encode(["data" => $data, "total" => $total]);
    exit;
}

// 거래처 등록
if ($action === "add") {
    $stmt = $conn->prepare("INSERT INTO customers (cust_name, owner_name, phone, email, address)
                            VALUES (:cust_name, :owner_name, :phone, :email, :address)");
    $stmt->bindParam(":cust_name", $_POST['cust_name']);
    $stmt->bindParam(":owner_name", $_POST['owner_name']);
    $stmt->bindParam(":phone", $_POST['phone']);
    $stmt->bindParam(":email", $_POST['email']);
    $stmt->bindParam(":address", $_POST['address']);
    $stmt->execute();
    echo json_encode(["message" => "거래처가 등록되었습니다."]);
    exit;
}

// 거래처 수정
if ($action === "update") {
    $stmt = $conn->prepare("UPDATE customers 
                            SET cust_name=:cust_name, owner_name=:owner_name, phone=:phone, email=:email, address=:address 
                            WHERE id=:id");
    $stmt->bindParam(":cust_name", $_POST['cust_name']);
    $stmt->bindParam(":owner_name", $_POST['owner_name']);
    $stmt->bindParam(":phone", $_POST['phone']);
    $stmt->bindParam(":email", $_POST['email']);
    $stmt->bindParam(":address", $_POST['address']);
    $stmt->bindParam(":id", $_POST['id']);
    $stmt->execute();
    echo json_encode(["message" => "거래처 정보가 수정되었습니다."]);
    exit;
}

// 거래처 삭제
if ($action === "delete") {
    $stmt = $conn->prepare("DELETE FROM customers WHERE id=:id");
    $stmt->bindParam(":id", $_POST['id']);
    $stmt->execute();
    echo json_encode(["message" => "거래처가 삭제되었습니다."]);
    exit;
}

echo json_encode(["error" => "잘못된 요청입니다."]);
