<?php
/**
 * 설치 시 문자열 안전성 검사 함수
 */
function safe_install_string_check($str, $is_json=false) {
    $is_check = false;

    // 위험한 함수 호출 검사
    if(preg_match('#\);(passthru|eval|pcntl_exec|exec|system|popen|fopen|fsockopen|file|file_get_contents|readfile|unlink|include|include_once|require|require_once)\s?#i', $str)) {
        $is_check = true;
    }

    // $_GET, $_POST, $_REQUEST 변수 검사
    if(preg_match('#\$_(get|post|request)\s?\[.*?\]\s?\)#i', $str)){
        $is_check = true;
    }

    if($is_check){
        $msg = "입력한 값에 안전하지 않은 문자가 포함되어 있습니다.";
        if($is_json){
            header('Content-Type: application/json; charset=utf-8');
            die(json_encode(['success' => false, 'error' => $msg]));
        }
        die($msg);
    }

    return stripslashes($str);
}