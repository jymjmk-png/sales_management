<?php
header("Content-Type: application/json; charset=utf-8");
include_once "../config/database.php";
include_once "../includes/validation.php";

$action = $_REQUEST['action'] ?? '';
$page = intval($_GET['page'] ?? 1);
$limit = intval($_GET['limit'] ?? 10);
$offset = ($page - 1) * $limit;

// 유효성 검사 규칙 정의
$rules = [
    'cust_name' => ['required', ['max' => 100]],
    'owner_name' => ['required', ['max' => 50]],
    'phone' => ['required', 'phone', ['max' => 20]],
    'email' => ['nullable', 'email', ['max' => 100]],
    'address' => ['nullable', ['max' => 255]]
];

// DB 연결
$db = new Database();
$conn = $db->getConnection();

// 테이블명 및 컬럼명 상수 정의
define('TABLE_NAME', '거래처');
define('COL_ID', '거래처코드');
define('COL_NAME', '거래처명');
define('COL_OWNER', '대표자명');
define('COL_PHONE', '전화번호');
define('COL_EMAIL', '이메일');
define('COL_ADDRESS', '주소');
define('COL_UPDATED', '수정일시');

// 거래처 목록 조회
if ($action === "list") {
    $stmt = $conn->prepare("SELECT SQL_CALC_FOUND_ROWS 
                            " . COL_ID . " as id,
                            " . COL_NAME . " as cust_name,
                            " . COL_OWNER . " as owner_name,
                            " . COL_PHONE . " as phone,
                            " . COL_EMAIL . " as email,
                            " . COL_ADDRESS . " as address,
                            " . COL_UPDATED . " as updated_at
                          FROM " . TABLE_NAME . " 
                          ORDER BY " . COL_ID . " DESC 
                          LIMIT :offset, :limit");
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
    // 입력값 검증
    list($isValid, $errors) = Validation::validate($_POST, $rules);
    if (!$isValid) {
        http_response_code(400);
        echo json_encode([
            "error" => "입력값 오류",
            "details" => $errors
        ]);
        exit;
    }

    try {
        $conn->beginTransaction();

        // 새 거래처코드 생성
        $stmt = $conn->query("SELECT MAX(CAST(SUBSTRING(" . COL_ID . ", 2) AS UNSIGNED)) as max_id FROM " . TABLE_NAME);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        $next_id = str_pad(($result['max_id'] ?? 0) + 1, 4, '0', STR_PAD_LEFT);
        $cust_id = 'C' . $next_id;

        $stmt = $conn->prepare("INSERT INTO " . TABLE_NAME . " 
                                (" . COL_ID . ", " . COL_NAME . ", " . COL_OWNER . ", " . COL_PHONE . ", " . COL_EMAIL . ", " . COL_ADDRESS . ")
                                VALUES (:id, :cust_name, :owner_name, :phone, :email, :address)");
        $stmt->bindParam(":id", $cust_id);
        $stmt->bindParam(":cust_name", $_POST['cust_name']);
        $stmt->bindParam(":owner_name", $_POST['owner_name']);
        $stmt->bindParam(":phone", $_POST['phone']);
        $stmt->bindParam(":email", $_POST['email']);
        $stmt->bindParam(":address", $_POST['address']);
        $stmt->execute();

        $conn->commit();
        echo json_encode([
            "message" => "거래처가 등록되었습니다.",
            "id" => $cust_id
        ]);
    } catch (PDOException $e) {
        $conn->rollBack();
        http_response_code(500);
        echo json_encode([
            "error" => "데이터베이스 오류",
            "message" => "거래처 등록 중 오류가 발생했습니다."
        ]);
    }
    exit;
}

// 거래처 수정
if ($action === "update") {
    if (empty($_POST['id'])) {
        http_response_code(400);
        echo json_encode(["error" => "거래처 ID가 필요합니다."]);
        exit;
    }

    // 입력값 검증
    list($isValid, $errors) = Validation::validate($_POST, $rules);
    if (!$isValid) {
        http_response_code(400);
        echo json_encode([
            "error" => "입력값 오류",
            "details" => $errors
        ]);
        exit;
    }

    try {
        $conn->beginTransaction();

        // 거래처 존재 여부 확인
        $check = $conn->prepare("SELECT " . COL_ID . " FROM " . TABLE_NAME . " WHERE " . COL_ID . " = :id");
        $check->bindParam(":id", $_POST['id']);
        $check->execute();

        if (!$check->fetch()) {
            throw new Exception("존재하지 않는 거래처입니다.");
        }

        $stmt = $conn->prepare("UPDATE " . TABLE_NAME . "
                                SET " . COL_NAME . "=:cust_name, 
                                    " . COL_OWNER . "=:owner_name, 
                                    " . COL_PHONE . "=:phone, 
                                    " . COL_EMAIL . "=:email, 
                                    " . COL_ADDRESS . "=:address 
                                WHERE " . COL_ID . "=:id");
        $stmt->bindParam(":cust_name", $_POST['cust_name']);
        $stmt->bindParam(":owner_name", $_POST['owner_name']);
        $stmt->bindParam(":phone", $_POST['phone']);
        $stmt->bindParam(":email", $_POST['email']);
        $stmt->bindParam(":address", $_POST['address']);
        $stmt->bindParam(":id", $_POST['id']);
        $stmt->execute();

        $conn->commit();
        echo json_encode(["message" => "거래처 정보가 수정되었습니다."]);
    } catch (Exception $e) {
        $conn->rollBack();
        http_response_code(404);
        echo json_encode([
            "error" => "거래처 수정 오류",
            "message" => $e->getMessage()
        ]);
    } catch (PDOException $e) {
        $conn->rollBack();
        http_response_code(500);
        echo json_encode([
            "error" => "데이터베이스 오류",
            "message" => "거래처 수정 중 오류가 발생했습니다."
        ]);
    }
    exit;
}

// 거래처 삭제
if ($action === "delete") {
    if (empty($_POST['id'])) {
        http_response_code(400);
        echo json_encode(["error" => "거래처 ID가 필요합니다."]);
        exit;
    }

    try {
        $conn->beginTransaction();

        // 거래처 존재 여부 확인
        $check = $conn->prepare("SELECT " . COL_ID . " FROM " . TABLE_NAME . " WHERE " . COL_ID . " = :id");
        $check->bindParam(":id", $_POST['id']);
        $check->execute();

        if (!$check->fetch()) {
            throw new Exception("존재하지 않는 거래처입니다.");
        }

        $stmt = $conn->prepare("DELETE FROM " . TABLE_NAME . " WHERE " . COL_ID . "=:id");
        $stmt->bindParam(":id", $_POST['id']);
        $stmt->execute();

        $conn->commit();
        echo json_encode(["message" => "거래처가 삭제되었습니다."]);
    } catch (Exception $e) {
        $conn->rollBack();
        http_response_code(404);
        echo json_encode([
            "error" => "거래처 삭제 오류",
            "message" => $e->getMessage()
        ]);
    } catch (PDOException $e) {
        $conn->rollBack();
        http_response_code(500);
        echo json_encode([
            "error" => "데이터베이스 오류",
            "message" => "거래처 삭제 중 오류가 발생했습니다."
        ]);
    }
    exit;
}

echo json_encode(["error" => "잘못된 요청입니다."]);
