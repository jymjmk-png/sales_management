<?php
require_once __DIR__ . '/../config/database.php';
header('Content-Type: application/json; charset=utf-8');

try {
    // Validate input
    $q = trim($_GET['q'] ?? '');
    if (mb_strlen($q) > 100) {
        http_response_code(400);
        echo json_encode(['error' => '검색어가 너무 깁니다']);
        exit;
    }

    // Prepare and execute query
    $sql = "SELECT 분류코드,세부코드,자재명,규격,단위 FROM 자재 ";
    $p = [];
    if ($q !== '') {
        $sql .= "WHERE 자재명 LIKE ? OR 세부코드 LIKE ? ";
        $p = ["%$q%", "%$q%"];
    }
    $sql .= "ORDER BY 자재명 LIMIT 50";

    // DB 연결
    $db = new Database();
    $conn = $db->getConnection();

    $stmt = $conn->prepare($sql);
    $stmt->execute($p);
    echo json_encode([
        'success' => true,
        'data' => $stmt->fetchAll()
    ]);
} catch (Throwable $e) {
    error_log("Materials API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => '서버 오류가 발생했습니다'
    ]);
}
