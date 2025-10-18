-- 판매관리 시스템 데이터베이스 스키마
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 시스템설정
CREATE TABLE IF NOT EXISTS `시스템설정` (
  `키` varchar(50) NOT NULL,
  `값` varchar(255) NOT NULL,
  PRIMARY KEY (`키`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `시스템설정` (`키`, `값`) VALUES
('TAX_RATE', '0.1'),
('DOC_SEQ_SCOPE', 'DATE'),
('ROUND_AMT', 'ROUND'),
('ROUND_QTY', 'ROUND'),
('ROUND_PRICE', 'ROUND');

-- 매출처
CREATE TABLE IF NOT EXISTS `매출처` (
  `사업장코드` varchar(10) NOT NULL,
  `매출처코드` varchar(20) NOT NULL,
  `매출처명` varchar(100) NOT NULL,
  `전화` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`사업장코드`, `매출처코드`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 자재
CREATE TABLE IF NOT EXISTS `자재` (
  `분류코드` varchar(10) NOT NULL,
  `세부코드` varchar(20) NOT NULL,
  `자재명` varchar(100) NOT NULL,
  `규격` varchar(100) DEFAULT NULL,
  `단위` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`분류코드`, `세부코드`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 매출전표
CREATE TABLE IF NOT EXISTS `매출전표` (
  `사업장코드` varchar(10) NOT NULL,
  `전표일자` date NOT NULL,
  `전표번호` int NOT NULL,
  `매출처코드` varchar(20) NOT NULL,
  `공급가액` decimal(12,0) NOT NULL DEFAULT 0,
  `부가세액` decimal(12,0) NOT NULL DEFAULT 0,
  `합계금액` decimal(12,0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`사업장코드`, `전표일자`, `전표번호`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 사용자
CREATE TABLE IF NOT EXISTS `사용자` (
  `사용자코드` varchar(20) NOT NULL,
  `비밀번호` varchar(255) NOT NULL,
  `이름` varchar(50) NOT NULL,
  `이메일` varchar(100) DEFAULT NULL,
  `최종로그인` datetime DEFAULT NULL,
  PRIMARY KEY (`사용자코드`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 초기 관리자 계정 생성 (비밀번호: admin123)
INSERT INTO `사용자` (`사용자코드`, `비밀번호`, `이름`, `이메일`) VALUES
('admin', '$2y$10$8tgXXHm1r84UX.OCzJxQj.qD4qvUuJa7RYUECVnM0oHEJGRXFriry', '관리자', NULL);

SET FOREIGN_KEY_CHECKS = 1;