-- 거래처 테이블 생성
CREATE TABLE IF NOT EXISTS `거래처` (
  `거래처코드` varchar(5) NOT NULL,
  `거래처명` varchar(100) NOT NULL,
  `대표자명` varchar(50) NOT NULL,
  `전화번호` varchar(20) NOT NULL,
  `이메일` varchar(100) DEFAULT NULL,
  `주소` varchar(255) DEFAULT NULL,
  `사용여부` tinyint(1) NOT NULL DEFAULT 1,
  `수정일시` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`거래처코드`),
  KEY `idx_거래처명` (`거래처명`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;