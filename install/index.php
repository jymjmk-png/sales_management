<?php
header('Content-Type: text/html; charset=utf-8');
header('X-Robots-Tag: noindex');

// 이미 설치되어 있는지 확인
if (file_exists(__DIR__ . '/../.env')) {
    die('이미 설치가 완료되었습니다. .env 파일을 삭제하고 다시 시도하세요.');
}

$title = "판매관리 시스템 설치";
$subtitle = "데이터베이스 설정 및 초기화";

require_once __DIR__ . '/install.function.php';

// 시스템 요구사항 체크
$requirements_errors = check_requirements();
?>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($title) ?></title>
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="./install.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="install-form">
            <div class="install-header">
                <h2><?= htmlspecialchars($title) ?></h2>
                <p><?= htmlspecialchars($subtitle) ?></p>
            </div>

            <?php if (!empty($requirements_errors)): ?>
                <div class="alert alert-danger">
                    <h4 class="alert-heading">시스템 요구사항 미충족</h4>
                    <ul class="mb-0">
                        <?php foreach ($requirements_errors as $error): ?>
                            <li><?= htmlspecialchars($error) ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            <?php else: ?>
                <form id="installForm" class="card p-4 shadow-sm">
                    <div class="section-title">데이터베이스 설정</div>
                    <div class="mb-3">
                        <label for="dbhost" class="form-label">데이터베이스 호스트</label>
                        <input type="text" class="form-control" id="dbhost" name="dbhost" value="localhost" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="dbname" class="form-label">데이터베이스 이름</label>
                        <input type="text" class="form-control" id="dbname" name="dbname" value="sales_management" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="dbuser" class="form-label">데이터베이스 사용자</label>
                        <input type="text" class="form-control" id="dbuser" name="dbuser" value="root" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="dbpass" class="form-label">데이터베이스 비밀번호</label>
                        <input type="password" class="form-control" id="dbpass" name="dbpass">
                    </div>

                    <hr class="my-4">
                    
                    <div class="section-title">기본 사업장 설정</div>
                    <div class="mb-3">
                        <label for="bizcode" class="form-label">사업장 코드</label>
                        <input type="text" class="form-control" id="bizcode" name="bizcode" maxlength="4" required
                               pattern="[A-Za-z0-9]+" title="영문자와 숫자만 입력 가능합니다">
                        <div class="form-text">영문자와 숫자로 4자리 이내</div>
                    </div>

                    <div class="mb-3">
                        <label for="bizname" class="form-label">사업장명</label>
                        <input type="text" class="form-control" id="bizname" name="bizname" maxlength="30" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100">설치하기</button>
                </form>
                
                <div class="install-footer">
                    <p>* 설치가 완료되면 자동으로 메인 페이지로 이동합니다.</p>
                    <p>* 초기 관리자 계정: admin / admin123</p>
                    <p>* 설치 후 반드시 관리자 비밀번호를 변경하세요.</p>
                </div>

                <script>
                document.getElementById('installForm').addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    const formData = new FormData(this);
                    const data = {};
                    for (let [key, value] of formData.entries()) {
                        data[key] = value;
                    }

                    fetch('./install_db.php', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(data)
                    })
                    .then(response => response.json())
                    .then(result => {
                        if (result.success) {
                            alert(result.message);
                            if (result.redirect) {
                                window.location.href = result.redirect;
                            }
                        } else {
                            alert(result.error || '설치 중 오류가 발생했습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('설치 중 오류가 발생했습니다.');
                    });
                });
                </script>
            <?php endif; ?>
        </div>
    </div>
    <script src="../assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>
