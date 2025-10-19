<?php
class Validation {
    /**
     * 입력값 검증
     * @param array $data 검증할 데이터
     * @param array $rules 검증 규칙
     * @return array [성공 여부, 오류 메시지]
     */
    public static function validate($data, $rules) {
        $errors = [];
        
        foreach ($rules as $field => $rule) {
            if (!isset($data[$field]) && !in_array('nullable', $rule)) {
                $errors[$field] = "필수 입력 항목입니다.";
                continue;
            }

            $value = $data[$field] ?? '';

            foreach ($rule as $validation) {
                if (is_string($validation)) {
                    switch ($validation) {
                        case 'required':
                            if (empty($value) && $value !== '0') {
                                $errors[$field] = "필수 입력 항목입니다.";
                            }
                            break;
                        case 'email':
                            if (!empty($value) && !filter_var($value, FILTER_VALIDATE_EMAIL)) {
                                $errors[$field] = "올바른 이메일 형식이 아닙니다.";
                            }
                            break;
                        case 'phone':
                            if (!empty($value) && !preg_match('/^[0-9\-\(\)]{8,20}$/', $value)) {
                                $errors[$field] = "올바른 전화번호 형식이 아닙니다.";
                            }
                            break;
                        case 'nullable':
                            break;
                    }
                } else if (is_array($validation)) {
                    $rule_name = key($validation);
                    $rule_value = current($validation);
                    
                    switch ($rule_name) {
                        case 'max':
                            if (mb_strlen($value, 'UTF-8') > $rule_value) {
                                $errors[$field] = "최대 {$rule_value}자까지 입력 가능합니다.";
                            }
                            break;
                        case 'min':
                            if (mb_strlen($value, 'UTF-8') < $rule_value) {
                                $errors[$field] = "최소 {$rule_value}자 이상 입력해주세요.";
                            }
                            break;
                    }
                }
            }
        }
        
        return [empty($errors), $errors];
    }
}