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
    $sql = "SELECT 사업장코드,매출처코드,매출처명,전화 FROM 매출처 ";
    $p = [];
    if ($q !== '') {
        $sql .= "WHERE 매출처명 LIKE ? OR 매출처코드 LIKE ? ";
        $p = ["%$q%", "%$q%"];
    }
    $sql .= "ORDER BY 매출처명 LIMIT 50";
    
    $stmt = db()->prepare($sql);
    $stmt->execute($p);
    echo json_encode([
        'success' => true,
        'data' => $stmt->fetchAll()
    ]);
} catch (Throwable $e) {
    error_log("Customer API error: " . $e->getMessage());
    http_response_code(500);
    echo json_encode([
        'error' => '서버 오류가 발생했습니다'
    ]);
}
