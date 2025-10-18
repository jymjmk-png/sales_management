-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- 생성 시간: 25-10-18 16:03
-- 서버 버전: 10.4.27-MariaDB-log
-- PHP 버전: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `sales_management`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `견적`
--

CREATE TABLE `견적` (
  `사업장코드` varchar(2) NOT NULL,
  `견적일자` varchar(8) NOT NULL,
  `견적번호` decimal(24,0) NOT NULL DEFAULT 0,
  `매출처코드` varchar(8) NOT NULL DEFAULT '',
  `출고희망일자` varchar(8) NOT NULL DEFAULT '',
  `결제방법` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `결제예정일자` varchar(8) NOT NULL DEFAULT '',
  `유효일수` int(11) NOT NULL DEFAULT 0,
  `제목` varchar(30) NOT NULL DEFAULT '',
  `적요` varchar(50) NOT NULL DEFAULT '',
  `상태코드` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` varchar(8) NOT NULL DEFAULT '',
  `출고일자` varchar(8) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `견적내역`
--

CREATE TABLE `견적내역` (
  `사업장코드` varchar(2) NOT NULL,
  `견적일자` varchar(8) NOT NULL,
  `견적번호` decimal(24,0) NOT NULL DEFAULT 0,
  `견적시간` varchar(9) NOT NULL DEFAULT '',
  `자재코드` varchar(18) NOT NULL DEFAULT '',
  `매입처코드` varchar(8) NOT NULL DEFAULT '',
  `수량` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `매출처코드` varchar(8) NOT NULL DEFAULT '',
  `계산서발행여부` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `입고단가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `입고부가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고단가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고부가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `상태코드` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` varchar(8) NOT NULL DEFAULT '',
  `출고일자` varchar(8) NOT NULL DEFAULT '',
  `적요` varchar(50) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `매입세금계산서장부`
--

CREATE TABLE `매입세금계산서장부` (
  `사업장코드` varchar(2) NOT NULL DEFAULT '1',
  `작성일자` varchar(8) NOT NULL DEFAULT '',
  `작성시간` varchar(9) NOT NULL DEFAULT '',
  `매입처코드` varchar(8) NOT NULL DEFAULT '',
  `품목및규격` varchar(50) NOT NULL DEFAULT '',
  `수량` decimal(24,0) NOT NULL DEFAULT 0,
  `공급가액` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `세액` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `금액구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `영청구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `발행여부` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `작성구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `미지급구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `적요` varchar(50) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT '',
  `작성년도` varchar(4) NOT NULL DEFAULT '',
  `책번호` decimal(24,0) NOT NULL DEFAULT 0,
  `일련번호` decimal(24,0) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `매입처`
--

CREATE TABLE `매입처` (
  `사업장코드` varchar(2) NOT NULL,
  `매입처코드` varchar(8) NOT NULL,
  `매입처명` varchar(60) NOT NULL DEFAULT '',
  `사업자번호` varchar(10) NOT NULL DEFAULT '',
  `전화` varchar(20) NOT NULL DEFAULT '',
  `주소` varchar(100) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `수정일자` varchar(8) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `매출세금계산서장부`
--

CREATE TABLE `매출세금계산서장부` (
  `사업장코드` varchar(2) NOT NULL DEFAULT '1',
  `작성일자` varchar(8) NOT NULL DEFAULT '',
  `작성시간` varchar(9) NOT NULL DEFAULT '',
  `매출처코드` varchar(8) NOT NULL DEFAULT '',
  `품목및규격` varchar(50) NOT NULL DEFAULT '',
  `수량` decimal(24,0) NOT NULL DEFAULT 0,
  `공급가액` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `세액` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `금액구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `영청구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `발행여부` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `작성구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `미수구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `적요` varchar(50) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT '',
  `작성년도` varchar(4) NOT NULL DEFAULT '',
  `책번호` decimal(24,0) NOT NULL DEFAULT 0,
  `일련번호` decimal(24,0) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `매출처`
--

CREATE TABLE `매출처` (
  `사업장코드` varchar(2) NOT NULL,
  `매출처코드` varchar(8) NOT NULL,
  `매출처명` varchar(60) NOT NULL DEFAULT '',
  `사업자번호` varchar(10) NOT NULL DEFAULT '',
  `전화` varchar(20) NOT NULL DEFAULT '',
  `주소` varchar(100) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `수정일자` varchar(8) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `발주`
--

CREATE TABLE `발주` (
  `사업장코드` varchar(2) NOT NULL,
  `발주일자` varchar(8) NOT NULL,
  `발주번호` decimal(24,0) NOT NULL DEFAULT 0,
  `매입처코드` varchar(8) NOT NULL DEFAULT '',
  `입고희망일자` varchar(8) NOT NULL DEFAULT '',
  `결제방법` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `결제예정일자` varchar(8) NOT NULL DEFAULT '',
  `유효일수` int(11) NOT NULL DEFAULT 0,
  `제목` varchar(30) NOT NULL DEFAULT '',
  `적요` varchar(50) NOT NULL DEFAULT '',
  `상태코드` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` varchar(8) NOT NULL DEFAULT '',
  `출고일자` varchar(8) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `발주내역`
--

CREATE TABLE `발주내역` (
  `사업장코드` varchar(2) NOT NULL,
  `발주일자` varchar(8) NOT NULL,
  `발주번호` decimal(24,0) NOT NULL DEFAULT 0,
  `발주시간` varchar(9) NOT NULL DEFAULT '',
  `자재코드` varchar(18) NOT NULL DEFAULT '',
  `매입처코드` varchar(8) NOT NULL DEFAULT '',
  `발주량` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `매출처코드` varchar(8) NOT NULL DEFAULT '',
  `직송구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `입고단가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `입고부가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고단가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고부가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `상태코드` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` varchar(8) NOT NULL DEFAULT '',
  `출고일자` varchar(8) NOT NULL DEFAULT '',
  `적요` varchar(50) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `사업장`
--

CREATE TABLE `사업장` (
  `사업장코드` varchar(2) NOT NULL,
  `사업장명` varchar(50) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `사용자`
--

CREATE TABLE `사용자` (
  `사용자코드` varchar(4) NOT NULL,
  `사용자명` varchar(30) NOT NULL DEFAULT '',
  `비밀번호` varchar(100) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `수정일자` varchar(8) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `세금계산서`
--

CREATE TABLE `세금계산서` (
  `사업장코드` varchar(2) NOT NULL DEFAULT '1',
  `작성년도` varchar(4) NOT NULL DEFAULT '',
  `책번호` decimal(24,0) NOT NULL DEFAULT 0,
  `일련번호` decimal(24,0) NOT NULL DEFAULT 0,
  `매출처코드` varchar(8) NOT NULL DEFAULT '',
  `작성일자` varchar(8) NOT NULL DEFAULT '',
  `품목및규격` varchar(50) NOT NULL DEFAULT '',
  `수량` decimal(24,0) NOT NULL DEFAULT 0,
  `공급가액` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `세액` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `금액구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `영청구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `발행여부` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `작성구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `미수구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `적요` varchar(50) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `시스템설정`
--

CREATE TABLE `시스템설정` (
  `키` varchar(50) NOT NULL,
  `값` varchar(200) NOT NULL,
  `설명` varchar(200) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 테이블의 덤프 데이터 `시스템설정`
--

INSERT INTO `시스템설정` (`키`, `값`, `설명`) VALUES
('DOC_SEQ_SCOPE', 'DATE', '전표번호 범위: DATE|YEAR'),
('ROUND_AMT', 'ROUND', '금액 반올림 방식'),
('ROUND_PRICE', 'ROUND', '단가 반올림 방식: ROUND|FLOOR|CEIL'),
('ROUND_QTY', 'ROUND', '수량 반올림 방식'),
('TAX_RATE', '0.10', '부가세율 10%');

-- --------------------------------------------------------

--
-- 테이블 구조 `우편번호`
--

CREATE TABLE `우편번호` (
  `우편번호` varchar(7) NOT NULL DEFAULT '',
  `주소1` varchar(45) NOT NULL DEFAULT '',
  `주소2` varchar(30) NOT NULL DEFAULT '',
  `읍면동` varchar(30) NOT NULL DEFAULT '',
  `번지` varchar(15) NOT NULL DEFAULT '',
  `지역번호` varchar(3) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `자재`
--

CREATE TABLE `자재` (
  `분류코드` varchar(2) NOT NULL,
  `세부코드` varchar(16) NOT NULL,
  `자재명` varchar(30) NOT NULL DEFAULT '',
  `바코드` varchar(13) NOT NULL DEFAULT '',
  `규격` varchar(30) NOT NULL DEFAULT '',
  `단위` varchar(20) NOT NULL DEFAULT '',
  `폐기율` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `과세구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `적요` varchar(60) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `자재분류`
--

CREATE TABLE `자재분류` (
  `분류코드` varchar(2) NOT NULL,
  `분류명` varchar(30) NOT NULL DEFAULT '',
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `수정일자` varchar(8) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `자재원장`
--

CREATE TABLE `자재원장` (
  `사업장코드` varchar(2) NOT NULL,
  `분류코드` varchar(2) NOT NULL,
  `세부코드` varchar(16) NOT NULL,
  `현재고` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `수정일자` varchar(8) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `자재입출내역`
--

CREATE TABLE `자재입출내역` (
  `사업장코드` varchar(2) NOT NULL,
  `분류코드` varchar(2) NOT NULL,
  `세부코드` varchar(16) NOT NULL,
  `입출고구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `입출고일자` varchar(8) NOT NULL DEFAULT '',
  `입출고시간` varchar(9) NOT NULL DEFAULT '',
  `입고수량` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `입고단가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `입고부가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고수량` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고단가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `출고부가` decimal(19,4) NOT NULL DEFAULT 0.0000,
  `매입처코드` varchar(8) NOT NULL DEFAULT '',
  `매출처코드` varchar(8) NOT NULL DEFAULT '',
  `원래입출고일자` varchar(8) NOT NULL DEFAULT '',
  `직송구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `발견일자` varchar(8) NOT NULL DEFAULT '',
  `발견번호` decimal(24,0) NOT NULL DEFAULT 0,
  `거래일자` varchar(8) NOT NULL DEFAULT '',
  `거래번호` decimal(24,0) NOT NULL DEFAULT 0,
  `계산서발행여부` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `현금구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `감가구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `적요` varchar(50) NOT NULL DEFAULT '',
  `작성년도` varchar(4) NOT NULL DEFAULT '',
  `책번호` decimal(24,0) NOT NULL DEFAULT 0,
  `일련번호` decimal(24,0) NOT NULL DEFAULT 0,
  `사용구분` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` varchar(8) NOT NULL DEFAULT '',
  `사용자코드` varchar(4) NOT NULL DEFAULT '',
  `재고이동사업장코드` varchar(2) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `견적`
--
ALTER TABLE `견적`
  ADD PRIMARY KEY (`사업장코드`,`견적일자`,`견적번호`),
  ADD KEY `IX_출고일자` (`출고일자`),
  ADD KEY `IX_출고희망일자` (`출고희망일자`),
  ADD KEY `FK_견적_매출처` (`사업장코드`,`매출처코드`);

--
-- 테이블의 인덱스 `견적내역`
--
ALTER TABLE `견적내역`
  ADD PRIMARY KEY (`사업장코드`,`견적일자`,`견적번호`,`견적시간`,`자재코드`),
  ADD KEY `IX_매출처코드` (`매출처코드`),
  ADD KEY `IX_출고일자` (`출고일자`);

--
-- 테이블의 인덱스 `매입세금계산서장부`
--
ALTER TABLE `매입세금계산서장부`
  ADD PRIMARY KEY (`사업장코드`,`작성일자`,`작성시간`),
  ADD KEY `IX_매입세금계산서번호` (`사업장코드`,`작성년도`,`책번호`,`일련번호`),
  ADD KEY `FK_매입세금계산서장부_매입처` (`사업장코드`,`매입처코드`);

--
-- 테이블의 인덱스 `매입처`
--
ALTER TABLE `매입처`
  ADD PRIMARY KEY (`사업장코드`,`매입처코드`),
  ADD KEY `IX_매입처명` (`매입처명`);

--
-- 테이블의 인덱스 `매출세금계산서장부`
--
ALTER TABLE `매출세금계산서장부`
  ADD PRIMARY KEY (`사업장코드`,`작성일자`,`작성시간`),
  ADD KEY `IX_매출세금계산서번호` (`사업장코드`,`작성년도`,`책번호`,`일련번호`),
  ADD KEY `FK_매출세금계산서장부_매출처` (`사업장코드`,`매출처코드`);

--
-- 테이블의 인덱스 `매출처`
--
ALTER TABLE `매출처`
  ADD PRIMARY KEY (`사업장코드`,`매출처코드`),
  ADD KEY `IX_매출처명` (`매출처명`);

--
-- 테이블의 인덱스 `발주`
--
ALTER TABLE `발주`
  ADD PRIMARY KEY (`사업장코드`,`발주일자`,`발주번호`),
  ADD KEY `IX_입고희망일자` (`입고희망일자`),
  ADD KEY `IX_입고일자` (`입고일자`),
  ADD KEY `FK_발주_매입처` (`사업장코드`,`매입처코드`);

--
-- 테이블의 인덱스 `발주내역`
--
ALTER TABLE `발주내역`
  ADD PRIMARY KEY (`사업장코드`,`발주일자`,`발주번호`,`발주시간`,`자재코드`,`매출처코드`),
  ADD KEY `IX_매입처코드` (`매입처코드`),
  ADD KEY `IX_입고일자` (`입고일자`);

--
-- 테이블의 인덱스 `사업장`
--
ALTER TABLE `사업장`
  ADD PRIMARY KEY (`사업장코드`),
  ADD KEY `IX_사업장명` (`사업장명`);

--
-- 테이블의 인덱스 `사용자`
--
ALTER TABLE `사용자`
  ADD PRIMARY KEY (`사용자코드`),
  ADD KEY `IX_사용자명` (`사용자명`);

--
-- 테이블의 인덱스 `세금계산서`
--
ALTER TABLE `세금계산서`
  ADD PRIMARY KEY (`사업장코드`,`작성년도`,`책번호`,`일련번호`),
  ADD KEY `IX_작성일자` (`사업장코드`,`작성일자`),
  ADD KEY `IX_매출처코드` (`사업장코드`,`매출처코드`);

--
-- 테이블의 인덱스 `시스템설정`
--
ALTER TABLE `시스템설정`
  ADD PRIMARY KEY (`키`);

--
-- 테이블의 인덱스 `우편번호`
--
ALTER TABLE `우편번호`
  ADD KEY `IX_우편번호` (`우편번호`),
  ADD KEY `IX_읍면동` (`우편번호`,`읍면동`);

--
-- 테이블의 인덱스 `자재`
--
ALTER TABLE `자재`
  ADD PRIMARY KEY (`분류코드`,`세부코드`),
  ADD KEY `IX_자재명` (`자재명`),
  ADD KEY `IX_바코드` (`바코드`),
  ADD KEY `IX_규격` (`규격`);

--
-- 테이블의 인덱스 `자재분류`
--
ALTER TABLE `자재분류`
  ADD PRIMARY KEY (`분류코드`),
  ADD KEY `IX_분류명` (`분류명`);

--
-- 테이블의 인덱스 `자재원장`
--
ALTER TABLE `자재원장`
  ADD PRIMARY KEY (`사업장코드`,`분류코드`,`세부코드`),
  ADD KEY `FK_자재원장_자재` (`분류코드`,`세부코드`);

--
-- 테이블의 인덱스 `자재입출내역`
--
ALTER TABLE `자재입출내역`
  ADD PRIMARY KEY (`사업장코드`,`분류코드`,`세부코드`,`입출고구분`,`입출고일자`,`입출고시간`,`매출처코드`),
  ADD KEY `IX_거래일번` (`사업장코드`,`거래일자`,`거래번호`),
  ADD KEY `IX_세금계산서` (`사업장코드`,`작성년도`,`책번호`,`일련번호`),
  ADD KEY `FK_자재입출내역_자재` (`분류코드`,`세부코드`);

--
-- 덤프된 테이블의 제약사항
--

--
-- 테이블의 제약사항 `견적`
--
ALTER TABLE `견적`
  ADD CONSTRAINT `FK_견적_매출처` FOREIGN KEY (`사업장코드`,`매출처코드`) REFERENCES `매출처` (`사업장코드`, `매출처코드`);

--
-- 테이블의 제약사항 `견적내역`
--
ALTER TABLE `견적내역`
  ADD CONSTRAINT `FK_견적내역_견적` FOREIGN KEY (`사업장코드`,`견적일자`,`견적번호`) REFERENCES `견적` (`사업장코드`, `견적일자`, `견적번호`);

--
-- 테이블의 제약사항 `매입세금계산서장부`
--
ALTER TABLE `매입세금계산서장부`
  ADD CONSTRAINT `FK_매입세금계산서장부_매입처` FOREIGN KEY (`사업장코드`,`매입처코드`) REFERENCES `매입처` (`사업장코드`, `매입처코드`);

--
-- 테이블의 제약사항 `매입처`
--
ALTER TABLE `매입처`
  ADD CONSTRAINT `FK_매입처_사업장` FOREIGN KEY (`사업장코드`) REFERENCES `사업장` (`사업장코드`);

--
-- 테이블의 제약사항 `매출세금계산서장부`
--
ALTER TABLE `매출세금계산서장부`
  ADD CONSTRAINT `FK_매출세금계산서장부_매출처` FOREIGN KEY (`사업장코드`,`매출처코드`) REFERENCES `매출처` (`사업장코드`, `매출처코드`);

--
-- 테이블의 제약사항 `매출처`
--
ALTER TABLE `매출처`
  ADD CONSTRAINT `FK_매출처_사업장` FOREIGN KEY (`사업장코드`) REFERENCES `사업장` (`사업장코드`);

--
-- 테이블의 제약사항 `발주`
--
ALTER TABLE `발주`
  ADD CONSTRAINT `FK_발주_매입처` FOREIGN KEY (`사업장코드`,`매입처코드`) REFERENCES `매입처` (`사업장코드`, `매입처코드`);

--
-- 테이블의 제약사항 `발주내역`
--
ALTER TABLE `발주내역`
  ADD CONSTRAINT `FK_발주내역_발주` FOREIGN KEY (`사업장코드`,`발주일자`,`발주번호`) REFERENCES `발주` (`사업장코드`, `발주일자`, `발주번호`);

--
-- 테이블의 제약사항 `세금계산서`
--
ALTER TABLE `세금계산서`
  ADD CONSTRAINT `FK_세금계산서_매출처` FOREIGN KEY (`사업장코드`,`매출처코드`) REFERENCES `매출처` (`사업장코드`, `매출처코드`);

--
-- 테이블의 제약사항 `자재`
--
ALTER TABLE `자재`
  ADD CONSTRAINT `FK_자재_자재분류` FOREIGN KEY (`분류코드`) REFERENCES `자재분류` (`분류코드`);

--
-- 테이블의 제약사항 `자재원장`
--
ALTER TABLE `자재원장`
  ADD CONSTRAINT `FK_자재원장_사업장` FOREIGN KEY (`사업장코드`) REFERENCES `사업장` (`사업장코드`),
  ADD CONSTRAINT `FK_자재원장_자재` FOREIGN KEY (`분류코드`,`세부코드`) REFERENCES `자재` (`분류코드`, `세부코드`);

--
-- 테이블의 제약사항 `자재입출내역`
--
ALTER TABLE `자재입출내역`
  ADD CONSTRAINT `FK_자재입출내역_사업장` FOREIGN KEY (`사업장코드`) REFERENCES `사업장` (`사업장코드`),
  ADD CONSTRAINT `FK_자재입출내역_자재` FOREIGN KEY (`분류코드`,`세부코드`) REFERENCES `자재` (`분류코드`, `세부코드`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_자재입출내역_자재원장` FOREIGN KEY (`사업장코드`,`분류코드`,`세부코드`) REFERENCES `자재원장` (`사업장코드`, `분류코드`, `세부코드`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
