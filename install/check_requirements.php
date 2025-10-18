<?php
/**
 * 설치 전 시스템 요구사항 체크
 */

// 에러 리포팅 설정
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once __DIR__ . '/install.function.php';

// 시스템 요구사항 체크
$errors = check_requirements();

// JSON 응답
header('Content-Type: application/json; charset=utf-8');

if (empty($errors)) {
    echo json_encode([
        'success' => true,
        'message' => '시스템 요구사항이 충족되었습니다.'
    ]);
} else {
    echo json_encode([
        'success' => false,
        'errors' => $errors
    ]);
}