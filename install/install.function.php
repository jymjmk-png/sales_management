<?php
/**
 * 판매관리 시스템 설치 헬퍼 함수
 */

if (!function_exists('array_map_deep')) {
    // multi-dimensional array에 사용자지정 함수적용
    function array_map_deep($fn, $array)
    {
        if (is_array($array)) {
            foreach ($array as $key => $value) {
                if (is_array($value)) {
                    $array[$key] = array_map_deep($fn, $value);
                } else {
                    $array[$key] = call_user_func($fn, $value);
                }
            }
        } else {
            $array = call_user_func($fn, $array);
        }

        return $array;
    }
}

if (!function_exists('safe_install_string_check')) {
    function safe_install_string_check($str, $is_json = false)
    {
        $is_check = false;

        if (preg_match('#\);(passthru|eval|pcntl_exec|exec|system|popen|fopen|fsockopen|file|file_get_contents|readfile|unlink|include|include_once|require|require_once)\s?#i', $str)) {
            $is_check = true;
        }

        if (preg_match('#\$_(get|post|request)\s?\[.*?\]\s?\)#i', $str)) {
            $is_check = true;
        }

        if ($is_check) {
            $msg = "입력한 값에 안전하지 않는 문자가 포함되어 있습니다. 설치를 중단합니다.";

            if ($is_json) {
                die(install_json_msg($msg));
            }

            die($msg);
        }

        return array_map_deep('stripslashes', $str);
    }
}

if (!function_exists('install_json_msg')) {
    function install_json_msg($msg, $type = 'error')
    {
        $error_msg = ($type === 'error') ? $msg : '';
        $success_msg = ($type === 'success') ? $msg : '';
        $exists_msg = ($type === 'exists') ? $msg : '';

        return json_encode(array('error' => $error_msg, 'success' => $success_msg, 'exists' => $exists_msg));
    }
}

if (!function_exists('check_requirements')) {
    /**
     * 시스템 요구사항을 체크하는 함수
     * 
     * @return array 요구사항 미충족 시 에러 메시지 배열, 모두 충족 시 빈 배열
     */
    function check_requirements()
    {
        $errors = array();

        // PHP 버전 체크 (7.4 이상)
        if (version_compare(PHP_VERSION, '7.4.0', '<')) {
            $errors[] = 'PHP 7.4 이상이 필요합니다. (현재 버전: ' . PHP_VERSION . ')';
        }

        // 필수 PHP 확장 체크
        $required_extensions = array(
            'mysqli' => 'MySQL 확장',
            'gd' => 'GD 이미지 처리 확장',
            'mbstring' => 'MBString 확장',
            'curl' => 'cURL 확장',
            'json' => 'JSON 확장',
            'openssl' => 'OpenSSL 확장'
        );

        foreach ($required_extensions as $ext => $name) {
            if (!extension_loaded($ext)) {
                $errors[] = $name . "이 설치되어 있지 않습니다.";
            }
        }

        // 필수 디렉토리 쓰기 권한 체크
        $required_writable_dirs = array(
            __DIR__ . '/..' => '루트 디렉토리',
            __DIR__ . '/../config' => '설정 디렉토리',
            __DIR__ . '/../data' => '데이터 디렉토리',
            __DIR__ . '/../data/cache' => '캐시 디렉토리',
            __DIR__ . '/../data/files' => '파일 디렉토리',
            __DIR__ . '/../data/logs' => '로그 디렉토리'
        );

        foreach ($required_writable_dirs as $dir => $name) {
            if (!is_dir($dir)) {
                // 디렉토리가 없으면 생성 시도
                if (!@mkdir($dir, 0755, true)) {
                    $errors[] = "$name ($dir) 생성에 실패했습니다.";
                    continue;
                }
            }

            if (!is_writable($dir)) {
                $errors[] = "$name ($dir)에 쓰기 권한이 없습니다.";
            }
        }

        // 최소 메모리 제한 체크 (128M)
        $memory_limit = ini_get('memory_limit');
        if ($memory_limit != -1) {  // -1은 무제한
            $memory_limit_bytes = return_bytes($memory_limit);
            if ($memory_limit_bytes < 128 * 1024 * 1024) {  // 128MB
                $errors[] = "PHP 메모리 제한이 너무 낮습니다. (현재: $memory_limit, 필요: 128M)";
            }
        }

        // 최소 실행 시간 제한 체크 (30초)
        $max_execution_time = ini_get('max_execution_time');
        if ($max_execution_time != 0 && $max_execution_time < 30) {  // 0은 무제한
            $errors[] = "PHP 실행 시간 제한이 너무 낮습니다. (현재: {$max_execution_time}초, 필요: 30초)";
        }

        return $errors;
    }
}

if (!function_exists('return_bytes')) {
    /**
     * PHP ini 파일의 용량 표시를 바이트로 변환
     * 
     * @param string $val 용량 문자열 (예: "128M", "1G")
     * @return int 바이트 단위 용량
     */
    function return_bytes($val)
    {
        $val = trim($val);
        $last = strtolower($val[strlen($val) - 1]);
        $val = (int)$val;
        switch ($last) {
            case 'g':
                $val *= 1024;
            case 'm':
                $val *= 1024;
            case 'k':
                $val *= 1024;
        }
        return $val;
    }
}

if (!function_exists('create_env_file')) {
    /**
     * .env 파일 생성
     * 
     * @param array $config 설정값 배열
     * @return bool 성공 여부
     */
    function create_env_file($config)
    {
        $content = "";
        foreach ($config as $key => $value) {
            $value = str_replace('"', '\\"', $value); // 따옴표 이스케이프
            $content .= "$key=\"$value\"\n";
        }

        return file_put_contents(__DIR__ . '/../.env', $content) !== false;
    }
}

if (!function_exists('test_database_connection')) {
    /**
     * 데이터베이스 연결 테스트
     * 
     * @param string $host 호스트
     * @param string $user 사용자
     * @param string $pass 비밀번호
     * @param string $name 데이터베이스명
     * @return array 성공 시 ['success' => true], 실패 시 ['success' => false, 'error' => '에러메시지']
     */
    function test_database_connection($host, $user, $pass, $name)
    {
        try {
            $mysqli = @new mysqli($host, $user, $pass);

            if ($mysqli->connect_error) {
                return array(
                    'success' => false,
                    'error' => '데이터베이스 연결 실패: ' . $mysqli->connect_error
                );
            }

            // 문자셋 설정
            if (!$mysqli->set_charset('utf8mb4')) {
                return array(
                    'success' => false,
                    'error' => '문자셋(utf8mb4) 설정 실패: ' . $mysqli->error
                );
            }

            // 데이터베이스 존재 여부 확인 및 생성
            $db_exists = $mysqli->select_db($name);
            if (!$db_exists) {
                if (!$mysqli->query("CREATE DATABASE IF NOT EXISTS `$name` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci")) {
                    return array(
                        'success' => false,
                        'error' => '데이터베이스 생성 실패: ' . $mysqli->error
                    );
                }
            }

            $mysqli->close();
            return array('success' => true);
        } catch (Exception $e) {
            return array(
                'success' => false,
                'error' => '데이터베이스 연결 오류: ' . $e->getMessage()
            );
        }
    }
}

if (!function_exists('validate_business_code')) {
    /**
     * 기본 사업장 코드 유효성 검사
     * 
     * @param string $code 사업장 코드
     * @return bool 유효 여부
     */
    function validate_business_code($code)
    {
        return (bool)preg_match('/^[A-Za-z0-9]{1,4}$/', $code);
    }
}