-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- 생성 시간: 25-10-19 13:44
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
-- 테이블 구조 `사용자`
--

CREATE TABLE `사용자` (
  `사용자코드` varchar(4) NOT NULL,
  `아이디` varchar(30) NOT NULL,
  `비밀번호` varchar(255) NOT NULL,
  `이름` varchar(50) NOT NULL,
  `권한` varchar(20) NOT NULL DEFAULT 'user',
  `사용여부` tinyint(4) NOT NULL DEFAULT 1,
  `수정일시` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 테이블의 덤프 데이터 `사용자`
--

INSERT INTO `사용자` (`사용자코드`, `아이디`, `비밀번호`, `이름`, `권한`, `사용여부`, `수정일시`) VALUES
('0001', 'admin', '$2y$10$GzAD7uxSsE8m4uEV73ynFuHtZwbt.fRYaMOqTBAAKw6fFJitTaZL6', '관리자', 'admin', 1, '2025-10-18 08:32:48');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `사용자`
--
ALTER TABLE `사용자`
  ADD PRIMARY KEY (`사용자코드`),
  ADD UNIQUE KEY `아이디` (`아이디`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
