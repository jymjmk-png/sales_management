-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: YmhDB
-- Source Schemata: YmhDB
-- Created: Sun Oct 19 15:21:20 2025
-- Workbench Version: 8.0.43
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema YmhDB
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `YmhDB` ;
CREATE SCHEMA IF NOT EXISTS `YmhDB` ;

-- ----------------------------------------------------------------------------
-- Table YmhDB.계정과목
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`계정과목` (
  `계정코드` VARCHAR(4) NOT NULL DEFAULT '',
  `계정명` VARCHAR(30) NOT NULL DEFAULT '',
  `합계시산표연결여부` VARCHAR(1) NOT NULL DEFAULT 'Y',
  `적요` VARCHAR(60) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`계정코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.우편번호
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`우편번호` (
  `우편번호` VARCHAR(7) CHARACTER SET 'utf8mb4' NOT NULL DEFAULT '',
  `주소1` VARCHAR(45) CHARACTER SET 'utf8mb4' NOT NULL DEFAULT '',
  `주소2` VARCHAR(30) CHARACTER SET 'utf8mb4' NOT NULL DEFAULT '',
  `읍면동` VARCHAR(30) CHARACTER SET 'utf8mb4' NOT NULL DEFAULT '',
  `번지` VARCHAR(15) CHARACTER SET 'utf8mb4' NOT NULL DEFAULT '',
  `지역번호` VARCHAR(3) CHARACTER SET 'utf8mb4' NOT NULL DEFAULT '',
  INDEX `IX_우편번호` (`우편번호` ASC) VISIBLE,
  INDEX `IX_읍면동` (`우편번호` ASC, `읍면동` ASC) VISIBLE);

-- ----------------------------------------------------------------------------
-- Table YmhDB.매출처
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`매출처` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `매출처명` VARCHAR(30) NOT NULL DEFAULT '',
  `사업자번호` VARCHAR(14) NOT NULL DEFAULT '',
  `법인번호` VARCHAR(14) NOT NULL DEFAULT '',
  `대표자명` VARCHAR(30) NOT NULL DEFAULT '',
  `대표자주민번호` VARCHAR(14) NOT NULL DEFAULT '',
  `개업일자` VARCHAR(8) NOT NULL DEFAULT '',
  `우편번호` VARCHAR(7) NOT NULL DEFAULT '',
  `주소` VARCHAR(60) NOT NULL DEFAULT '',
  `번지` VARCHAR(60) NOT NULL DEFAULT '',
  `업태` VARCHAR(30) NOT NULL DEFAULT '',
  `업종` VARCHAR(30) NOT NULL DEFAULT '',
  `전화번호` VARCHAR(20) NOT NULL DEFAULT '',
  `팩스번호` VARCHAR(14) NOT NULL DEFAULT '',
  `은행코드` VARCHAR(2) NOT NULL DEFAULT '',
  `계좌번호` VARCHAR(20) NOT NULL DEFAULT '',
  `계산서발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `계산서발행율` DECIMAL(19,4) NOT NULL DEFAULT 100,
  `담당자명` VARCHAR(30) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `비고란` VARCHAR(100) NOT NULL DEFAULT '',
  `단가구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`사업장코드`, `매출처코드`),
  CONSTRAINT `FK_매출처_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.은행
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`은행` (
  `은행코드` VARCHAR(2) NOT NULL DEFAULT '',
  `은행명` VARCHAR(30) NOT NULL DEFAULT '',
  `적요` VARCHAR(60) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`은행코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재` (
  `분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `자재명` VARCHAR(30) NOT NULL DEFAULT '',
  `바코드` VARCHAR(13) NOT NULL DEFAULT '',
  `규격` VARCHAR(30) NOT NULL DEFAULT '',
  `단위` VARCHAR(20) NOT NULL DEFAULT '',
  `폐기율` DECIMAL(19,4) NOT NULL DEFAULT 0.00,
  `과세구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `적요` VARCHAR(60) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`분류코드`, `세부코드`),
  INDEX `IX_자재명` (`자재명` ASC) VISIBLE,
  INDEX `IX_바코드` (`자재명` ASC) VISIBLE,
  INDEX `IX_규격` (`규격` ASC) VISIBLE,
  CONSTRAINT `FK_자재_자재분류`
    FOREIGN KEY (`분류코드`)
    REFERENCES `YmhDB`.`자재분류` (`분류코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재분류
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재분류` (
  `분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `분류명` VARCHAR(30) NOT NULL DEFAULT '',
  `적요` VARCHAR(60) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`분류코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재원장마감
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재원장마감` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `입고누계수량` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고누계수량` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `분류코드`, `세부코드`, `마감년월`),
  CONSTRAINT `FK_자재원장마감_자재`
    FOREIGN KEY (`분류코드` , `세부코드`)
    REFERENCES `YmhDB`.`자재` (`분류코드` , `세부코드`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재시세
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재시세` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `적용일자` VARCHAR(8) NOT NULL DEFAULT '',
  `입고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `마진율` DECIMAL(19,4) NOT NULL DEFAULT 0.00,
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `분류코드`, `세부코드`, `매입처코드`, `적용일자`),
  CONSTRAINT `FK_자재시세_자재`
    FOREIGN KEY (`분류코드` , `세부코드`)
    REFERENCES `YmhDB`.`자재` (`분류코드` , `세부코드`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_자재시세_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.클라이언트정보
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`클라이언트정보` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `클라이언트이름` VARCHAR(20) NOT NULL DEFAULT '',
  `핸디스캐너유무` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`사업장코드`, `클라이언트이름`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재코드변경
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재코드변경` (
  `변경전분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `변경전세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `변경일시` VARCHAR(17) NOT NULL DEFAULT '',
  `변경후분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `변경후세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`변경전분류코드`, `변경전세부코드`, `변경일시`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.dtproperties
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`dtproperties` (
  `id` INT NOT NULL,
  `objectid` INT NULL,
  `property` VARCHAR(64) NOT NULL,
  `value` VARCHAR(255) NULL,
  `uvalue` VARCHAR(255) CHARACTER SET 'utf8mb4' NULL,
  `lvalue` LONGBLOB NULL,
  `version` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `property`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.미수금내역
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`미수금내역` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `미수금입금일자` VARCHAR(8) NOT NULL DEFAULT '',
  `미수금입금시간` VARCHAR(9) NOT NULL DEFAULT '',
  `미수금입금금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `결제방법` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `만기일자` VARCHAR(8) NOT NULL DEFAULT '',
  `어음번호` VARCHAR(20) NOT NULL DEFAULT '',
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `매출처코드`, `미수금입금일자`, `미수금입금시간`),
  CONSTRAINT `FK_미수금내역_매출처`
    FOREIGN KEY (`사업장코드` , `매출처코드`)
    REFERENCES `YmhDB`.`매출처` (`사업장코드` , `매출처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재입출내역
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재입출내역` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `입출고구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `입출고시간` VARCHAR(9) NOT NULL DEFAULT '',
  `입고수량` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고수량` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `원래입출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `직송구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `발견일자` VARCHAR(8) NOT NULL DEFAULT '',
  `발견번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `거래일자` VARCHAR(8) NOT NULL DEFAULT '',
  `거래번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `계산서발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `현금구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `감가구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `작성년도` VARCHAR(4) NOT NULL DEFAULT '',
  `책번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `일련번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `재고이동사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `분류코드`, `세부코드`, `입출고구분`, `입출고일자`, `입출고시간`, `매출처코드`),
  INDEX `IX_거래일번` (`사업장코드` ASC, `거래일자` ASC, `거래번호` ASC) VISIBLE,
  INDEX `IX_세금계산서` (`사업장코드` ASC, `작성년도` ASC, `책번호` ASC, `일련번호` ASC) VISIBLE,
  CONSTRAINT `FK_자재입출내역_자재원장`
    FOREIGN KEY (`사업장코드` , `분류코드` , `세부코드`)
    REFERENCES `YmhDB`.`자재원장` (`사업장코드` , `분류코드` , `세부코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_자재입출내역_자재`
    FOREIGN KEY (`분류코드` , `세부코드`)
    REFERENCES `YmhDB`.`자재` (`분류코드` , `세부코드`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_자재입출내역_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_자재입출내역_사용자`
    FOREIGN KEY (`사용자코드`)
    REFERENCES `YmhDB`.`사용자` (`사용자코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.매출세금계산서장부
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`매출세금계산서장부` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT 1,
  `작성일자` VARCHAR(8) NOT NULL DEFAULT '',
  `작성시간` VARCHAR(9) NOT NULL DEFAULT '',
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `품목및규격` VARCHAR(50) NOT NULL DEFAULT '',
  `수량` FLOAT(24,0) NOT NULL DEFAULT 0,
  `공급가액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `세액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `금액구분` TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `영청구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `작성구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `미수구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `작성년도` VARCHAR(4) NOT NULL DEFAULT '',
  `책번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `일련번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`사업장코드`, `작성일자`, `작성시간`),
  INDEX `IX_매출세금계산서번호` (`사업장코드` ASC, `작성년도` ASC, `책번호` ASC, `일련번호` ASC) VISIBLE,
  CONSTRAINT `FK_매출세금계산서장부_매출처`
    FOREIGN KEY (`사업장코드` , `매출처코드`)
    REFERENCES `YmhDB`.`매출처` (`사업장코드` , `매출처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.매입세금계산서장부
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`매입세금계산서장부` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT 1,
  `작성일자` VARCHAR(8) NOT NULL DEFAULT '',
  `작성시간` VARCHAR(9) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `품목및규격` VARCHAR(50) NOT NULL DEFAULT '',
  `수량` FLOAT(24,0) NOT NULL DEFAULT 0,
  `공급가액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `세액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `금액구분` TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `영청구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `작성구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `미지급구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `작성년도` VARCHAR(4) NOT NULL DEFAULT '',
  `책번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `일련번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`사업장코드`, `작성일자`, `작성시간`),
  INDEX `IX_매입세금계산서번호` (`사업장코드` ASC, `작성년도` ASC, `책번호` ASC, `일련번호` ASC) VISIBLE,
  CONSTRAINT `FK_매입세금계산서장부_매입처`
    FOREIGN KEY (`사업장코드` , `매입처코드`)
    REFERENCES `YmhDB`.`매입처` (`사업장코드` , `매입처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.미수금원장
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`미수금원장` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `최종미수금일자` VARCHAR(8) NOT NULL DEFAULT '',
  `최종입금일자` VARCHAR(8) NOT NULL DEFAULT '',
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `매출처코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.미수금원장마감
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`미수금원장마감` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `미수금누계금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `미수금입금누계금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `매출처코드`, `마감년월`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.프린터환경설정
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`프린터환경설정` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT 1,
  `거래명세서공급자란인쇄유무` INT NOT NULL DEFAULT 0,
  `거래명세서상단마진` INT NOT NULL DEFAULT 5,
  `거래명세서왼쪽마진` INT NOT NULL DEFAULT 13,
  `세금계산서공급자란인쇄유무` INT NOT NULL DEFAULT 0,
  `세금계산서상단마진` INT NOT NULL DEFAULT 2,
  `세금계산서왼쪽마진` INT NOT NULL DEFAULT 20,
  PRIMARY KEY (`사업장코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.사용자
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`사용자` (
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `사용자명` VARCHAR(30) NOT NULL DEFAULT '',
  `사용자권한` VARCHAR(200) NOT NULL DEFAULT '',
  `로그인여부` VARCHAR(1) NOT NULL DEFAULT '',
  `로그인비밀번호` VARCHAR(4) NOT NULL DEFAULT '',
  `결재비밀번호` VARCHAR(4) NOT NULL DEFAULT '',
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `시작일시` VARCHAR(17) NOT NULL DEFAULT '',
  `종료일시` VARCHAR(17) NOT NULL DEFAULT '',
  PRIMARY KEY (`사용자코드`),
  CONSTRAINT `FK_사용자_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.사업장
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`사업장` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `사업장명` VARCHAR(30) NOT NULL DEFAULT '',
  `사업자번호` VARCHAR(14) NOT NULL DEFAULT '',
  `법인번호` VARCHAR(14) NOT NULL DEFAULT '',
  `대표자명` VARCHAR(30) NOT NULL DEFAULT '',
  `대표자주민번호` VARCHAR(14) NOT NULL DEFAULT '',
  `개업일자` VARCHAR(8) NOT NULL DEFAULT '',
  `우편번호` VARCHAR(7) NOT NULL DEFAULT '',
  `주소` VARCHAR(60) NOT NULL DEFAULT '',
  `번지` VARCHAR(60) NOT NULL DEFAULT '',
  `업태` VARCHAR(30) NOT NULL DEFAULT '',
  `업종` VARCHAR(30) NOT NULL DEFAULT '',
  `전화번호` VARCHAR(20) NOT NULL DEFAULT '',
  `팩스번호` VARCHAR(14) NOT NULL DEFAULT '',
  `부가세율` DECIMAL(19,4) NOT NULL DEFAULT 0.00,
  `미지급금발생구분` TINYINT UNSIGNED NOT NULL DEFAULT 2,
  `미수금발생구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `이메일주소` VARCHAR(50) NOT NULL DEFAULT '',
  `홈페이지주소` VARCHAR(50) NOT NULL DEFAULT '',
  `백업폴더` VARCHAR(50) NOT NULL DEFAULT '',
  `자재기초마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `미지급금기초마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `미수금기초마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `회계기초마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `출력타입구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `거래명세서상단마진` INT NOT NULL DEFAULT 5,
  `거래명세서왼쪽마진` INT NOT NULL DEFAULT 13,
  `세금계산서상단마진` INT NOT NULL DEFAULT 2,
  `세금계산서왼쪽마진` INT NOT NULL DEFAULT 20,
  `최종입고단가자동갱신구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `최종출고단가자동갱신구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`사업장코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.미지급금내역
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`미지급금내역` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `미지급금지급일자` VARCHAR(8) NOT NULL DEFAULT '',
  `미지급금지급시간` VARCHAR(9) NOT NULL DEFAULT '',
  `미지급금지급금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `결제방법` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `만기일자` VARCHAR(8) NOT NULL DEFAULT '',
  `어음번호` VARCHAR(20) NOT NULL DEFAULT '',
  `적요` VARCHAR(50) NOT NULL,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `매입처코드`, `미지급금지급일자`, `미지급금지급시간`),
  CONSTRAINT `FK_미지급금내역_매입처`
    FOREIGN KEY (`사업장코드` , `매입처코드`)
    REFERENCES `YmhDB`.`매입처` (`사업장코드` , `매입처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.제조처
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`제조처` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `제조처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `제조처명` VARCHAR(30) NOT NULL DEFAULT '',
  `사업자번호` VARCHAR(14) NOT NULL DEFAULT '',
  `법인번호` VARCHAR(14) NOT NULL DEFAULT '',
  `대표자명` VARCHAR(30) NOT NULL DEFAULT '',
  `대표자주민번호` VARCHAR(14) NOT NULL DEFAULT '',
  `개업일자` VARCHAR(8) NOT NULL DEFAULT '',
  `우편번호` VARCHAR(7) NOT NULL DEFAULT '',
  `주소` VARCHAR(60) NOT NULL DEFAULT '',
  `번지` VARCHAR(60) NOT NULL DEFAULT '',
  `업태` VARCHAR(30) NOT NULL DEFAULT '',
  `업종` VARCHAR(30) NOT NULL DEFAULT '',
  `전화번호` VARCHAR(20) NOT NULL DEFAULT '',
  `팩스번호` VARCHAR(14) NOT NULL DEFAULT '',
  `은행코드` VARCHAR(2) NOT NULL DEFAULT '',
  `계좌번호` VARCHAR(20) NOT NULL DEFAULT '',
  `담당자명` VARCHAR(30) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `제조처코드`),
  CONSTRAINT `FK_제조처_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.미지급금원장
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`미지급금원장` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `최종미지급금일자` VARCHAR(8) NOT NULL DEFAULT '',
  `최종지급일자` VARCHAR(8) NOT NULL DEFAULT '',
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `매입처코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.견적
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`견적` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `견적일자` VARCHAR(8) NOT NULL DEFAULT '',
  `견적번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `출고희망일자` VARCHAR(8) NOT NULL DEFAULT '',
  `결제방법` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `결제예정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `유효일수` INT NOT NULL DEFAULT 0,
  `제목` VARCHAR(30) NOT NULL DEFAULT '',
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `상태코드` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `견적일자`, `견적번호`),
  INDEX `IX_출고일자` (`출고일자` ASC) VISIBLE,
  INDEX `IX_출고희망일자` (`출고희망일자` ASC) VISIBLE,
  CONSTRAINT `FK_견적_매출처`
    FOREIGN KEY (`사업장코드` , `매출처코드`)
    REFERENCES `YmhDB`.`매출처` (`사업장코드` , `매출처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.회계전표내역
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`회계전표내역` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `작성일자` VARCHAR(8) NOT NULL DEFAULT '',
  `작성시간` VARCHAR(9) NOT NULL DEFAULT '',
  `계정코드` VARCHAR(4) NOT NULL DEFAULT '',
  `입출구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입금금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출금금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `적요` VARCHAR(60) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `작성자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `작성일자`, `작성시간`),
  CONSTRAINT `FK_회계전표내역_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_회계전표내역_계정과목`
    FOREIGN KEY (`계정코드`)
    REFERENCES `YmhDB`.`계정과목` (`계정코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.회계전표내역마감
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`회계전표내역마감` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `계정코드` VARCHAR(4) NOT NULL DEFAULT '',
  `마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `입금누계금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출금누계금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `계정코드`, `마감년월`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.미지급금원장마감
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`미지급금원장마감` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `마감년월` VARCHAR(6) NOT NULL DEFAULT '',
  `미지급금누계금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `미지급금지급누계금액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `매입처코드`, `마감년월`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.sysdiagrams
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`sysdiagrams` (
  `name` VARCHAR(160) NOT NULL,
  `principal_id` INT NOT NULL,
  `diagram_id` INT NOT NULL,
  `version` INT NULL,
  `definition` LONGBLOB NULL,
  PRIMARY KEY (`diagram_id`),
  UNIQUE INDEX `UK_principal_name` (`principal_id` ASC, `name` ASC) VISIBLE);

-- ----------------------------------------------------------------------------
-- Table YmhDB.발주
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`발주` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `발주일자` VARCHAR(8) NOT NULL DEFAULT '',
  `발주번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `입고희망일자` VARCHAR(8) NOT NULL DEFAULT '',
  `결제방법` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `결제예정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `유효일수` INT NOT NULL DEFAULT 0,
  `제목` VARCHAR(30) NOT NULL DEFAULT '',
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `상태코드` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `발주일자`, `발주번호`),
  INDEX `IX_입고희망일자` (`입고희망일자` ASC) VISIBLE,
  INDEX `IX_입고일자` (`입고일자` ASC) VISIBLE,
  CONSTRAINT `FK_발주_매입처`
    FOREIGN KEY (`사업장코드` , `매입처코드`)
    REFERENCES `YmhDB`.`매입처` (`사업장코드` , `매입처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.견적내역
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`견적내역` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `견적일자` VARCHAR(8) NOT NULL DEFAULT '',
  `견적번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `견적시간` VARCHAR(9) NOT NULL DEFAULT '',
  `자재코드` VARCHAR(18) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `수량` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `계산서발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `상태코드` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `견적일자`, `견적번호`, `견적시간`, `자재코드`),
  INDEX `IX_매출처코드` (`매출처코드` ASC) VISIBLE,
  INDEX `IX_출고일자` (`출고일자` ASC) VISIBLE,
  CONSTRAINT `FK_견적내역_매출처`
    FOREIGN KEY (`사업장코드` , `견적일자` , `견적번호`)
    REFERENCES `YmhDB`.`견적` (`사업장코드` , `견적일자` , `견적번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.발주내역
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`발주내역` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `발주일자` VARCHAR(8) NOT NULL DEFAULT '',
  `발주번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `발주시간` VARCHAR(9) NOT NULL DEFAULT '',
  `자재코드` VARCHAR(18) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `발주량` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `직송구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `입고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고부가` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `상태코드` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `입고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `발주일자`, `발주번호`, `발주시간`, `자재코드`, `매출처코드`),
  INDEX `IX_매입처코드` (`매입처코드` ASC) VISIBLE,
  INDEX `IX_입고일자` (`입고일자` ASC) VISIBLE,
  CONSTRAINT `FK_발주내역_발주`
    FOREIGN KEY (`사업장코드` , `발주일자` , `발주번호`)
    REFERENCES `YmhDB`.`발주` (`사업장코드` , `발주일자` , `발주번호`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.매입처
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`매입처` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `매입처명` VARCHAR(30) NOT NULL DEFAULT '',
  `사업자번호` VARCHAR(14) NOT NULL DEFAULT '',
  `법인번호` VARCHAR(14) NOT NULL DEFAULT '',
  `대표자명` VARCHAR(30) NOT NULL DEFAULT '',
  `대표자주민번호` VARCHAR(14) NOT NULL DEFAULT '',
  `개업일자` VARCHAR(8) NOT NULL DEFAULT '',
  `우편번호` VARCHAR(7) NOT NULL DEFAULT '',
  `주소` VARCHAR(60) NOT NULL DEFAULT '',
  `번지` VARCHAR(60) NOT NULL DEFAULT '',
  `업태` VARCHAR(30) NOT NULL DEFAULT '',
  `업종` VARCHAR(30) NOT NULL DEFAULT '',
  `전화번호` VARCHAR(20) NOT NULL DEFAULT '',
  `팩스번호` VARCHAR(14) NOT NULL DEFAULT '',
  `은행코드` VARCHAR(2) NOT NULL DEFAULT '',
  `계좌번호` VARCHAR(20) NOT NULL DEFAULT '',
  `계산서발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `계산서발행율` DECIMAL(19,4) NOT NULL DEFAULT 100,
  `담당자명` VARCHAR(30) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `비고란` VARCHAR(100) NOT NULL DEFAULT '',
  `단가구분` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`사업장코드`, `매입처코드`),
  CONSTRAINT `FK_매입처_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.로그
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`로그` (
  `테이블명` VARCHAR(50) NOT NULL,
  `베이스코드` VARCHAR(50) NOT NULL,
  `최종로그` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `최종로그1` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`테이블명`, `베이스코드`));

-- ----------------------------------------------------------------------------
-- Table YmhDB.세금계산서
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`세금계산서` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT 1,
  `작성년도` VARCHAR(4) NOT NULL DEFAULT '',
  `책번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `일련번호` FLOAT(24,0) NOT NULL DEFAULT 0,
  `매출처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `작성일자` VARCHAR(8) NOT NULL DEFAULT '',
  `품목및규격` VARCHAR(50) NOT NULL DEFAULT '',
  `수량` FLOAT(24,0) NOT NULL DEFAULT 0,
  `공급가액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `세액` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `금액구분` TINYINT UNSIGNED NOT NULL DEFAULT 3,
  `영청구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `발행여부` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `작성구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `미수구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `적요` VARCHAR(50) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`사업장코드`, `작성년도`, `책번호`, `일련번호`),
  INDEX `IX_작성일자` (`사업장코드` ASC, `작성일자` ASC) VISIBLE,
  INDEX `IX_매출처코드` (`사업장코드` ASC, `매출처코드` ASC) VISIBLE,
  CONSTRAINT `FK_세금계산서_매출처`
    FOREIGN KEY (`사업장코드` , `매출처코드`)
    REFERENCES `YmhDB`.`매출처` (`사업장코드` , `매출처코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table YmhDB.자재원장
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `YmhDB`.`자재원장` (
  `사업장코드` VARCHAR(2) NOT NULL DEFAULT '',
  `분류코드` VARCHAR(2) NOT NULL DEFAULT '',
  `세부코드` VARCHAR(16) NOT NULL DEFAULT '',
  `적정재고` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `최저재고` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `최종입고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `최종출고일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용구분` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `수정일자` VARCHAR(8) NOT NULL DEFAULT '',
  `사용자코드` VARCHAR(4) NOT NULL DEFAULT '',
  `비고란` VARCHAR(100) NOT NULL DEFAULT '',
  `주매입처코드` VARCHAR(8) NOT NULL DEFAULT '',
  `입고단가1` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고단가2` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `입고단가3` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가1` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가2` DECIMAL(19,4) NOT NULL DEFAULT 0,
  `출고단가3` DECIMAL(19,4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`사업장코드`, `분류코드`, `세부코드`),
  CONSTRAINT `FK_자재원장_사업장`
    FOREIGN KEY (`사업장코드`)
    REFERENCES `YmhDB`.`사업장` (`사업장코드`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_자재원장_자재`
    FOREIGN KEY (`분류코드` , `세부코드`)
    REFERENCES `YmhDB`.`자재` (`분류코드` , `세부코드`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매입처원장인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매입처원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMJGbn int = 2)
-- 
-- AS
-- 
-- IF @ParMJGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            T1.입출고구분 AS 구분, T1.입고수량 AS 입고수량, T1.입고단가 AS 입고단가, (T1.입고수량 * T1.입고단가) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 1) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            1 AS 구분, T1.입고수량 AS 입고수량, T1.입고단가 AS 입고단가, (T1.입고수량 * T1.입고단가) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.입출고구분 = 1
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매입처정보인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매입처정보인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0, @ParSortGbn int = 0)
-- 
-- AS
-- IF @ParSortGbn = 0 
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매입처코드 AS 매입처코드, 
--             T1.매입처명 AS 매입처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율 
--        FROM 매입처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매입처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매입처코드 AS 매입처코드, 
--             T1.매입처명 AS 매입처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율
--        FROM 매입처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매입처명
--    END
--  
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매출세금계산서장부현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매출세금계산서장부현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.작성일자 AS 작성일자, T1.작성시간,
--            T1.매출처코드 AS 매출처코드, T2.매출처명 AS 매출처명, 
--            T1.공급가액 AS 공급가액, T1.세액 AS 세액, 
--            T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--            T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.발행여부 AS 발행여부,
--            T1.작성구분 AS 작성구분, T1.미수구분 AS 미수구분, T1.사용구분 AS 사용구분 
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 매출처 T2 ON T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.작성일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--      ORDER BY T1.사업장코드, T1.작성일자, T1.작성시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매출세금계산서현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매출세금계산서현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.작성년도 AS 작성년도, 
--            T1.책번호 AS 책번호, T1.일련번호 AS 일련번호, 
--            T1.작성일자 AS 작성일자, T1.매출처코드 AS 매출처코드, T2.매출처명 AS 매출처명, 
--            T1.공급가액 AS 공급가액, T1.세액 AS 세액, 
--            T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--            T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.발행여부 AS 발행여부,
--            T1.작성구분 AS 작성구분, T1.미수구분 AS 미수구분, T1.사용구분 AS 사용구분 
--       FROM 세금계산서 T1 
--       LEFT JOIN 매출처 T2 ON T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.작성일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--      ORDER BY T1.사업장코드, T1.작성일자, T1.작성년도, T1.책번호, T1.일련번호 
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매출처보조부인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매출처보조부인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParBranchCode VarChar(2) = '01')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이월)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 출고수량, 0 AS 출고단가,
--            0 AS 출고부가, (T1.미수금누계금액 - T1.미수금입금누계금액) AS 출고금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) = '00' 
--        AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월   계)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 출고수량, 0 AS 출고단가,
--            0 AS 출고부가, (T1.미수금누계금액 - T1.미수금입금누계금액) AS 출고금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) <> '00' 
--        AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, (T1.원래입출고일자) AS 적요, 
--            T1.분류코드 AS 분류코드, T4.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T5.자재명, '') AS 자재명, 
--            ISNULL(T5.규격,'') AS 규격, ISNULL(T5.단위,'') AS 단위, T1.입출고구분 AS 구분,
--            SUM(T1.출고수량) AS 출고수량, T1.출고단가 AS 출고단가, 
--            T1.출고부가 AS 출고부가, (SUM(T1.출고수량*T1.출고단가)) AS 출고금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.입출고일자, T1.원래입출고일자,
--               T1.분류코드, T4.분류명, T1.세부코드, T5.자재명, 
--               T5.규격, T5.단위, T1.입출고구분, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, 일자, 자재명, 구분  
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매출처원장인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매출처원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMSGbn int = 2)
-- 
-- AS
-- 
-- IF @ParMSGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            T1.입출고구분 AS 구분, T1.출고수량 AS 출고수량, T1.출고단가 AS 출고단가, (T1.출고수량 * T1.출고단가) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 2) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 시간, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            2 AS 구분, T1.출고수량 AS 출고수량, T1.출고단가 AS 출고단가, (T1.출고수량 * T1.출고단가) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.입출고구분 = 2
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 시간, 구분  
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매출처정보인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매출처정보인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0, @ParSortGbn int = 0)
-- 
-- AS
-- IF @ParSortGbn = 0 
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매출처코드 AS 매출처코드, 
--             T1.매출처명 AS 매출처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율
--        FROM 매출처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매출처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매출처코드 AS 매출처코드, 
--             T1.매출처명 AS 매출처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율
--        FROM 매출처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매출처명
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp미달상품내역인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp미달상품내역인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명, 
--            ISNULL(T1.세부코드,'') AS 세부코드, T3.자재명 AS 자재명, 
--            T3.규격 AS 규격, T3.단위 AS 단위, T3.폐기율 AS 폐기율, T3.과세구분 AS 과세구분, 
--            T1.사용구분 AS 사용구분, T1.적정재고 AS 적정재고, 
--            ISNULL(T1.최종입고일자,'') AS 최종입고일자, ISNULL(T1.최종출고일자,'') AS 최종출고일자, 
--           (SELECT ISNULL(SUM(입고누계수량-출고누계수량),0) 
--             FROM 자재원장마감 
--            WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--              AND 사업장코드 = T1.사업장코드 
--              AND 마감년월 >= SUBSTRING(@ParTDate, 1, 4) + '00' 
--              AND 마감년월 < SUBSTRING(@ParTDate, 1, 6)) AS 이월재고,
--           (SELECT ISNULL(SUM(입고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 1)
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6) + '01' AND @ParTDate) AS 입고수량,
--           (SELECT ISNULL(SUM(출고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 2)
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6)  + '01' AND @ParTDate) AS 출고수량,
--           (SELECT ISNULL(SUM(입고수량-출고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 5 OR 입출고구분 = 6) 
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6) + '01' AND @ParTDate) AS 재고조정수량,
--           (SELECT ISNULL(SUM(입고수량-출고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 11 OR 입출고구분 = 12) 
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6) + '01' AND @ParTDate) AS 재고이동수량
--       FROM 자재원장 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재 T3 ON T3.분류코드 = T1.분류코드 AND T3.세부코드 = T1.세부코드                     
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.적정재고 <> 0
--   ORDER BY T1.사업장코드, T1.분류코드, T3.자재명
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp미수금원장인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp미수금원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMSGbn int = 2)
-- 
-- AS
-- IF @ParMSGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            T1.입출고구분 AS 구분, (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.입출고일자, T1.입출고시간, T1.현금구분, T1.입출고구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, T3.매출처명 AS 매출처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            2 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.미수구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 시간, 구분  
--    END
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp미지급금원장인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp미지급금원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMJGbn int = 2)
-- AS
-- IF @ParMJGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            T1.입출고구분 AS 구분, (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 1) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.입출고일자, T1.입출고시간, T1.현금구분, T1.입출고구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            1 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.미지급구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp반입내역_업체별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp반입내역_업체별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매출처코드,'') AS 업체코드, ISNULL(T3.매출처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.출고수량 AS 수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           (T1.출고수량 * T1.출고단가) AS 금액1, ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매출처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드= T1.매출처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 2 AND T1.출고수량 < 0 
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매출처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp반입내역_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp반입내역_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매출처코드,'') AS 업체코드, ISNULL(T3.매출처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.출고수량 AS 수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           (T1.출고수량 * T1.출고단가) AS 금액1, ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매출처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드= T1.매출처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 2 AND T1.출고수량 < 0 
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매출처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp반품내역_업체별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp반품내역_업체별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매입처코드,'') AS 업체코드, ISNULL(T3.매입처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.입고수량 AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           (T1.입고수량 * T1.입고단가) AS 금액1, ((T1.입고수량 * T1.입고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매입처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드= T1.매입처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 1 AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입고수량 < 0 
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매입처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp반품내역_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp반품내역_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매입처코드,'') AS 업체코드, ISNULL(T3.매입처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.입고수량 AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           (T1.입고수량 * T1.입고단가) AS 금액1, ((T1.입고수량 * T1.입고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매입처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드= T1.매입처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 1 AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입고수량 < 0
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매입처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp발주서인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp발주서인쇄] 
--       (@ParBranchCode VarChar(2) = '01', @ParOrderDate VarChar(8) = '', @ParOrderNo Real = 0, @ParOrderGbn Tinyint = 0)
-- 
-- AS
-- 
--   IF @ParOrderGbn = 0 
--      BEGIN 
--        SELECT T1.사업장코드, T1.발주일자, T1.발주번호, T1.입고희망일자,
--               T1.매입처코드, T3.매입처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.발주량 AS 수량, T4.단위 AS 단위,
--               T2.직송구분, 0 AS 입고단가, 0 AS 입고부가, (0 * T2.발주량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수,
--               DATEDIFF(day, CONVERT(DATETIME, T1.발주일자), CONVERT(DATETIME, T1.입고희망일자)) AS 발주후납기일수
--         FROM 발주 T1
--        INNER JOIN 발주내역 T2
--                ON T2.사업장코드 = T1.사업장코드 AND T2.발주일자 = T1.발주일자 AND T2.발주번호 = T1.발주번호  
--         LEFT JOIN 매입처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매입처코드 = T2.매입처코드
--         LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--        WHERE T1.사업장코드 = @ParBranchCode
--          AND T1.발주일자 = @ParOrderDate
--          AND T1.발주번호 = @ParOrderNo
--          AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--          AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--        ORDER BY T1.사업장코드, T1.발주일자, T1.발주번호, T2.발주시간
--      END
--   ELSE
--      BEGIN 
--        SELECT T1.사업장코드, T1.발주일자, T1.발주번호, T1.입고희망일자,
--               T1.매입처코드, T3.매입처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.발주량 AS 수량,  T4.단위 AS 단위,
--               T2.직송구분, T2.입고단가 AS 입고단가, T2.입고부가 AS 입고부가, (T2.입고단가 * T2.발주량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수,
--               DATEDIFF(day, CONVERT(DATETIME, T1.발주일자), CONVERT(DATETIME, T1.입고희망일자)) AS 발주후납기일수
--          FROM 발주 T1
--         INNER JOIN 발주내역 T2
--                 ON T2.사업장코드 = T1.사업장코드 AND T2.발주일자 = T1.발주일자 AND T2.발주번호 = T1.발주번호  
--          LEFT JOIN 매입처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매입처코드 = T2.매입처코드
--          LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--         WHERE T1.사업장코드 = @ParBranchCode
--           AND T1.발주일자 = @ParOrderDate
--           AND T1.발주번호 = @ParOrderNo
--           AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--           AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--         ORDER BY T1.사업장코드, T1.발주일자, T1.발주번호, T2.발주시간
--      END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp세금계산서A4백지_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp세금계산서A4백지_인쇄] 
--       (@ParstrBranchCode VarChar(02) = '01', @ParstrMakeYear VarChar(04) = '', @ParlngLogCnt1 Real = 0, @ParlngLogCnt2 Real = 0, 
--        @ParintJangGbn Int = 0, @ParstrMakeDate VarChar(08) = '', @ParstrMakeTime VarChar(12) = '', @ParstrSupplierCode VarChar(08) = '')
-- AS
-- 
--   IF @ParintJangGbn = 1
--      BEGIN 
--        SELECT T1.사업장코드 AS 사업장코드, T1.작성년도 AS 작성년도, T1.책번호 AS 책번호, T1.일련번호 AS 일련번호,
--               T1.매출처코드 AS 매출처코드, 
--               ISNULL(T3.사업자번호, '') AS 좌등록번호, ISNULL(T3.사업장명, '') AS 좌상호법인명,
--               ISNULL(T3.대표자명, '') AS 좌성명, (ISNULL(T3.주소, '') + SPACE(1) + ISNULL(T3.번지, '')) AS 좌사업장주소, 
--               ISNULL(T3.업태, '') AS 좌업태, ISNULL(T3.업종, '') AS 좌종목, 
--               ISNULL(T2.사업자번호, '') AS 우등록번호, ISNULL(T2.매출처명, '') AS 우상호법인명, 
--               ISNULL(T2.대표자명, '') AS 우성명, (ISNULL(T2.주소, '') + SPACE(1) + ISNULL(T2.번지, '')) AS 우사업장주소, 
--               ISNULL(T2.업태, '') AS 우업태, ISNULL(T2.업종, '') AS 우종목, 
--               T1.작성일자 AS 작성일자, T1.공급가액 AS 공급가액, T1.세액 AS 세액, T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--               T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.미수구분 AS 미수구분 
--          FROM 매출세금계산서장부 T1 
--          LEFT JOIN 매출처 T2 ON T2.매출처코드 = T1.매출처코드 
--          LEFT JOIN 사업장 T3 ON T3.사업장코드 = T1.사업장코드
--         WHERE T1.사업장코드 = @ParstrBranchCode AND T1.작성일자 = @ParstrMakeDate
--           AND T1.작성시간 = @ParstrMakeTime AND T1.매출처코드 = @ParstrSupplierCode
--           AND T1.사용구분 = 0
--         ORDER BY T1.사업장코드, T1.작성일자, T1.작성시간, T1.매출처코드
--      END
--   ELSE
--      BEGIN 
--        SELECT T1.사업장코드 AS 사업장코드, T1.작성년도 AS 작성년도, T1.책번호 AS 책번호, T1.일련번호 AS 일련번호, 
--               T1.매출처코드 AS 매출처코드, 
--               ISNULL(T3.사업자번호, '') AS 좌등록번호, ISNULL(T3.사업장명, '') AS 좌상호법인명,
--               ISNULL(T3.대표자명, '') AS 좌성명, (ISNULL(T3.주소, '') + SPACE(1) + ISNULL(T3.번지, '')) AS 좌사업장주소, 
--               ISNULL(T3.업태, '') AS 좌업태, ISNULL(T3.업종, '') AS 좌종목, 
--               ISNULL(T2.사업자번호, '') AS 우등록번호, ISNULL(T2.매출처명, '') AS 우상호법인명, 
--               ISNULL(T2.대표자명, '') AS 우성명, (ISNULL(T2.주소, '') + SPACE(1) + ISNULL(T2.번지, '')) AS 우사업장주소, 
--               ISNULL(T2.업태, '') AS 우업태, ISNULL(T2.업종, '') AS 우종목, 
--               T1.작성일자 AS 작성일자, T1.공급가액 AS 공급가액, T1.세액 AS 세액, T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--               T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.미수구분 AS 미수구분 
--          FROM 세금계산서 T1 
--          LEFT JOIN 매출처 T2 ON T2.매출처코드 = T1.매출처코드 
--          LEFT JOIN 사업장 T3 ON T3.사업장코드 = T1.사업장코드
--         WHERE T1.사업장코드 = @ParstrBranchCode AND T1.작성년도 = @ParstrMakeYear
--           AND T1.책번호 = @ParlngLogCnt1 AND T1.일련번호 = @ParlngLogCnt2 AND T1.사용구분 = 0 
--         ORDER BY T1.사업장코드, T1.작성년도, T1.책번호, T1.일련번호
--      END
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp수불부인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp수불부인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParMtCode VarChar(20) = '',  @ParBranchCode Varchar(2) = '01')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T4.자재명,'ERROR!') AS 자재명, 
--            ISNULL(T4.규격,'') AS 규격, ISNULL(T4.단위,'') AS 단위, 
--            (T1.마감년월 + '00') AS 일자, '(년 이월)' AS 적요, 
--            (T1.입고누계수량) AS 입고수량, (T1.출고누계수량) AS 출고수량, 
--            (T1.입고누계수량 - T1.출고누계수량) AS 재고수량 
--       FROM 자재원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) = '00' 
--        AND (T1.분류코드+T1.세부코드) LIKE '%' + LTRIM(@ParMtCode) + '%'
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T4.자재명,'ERROR!') AS 자재명, 
--            ISNULL(T4.규격,'') AS 규격, ISNULL(T4.단위,'') AS 단위, 
--            (T1.마감년월 + '00') AS 일자, '(월   계)' AS 적요, 
--            (T1.입고누계수량) AS 입고수량, (T1.출고누계수량) AS 출고수량, 
--            (T1.입고누계수량 - T1.출고누계수량) AS 재고수량 
--       FROM 자재원장마감 T1 LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) <> '00' 
--        AND (T1.분류코드+T1.세부코드) LIKE '%' + LTRIM(@ParMtCode) + '%'
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T4.자재명,'ERROR!') AS 자재명, 
--            ISNULL(T4.규격,'') AS 규격, ISNULL(T4.단위,'') AS 단위, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            SUM(T1.입고수량) AS 입고수량, SUM(T1.출고수량) AS 출고수량, 
--            SUM(T1.입고수량 - T1.출고수량) As 재고수량 
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND (T1.입출고구분 BETWEEN 1 AND 2)
--        AND (T1.분류코드+T1.세부코드) LIKE '%' + LTRIM(@ParMtCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.분류코드, T3.분류명, T1.세부코드, T4.자재명,             
--               T4.규격, T4.단위, T1.입출고일자 
--      ORDER BY T1.사업장코드, T1.자재명, 일자  
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매입현황_3개월간_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매입현황_3개월간_인쇄] 
--       (@ParBranchCode VARCHAR(02) ='01', @ParDate VARCHAR(08) = '', @ParBeforeYM VARCHAR(06) = '',
--        @ParFirstYM VARCHAR(06) = '', @ParSecondYM VARCHAR(06) = '', @ParThirdYM VARCHAR(06) = '')
-- 
-- AS
-- 
--    SELECT @ParBeforeYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 4) + '00')
--    SELECT @ParFirstYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParSecondYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -2, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParThirdYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -1, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T1.매입처코드 AS 매입처코드, ISNULL(T1.매입처명, '') AS 매입처명, T1.전화번호 AS 전화번호,
--           (SELECT ISNULL(SUM(미지급금누계금액 - 미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 >= @ParBeforeYM AND 마감년월 < @ParFirstYM) AS 삼개월전잔액,
--           (SELECT ISNULL(SUM(미지급금누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월매입,
--           (SELECT ISNULL(SUM(미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월지급,
--           (SELECT ISNULL(SUM(미지급금누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월매입,
--           (SELECT ISNULL(SUM(미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월지급,
--           (SELECT ISNULL(SUM(미지급금누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월매입,
--           (SELECT ISNULL(SUM(미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월지급,
--           (SELECT ISNULL(SUM(공급가액+세액), 0) 
--              FROM 매입세금계산서장부
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0 AND 미지급구분 = 1
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월매입,      
--           (SELECT ISNULL(SUM(미지급금지급금액), 0) 
--              FROM 미지급금내역
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드
--               AND 미지급금지급일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월지급
--      FROM 매입처 T1
--     WHERE T1.사업장코드 = @ParBranchCode
--     ORDER BY T1.사업장코드, T1.매입처명, T1.매입처코드
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매입현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매입현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, (T1.입고수량) AS 수량, 
--            (T1.입고수량 * T1.입고단가) AS 금액1,
--            (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, T1.입출고일자, T1.입출고시간
--    END
-- ELSE
--    BEGIN 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, (T1.입고수량) AS 수량, 
--            (T1.입고수량 * T1.입고단가) AS 금액1,
--            (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, T1.입출고일자, T1.입출고시간
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매입현황_품목별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매입현황_품목별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(2) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * 입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * 입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T5.자재명
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매입현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매입현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(8) = '', @ParKindCode Varchar(2) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매입처명, T3.매입처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매입처명, T3.매입처코드
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매출현황_3개월간_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매출현황_3개월간_인쇄] 
--       (@ParBranchCode VARCHAR(02) ='01', @ParDate VARCHAR(08) = '', @ParBeforeYM VARCHAR(06) = '',
--        @ParFirstYM VARCHAR(06) = '', @ParSecondYM VARCHAR(06) = '', @ParThirdYM VARCHAR(06) = '')
-- 
-- AS
-- 
--    SELECT @ParBeforeYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 4) + '00')
--    SELECT @ParFirstYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParSecondYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -2, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParThirdYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -1, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T1.매출처코드 AS 매출처코드, ISNULL(T1.매출처명, '') AS 매출처명, T1.전화번호 AS 전화번호,
--           (SELECT ISNULL(SUM(미수금누계금액 - 미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 >= @ParBeforeYM AND 마감년월 < @ParFirstYM) AS 삼개월전잔액,
--           (SELECT ISNULL(SUM(미수금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월매출,
--           (SELECT ISNULL(SUM(미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월입금,
--           (SELECT ISNULL(SUM(미수금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월매출,
--           (SELECT ISNULL(SUM(미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월입금,
--           (SELECT ISNULL(SUM(미수금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월매출,
--           (SELECT ISNULL(SUM(미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월입금,
--           (SELECT ISNULL(SUM(공급가액+세액), 0) 
--              FROM 매출세금계산서장부
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0 AND 미수구분 = 1
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월매출,      
--           (SELECT ISNULL(SUM(미수금입금금액), 0) 
--              FROM 미수금내역
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드
--               AND 미수금입금일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월입금
--      FROM 매출처 T1
--     WHERE T1.사업장코드 = @ParBranchCode
--     ORDER BY T1.사업장코드, T1.매출처명, T1.매출처코드
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매출현황_매입단가출력_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매출현황_매입단가출력_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- AS
-- 
-- IF @ParKindCode = '00'
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--             (T1.출고수량) AS 수량, 
--             (T1.출고수량 * T1.출고단가) AS 금액1,
--             ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--             입고단가 = CASE WHEN T7.단가구분 = 1 THEN (T6.입고단가1 * T1.출고수량) 
--                             WHEN T7.단가구분 = 2 THEN (T6.입고단가2 * T1.출고수량)
--                             WHEN T7.단가구분 = 3 THEN (T6.입고단가3 * T1.출고수량) ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--             (T1.출고수량) AS 수량, 
--             (T1.출고수량 * T1.출고단가) AS 금액1,
--             ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--             입고단가 = CASE WHEN T7.단가구분 = 1 THEN (T6.입고단가1 * T1.출고수량) 
--                             WHEN T7.단가구분 = 2 THEN (T6.입고단가2 * T1.출고수량)
--                             WHEN T7.단가구분 = 3 THEN (T6.입고단가3 * T1.출고수량) ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매출현황_일자별_매입단가출력_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매출현황_일자별_매입단가출력_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- 
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            ISNULL(T6.주매입처코드, '') AS 주매입처코드, ISNULL(T7.매입처명, '') AS 주매입처명,
--            입고단가 = CASE WHEN T7.단가구분 = 1 THEN T6.입고단가1 
--                            WHEN T7.단가구분 = 2 THEN T6.입고단가2
--                            WHEN T7.단가구분 = 3 THEN T6.입고단가3 ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가,
--               T6.주매입처코드, T7.매입처명, T7.단가구분, T6.입고단가1, T6.입고단가2, T6.입고단가3
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            ISNULL(T6.주매입처코드, '') AS 주매입처코드, ISNULL(T7.매입처명, '') AS 주매입처명,
--            입고단가 = CASE WHEN T7.단가구분 = 1 THEN T6.입고단가1 
--                            WHEN T7.단가구분 = 2 THEN T6.입고단가2
--                            WHEN T7.단가구분 = 3 THEN T6.입고단가3 ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드= LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가,
--               T6.주매입처코드, T7.매입처명, T7.단가구분, T6.입고단가1, T6.입고단가2, T6.입고단가3
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매출현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매출현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드= LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매출현황_품목별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매출현황_품목별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T5.자재명
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별매출현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별매출현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별미수금현황_집계표_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별미수금현황_집계표_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '', @ParMSGbn int = 2)
-- 
-- AS
-- IF @ParMSGbn = 1 
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미수금누계금액) AS 미수금금액, SUM(T1.미수금입금누계금액) AS 미수금입금금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 미수금금액, 0 AS 미수금입금금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            0 AS 미수금금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 미수금입금금액 
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미수금누계금액) AS 미수금금액, SUM(T1.미수금입금누계금액) AS 미수금입금금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.공급가액 + T1.세액)) AS 미수금금액, 0 AS 미수금입금금액
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  AND T1.사용구분 = 0 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--     UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            0 AS 미수금금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 미수금입금금액 
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END   
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별미지급금현황_집계표_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별미지급금현황_집계표_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParTDate VarChar(08) = '', @ParSupplierCode VarChar(08) = '', @ParMJGbn int = 2)
-- 
-- AS
-- IF @ParMJGbn = 1 
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미지급금누계금액) AS 미지급금금액, SUM(T1.미지급금지급누계금액) AS 미지급금지급금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.입고수량*T1.입고단가) * 1.1) AS 미지급금금액, 0 AS 미지급금지급금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--        AND (T1.입출고구분 = 1)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            0 AS 미지급금금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 미지급금지급금액 
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T3.전화번호
--    END 
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미지급금누계금액) AS 미지급금금액, SUM(T1.미지급금지급누계금액) AS 미지급금지급금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.공급가액 + T1.세액)) AS 미지급금금액, 0 AS 미지급금지급금액
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--     UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            0 AS 미지급금금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 미지급금지급금액 
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T3.전화번호
--    END 
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별수금현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별수금현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명,
--            T1.미수금입금일자 AS 수금일,            
--            결제구분 = CASE WHEN T1.결제방법 = 0 THEN '현금'
--                            WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음'
--                            ELSE '오류'
--                            END,
--            ISNULL(T1.미수금입금금액,0) AS 수금금액, 
--            만기일자 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.만기일자
--                            END,
--            어음번호 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.어음번호
--                            END,
--           T1.적요 AS 적요
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.미수금입금일자, T1.미수금입금시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp업체별지급현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp업체별지급현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명,
--            T1.미지급금지급일자 AS 지불일,            
--            결제구분 = CASE WHEN T1.결제방법 = 0 THEN '현금'
--                            WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음'
--                            ELSE '오류'
--                            END,
--            ISNULL(T1.미지급금지급금액,0) AS 지불금액, 
--            만기일자 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.만기일자
--                            END,
--            어음번호 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.어음번호
--                            END,
--           T1.적요 AS 적요
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T1.미지급금지급일자, T1.미지급금지급시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp일계표인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp일계표인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '1' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '경   비' AS 구분,
--           '' AS 계정코드, '전일이월' AS 계정명, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '1' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '경   비' AS 구분,
--           '' AS 계정코드, '전일이월' AS 계정명,
--           0 AS 수입1, 0 AS 수입2, 
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParDate, 1, 6) + '01') AND T1.작성일자 < @ParDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '1' AS 그룹1, '1' AS 그룹2, T1.작성시간 AS 작성시간,
--           '경   비' AS 구분,
--           T1.계정코드 AS 계정코드, T1.적요 AS 계정명,
--           SUM(T1.입금금액) AS 수입1, 0 AS 수입2, 
--           SUM(T1.출금금액) AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 =  @ParDate)
--     GROUP BY T1.사업장코드, T2.사업장명, T1.작성시간, T1.계정코드, T1.적요
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '2' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '매   입' AS 구분,
--           T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--           SUM(T1.입고수량 * T1.입고단가) AS 수입1, (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 수입2,
--           0 AS 지출1, 0 AS 지출2, 
--           0 AS 잔액
--      FROM 자재입출내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND T1.입출고일자 = @ParDate
--       AND T1.입출고구분 = 1
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매입처명, T1.매입처코드
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '2' AS 그룹1, '2' AS 그룹2, '' AS 작성시간,
--           '매   출' AS 구분,
--           T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--           0 AS 수입1, 0 AS 수입2,           
--           SUM(T1.출고수량 * T1.출고단가) AS 지출1, (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 지출2,
--           0 AS 잔액
--      FROM 자재입출내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND T1.입출고일자 = @ParDate
--       AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매출처명, T1.매출처코드
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '3' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '입   금' AS 구분,
--           T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명,
--           SUM(ISNULL(T1.미수금입금금액,0)) AS 수입1, SUM(ISNULL(T1.미수금입금금액,0)) AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           0 AS 잔액 
--      FROM 미수금내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--     WHERE T1.사업장코드 = @ParBranchCode  
--       AND T1.미수금입금일자 = @ParDate
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매출처명, T1.매출처코드   
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '3' AS 그룹1, '2' AS 그룹2, '' AS 작성시간,
--           '출   금' AS 구분,
--           T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명,
--           0 AS 수입1, 0 AS 수입2,
--           SUM(ISNULL(T1.미지급금지급금액,0)) AS 지출1, SUM(ISNULL(T1.미지급금지급금액,0)) AS 지출2,
--           0 AS 잔액 
--      FROM 미지급금내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--     WHERE T1.사업장코드 = @ParBranchCode  
--       AND T1.미지급금지급일자 = @ParDate
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매입처명, T1.매입처코드   
--     ORDER BY 사업장코드, 사업장명, 그룹1, 그룹2, 작성시간
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자동마감작업갱신
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자동마감작업갱신] 
--       (@ParBranchCode VarChar(02) ='01', @ParDate VarChar(08) = '', @ParMagamGbn TinyInt = 0, 
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '', 
--        @ParIOGbn TinyInt = 1, @ParSupplierCode Varchar(08) = '', @ParAccountCode Varchar(04) = '' )
-- 
-- AS
-- 
-- SET @ParMagamGbn = (SELECT 마감구분 = CASE WHEN @ParMagamGbn = 1 AND (SUBSTRING(@ParDate, 1, 6) > T1.자재기초마감년월) THEN 1
--                                            WHEN @ParMagamGbn = 2 AND (SUBSTRING(@ParDate, 1, 6) > T1.미지급금기초마감년월) THEN 2
--                                            WHEN @ParMagamGbn = 3 AND (SUBSTRING(@ParDate, 1, 6) > T1.미수금기초마감년월)THEN 3  
--                                            WHEN @ParMagamGbn = 4 AND (SUBSTRING(@ParDate, 1, 6) > T1.회계기초마감년월)THEN 4
--                                       ELSE 0 END
--                       FROM 사업장 T1 WHERE T1.사업장코드 = @ParBranchCode )
-- 
-- IF @ParMagamGbn = 1
--    BEGIN
--      DELETE 자재원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = @ParKindCode AND 세부코드 = @ParMtCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6)
-- 
--      INSERT 자재원장마감
--      SELECT T1.사업장코드, T1.분류코드, T1.세부코드, SUBSTRING(T1.입출고일자, 1, 6), SUM(T1.입고수량), SUM(T1.출고수량), '', ''
--        FROM 자재입출내역 T1 
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--         AND SUBSTRING(T1.입출고일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--         AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode
--       GROUP BY T1.사업장코드, T1.분류코드, T1.세부코드, SUBSTRING(T1.입출고일자, 1, 6)
-- 
--      DELETE 자재원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = @ParKindCode AND 세부코드 = @ParMtCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 자재원장마감 
--      SELECT T1.사업장코드, T1.분류코드, T1.세부코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.입고누계수량), SUM(T1.출고누계수량), '', ''
--        FROM 자재원장마감 T1 
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode 
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.분류코드, T1.세부코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')          
-- 
--    END
-- ELSE
-- IF @ParMagamGbn = 2
--    BEGIN
--      DELETE 미지급금원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 매입처코드 = @ParSupplierCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT INTO 미지급금원장마감
--      SELECT T1.사업장코드, T1.매입처코드, SUBSTRING(T1.작성일자, 1, 6), ISNULL(SUM(T1.공급가액 + T1.세액), 0), 0, '', ''                   
--        FROM 매입세금계산서장부 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 AND T1.매입처코드 = @ParSupplierCode
--         AND T1.미지급구분 = 1 AND SUBSTRING(T1.작성일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--       GROUP BY T1.사업장코드, T1.매입처코드, SUBSTRING(T1.작성일자, 1, 6)
-- 
--      UPDATE 미지급금원장마감 SET 미지급금지급누계금액 =
--             ISNULL((SELECT SUM(T2.미지급금지급금액) FROM 미지급금내역 T2 
--                      WHERE T2.사업장코드 = T1.사업장코드 AND T2.매입처코드 = T1.매입처코드
--                        AND SUBSTRING(T2.미지급금지급일자, 1, 6) = T1.마감년월), 0)
--        FROM 미지급금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매입처코드 = @ParSupplierCode AND T1.마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT 미지급금원장마감 
--      SELECT T1.사업장코드, T1.매입처코드, SUBSTRING(T1.미지급금지급일자, 1, 6), 0, ISNULL(SUM(T1.미지급금지급금액), 0), '', ''
--        FROM 미지급금내역 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매입처코드 = @ParSupplierCode 
--         AND SUBSTRING(T1.미지급금지급일자, 1, 6) = SUBSTRING(@ParDate, 1, 6) 
--         AND NOT EXISTS 
--            (SELECT T2.마감년월
--               FROM 미지급금원장마감 T2 
--              WHERE T2.사업장코드 = T1.사업장코드 AND T2.매입처코드 = T1.매입처코드 
--                AND T2.마감년월 = SUBSTRING(@ParDate, 1, 6))
--       GROUP BY T1.사업장코드, T1.매입처코드, SUBSTRING(T1.미지급금지급일자, 1, 6)   
-- 
--      DELETE 미지급금원장마감 
--       WHERE 사업장코드 = @ParBranchCode And 매입처코드 = @ParSupplierCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 미지급금원장마감 
--      SELECT T1.사업장코드, T1.매입처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.미지급금누계금액 - T1.미지급금지급누계금액), 0, '', ''
--        FROM 미지급금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매입처코드 = @ParSupplierCode
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.매입처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')
-- 
--    END 
-- ELSE
-- IF @ParMagamGbn = 3
--    BEGIN
--      DELETE 미수금원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 매출처코드 = @ParSupplierCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT INTO 미수금원장마감
--      SELECT T1.사업장코드, T1.매출처코드, SUBSTRING(T1.작성일자, 1, 6), ISNULL(SUM(T1.공급가액 + T1.세액), 0), 0, '', ''                   
--        FROM 매출세금계산서장부 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 AND T1.매출처코드 = @ParSupplierCode
--         AND T1.미수구분 = 1 AND SUBSTRING(T1.작성일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--       GROUP BY T1.사업장코드, T1.매출처코드, SUBSTRING(T1.작성일자, 1, 6)
-- 
--      UPDATE 미수금원장마감 SET 미수금입금누계금액 =
--             ISNULL((SELECT SUM(T2.미수금입금금액) FROM 미수금내역 T2 
--                      WHERE T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드
--                        AND SUBSTRING(T2.미수금입금일자, 1, 6) = T1.마감년월), 0)
--        FROM 미수금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매출처코드 = @ParSupplierCode AND T1.마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT 미수금원장마감 
--      SELECT T1.사업장코드, T1.매출처코드, SUBSTRING(T1.미수금입금일자, 1, 6), 0, ISNULL(SUM(T1.미수금입금금액), 0), '', ''
--        FROM 미수금내역 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매출처코드 = @ParSupplierCode 
--         AND SUBSTRING(T1.미수금입금일자, 1, 6) = SUBSTRING(@ParDate, 1, 6) 
--         AND NOT EXISTS 
--            (SELECT T2.마감년월
--               FROM 미수금원장마감 T2 
--              WHERE T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드 
--                AND T2.마감년월 = SUBSTRING(@ParDate, 1, 6))
--       GROUP BY T1.사업장코드, T1.매출처코드, SUBSTRING(T1.미수금입금일자, 1, 6)   
-- 
--      DELETE 미수금원장마감 
--       WHERE 사업장코드 = @ParBranchCode And 매출처코드 = @ParSupplierCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 미수금원장마감 
--      SELECT T1.사업장코드, T1.매출처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.미수금누계금액 - T1.미수금입금누계금액), 0, '', ''
--        FROM 미수금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매출처코드 = @ParSupplierCode
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.매출처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')
-- 
--    END 
-- ELSE
-- IF @ParMagamGbn = 4
--    BEGIN
--      DELETE 회계전표내역마감 
--       WHERE 사업장코드 = @ParBranchCode AND 계정코드 = @ParAccountCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT 회계전표내역마감 
--      SELECT T1.사업장코드, T1.계정코드, SUBSTRING(T1.작성일자, 1, 6), SUM(T1.입금금액), SUM(T1.출금금액), '', ''
--        FROM 회계전표내역 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--         AND SUBSTRING(T1.작성일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--         AND T1.계정코드 = @ParAccountCode
--       GROUP BY T1.사업장코드, T1.계정코드, SUBSTRING(T1.작성일자, 1, 6)
-- 
--      DELETE 회계전표내역마감 
--       WHERE 사업장코드 = @ParBranchCode AND 계정코드 = @ParAccountCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 회계전표내역마감 
--      SELECT T1.사업장코드, T1.계정코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.입금누계금액), SUM(T1.출금누계금액), '', ''
--        FROM 회계전표내역마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.계정코드 = @ParAccountCode
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.계정코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')
-- 
--      UPDATE 회계전표내역마감 SET 
--             입금누계금액 = CASE WHEN (입금누계금액 > 출금누계금액) THEN (입금누계금액 - 출금누계금액) ELSE 0 END, 
--             출금누계금액 = CASE WHEN (입금누계금액 < 출금누계금액) THEN (출금누계금액 - 입금누계금액) ELSE 0 END 
--       WHERE 사업장코드 = @ParBranchCode AND 계정코드 = @ParAccountCode
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--    END
--  
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자재분류정보인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자재분류정보인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0)
-- 
-- AS
-- 
--    SELECT T1.분류코드 AS 분류코드, T1.분류명 AS 분류명,
--           T1.적요 AS 적요, 
--           사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                           WHEN T1.사용구분 = 9 THEN '사용불가'
--                      ELSE '오    류' END                 
--      FROM 자재분류 T1 
--     ORDER BY T1.분류코드
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자재시세인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자재시세인쇄] 
--       (@AppMtGroupCode VarChar(6) = '', @AppSupplierCode VarChar(8) = '', @AppStandardDate VarChar(8) = '', 
--        @AppMtName VarChar(20) = '', @AppChkCode int = 1, @AppStateCode int = 0, @AppBranchCode Varchar(2) = '01')
-- 
-- AS
-- IF @AppChkCode = 0
--    BEGIN
--        SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명,
--               ISNULL(T1.세부코드,'') AS 세부코드, ISNULL(T2.자재명,'') AS 자재명, 
--               ISNULL(T1.매입처코드,'') AS 매입처코드, ISNULL(T3.매입처명,'') AS 매입처명,
--               ISNULL(T1.적용일자,'') AS 적용일자, ISNULL(T2.규격,'') AS 규격, ISNULL(T2.단위,'') AS 단위, 
--               과세구분 = CASE WHEN T2.과세구분 = 0 THEN '비과세'
--                               WHEN T2.과세구분 = 1 THEN '과  세'
--                               ELSE '오  류'
--                         END,
--               ISNULl(T1.입고단가,0) AS 입고단가, ISNULL(T1.입고부가,0) AS 입고부가, 
--               ISNULl(T1.출고단가,0) AS 출고단가, ISNULL(T1.출고부가,0) AS 출고부가, 
--               ISNULL(T1.마진율,0) AS 마진율,
--               사용구분 = CASE WHEN T2.사용구분 = 0 THEN '정  상'
--                               WHEN T2.사용구분 = 9 THEN '삭  제'
--                               ELSE '오  류'
--                          END
--          FROM 자재시세 T1 
--          LEFT JOIN 자재 T2 
--                 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--          LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드 
--          LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--         WHERE (T1.사업장코드 = @AppBranchCode AND T1.사용구분 = @AppStateCode)
--           AND (T1.분류코드) LIKE '%' + LTRIM(@AppMtGroupCode) + '%'
--           AND (T1.매입처코드 LIKE '%' + LTRIM(@AppSupplierCode) + '%')
--           AND (T2.자재명 LIKE '%' + LTRIM(@AppMtName) + '%')
--           AND (T1.적용일자 BETWEEN 
--                           (SELECT TOP 1 적용일자 
--                              FROM 자재시세
--                             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드
--                               AND 적용일자 <= @AppStandardDate
--                               AND 사업장코드 = @AppBranchCode
--                             ORDER BY T1.적용일자 DESC)
--                               AND @AppStandardDate)
--         ORDER BY T1.분류코드, T1.세부코드, T1.적용일자 DESC  
--    END
-- ELSE
--    BEGIN
--        SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명,
--               ISNULL(T1.세부코드,'') AS 세부코드, ISNULL(T2.자재명,'') AS 자재명, 
--               ISNULL(T1.매입처코드,'') AS 매입처코드, ISNULL(T3.매입처명,'') AS 매입처명,
--               ISNULL(T1.적용일자,'') AS 적용일자, ISNULL(T2.규격,'') AS 규격, ISNULL(T2.단위,'') 단위, 
--               과세구분 = CASE WHEN T2.과세구분 = 0 THEN '비과세'
--                               WHEN T2.과세구분 = 1 THEN '과  세'
--                               ELSE '오  류'
--                         END,
--               ISNULl(T1.입고단가,0) AS 입고단가, ISNULL(T1.입고부가,0) AS 입고부가, 
--               ISNULl(T1.출고단가,0) AS 출고단가, ISNULL(T1.출고부가,0) AS 출고부가, 
--               ISNULL(T1.마진율,0) AS 마진율,
--               사용구분 = CASE WHEN T2.사용구분 = 0 THEN '정  상'
--                               WHEN T2.사용구분 = 9 THEN '삭  제'
--                               ELSE '오  류'
--                          END
--          FROM 자재시세 T1 
--          LEFT JOIN 자재 T2 
--                 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--          LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드 
--          LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--         WHERE (T1.사업장코드 = @AppBranchCode AND T1.사용구분 = @AppStateCode)
--           AND (T1.분류코드) LIKE '%' + LTRIM(@AppMtGroupCode) + '%'
--           AND (T1.매입처코드 LIKE '%' + LTRIM(@AppSupplierCode) + '%')
--           AND (T2.자재명 LIKE '%' + LTRIM(@AppMtName) + '%')
--           AND (T1.적용일자 = (SELECT TOP 1 적용일자 FROM 자재시세 
--                                WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                                  AND 매입처코드 = T1.매입처코드 
--                                  AND 적용일자 <= @AppStandardDate
--                                  AND 사업장코드 = @AppBranchCode
--                                ORDER BY 적용일자 DESC))
--         ORDER BY T1.분류코드, T1.세부코드, T1.적용일자 DESC  
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자재원장인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자재원장인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParKindCode VarChar(2) = '00', @ParMtCode VarChar(20) = '', 
--        @ParMtName VarChar(20) = '', @ParStateCode int = 0, @ParAppBranchCode VarChar(2) = '01', 
--        @ParExceptionCodeGbn TinyInt = 1, @ParSupCode VarChar(8) = '' )
-- 
-- AS
-- 
-- IF @ParExceptionCodeGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명, 
--            ISNULL(T1.세부코드,'') AS 세부코드, T3.자재명 AS 자재명, 
--            T3.규격 AS 규격, T3.단위 AS 단위, T3.폐기율 AS 폐기율, 
--            과세구분 = CASE WHEN T3.과세구분 = 0 THEN '비과세'
--                            WHEN T3.과세구분 = 1 THEN '과  세'
--                            ELSE '오  류'
--                       END,
--            사용구분 = CASE WHEN T3.사용구분 = 0 THEN '정    상'
--                            WHEN T3.사용구분 = 9 THEN '사용불가'
--                            ELSE '오    류'
--                       END,
--            T1.적정재고 AS 적정재고, 
--            ISNULL(T1.최종입고일자,'') AS 최종입고일자, ISNULL(T1.최종출고일자,'') AS 최종출고일자, 
--            (SELECT ISNULL(SUM(입고누계수량-출고누계수량),0) 
--               FROM 자재원장마감 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 마감년월 >= (SUBSTRING(@ParAppPGDate, 1, 4) + '00')
--                AND 마감년월 <  (SUBSTRING(@ParAppPGDate, 1, 6))) AS 이월재고, 
--            (SELECT ISNULL(SUM(입고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 1
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 입고수량,                                  
--            (SELECT ISNULL(SUM(출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 2
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 출고수량,
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 5 OR 입출고구분 = 6)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고조정수량,                                  
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 11 OR 입출고구분 = 12)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고이동수량,
--            ISNULL(T1.주매입처코드, '') AS 주매입처코드, ISNULL(T5.매입처명, '') AS 주매입처명,
--            T1.입고단가1 AS 입고단가1, T1.입고단가2 AS 입고단가2, T1.입고단가3 AS 입고단가3, 
--            T1.출고단가1 AS 출고단가1, T1.출고단가2 AS 출고단가2, T1.출고단가3 AS 출고단가3
--       FROM 자재원장 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재 T3 
--              ON T3.분류코드 = T1.분류코드 AND T3.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 매입처 T5 ON T5.사업장코드 = T1.사업장코드 AND T5.매입처코드 = T1.주매입처코드
--      WHERE (T1.사업장코드 = @ParAppBranchCode AND T1.사용구분 = @ParStateCode)
--        AND (T1.분류코드) LIKE '%' + LTRIM(@ParKindCode) + '%'
--        AND (T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%')
--        AND (T3.자재명 LIKE '%' + LTRIM(@ParMtName) + '%')
--        AND (T1.주매입처코드 LIKE '%' + LTRIM(@ParSupCode) + '%')
--        AND NOT (DATALENGTH(T1.세부코드) = 9 AND UPPER(SUBSTRING(T1.세부코드, 1, 4)) = 'CODE' 
--            AND T1.세부코드 LIKE 'CODE_____' AND ISNUMERIC(SUBSTRING(T1.세부코드, 5, 5)) = 1)             
--      ORDER BY T1.분류코드, T1.세부코드
--   END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명, 
--            ISNULL(T1.세부코드,'') AS 세부코드, T3.자재명 AS 자재명, 
--            T3.규격 AS 규격, T3.단위 AS 단위, T3.폐기율 AS 폐기율, 
--            과세구분 = CASE WHEN T3.과세구분 = 0 THEN '비과세'
--                            WHEN T3.과세구분 = 1 THEN '과  세'
--                            ELSE '오  류'
--                       END,
--            사용구분 = CASE WHEN T3.사용구분 = 0 THEN '정    상'
--                            WHEN T3.사용구분 = 9 THEN '사용불가'
--                            ELSE '오    류'
--                       END,
--            T1.적정재고 AS 적정재고, 
--            ISNULL(T1.최종입고일자,'') AS 최종입고일자, ISNULL(T1.최종출고일자,'') AS 최종출고일자, 
--            (SELECT ISNULL(SUM(입고누계수량-출고누계수량),0) 
--               FROM 자재원장마감 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 마감년월 >= (SUBSTRING(@ParAppPGDate, 1, 4) + '00')
--                AND 마감년월 <  (SUBSTRING(@ParAppPGDate, 1, 6))) AS 이월재고, 
--            (SELECT ISNULL(SUM(입고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 1
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 입고수량,                                  
--            (SELECT ISNULL(SUM(출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 2
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 출고수량,
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 5 OR 입출고구분 = 6)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고조정수량,                                  
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 11 OR 입출고구분 = 12)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고이동수량,
--            ISNULL(T1.주매입처코드, '') AS 주매입처코드, ISNULL(T5.매입처명, '') AS 주매입처명,
--            T1.입고단가1 AS 입고단가1, T1.입고단가2 AS 입고단가2, T1.입고단가3 AS 입고단가3, 
--            T1.출고단가1 AS 출고단가1, T1.출고단가2 AS 출고단가2, T1.출고단가3 AS 출고단가3
--       FROM 자재원장 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재 T3 
--              ON T3.분류코드 = T1.분류코드 AND T3.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 매입처 T5 ON T5.사업장코드 = T1.사업장코드 AND T5.매입처코드 = T1.주매입처코드
--      WHERE (T1.사업장코드 = @ParAppBranchCode AND T1.사용구분 = @ParStateCode)
--        AND (T1.분류코드) LIKE '%' + LTRIM(@ParKindCode) + '%'
--        AND (T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%')
--        AND (T3.자재명 LIKE '%' + LTRIM(@ParMtName) + '%')
--        AND (T1.주매입처코드 LIKE '%' + LTRIM(@ParSupCode) + '%')
--      ORDER BY T1.분류코드, T1.세부코드
--   END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자재정보인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자재정보인쇄] 
--       (@AppGroupCode VarChar(2) = '00', @AppStateCode int = 0)
-- 
-- AS
-- BEGIN
--     IF @AppGroupCode = '00'
--        BEGIN 
--            SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T2.분류명,'') AS 분류명, 
--                   ISNULL(T1.세부코드,'') AS 세부코드, T1.자재명 AS 자재명, 
--                   T1.바코드 AS 바코드, T1.규격 AS 규격, T1.단위 AS 단위, T1.폐기율 AS 폐기율, 
--                   과세구분 = CASE WHEN T1.과세구분 = 0 THEN '비과세' WHEN T1.과세구분 = 1 THEN '과  세' ELSE '오  류' END,
--                   사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정  상' WHEN T1.사용구분 = 9 THEN '삭  제' ELSE '오  류' END
--              FROM 자재 T1 
--              LEFT JOIN 자재분류 T2 
--                     ON T2.분류코드 = T1.분류코드 
--             WHERE T1.사용구분 = @AppStateCode 
--             ORDER BY T1.분류코드, T1.세부코드  
--        END     
--     ELSE 
--        BEGIN
--            SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T2.분류명,'') AS 분류명, 
--                   ISNULL(T1.세부코드,'') AS 세부코드, T1.자재명 AS 자재명, 
--                   T1.바코드 AS 바코드, T1.규격 AS 규격, T1.단위 AS 단위, T1.폐기율 AS 폐기율, 
--                   과세구분 = CASE WHEN T1.과세구분 = 0 THEN '비과세' WHEN T1.과세구분 = 1 THEN '과  세' ELSE '오  류' END,
--                   사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정  상' WHEN T1.사용구분 = 9 THEN '삭  제' ELSE '오  류' END
--              FROM 자재 T1 
--              LEFT JOIN 자재분류 T2 ON T2.분류코드 = T1.분류코드 
--             WHERE T1.분류코드 = SUBSTRING(@AppGroupCode,1,2) 
--               AND T1.사용구분 = @AppStateCode 
--             ORDER BY T1.분류코드, T1.세부코드  
--        END
-- END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자재최종단가갱신
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자재최종단가갱신] 
--       (@ParBranchCode VarChar(02) ='01', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '', @ParIOGbn Tinyint = 1, 
--        @ParSupplierCode Varchar(8) = '', @ParLastPrice Money = 0, @ParIODate VarChar(8) = '')
-- AS
-- 
-- IF @ParIOGbn = 1
--    BEGIN
--      UPDATE 자재원장 SET 
--             입고단가1 = CASE WHEN T3.단가구분 = 1 THEN @ParLastPrice ELSE 입고단가1 END,
--             입고단가2 = CASE WHEN T3.단가구분 = 2 THEN @ParLastPrice ELSE 입고단가2 END,
--             입고단가3 = CASE WHEN T3.단가구분 = 3 THEN @ParLastPrice ELSE 입고단가3 END       
--        FROM 자재원장 T1
--       INNER JOIN 자재 T2 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드
--       INNER JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = @ParSupplierCode
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode AND T1.최종입고일자 <= @ParIODate
--    END
-- ELSE
--    BEGIN
--      UPDATE 자재원장 SET 
--             출고단가1 = CASE WHEN T3.단가구분 = 1 THEN @ParLastPrice ELSE 출고단가1 END,
--             출고단가2 = CASE WHEN T3.단가구분 = 2 THEN @ParLastPrice ELSE 출고단가2 END,
--             출고단가3 = CASE WHEN T3.단가구분 = 3 THEN @ParLastPrice ELSE 출고단가3 END       
--        FROM 자재원장 T1
--       INNER JOIN 자재 T2 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드
--       INNER JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = @ParSupplierCode
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode AND T1.최종출고일자 <= @ParIODate
--    END
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp자재최종입출고일자갱신
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp자재최종입출고일자갱신] 
--       (@ParBranchCode VarChar(02) ='01', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '', @ParIOGbn Tinyint = 1)
-- AS
-- 
-- IF @ParIOGbn = 1
--    BEGIN
--      UPDATE 자재원장 
--         SET 최종입고일자 = ISNULL(
--            (SELECT TOP 1 T1.입출고일자 AS 최종입출고일자
--               FROM 자재입출내역 T1 
--               LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--               LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--               LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--              WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--                AND T1.입출고구분 = @ParIOGbn
--                AND T1.분류코드 = LTRIM(@ParKindCode) AND T1.세부코드 = LTRIM(@ParMtCode)
--              ORDER BY T1.입출고일자 DESC), '')
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = LTRIM(@ParKindCode) AND 세부코드 = LTRIM(@ParMtCode)            
--    END
-- ELSE
--    BEGIN
--      UPDATE 자재원장 
--         SET 최종출고일자 = ISNULL(
--            (SELECT TOP 1 T1.입출고일자 AS 최종입출고일자
--               FROM 자재입출내역 T1 
--               LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--               LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--               LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--              WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--                AND T1.입출고구분 = @ParIOGbn
--                AND T1.분류코드 = LTRIM(@ParKindCode) AND T1.세부코드 = LTRIM(@ParMtCode)
--              ORDER BY T1.입출고일자 DESC), '')
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = LTRIM(@ParKindCode) AND 세부코드 = LTRIM(@ParMtCode)            
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp재고이동내역인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp재고이동내역인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.입고수량) AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           ((T1.입고수량) * T1.입고단가) AS 금액1, (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명, T1.재고이동사업장코드 AS 이동사업장코드, T6.사업장명 AS 이동사업장명
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--       LEFT JOIN 사업장 T6 
--              ON T6.사업장코드 = T1.재고이동사업장코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 11) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      UNION ALL
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.출고수량) AS 출고수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           ((T1.출고수량) * T1.출고단가) AS 금액1, (T1.출고수량 * T1.출고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명, T1.재고이동사업장코드 AS 이동사업장코드, T6.사업장명 AS 이동사업장명
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--       LEFT JOIN 사업장 T6 
--              ON T6.사업장코드 = T1.재고이동사업장코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 12) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T1.분류코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- 
-- 
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp재고조정내역인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp재고조정내역인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.입고수량) AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           ((T1.입고수량) * T1.입고단가) AS 금액1, (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 5) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      UNION ALL
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.출고수량) AS 출고수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           ((T1.출고수량) * T1.출고단가) AS 금액1, (T1.출고수량 * T1.출고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 6) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T1.분류코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp출납관리_계정과목별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp출납관리_계정과목별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParFDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액        
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParFDate, 1, 6) + '01') AND T1.작성일자 < @ParFDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T1.작성일자 AS 작성일자,
--           T1.계정코드 AS 계정코드, T3.계정명 AS 계정명, T1.적요 AS 적요,
--           T1.입금금액 AS 수입1, 0 AS 수입2,
--           T1.출금금액 AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 BETWEEN @ParFDate AND @ParTDate)
--     ORDER BY 사업장코드, 계정코드, 작성일자
--  
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp출납관리_계정별집계_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp출납관리_계정별집계_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--           '' AS 계정코드, '전일이월' AS 계정명,
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParFDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--           '' AS 계정코드, '전일이월' AS 계정명, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액        
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParFDate, 1, 6) + '01') AND T1.작성일자 < @ParFDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--           T1.계정코드 AS 계정코드, T3.계정명 AS 계정명,
--           SUM(T1.입금금액) AS 수입1, 0 AS 수입2,
--           SUM(T1.출금금액) AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 BETWEEN @ParFDate AND @ParTDate)
--     GROUP BY T1.사업장코드, T2.사업장명, T1.계정코드, T3.계정명
--     ORDER BY 사업장코드, 계정코드
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp출납관리_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp출납관리_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자, '' AS 작성시간,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParFDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자, '' AS 작성시간,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액        
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParFDate, 1, 6) + '01') AND T1.작성일자 < @ParFDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T1.작성일자 AS 작성일자, T1.작성시간 AS 작성시간,
--           T1.계정코드 AS 계정코드, T3.계정명 AS 계정명, T1.적요 AS 적요,
--           T1.입금금액 AS 수입1, 0 AS 수입2,
--           T1.출금금액 AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 BETWEEN @ParFDate AND @ParTDate)
--     ORDER BY 사업장코드, 작성일자, 작성시간, 계정코드
--  
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp품목별매입현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp품목별매입현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격, T5.단위 AS 단위,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 + T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END
-- ELSE
--    BEGIN
--          SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격, T5.단위 AS 단위,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 + T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp품목별매출현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp품목별매출현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명,'') AS 품명, 
--            ISNULL(T5.규격,'') AS 규격, ISNULL(T5.단위, '') AS 단위,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END 
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명,'') AS 품명, 
--            ISNULL(T5.규격,'') AS 규격, ISNULL(T5.단위, '') AS 단위,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드 = LTRIM(@ParKindCode) 
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp합계시산표
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp합계시산표] 
--       (@ParBranchCode VarChar(02) ='01', @ParDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT 0 AS 차변누계, 0 AS 차변당월,
--           '' AS 계정코드, '매     입' AS 계정명,
--           (SELECT ISNULL(SUM(입고단가 * 입고수량), 0) 
--              FROM 자재입출내역 
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND 입출고구분 = 1
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 대변당월,          
--           (SELECT ISNULL(SUM(입고단가 * 입고수량), 0) 
--              FROM 자재입출내역 
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND 입출고구분 = 1
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 대변누계
--     UNION ALL
--    SELECT (SELECT ISNULL(SUM(출고단가 * 출고수량), 0) 
--              FROM 자재입출내역
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND (입출고구분 = 2 OR 입출고구분 = 8)
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 차변누계,
--           (SELECT ISNULL(SUM(출고단가 * 출고수량), 0) 
--              FROM 자재입출내역 
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND (입출고구분 = 2 OR 입출고구분 = 8)
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 차변당월,
--           '' AS 계정코드, '매     출' AS 계정명,
--           0 AS 대변당월, 0 AS 대변누계 
--     UNION ALL
--    SELECT (SELECT ISNULL(SUM(입금금액), 0) 
--              FROM 회계전표내역
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 차변누계,
--           (SELECT ISNULL(SUM(입금금액), 0) 
--              FROM 회계전표내역 
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 차변당월,
--           T1.계정코드 AS 계정코드, T1.계정명 AS 계정명,
--           (SELECT ISNULL(SUM(출금금액), 0) 
--              FROM 회계전표내역 
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 대변당월,
--           (SELECT ISNULL(SUM(출금금액), 0) 
--              FROM 회계전표내역
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 대변누계
--      FROM 계정과목 T1
--     WHERE T1.합계시산표연결여부 = 'Y'
--     ORDER BY T1.계정코드
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_generateansiname
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /* 
-- **	Generate an ansi name that is unique in the dtproperties.value column 
-- */ 
-- create  OR REPLACE procedure dbo.dt_generateansiname(@name varchar(255) output) 
-- as 
-- 	declare @prologue varchar(20) 
-- 	declare @indexstring varchar(20) 
-- 	declare @index integer 
--  
-- 	set @prologue = 'MSDT-A-' 
-- 	set @index = 1 
--  
-- 	while 1 = 1 
-- 	begin 
-- 		set @indexstring = cast(@index as varchar(20)) 
-- 		set @name = @prologue + @indexstring 
-- 		if not exists (select value from dtproperties where value = @name) 
-- 			break 
-- 		 
-- 		set @index = @index + 1 
--  
-- 		if (@index = 10000) 
-- 			goto TooMany 
-- 	end 
--  
-- Leave: 
--  
-- 	return 
--  
-- TooMany: 
--  
-- 	set @name = 'DIAGRAM' 
-- 	goto Leave 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_adduserobject
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Add an object to the dtproperties table
-- */
-- create  OR REPLACE procedure dbo.dt_adduserobject
-- as
-- 	set nocount on
-- 	/*
-- 	** Create the user object if it does not exist already
-- 	*/
-- 	begin transaction
-- 		insert dbo.dtproperties (property) VALUES ('DtgSchemaOBJECT')
-- 		update dbo.dtproperties set objectid=@@identity 
-- 			where id=@@identity and property='DtgSchemaOBJECT'
-- 	commit
-- 	return @@identity
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_setpropertybyid
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	If the property already exists, reset the value; otherwise add property
-- **		id -- the id in sysobjects of the object
-- **		property -- the name of the property
-- **		value -- the text value of the property
-- **		lvalue -- the binary value of the property (image)
-- */
-- create  OR REPLACE procedure dbo.dt_setpropertybyid
-- 	@id int,
-- 	@property varchar(64),
-- 	@value varchar(255),
-- 	@lvalue image
-- as
-- 	set nocount on
-- 	declare @uvalue nvarchar(255) 
-- 	set @uvalue = convert(nvarchar(255), @value) 
-- 	if exists (select * from dbo.dtproperties 
-- 			where objectid=@id and property=@property)
-- 	begin
-- 		--
-- 		-- bump the version count for this row as we update it
-- 		--
-- 		update dbo.dtproperties set value=@value, uvalue=@uvalue, lvalue=@lvalue, version=version+1
-- 			where objectid=@id and property=@property
-- 	end
-- 	else
-- 	begin
-- 		--
-- 		-- version count is auto-set to 0 on initial insert
-- 		--
-- 		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
-- 			values (@property, @id, @value, @uvalue, @lvalue)
-- 	end
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_getobjwithprop
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Retrieve the owner object(s) of a given property
-- */
-- create  OR REPLACE procedure dbo.dt_getobjwithprop
-- 	@property varchar(30),
-- 	@value varchar(255)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 	begin
-- 		raiserror('Must specify a property name.',-1,-1)
-- 		return (1)
-- 	end
-- 
-- 	if (@value is null)
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property
-- 
-- 	else
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property and value=@value
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_getpropertiesbyid
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Retrieve properties by id's
-- **
-- **	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
-- **	dt_getproperties objid, property -- retrieve the property specified
-- */
-- create  OR REPLACE procedure dbo.dt_getpropertiesbyid
-- 	@id int,
-- 	@property varchar(64)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 		select property, version, value, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid
-- 	else
-- 		select property, version, value, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid and @property=property
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_setpropertybyid_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	If the property already exists, reset the value; otherwise add property
-- **		id -- the id in sysobjects of the object
-- **		property -- the name of the property
-- **		uvalue -- the text value of the property
-- **		lvalue -- the binary value of the property (image)
-- */
-- create  OR REPLACE procedure dbo.dt_setpropertybyid_u
-- 	@id int,
-- 	@property varchar(64),
-- 	@uvalue nvarchar(255),
-- 	@lvalue image
-- as
-- 	set nocount on
-- 	-- 
-- 	-- If we are writing the name property, find the ansi equivalent. 
-- 	-- If there is no lossless translation, generate an ansi name. 
-- 	-- 
-- 	declare @avalue varchar(255) 
-- 	set @avalue = null 
-- 	if (@uvalue is not null) 
-- 	begin 
-- 		if (convert(nvarchar(255), convert(varchar(255), @uvalue)) = @uvalue) 
-- 		begin 
-- 			set @avalue = convert(varchar(255), @uvalue) 
-- 		end 
-- 		else 
-- 		begin 
-- 			if 'DtgSchemaNAME' = @property 
-- 			begin 
-- 				exec dbo.dt_generateansiname @avalue output 
-- 			end 
-- 		end 
-- 	end 
-- 	if exists (select * from dbo.dtproperties 
-- 			where objectid=@id and property=@property)
-- 	begin
-- 		--
-- 		-- bump the version count for this row as we update it
-- 		--
-- 		update dbo.dtproperties set value=@avalue, uvalue=@uvalue, lvalue=@lvalue, version=version+1
-- 			where objectid=@id and property=@property
-- 	end
-- 	else
-- 	begin
-- 		--
-- 		-- version count is auto-set to 0 on initial insert
-- 		--
-- 		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
-- 			values (@property, @id, @avalue, @uvalue, @lvalue)
-- 	end
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_getobjwithprop_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Retrieve the owner object(s) of a given property
-- */
-- create  OR REPLACE procedure dbo.dt_getobjwithprop_u
-- 	@property varchar(30),
-- 	@uvalue nvarchar(255)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 	begin
-- 		raiserror('Must specify a property name.',-1,-1)
-- 		return (1)
-- 	end
-- 
-- 	if (@uvalue is null)
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property
-- 
-- 	else
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property and uvalue=@uvalue
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_getpropertiesbyid_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Retrieve properties by id's
-- **
-- **	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
-- **	dt_getproperties objid, property -- retrieve the property specified
-- */
-- create  OR REPLACE procedure dbo.dt_getpropertiesbyid_u
-- 	@id int,
-- 	@property varchar(64)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 		select property, version, uvalue, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid
-- 	else
-- 		select property, version, uvalue, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid and @property=property
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_dropuserobjectbyid
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Drop an object from the dbo.dtproperties table
-- */
-- create  OR REPLACE procedure dbo.dt_dropuserobjectbyid
-- 	@id int
-- as
-- 	set nocount on
-- 	delete from dbo.dtproperties where objectid=@id
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_droppropertiesbyid
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	Drop one or all the associated properties of an object or an attribute 
-- **
-- **	dt_dropproperties objid, null or '' -- drop all properties of the object itself
-- **	dt_dropproperties objid, property -- drop the property
-- */
-- create  OR REPLACE procedure dbo.dt_droppropertiesbyid
-- 	@id int,
-- 	@property varchar(64)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 		delete from dbo.dtproperties where objectid=@id
-- 	else
-- 		delete from dbo.dtproperties 
-- 			where objectid=@id and property=@property
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_verstamp006
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	This procedure returns the version number of the stored
-- **    procedures used by legacy versions of the Microsoft
-- **	Visual Database Tools.  Version is 7.0.00.
-- */
-- create  OR REPLACE procedure dbo.dt_verstamp006
-- as
-- 	select 7000
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_verstamp007
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- /*
-- **	This procedure returns the version number of the stored
-- **    procedures used by the the Microsoft Visual Database Tools.
-- **	Version is 7.0.05.
-- */
-- create  OR REPLACE procedure dbo.dt_verstamp007
-- as
-- 	select 7005
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_getpropertiesbyid_vcs
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE procedure dbo.dt_getpropertiesbyid_vcs
--     @id       int,
--     @property varchar(64),
--     @value    varchar(255) = NULL OUT
-- 
-- as
-- 
--     set nocount on
-- 
--     select @value = (
--         select value
--                 from dbo.dtproperties
--                 where @id=objectid and @property=property
--                 )
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_displayoaerror
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- CREATE  OR REPLACE PROCEDURE dbo.dt_displayoaerror
--     @iObject int,
--     @iresult int
-- as
-- 
-- set nocount on
-- 
-- declare @vchOutput      varchar(255)
-- declare @hr             int
-- declare @vchSource      varchar(255)
-- declare @vchDescription varchar(255)
-- 
--     exec @hr = master.dbo.sp_OAGetErrorInfo @iObject, @vchSource OUT, @vchDescription OUT
-- 
--     select @vchOutput = @vchSource + ': ' + @vchDescription
--     raiserror (@vchOutput,16,-1)
-- 
--     return
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_adduserobject_vcs
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE procedure dbo.dt_adduserobject_vcs
--     @vchProperty varchar(64)
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
--     /*
--     ** Create the user object if it does not exist already
--     */
--     begin transaction
--         select @iReturn = objectid from dbo.dtproperties where property = @vchProperty
--         if @iReturn IS NULL
--         begin
--             insert dbo.dtproperties (property) VALUES (@vchProperty)
--             update dbo.dtproperties set objectid=@@identity
--                     where id=@@identity and property=@vchProperty
--             select @iReturn = @@identity
--         end
--     commit
--     return @iReturn
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_addtosourcecontrol
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_addtosourcecontrol
--     @vchSourceSafeINI varchar(255) = '',
--     @vchProjectName   varchar(255) ='',
--     @vchComment       varchar(255) ='',
--     @vchLoginName     varchar(255) ='',
--     @vchPassword      varchar(255) =''
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
-- declare @iObjectId int
-- select @iObjectId = 0
-- 
-- declare @iStreamObjectId int
-- select @iStreamObjectId = 0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- declare @vchDatabaseName varchar(255)
-- select @vchDatabaseName = db_name()
-- 
-- declare @iReturnValue int
-- select @iReturnValue = 0
-- 
-- declare @iPropertyObjectId int
-- declare @vchParentId varchar(255)
-- 
-- declare @iObjectCount int
-- select @iObjectCount = 0
-- 
--     exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--     if @iReturn <> 0 GOTO E_OAError
-- 
-- 
--     /* Create Project in SS */
--     exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 											'AddProjectToSourceSafe',
-- 											NULL,
-- 											@vchSourceSafeINI,
-- 											@vchProjectName output,
-- 											@@SERVERNAME,
-- 											@vchDatabaseName,
-- 											@vchLoginName,
-- 											@vchPassword,
-- 											@vchComment
-- 
-- 
--     if @iReturn <> 0 GOTO E_OAError
-- 
--     /* Set Database Properties */
-- 
--     begin tran SetProperties
-- 
--     /* add high level object */
-- 
--     exec @iPropertyObjectId = dbo.dt_adduserobject_vcs 'VCSProjectID'
-- 
--     select @vchParentId = CONVERT(varchar(255),@iPropertyObjectId)
-- 
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSProjectID', @vchParentId , NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSProject' , @vchProjectName , NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSSourceSafeINI' , @vchSourceSafeINI , NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSSQLServer', @@SERVERNAME, NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSSQLDatabase', @vchDatabaseName, NULL
-- 
--     if @@error <> 0 GOTO E_General_Error
-- 
--     commit tran SetProperties
--     
--     select @iObjectCount = 0;
-- 
-- CleanUp:
--     select @vchProjectName
--     select @iObjectCount
--     return
-- 
-- E_General_Error:
--     /* this is an all or nothing.  No specific error messages */
--     goto CleanUp
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     goto CleanUp
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_checkinobject
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_checkinobject
--     @chObjectType  char(4),
--     @vchObjectName varchar(255),
--     @vchComment    varchar(255)='',
--     @vchLoginName  varchar(255),
--     @vchPassword   varchar(255)='',
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0,   /* 0 => AddFile, 1 => CheckIn */
--     @txStream1     Text = '', /* drop stream   */ /* There is a bug that if items are NULL they do not pass to OLE servers */
--     @txStream2     Text = '', /* create stream */
--     @txStream3     Text = ''  /* grant stream  */
-- 
-- 
-- as
-- 
-- 	set nocount on
-- 
-- 	declare @iReturn int
-- 	declare @iObjectId int
-- 	select @iObjectId = 0
-- 	declare @iStreamObjectId int
-- 
-- 	declare @VSSGUID varchar(100)
-- 	select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- 	declare @iPropertyObjectId int
-- 	select @iPropertyObjectId  = 0
-- 
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     declare @iReturnValue	  int
--     declare @pos			  int
--     declare @vchProcLinePiece varchar(255)
-- 
--     
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if @chObjectType = 'PROC'
--     begin
--         if @iActionFlag = 1
--         begin
--             /* Procedure Can have up to three streams
--             Drop Stream, Create Stream, GRANT stream */
-- 
--             begin tran compile_all
-- 
--             /* try to compile the streams */
--             exec (@txStream1)
--             if @@error <> 0 GOTO E_Compile_Fail
-- 
--             exec (@txStream2)
--             if @@error <> 0 GOTO E_Compile_Fail
-- 
--             exec (@txStream3)
--             if @@error <> 0 GOTO E_Compile_Fail
--         end
-- 
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, 'GetStreamObject', @iStreamObjectId OUT
--         if @iReturn <> 0 GOTO E_OAError
--         
--         if @iActionFlag = 1
--         begin
--             
--             declare @iStreamLength int
-- 			
-- 			select @pos=1
-- 			select @iStreamLength = datalength(@txStream2)
-- 			
-- 			if @iStreamLength > 0
-- 			begin
-- 			
-- 				while @pos < @iStreamLength
-- 				begin
-- 						
-- 					select @vchProcLinePiece = substring(@txStream2, @pos, 255)
-- 					
-- 					exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'AddStream', @iReturnValue OUT, @vchProcLinePiece
--             		if @iReturn <> 0 GOTO E_OAError
--             		
-- 					select @pos = @pos + 255
-- 					
-- 				end
--             
-- 				exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 														'CheckIn_StoredProcedure',
-- 														NULL,
-- 														@sProjectName = @vchProjectName,
-- 														@sSourceSafeINI = @vchSourceSafeINI,
-- 														@sServerName = @vchServerName,
-- 														@sDatabaseName = @vchDatabaseName,
-- 														@sObjectName = @vchObjectName,
-- 														@sComment = @vchComment,
-- 														@sLoginName = @vchLoginName,
-- 														@sPassword = @vchPassword,
-- 														@iVCSFlags = @iVCSFlags,
-- 														@iActionFlag = @iActionFlag,
-- 														@sStream = ''
--                                         
-- 			end
--         end
--         else
--         begin
--         
--             select colid, text into #ProcLines
--             from syscomments
--             where id = object_id(@vchObjectName)
--             order by colid
-- 
--             declare @iCurProcLine int
--             declare @iProcLines int
--             select @iCurProcLine = 1
--             select @iProcLines = (select count(*) from #ProcLines)
--             while @iCurProcLine <= @iProcLines
--             begin
--                 select @pos = 1
--                 declare @iCurLineSize int
--                 select @iCurLineSize = len((select text from #ProcLines where colid = @iCurProcLine))
--                 while @pos <= @iCurLineSize
--                 begin                
--                     select @vchProcLinePiece = convert(varchar(255),
--                         substring((select text from #ProcLines where colid = @iCurProcLine),
--                                   @pos, 255 ))
--                     exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'AddStream', @iReturnValue OUT, @vchProcLinePiece
--                     if @iReturn <> 0 GOTO E_OAError
--                     select @pos = @pos + 255                  
--                 end
--                 select @iCurProcLine = @iCurProcLine + 1
--             end
--             drop table #ProcLines
-- 
--             exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 													'CheckIn_StoredProcedure',
-- 													NULL,
-- 													@sProjectName = @vchProjectName,
-- 													@sSourceSafeINI = @vchSourceSafeINI,
-- 													@sServerName = @vchServerName,
-- 													@sDatabaseName = @vchDatabaseName,
-- 													@sObjectName = @vchObjectName,
-- 													@sComment = @vchComment,
-- 													@sLoginName = @vchLoginName,
-- 													@sPassword = @vchPassword,
-- 													@iVCSFlags = @iVCSFlags,
-- 													@iActionFlag = @iActionFlag,
-- 													@sStream = ''
--         end
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         if @iActionFlag = 1
--         begin
--             commit tran compile_all
--             if @@error <> 0 GOTO E_Compile_Fail
--         end
-- 
--     end
-- 
-- CleanUp:
-- 	return
-- 
-- E_Compile_Fail:
-- 	declare @lerror int
-- 	select @lerror = @@error
-- 	rollback tran compile_all
-- 	RAISERROR (@lerror,16,-1)
-- 	goto CleanUp
-- 
-- E_OAError:
-- 	if @iActionFlag = 1 rollback tran compile_all
-- 	exec dbo.dt_displayoaerror @iObjectId, @iReturn
-- 	goto CleanUp
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_checkoutobject
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_checkoutobject
--     @chObjectType  char(4),
--     @vchObjectName varchar(255),
--     @vchComment    varchar(255),
--     @vchLoginName  varchar(255),
--     @vchPassword   varchar(255),
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0/* 0 => Checkout, 1 => GetLatest, 2 => UndoCheckOut */
-- 
-- as
-- 
-- 	set nocount on
-- 
-- 	declare @iReturn int
-- 	declare @iObjectId int
-- 	select @iObjectId =0
-- 
-- 	declare @VSSGUID varchar(100)
-- 	select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- 	declare @iReturnValue int
-- 	select @iReturnValue = 0
-- 
-- 	declare @vchTempText varchar(255)
-- 
-- 	/* this is for our strings */
-- 	declare @iStreamObjectId int
-- 	select @iStreamObjectId = 0
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if @chObjectType = 'PROC'
--     begin
--         /* Procedure Can have up to three streams
--            Drop Stream, Create Stream, GRANT stream */
-- 
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 												'CheckOut_StoredProcedure',
-- 												NULL,
-- 												@sProjectName = @vchProjectName,
-- 												@sSourceSafeINI = @vchSourceSafeINI,
-- 												@sObjectName = @vchObjectName,
-- 												@sServerName = @vchServerName,
-- 												@sDatabaseName = @vchDatabaseName,
-- 												@sComment = @vchComment,
-- 												@sLoginName = @vchLoginName,
-- 												@sPassword = @vchPassword,
-- 												@iVCSFlags = @iVCSFlags,
-- 												@iActionFlag = @iActionFlag
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
-- 
--         exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, 'GetStreamObject', @iStreamObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         create table #commenttext (id int identity, sourcecode varchar(255))
-- 
-- 
--         select @vchTempText = 'STUB'
--         while @vchTempText is not null
--         begin
--             exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'GetStream', @iReturnValue OUT, @vchTempText OUT
--             if @iReturn <> 0 GOTO E_OAError
--             
--             if (@vchTempText = '') set @vchTempText = null
--             if (@vchTempText is not null) insert into #commenttext (sourcecode) select @vchTempText
--         end
-- 
--         select 'VCS'=sourcecode from #commenttext order by id
--         select 'SQL'=text from syscomments where id = object_id(@vchObjectName) order by colid
-- 
--     end
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     GOTO CleanUp
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_isundersourcecontrol
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_isundersourcecontrol
--     @vchLoginName varchar(255) = '',
--     @vchPassword  varchar(255) = '',
--     @iWhoToo      int = 0 /* 0 => Just check project; 1 => get list of objs */
-- 
-- as
-- 
-- 	set nocount on
-- 
-- 	declare @iReturn int
-- 	declare @iObjectId int
-- 	select @iObjectId = 0
-- 
-- 	declare @VSSGUID varchar(100)
-- 	select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- 	declare @iReturnValue int
-- 	select @iReturnValue = 0
-- 
-- 	declare @iStreamObjectId int
-- 	select @iStreamObjectId   = 0
-- 
-- 	declare @vchTempText varchar(255)
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if (@vchProjectName = '')	set @vchProjectName		= null
--     if (@vchSourceSafeINI = '') set @vchSourceSafeINI	= null
--     if (@vchServerName = '')	set @vchServerName		= null
--     if (@vchDatabaseName = '')	set @vchDatabaseName	= null
--     
--     if (@vchProjectName is null) or (@vchSourceSafeINI is null) or (@vchServerName is null) or (@vchDatabaseName is null)
--     begin
--         RAISERROR('Not Under Source Control',16,-1)
--         return
--     end
-- 
--     if @iWhoToo = 1
--     begin
-- 
--         /* Get List of Procs in the project */
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 												'GetListOfObjects',
-- 												NULL,
-- 												@vchProjectName,
-- 												@vchSourceSafeINI,
-- 												@vchServerName,
-- 												@vchDatabaseName,
-- 												@vchLoginName,
-- 												@vchPassword
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, 'GetStreamObject', @iStreamObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         create table #ObjectList (id int identity, vchObjectlist varchar(255))
-- 
--         select @vchTempText = 'STUB'
--         while @vchTempText is not null
--         begin
--             exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'GetStream', @iReturnValue OUT, @vchTempText OUT
--             if @iReturn <> 0 GOTO E_OAError
--             
--             if (@vchTempText = '') set @vchTempText = null
--             if (@vchTempText is not null) insert into #ObjectList (vchObjectlist ) select @vchTempText
--         end
-- 
--         select vchObjectlist from #ObjectList order by id
--     end
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     goto CleanUp
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_removefromsourcecontrol
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE procedure dbo.dt_removefromsourcecontrol
-- 
-- as
-- 
--     set nocount on
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     exec dbo.dt_droppropertiesbyid @iPropertyObjectId, null
-- 
--     /* -1 is returned by dt_droppopertiesbyid */
--     if @@error <> 0 and @@error <> -1 return 1
-- 
--     return 0
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_validateloginparams
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_validateloginparams
--     @vchLoginName  varchar(255),
--     @vchPassword   varchar(255)
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
-- declare @iObjectId int
-- select @iObjectId =0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchSourceSafeINI varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
-- 
--     exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--     if @iReturn <> 0 GOTO E_OAError
-- 
--     exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 											'ValidateLoginParams',
-- 											NULL,
-- 											@sSourceSafeINI = @vchSourceSafeINI,
-- 											@sLoginName = @vchLoginName,
-- 											@sPassword = @vchPassword
--     if @iReturn <> 0 GOTO E_OAError
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     GOTO CleanUp
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_vcsenabled
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_vcsenabled
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iObjectId int
-- select @iObjectId = 0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
--     declare @iReturn int
--     exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--     if @iReturn <> 0 raiserror('', 16, -1) /* Can't Load Helper DLLC */
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_whocheckedout
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_whocheckedout
--         @chObjectType  char(4),
--         @vchObjectName varchar(255),
--         @vchLoginName  varchar(255),
--         @vchPassword   varchar(255)
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
-- declare @iObjectId int
-- select @iObjectId =0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
--     declare @iPropertyObjectId int
-- 
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if @chObjectType = 'PROC'
--     begin
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         declare @vchReturnValue varchar(255)
--         select @vchReturnValue = ''
-- 
--         exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 												'WhoCheckedOut',
-- 												@vchReturnValue OUT,
-- 												@sProjectName = @vchProjectName,
-- 												@sSourceSafeINI = @vchSourceSafeINI,
-- 												@sObjectName = @vchObjectName,
-- 												@sServerName = @vchServerName,
-- 												@sDatabaseName = @vchDatabaseName,
-- 												@sLoginName = @vchLoginName,
-- 												@sPassword = @vchPassword
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         select @vchReturnValue
-- 
--     end
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     GOTO CleanUp
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_getpropertiesbyid_vcs_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE procedure dbo.dt_getpropertiesbyid_vcs_u
--     @id       int,
--     @property varchar(64),
--     @value    nvarchar(255) = NULL OUT
-- 
-- as
-- 
--     -- This procedure should no longer be called;  dt_getpropertiesbyid_vcsshould be called instead.
-- 	-- Calls are forwarded to dt_getpropertiesbyid_vcs to maintain backward compatibility.
-- 	set nocount on
--     exec dbo.dt_getpropertiesbyid_vcs
-- 		@id,
-- 		@property,
-- 		@value output
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_displayoaerror_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- CREATE  OR REPLACE PROCEDURE dbo.dt_displayoaerror_u
--     @iObject int,
--     @iresult int
-- as
-- 	-- This procedure should no longer be called;  dt_displayoaerror should be called instead.
-- 	-- Calls are forwarded to dt_displayoaerror to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_displayoaerror
-- 		@iObject,
-- 		@iresult
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_addtosourcecontrol_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_addtosourcecontrol_u
--     @vchSourceSafeINI nvarchar(255) = '',
--     @vchProjectName   nvarchar(255) ='',
--     @vchComment       nvarchar(255) ='',
--     @vchLoginName     nvarchar(255) ='',
--     @vchPassword      nvarchar(255) =''
-- 
-- as
-- 	-- This procedure should no longer be called;  dt_addtosourcecontrol should be called instead.
-- 	-- Calls are forwarded to dt_addtosourcecontrol to maintain backward compatibility
-- 	set nocount on
-- 	exec dbo.dt_addtosourcecontrol 
-- 		@vchSourceSafeINI, 
-- 		@vchProjectName, 
-- 		@vchComment, 
-- 		@vchLoginName, 
-- 		@vchPassword
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_checkinobject_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_checkinobject_u
--     @chObjectType  char(4),
--     @vchObjectName nvarchar(255),
--     @vchComment    nvarchar(255)='',
--     @vchLoginName  nvarchar(255),
--     @vchPassword   nvarchar(255)='',
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0,   /* 0 => AddFile, 1 => CheckIn */
--     @txStream1     text = '',  /* drop stream   */ /* There is a bug that if items are NULL they do not pass to OLE servers */
--     @txStream2     text = '',  /* create stream */
--     @txStream3     text = ''   /* grant stream  */
-- 
-- as	
-- 	-- This procedure should no longer be called;  dt_checkinobject should be called instead.
-- 	-- Calls are forwarded to dt_checkinobject to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_checkinobject
-- 		@chObjectType,
-- 		@vchObjectName,
-- 		@vchComment,
-- 		@vchLoginName,
-- 		@vchPassword,
-- 		@iVCSFlags,
-- 		@iActionFlag,   
-- 		@txStream1,		
-- 		@txStream2,		
-- 		@txStream3		
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_checkoutobject_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_checkoutobject_u
--     @chObjectType  char(4),
--     @vchObjectName nvarchar(255),
--     @vchComment    nvarchar(255),
--     @vchLoginName  nvarchar(255),
--     @vchPassword   nvarchar(255),
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0/* 0 => Checkout, 1 => GetLatest, 2 => UndoCheckOut */
-- 
-- as
-- 
-- 	-- This procedure should no longer be called;  dt_checkoutobject should be called instead.
-- 	-- Calls are forwarded to dt_checkoutobject to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_checkoutobject
-- 		@chObjectType,  
-- 		@vchObjectName, 
-- 		@vchComment,    
-- 		@vchLoginName,  
-- 		@vchPassword,  
-- 		@iVCSFlags,    
-- 		@iActionFlag 
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_isundersourcecontrol_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_isundersourcecontrol_u
--     @vchLoginName nvarchar(255) = '',
--     @vchPassword  nvarchar(255) = '',
--     @iWhoToo      int = 0 /* 0 => Just check project; 1 => get list of objs */
-- 
-- as
-- 	-- This procedure should no longer be called;  dt_isundersourcecontrol should be called instead.
-- 	-- Calls are forwarded to dt_isundersourcecontrol to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_isundersourcecontrol
-- 		@vchLoginName,
-- 		@vchPassword,
-- 		@iWhoToo 
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_validateloginparams_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_validateloginparams_u
--     @vchLoginName  nvarchar(255),
--     @vchPassword   nvarchar(255)
-- as
-- 
-- 	-- This procedure should no longer be called;  dt_validateloginparams should be called instead.
-- 	-- Calls are forwarded to dt_validateloginparams to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_validateloginparams
-- 		@vchLoginName,
-- 		@vchPassword 
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.dt_whocheckedout_u
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- create  OR REPLACE proc dbo.dt_whocheckedout_u
--         @chObjectType  char(4),
--         @vchObjectName nvarchar(255),
--         @vchLoginName  nvarchar(255),
--         @vchPassword   nvarchar(255)
-- 
-- as
-- 
-- 	-- This procedure should no longer be called;  dt_whocheckedout should be called instead.
-- 	-- Calls are forwarded to dt_whocheckedout to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_whocheckedout
-- 		@chObjectType, 
-- 		@vchObjectName,
-- 		@vchLoginName, 
-- 		@vchPassword  
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_upgraddiagrams
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_upgraddiagrams
-- 	AS
-- 	BEGIN
-- 		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
-- 			return 0;
-- 	
-- 		CREATE TABLE dbo.sysdiagrams
-- 		(
-- 			name sysname NOT NULL,
-- 			principal_id int NOT NULL,	-- we may change it to varbinary(85)
-- 			diagram_id int PRIMARY KEY IDENTITY,
-- 			version int,
-- 	
-- 			definition varbinary(max)
-- 			CONSTRAINT UK_principal_name UNIQUE
-- 			(
-- 				principal_id,
-- 				name
-- 			)
-- 		);
-- 
-- 
-- 		/* Add this if we need to have some form of extended properties for diagrams */
-- 		/*
-- 		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
-- 		BEGIN
-- 			CREATE TABLE dbo.sysdiagram_properties
-- 			(
-- 				diagram_id int,
-- 				name sysname,
-- 				value varbinary(max) NOT NULL
-- 			)
-- 		END
-- 		*/
-- 
-- 		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
-- 		begin
-- 			insert into dbo.sysdiagrams
-- 			(
-- 				[name],
-- 				[principal_id],
-- 				[version],
-- 				[definition]
-- 			)
-- 			select	 
-- 				convert(sysname, dgnm.[uvalue]),
-- 				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
-- 				0,							-- zero for old format, dgdef.[version],
-- 				dgdef.[lvalue]
-- 			from dbo.[dtproperties] dgnm
-- 				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
-- 				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
-- 				
-- 			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
-- 			return 2;
-- 		end
-- 		return 1;
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_helpdiagrams
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_helpdiagrams
-- 	(
-- 		@diagramname sysname = NULL,
-- 		@owner_id int = NULL
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		DECLARE @user sysname
-- 		DECLARE @dboLogin bit
-- 		EXECUTE AS CALLER;
-- 			SET @user = USER_NAME();
-- 			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
-- 		REVERT;
-- 		SELECT
-- 			[Database] = DB_NAME(),
-- 			[Name] = name,
-- 			[ID] = diagram_id,
-- 			[Owner] = USER_NAME(principal_id),
-- 			[OwnerID] = principal_id
-- 		FROM
-- 			sysdiagrams
-- 		WHERE
-- 			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
-- 			(@diagramname IS NULL OR name = @diagramname) AND
-- 			(@owner_id IS NULL OR principal_id = @owner_id)
-- 		ORDER BY
-- 			4, 5, 1
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_helpdiagramdefinition
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_helpdiagramdefinition
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null 		
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 
-- 		declare @theId 		int
-- 		declare @IsDbo 		int
-- 		declare @DiagId		int
-- 		declare @UIDFound	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert; 
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 
-- 		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
-- 		return 0
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_creatediagram
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_creatediagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id		int	= null, 	
-- 		@version 		int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId int
-- 		declare @retval int
-- 		declare @IsDbo	int
-- 		declare @userName sysname
-- 		if(@version is null or @diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID(); 
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		revert; 
-- 		
-- 		if @owner_id is null
-- 		begin
-- 			select @owner_id = @theId;
-- 		end
-- 		else
-- 		begin
-- 			if @theId <> @owner_id
-- 			begin
-- 				if @IsDbo = 0
-- 				begin
-- 					RAISERROR (N'E_INVALIDARG', 16, 1);
-- 					return -1
-- 				end
-- 				select @theId = @owner_id
-- 			end
-- 		end
-- 		-- next 2 line only for test, will be removed after define name unique
-- 		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end
-- 	
-- 		insert into dbo.sysdiagrams(name, principal_id , version, definition)
-- 				VALUES(@diagramname, @theId, @version, @definition) ;
-- 		
-- 		select @retval = @@IDENTITY 
-- 		return @retval
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_renamediagram
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_renamediagram
-- 	(
-- 		@diagramname 		sysname,
-- 		@owner_id		int	= null,
-- 		@new_diagramname	sysname
-- 	
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @DiagIdTarg		int
-- 		declare @u_name			sysname
-- 		if((@diagramname is null) or (@new_diagramname is null))
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT;
-- 	
-- 		select @u_name = USER_NAME(@owner_id)
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
-- 		--	return 0;
-- 	
-- 		if(@u_name is null)
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
-- 		else
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
-- 	
-- 		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end		
-- 	
-- 		if(@u_name is null)
-- 			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
-- 		else
-- 			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
-- 		return 0
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_alterdiagram
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_alterdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null,
-- 		@version 	int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId 			int
-- 		declare @retval 		int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @ShouldChangeUID	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid ARG', 16, 1)
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();	 
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert;
-- 	
-- 		select @ShouldChangeUID = 0
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 	
-- 		if(@IsDbo <> 0)
-- 		begin
-- 			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
-- 			begin
-- 				select @ShouldChangeUID = 1 ;
-- 			end
-- 		end
-- 
-- 		-- update dds data			
-- 		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;
-- 
-- 		-- change owner
-- 		if(@ShouldChangeUID = 1)
-- 			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;
-- 
-- 		-- update dds version
-- 		if(@version is not null)
-- 			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;
-- 
-- 		return 0
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp_dropdiagram
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE PROCEDURE dbo.sp_dropdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT; 
-- 		
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		delete from dbo.sysdiagrams where diagram_id = @DiagId;
-- 	
-- 		return 0;
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.fn_diagramobjects
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 	CREATE  OR REPLACE FUNCTION dbo.fn_diagramobjects() 
-- 	RETURNS int
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		declare @id_upgraddiagrams		int
-- 		declare @id_sysdiagrams			int
-- 		declare @id_helpdiagrams		int
-- 		declare @id_helpdiagramdefinition	int
-- 		declare @id_creatediagram	int
-- 		declare @id_renamediagram	int
-- 		declare @id_alterdiagram 	int 
-- 		declare @id_dropdiagram		int
-- 		declare @InstalledObjects	int
-- 
-- 		select @InstalledObjects = 0
-- 
-- 		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
-- 			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
-- 			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
-- 			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
-- 			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
-- 			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
-- 			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
-- 			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')
-- 
-- 		if @id_upgraddiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 1
-- 		if @id_sysdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 2
-- 		if @id_helpdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 4
-- 		if @id_helpdiagramdefinition is not null
-- 			select @InstalledObjects = @InstalledObjects + 8
-- 		if @id_creatediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 16
-- 		if @id_renamediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 32
-- 		if @id_alterdiagram  is not null
-- 			select @InstalledObjects = @InstalledObjects + 64
-- 		if @id_dropdiagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 128
-- 		
-- 		return @InstalledObjects 
-- 	END
-- 	;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp제경비내역_일자별_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp제경비내역_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParCode VarChar(4) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.제경비일자 AS 제경비일자, 
--            T1.제경비시간 AS 제경비시간, T1.제경비코드 AS 제경비코드, 
--            ISNULL(T2.제경비명, '') AS 제경비명, ISNULL(T1.제경비금액, 0) AS 제경비금액, 
--            ISNULL(T1.적요, '') AS 적요, T1.작성자코드 AS 작성자코드, 
--            T3.사용자명 AS 작성자명, T1.사용구분 AS 사용구분, 
--            T1.수정일자 AS 수정일자, T1.사용자코드 AS 사용자코드, 
--            T4.사용자명 AS 사용자명 
--       FROM 제경비내역 T1 
--      INNER JOIN 제경비코드 T2 
--              ON T2.제경비코드 = T1.제경비코드 
--       LEFT JOIN 사용자 T3 
--              ON T3.사용자코드 = T1.작성자코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사용자코드 = T1.사용자코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.제경비코드 LIKE '%' + LTRIM(@ParCode) + '%'
--        AND T1.제경비일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.사용구분 = 0 
--      ORDER BY T1.사업장코드, T1.제경비일자, T1.제경비시간
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.spBackUpYmhDB
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[spBackUpYmhDB] 
--       (@ParToBackUpDeviceName VarChar(50) = '', @ParToBackUpPath VarChar(50) = '', @ParToBackUpFile VarChar(50) = '', @ParToBackUpName VarChar(50) = '', 
--        @ParR_Status Int = 0 OUTPUt, @ParR_MSG VarChar(100) = '' OUTPUT)
-- AS
-- SET @ParToBackUpName = (@ParToBackupPath+ '/' + @ParToBackUpDeviceName + @ParToBackUpFIle)
-- BEGIN
--   BACKUP DATABASE YmhDB TO DISK = @ParToBackUpName
--   WITH FORMAT, NAME = '판매관리시스템'
--   IF (@@ERROR <> 0)       
--      BEGIN       
--        GOTO Err_Rtn      
--      END      
-- END
-- /*-------*/            
--   pEXIT:      
-- /*-------*/      
-- -- CLOSE CURSOR      
-- -- DEALLOCATE CURSOR
-- SET @ParR_Status = '1'             
-- SET @ParR_MSG = '(' + @ParToBackUpName + ')'  + ' BACKUP DATABASE이(가) 정상적으로 종료되었습니다.'
-- SELECT @ParR_Status, @ParR_MSG
-- -- Commit Transaction       
-- RETURN             
-- /*-------*/            
--   Err_Rtn:      
-- /*-------*/      
-- -- CLOSE CURSOR      
-- -- DEALLOCATE CURSOR
-- SET @ParR_Status = '0'      
-- SET @ParR_MSG = '(' + @ParToBackUpName + ')'  + ' BACKUP DATABASE이(가) 비정상적으로 종료되었습니다.'
-- SELECT @ParR_Status, @ParR_MSG
-- --RollBack Transaction            
-- RETURN
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.spLogCounter
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[spLogCounter] 
--       (@varTableName VarChar(50) = '', @varBaseCode VarChar(50) = '', 
--        @mnyLastLog Money = 0, @mnyLastLog1 Money = 0, @varServerDate VarChar(8) = '', @varUserCode VarChar(4) = '')
-- 
-- AS
-- SELECT @varServerDate = Convert(VarChar(8),GETDATE(),112)
-- BEGIN 
--     IF NOT EXISTS(SELECT 최종로그 FROM [dbo].[로그]
--                    WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode )
--        BEGIN
--            IF @VarTableName = '세금계산서'
--               BEGIN
--                 INSERT [dbo].[로그] VALUES(@varTableName, @varBaseCode, 1, 1, @varServerDate, @varUserCode)
--                 SET @mnyLastLog = 1
--                 SET @mnyLastLog1 = 1
--               END
--            ELSE
--               BEGIN 
--                 INSERT [dbo].[로그] VALUES(@varTableName, @varBaseCode, 1, 0, @varServerDate, @varUserCode)
--                 SET @mnyLastLog = 1
--                 SET @mnyLastLog1 = 0
--               END           
--        END
--     ELSE
--        BEGIN
--            IF @VarTableName = '세금계산서'
--               BEGIN 
--                 SELECT @mnyLastLog = ISNULL(최종로그, 0), @mnyLastLog1 = ISNULL(최종로그1, 0)
--                   FROM [dbo].[로그]
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--                  IF @mnyLastLog1 = 50 
--                     BEGIN
--                        SET @mnyLastLog = @mnyLastLog + 1  
--                        SET @mnyLastLog1 = 1  
--                     END
--                  ELSE
--                     BEGIN
--                        SET @mnyLastLog1 = @mnyLastLog1 + 1  
--                     END
--                 UPDATE 로그 SET 최종로그 = @mnyLastLog, 최종로그1 = @mnyLastLog1
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--                 SELECT @mnyLastLog = ISNULL(최종로그, 0), @mnyLastLog1 = ISNULL(최종로그1, 0)
--                   FROM [dbo].[로그]
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--               END
--            ELSE
--               BEGIN
--                 UPDATE 로그 SET 최종로그 = 최종로그 + 1
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--                 SELECT @mnyLastLog = ISNULL(최종로그, 0), @mnyLastLog1 = ISNULL(최종로그1, 0)
--                   FROM [dbo].[로그]
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--               END
--        END 
--     SELECT @mnyLastLog, @mnyLastLog1
-- END
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp거래명세서A4백지_인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp거래명세서A4백지_인쇄] 
--       (@ParStrBranchCode VarChar(02) = '01', @ParStrDealDate VarChar(08) = '', @ParLngLogCnt Real = 0)
-- 
-- AS
-- 
--   SELECT T1.사업장코드 AS 사업장코드, T1.거래일자 AS 거래일자, T1.거래번호 AS 거래번호, 
--          T1.매출처코드 AS 매출처코드,
--          ISNULL(T4.사업자번호, '') AS 좌등록번호, ISNULL(T4.사업장명, '') AS 좌상호,
--          ISNULL(T4.대표자명, '') AS 좌성명, (ISNULL(T4.주소, '') + SPACE(1) + ISNULL(T4.번지, '')) AS 좌주소, 
--          ISNULL(T4.업태, '') AS 좌업태, ISNULL(T4.업종, '') AS 좌종목,
--          ISNULL(T3.사업자번호, '') AS 우등록번호, ISNULL(T3.매출처명, '') AS 우상호, 
--          ISNULL(T3.대표자명, '') AS 우성명, (ISNULL(T3.주소, '') + SPACE(1) + ISNULL(T3.번지, '')) AS 우주소, 
--          ISNULL(T3.업태, '') AS 우업태, ISNULL(T3.업종, '') AS 우종목, 
--         (SELECT SUM(출고수량 * 출고단가) FROM 자재입출내역 
--           WHERE 사업장코드 = @ParStrBranchCode
--             AND 입출고구분 = 2 AND 사용구분 = 0
--             AND 거래일자 = @ParStrDealDate
--             AND 거래번호 = @ParLngLogCnt) AS 총금액,
--         (SELECT COUNT(세부코드) FROM 자재입출내역 
--           WHERE 사업장코드 = @ParStrBranchCode
--             AND 입출고구분 = 2 AND 사용구분 = 0
--             AND 거래일자 = @ParStrDealDate
--             AND 거래번호 = @ParLngLogCnt) AS 건수,
--         (T1.분류코드 + T1.세부코드) AS 코드, T2.자재명 AS 품명, T2.규격 AS 규격, 
--          T1.출고수량 AS 수량, T2.단위 AS 단위, T1.출고단가 AS 단가, T1.출고부가 AS 부가, (T1.출고단가 * T1.출고수량) AS 출고금액
--     FROM 자재입출내역 T1 
--     LEFT JOIN 자재 T2 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드
--     LEFT JOIN 매출처 T3 ON T3.매출처코드 = T1.매출처코드
--     LEFT JOIN 사업장 T4 ON T3.사업장코드 = T1.사업장코드
--    WHERE T1.사업장코드 = @ParStrBranchCode
--      AND T1.입출고구분 = 2 AND T1.사용구분 = 0 
--      AND T1.거래일자 = @ParStrDealDate
--      AND T1.거래번호 = @ParLngLogCnt
--    ORDER BY T1.사업장코드, T1.거래일자, T1.거래번호, T1.입출고시간
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp견적서인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp견적서인쇄] 
--       (@ParBranchCode VarChar(2) = '01', @ParOrderDate VarChar(8) = '', @ParOrderNo Real = 0, @ParOrderGbn Tinyint = 0)
-- 
-- AS
--   IF @ParOrderGbn = 0 
--      BEGIN 
--        SELECT T1.사업장코드, T1.견적일자, T1.견적번호, T1.출고희망일자,
--               T1.매출처코드, T3.매출처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.수량 AS 수량, T4.단위 AS 단위,
--               T2.계산서발행여부, 0 AS 출고단가, 0 AS 출고부가, (0 * T2.수량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수,
--               DATEDIFF(day, CONVERT(DATETIME, T1.견적일자), CONVERT(DATETIME, T1.출고희망일자)) AS 견적후납기일수
--         FROM 견적 T1
--        INNER JOIN 견적내역 T2
--                ON T2.사업장코드 = T1.사업장코드 AND T2.견적일자 = T1.견적일자 AND T2.견적번호 = T1.견적번호  
--         LEFT JOIN 매출처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매출처코드 = T2.매출처코드
--         LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--        WHERE T1.사업장코드 = @ParBranchCode
--          AND T1.견적일자 = @ParOrderDate
--          AND T1.견적번호 = @ParOrderNo
--          AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--          AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--        ORDER BY T1.사업장코드, T1.견적일자, T1.견적번호, T2.견적시간
--      END
--   ELSE
--      BEGIN 
--        SELECT T1.사업장코드, T1.견적일자, T1.견적번호, T1.출고희망일자,
--               T1.매출처코드, T3.매출처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.수량 AS 수량,  T4.단위 AS 단위,
--               T2.계산서발행여부, T2.출고단가 AS 출고단가, T2.출고부가 AS 출고부가, (T2.출고단가 * T2.수량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수, 
--               DATEDIFF(day, CONVERT(DATETIME, T1.견적일자), CONVERT(DATETIME, T1.출고희망일자)) AS 견적후납기일수
--          FROM 견적 T1
--         INNER JOIN 견적내역 T2
--                 ON T2.사업장코드 = T1.사업장코드 AND T2.견적일자 = T1.견적일자 AND T2.견적번호 = T1.견적번호  
--          LEFT JOIN 매출처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매출처코드 = T2.매출처코드
--          LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--         WHERE T1.사업장코드 = @ParBranchCode
--           AND T1.견적일자 = @ParOrderDate
--           AND T1.견적번호 = @ParOrderNo
--           AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--           AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--         ORDER BY T1.사업장코드, T1.견적일자, T1.견적번호, T2.견적시간
--      END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp계정코드관리보고서인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp계정코드관리보고서인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0, @ParSortGbn int = 0)
-- 
-- AS
-- 
-- IF @ParSortGbn = 0 
--    BEGIN
--      SELECT T1.계정코드 AS 계정코드, T1.계정명 AS 계정명,
--             T1.합계시산표연결여부 AS 합계시산표연결여부, T1.적요 AS 적요,             
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END
--        FROM 계정과목 T1 
--       ORDER BY T1.계정코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.계정코드 AS 계정코드, T1.계정명 AS 계정명,
--             T1.합계시산표연결여부 AS 합계시산표연결여부, T1.적요 AS 적요,             
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END
--        FROM 계정과목 T1 
--       ORDER BY T1.계정명
--    END
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매입매출처원장인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매입매출처원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(14) = '', @ParWayGbn int = 2) 
-- 
-- AS
-- 
-- IF @ParWayGbn = 1
--    BEGIN
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,         
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')
--             UNION ALL
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액, (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM 
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,
--                  '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--             UNION ALL 
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액,
--                   (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            1 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.사용구분 = 0 AND T1.미지급구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            2 AS 구분, 0 AS 입고금액, (SUM(T1.공급가액 + T1.세액)) AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.사용구분 = 0 AND T1.미수구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매입처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            3 AS 구분, 0 AS 입고금액, ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            4 AS 구분, ISNULL(SUM(T1.미수금입금금액),0) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매입처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY 사업장코드, 매입처코드, 매입처명, 일자, 시간, 구분
--    END
-- ELSE
--    BEGIN
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                   ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,         
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')
--             UNION ALL
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                  ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액, (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM 
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                   ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,
--                  '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--             UNION ALL 
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                   ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액,
--                   (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            1 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.미지급구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            2 AS 구분, 0 AS 입고금액, (SUM(T1.공급가액 + T1.세액)) AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--        AND T1.사용구분 = 0 AND T1.미수구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            3 AS 구분, 0 AS 입고금액, ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            4 AS 구분, ISNULL(SUM(T1.미수금입금금액),0) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY 사업장코드, 매입처코드, 매입처명, 일자, 시간, 구분
--    END
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매입세금계산서장부현황인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매입세금계산서장부현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(8) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.작성일자 AS 작성일자, T1.작성시간,
--            T1.매입처코드 AS 매입처코드, T2.매입처명 AS 매입처명, 
--            T1.공급가액 AS 공급가액, T1.세액 AS 세액, 
--            T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--            T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.발행여부 AS 발행여부,
--            T1.작성구분 AS 작성구분, T1.미지급구분 AS 미지급구분, T1.사용구분 AS 사용구분 
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 매입처 T2 ON T2.사업장코드 = T1.사업장코드 AND T2.매입처코드 = T1.매입처코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.작성일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--      ORDER BY T1.사업장코드, T1.작성일자, T1.작성시간
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.sp매입처보조부인쇄
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- 
-- 
-- CREATE  OR REPLACE PROCEDURE [dbo].[sp매입처보조부인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParBranchCode Varchar(2) = '01')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이월)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 입고수량, 0 AS 입고단가,
--            0 AS 입고부가, (T1.미지급금누계금액 - T1.미지급금지급누계금액) AS 입고금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) = '00' 
--        AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <>0)
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월   계)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 입고수량, 0 AS 입고단가,
--            0 AS 입고부가, (T1.미지급금누계금액 - T1.미지급금지급누계금액) AS 입고금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) <> '00' 
--        AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, (T1.원래입출고일자) AS 적요, 
--            T1.분류코드 AS 분류코드, T4.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T7.자재명, '') AS 자재명, 
--            ISNULL(T7.규격,'') AS 규격, ISNULL(T7.단위,'') AS 단위, T1.입출고구분 AS 구분,
--            SUM(T1.입고수량) AS 입고수량, T1.입고단가 AS 입고단가, 
--            T1.입고부가 AS 입고부가, 
--            (SUM(T1.입고수량*T1.입고단가)) AS 입고금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T7 ON T7.분류코드 = T1.분류코드 AND T7.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--        AND T1.입출고구분 = 1
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.입출고일자, T1.원래입출고일자,
--               T1.분류코드, T4.분류명, T1.세부코드, T7.자재명, 
--               T7.규격, T7.단위, T1.입출고구분, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, T3.매입처명, 일자, 자재명, 구분  
-- 
-- ;

-- ----------------------------------------------------------------------------
-- View YmhDB.자재_VIEW1
-- ----------------------------------------------------------------------------
-- USE `YmhDB`;
-- CREATE   OR REPLACE VIEW  자재_VIEW1 AS
-- (SELECT A.분류코드,A.세부코드,A.품명,A.규격,A.단위,B.입고단가1,B.출고단가1  
--     FROM (SELECT 분류코드,세부코드, 자재명 AS 품명, 규격, 단위  FROM 자재) A 
--          INNER JOIN (SELECT 분류코드,세부코드, 입고단가1, 출고단가1  FROM 자재원장) B
--               ON (A.분류코드+A.세부코드) = (B.분류코드+B.세부코드))
-- 
-- 
-- ;

-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매입처원장인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp매입처원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMJGbn int = 2)
-- 
-- AS
-- 
-- IF @ParMJGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            T1.입출고구분 AS 구분, T1.입고수량 AS 입고수량, T1.입고단가 AS 입고단가, (T1.입고수량 * T1.입고단가) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 1) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            1 AS 구분, T1.입고수량 AS 입고수량, T1.입고단가 AS 입고단가, (T1.입고수량 * T1.입고단가) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.입출고구분 = 1
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 입고수량, 0 AS 입고단가, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매입처정보인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매입처정보인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0, @ParSortGbn int = 0)
-- 
-- AS
-- IF @ParSortGbn = 0 
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매입처코드 AS 매입처코드, 
--             T1.매입처명 AS 매입처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율 
--        FROM 매입처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매입처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매입처코드 AS 매입처코드, 
--             T1.매입처명 AS 매입처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율
--        FROM 매입처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매입처명
--    END
--  
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매출세금계산서장부현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매출세금계산서장부현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.작성일자 AS 작성일자, T1.작성시간,
--            T1.매출처코드 AS 매출처코드, T2.매출처명 AS 매출처명, 
--            T1.공급가액 AS 공급가액, T1.세액 AS 세액, 
--            T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--            T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.발행여부 AS 발행여부,
--            T1.작성구분 AS 작성구분, T1.미수구분 AS 미수구분, T1.사용구분 AS 사용구분 
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 매출처 T2 ON T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.작성일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--      ORDER BY T1.사업장코드, T1.작성일자, T1.작성시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매출세금계산서현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매출세금계산서현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.작성년도 AS 작성년도, 
--            T1.책번호 AS 책번호, T1.일련번호 AS 일련번호, 
--            T1.작성일자 AS 작성일자, T1.매출처코드 AS 매출처코드, T2.매출처명 AS 매출처명, 
--            T1.공급가액 AS 공급가액, T1.세액 AS 세액, 
--            T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--            T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.발행여부 AS 발행여부,
--            T1.작성구분 AS 작성구분, T1.미수구분 AS 미수구분, T1.사용구분 AS 사용구분 
--       FROM 세금계산서 T1 
--       LEFT JOIN 매출처 T2 ON T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.작성일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--      ORDER BY T1.사업장코드, T1.작성일자, T1.작성년도, T1.책번호, T1.일련번호 
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매출처보조부인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매출처보조부인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParBranchCode VarChar(2) = '01')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이월)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 출고수량, 0 AS 출고단가,
--            0 AS 출고부가, (T1.미수금누계금액 - T1.미수금입금누계금액) AS 출고금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) = '00' 
--        AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월   계)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 출고수량, 0 AS 출고단가,
--            0 AS 출고부가, (T1.미수금누계금액 - T1.미수금입금누계금액) AS 출고금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) <> '00' 
--        AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, (T1.원래입출고일자) AS 적요, 
--            T1.분류코드 AS 분류코드, T4.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T5.자재명, '') AS 자재명, 
--            ISNULL(T5.규격,'') AS 규격, ISNULL(T5.단위,'') AS 단위, T1.입출고구분 AS 구분,
--            SUM(T1.출고수량) AS 출고수량, T1.출고단가 AS 출고단가, 
--            T1.출고부가 AS 출고부가, (SUM(T1.출고수량*T1.출고단가)) AS 출고금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.입출고일자, T1.원래입출고일자,
--               T1.분류코드, T4.분류명, T1.세부코드, T5.자재명, 
--               T5.규격, T5.단위, T1.입출고구분, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, 일자, 자재명, 구분  
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매출처원장인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp매출처원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMSGbn int = 2)
-- 
-- AS
-- 
-- IF @ParMSGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            T1.입출고구분 AS 구분, T1.출고수량 AS 출고수량, T1.출고단가 AS 출고단가, (T1.출고수량 * T1.출고단가) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 2) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 시간, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            '' AS 품명, '' AS 규격, 
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            ISNULL(T4.자재명, '') AS 품명, ISNULL(T4.규격, '') AS 규격,
--            2 AS 구분, T1.출고수량 AS 출고수량, T1.출고단가 AS 출고단가, (T1.출고수량 * T1.출고단가) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.입출고구분 = 2
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            '' AS 품명, '' AS 규격,
--            0 AS 구분, 0 AS 출고수량, 0 AS 출고단가, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 시간, 구분  
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매출처정보인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매출처정보인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0, @ParSortGbn int = 0)
-- 
-- AS
-- IF @ParSortGbn = 0 
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매출처코드 AS 매출처코드, 
--             T1.매출처명 AS 매출처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율
--        FROM 매출처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매출처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T1.매출처코드 AS 매출처코드, 
--             T1.매출처명 AS 매출처명, T1.사업자번호 AS 사업자번호, 
--             T1.법인번호 AS 법인번호, T1.대표자명 AS 대표자명, 
--             T1.대표자주민번호 AS 대표자주민번호, T1.업태 AS 업태, 
--             T1.업종 AS 업종, T1.전화번호 AS 전화번호, 
--             T1.팩스번호 AS 팩스번호, 
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END,                 
--             T1.개업일자 AS 개업일자, T1.우편번호 AS 우편번호, 
--            (T1.주소 + T1.번지) AS 주소, 
--             ISNULL(T1.은행코드,'') AS 은행코드, ISNULL(T2.은행명,'') AS 은행명,
--             ISNULL(T1.계좌번호,'') AS 계좌번호, 
--             계산서발행여부 = CASE WHEN T1.계산서발행여부 = 0 THEN '미발행' 
--                                   WHEN T1.계산서발행여부 = 1 THEN '발  행' ELSE '오  류' END,
--             ISNULL(T1.담당자명,'') AS 담당자명, T1.계산서발행율 AS 계산서발행율
--        FROM 매출처 T1 
--        LEFT JOIN 은행 T2 
--               ON T2.은행코드 = T1.은행코드 
--       WHERE T1.사업장코드 = @ParBranchCode
--       ORDER BY T1.매출처명
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp미달상품내역인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp미달상품내역인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명, 
--            ISNULL(T1.세부코드,'') AS 세부코드, T3.자재명 AS 자재명, 
--            T3.규격 AS 규격, T3.단위 AS 단위, T3.폐기율 AS 폐기율, T3.과세구분 AS 과세구분, 
--            T1.사용구분 AS 사용구분, T1.적정재고 AS 적정재고, 
--            ISNULL(T1.최종입고일자,'') AS 최종입고일자, ISNULL(T1.최종출고일자,'') AS 최종출고일자, 
--           (SELECT ISNULL(SUM(입고누계수량-출고누계수량),0) 
--             FROM 자재원장마감 
--            WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--              AND 사업장코드 = T1.사업장코드 
--              AND 마감년월 >= SUBSTRING(@ParTDate, 1, 4) + '00' 
--              AND 마감년월 < SUBSTRING(@ParTDate, 1, 6)) AS 이월재고,
--           (SELECT ISNULL(SUM(입고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 1)
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6) + '01' AND @ParTDate) AS 입고수량,
--           (SELECT ISNULL(SUM(출고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 2)
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6)  + '01' AND @ParTDate) AS 출고수량,
--           (SELECT ISNULL(SUM(입고수량-출고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 5 OR 입출고구분 = 6) 
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6) + '01' AND @ParTDate) AS 재고조정수량,
--           (SELECT ISNULL(SUM(입고수량-출고수량),0) 
--              FROM 자재입출내역 
--             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--               AND 사업장코드 = T1.사업장코드 AND 사용구분 = 0 AND (입출고구분 = 11 OR 입출고구분 = 12) 
--               AND 입출고일자 BETWEEN SUBSTRING(@ParTDate, 1, 6) + '01' AND @ParTDate) AS 재고이동수량
--       FROM 자재원장 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재 T3 ON T3.분류코드 = T1.분류코드 AND T3.세부코드 = T1.세부코드                     
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.적정재고 <> 0
--   ORDER BY T1.사업장코드, T1.분류코드, T3.자재명
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp미수금원장인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp미수금원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMSGbn int = 2)
-- 
-- AS
-- IF @ParMSGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, T3.매출처명 AS 매출처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            T1.입출고구분 AS 구분, (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.입출고일자, T1.입출고시간, T1.현금구분, T1.입출고구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미수금누계금액) AS 출고금액,
--            (T1.미수금입금누계금액) AS 입금금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, T3.매출처명 AS 매출처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            2 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 출고금액,
--            0 AS 입금금액, 
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.미수구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 출고금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 입금금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, 일자, 시간, 구분  
--    END
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp미지급금원장인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp미지급금원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParMJGbn int = 2)
-- AS
-- IF @ParMJGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            T1.입출고구분 AS 구분, (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.현금구분 = 1 THEN '현금' ELSE '외상' END, '' AS 만기일자, '' AS 어음번호, 
--            T1.적요 AS 비고, T1.입출고시간 AS 시간
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (T1.입출고구분 = 1) AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.입출고일자, T1.입출고시간, T1.현금구분, T1.입출고구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--            0 AS 구분, (T1.미지급금누계금액) AS 입고금액,
--            (T1.미지급금지급누계금액) AS 지급금액,
--            '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            1 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 입고금액,
--            0 AS 지급금액, 
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.미지급구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            0 AS 구분, 0 AS 입고금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, 일자, 시간, 구분  
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp반입내역_업체별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp반입내역_업체별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매출처코드,'') AS 업체코드, ISNULL(T3.매출처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.출고수량 AS 수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           (T1.출고수량 * T1.출고단가) AS 금액1, ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매출처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드= T1.매출처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 2 AND T1.출고수량 < 0 
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매출처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp반입내역_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp반입내역_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매출처코드,'') AS 업체코드, ISNULL(T3.매출처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.출고수량 AS 수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           (T1.출고수량 * T1.출고단가) AS 금액1, ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매출처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드= T1.매출처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 2 AND T1.출고수량 < 0 
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매출처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp반품내역_업체별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp반품내역_업체별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매입처코드,'') AS 업체코드, ISNULL(T3.매입처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.입고수량 AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           (T1.입고수량 * T1.입고단가) AS 금액1, ((T1.입고수량 * T1.입고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매입처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드= T1.매입처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 1 AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입고수량 < 0 
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매입처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp반품내역_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp반품내역_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', 
--        @ParMtName VarChar(20) = '', @ParSupplierName Varchar(20) = '')
-- 
-- AS
--     SELECT T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            ISNULL(T1.매입처코드,'') AS 업체코드, ISNULL(T3.매입처명,'') AS 업체명, 
--           (T1.분류코드 + T1.세부코드) AS 자재코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.원래입출고일자,
--            T1.입고수량 AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           (T1.입고수량 * T1.입고단가) AS 금액1, ((T1.입고수량 * T1.입고단가) * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 매입처 T3 
--              ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드= T1.매입처코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.입출고구분 = 1 AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입고수량 < 0
--        AND T2.자재명 LIKE '%' + LTRIM(@ParMtName) + '%' AND T3.매입처명 LIKE '%' + LTRIM(@ParSupplierName) + '%'
--      ORDER BY T1.사업장코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp발주서인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp발주서인쇄] 
--       (@ParBranchCode VarChar(2) = '01', @ParOrderDate VarChar(8) = '', @ParOrderNo Real = 0, @ParOrderGbn Tinyint = 0)
-- 
-- AS
-- 
--   IF @ParOrderGbn = 0 
--      BEGIN 
--        SELECT T1.사업장코드, T1.발주일자, T1.발주번호, T1.입고희망일자,
--               T1.매입처코드, T3.매입처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.발주량 AS 수량, T4.단위 AS 단위,
--               T2.직송구분, 0 AS 입고단가, 0 AS 입고부가, (0 * T2.발주량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수,
--               DATEDIFF(day, CONVERT(DATETIME, T1.발주일자), CONVERT(DATETIME, T1.입고희망일자)) AS 발주후납기일수
--         FROM 발주 T1
--        INNER JOIN 발주내역 T2
--                ON T2.사업장코드 = T1.사업장코드 AND T2.발주일자 = T1.발주일자 AND T2.발주번호 = T1.발주번호  
--         LEFT JOIN 매입처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매입처코드 = T2.매입처코드
--         LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--        WHERE T1.사업장코드 = @ParBranchCode
--          AND T1.발주일자 = @ParOrderDate
--          AND T1.발주번호 = @ParOrderNo
--          AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--          AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--        ORDER BY T1.사업장코드, T1.발주일자, T1.발주번호, T2.발주시간
--      END
--   ELSE
--      BEGIN 
--        SELECT T1.사업장코드, T1.발주일자, T1.발주번호, T1.입고희망일자,
--               T1.매입처코드, T3.매입처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.발주량 AS 수량,  T4.단위 AS 단위,
--               T2.직송구분, T2.입고단가 AS 입고단가, T2.입고부가 AS 입고부가, (T2.입고단가 * T2.발주량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수,
--               DATEDIFF(day, CONVERT(DATETIME, T1.발주일자), CONVERT(DATETIME, T1.입고희망일자)) AS 발주후납기일수
--          FROM 발주 T1
--         INNER JOIN 발주내역 T2
--                 ON T2.사업장코드 = T1.사업장코드 AND T2.발주일자 = T1.발주일자 AND T2.발주번호 = T1.발주번호  
--          LEFT JOIN 매입처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매입처코드 = T2.매입처코드
--          LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--         WHERE T1.사업장코드 = @ParBranchCode
--           AND T1.발주일자 = @ParOrderDate
--           AND T1.발주번호 = @ParOrderNo
--           AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--           AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--         ORDER BY T1.사업장코드, T1.발주일자, T1.발주번호, T2.발주시간
--      END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp세금계산서A4백지_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp세금계산서A4백지_인쇄] 
--       (@ParstrBranchCode VarChar(02) = '01', @ParstrMakeYear VarChar(04) = '', @ParlngLogCnt1 Real = 0, @ParlngLogCnt2 Real = 0, 
--        @ParintJangGbn Int = 0, @ParstrMakeDate VarChar(08) = '', @ParstrMakeTime VarChar(12) = '', @ParstrSupplierCode VarChar(08) = '')
-- AS
-- 
--   IF @ParintJangGbn = 1
--      BEGIN 
--        SELECT T1.사업장코드 AS 사업장코드, T1.작성년도 AS 작성년도, T1.책번호 AS 책번호, T1.일련번호 AS 일련번호,
--               T1.매출처코드 AS 매출처코드, 
--               ISNULL(T3.사업자번호, '') AS 좌등록번호, ISNULL(T3.사업장명, '') AS 좌상호법인명,
--               ISNULL(T3.대표자명, '') AS 좌성명, (ISNULL(T3.주소, '') + SPACE(1) + ISNULL(T3.번지, '')) AS 좌사업장주소, 
--               ISNULL(T3.업태, '') AS 좌업태, ISNULL(T3.업종, '') AS 좌종목, 
--               ISNULL(T2.사업자번호, '') AS 우등록번호, ISNULL(T2.매출처명, '') AS 우상호법인명, 
--               ISNULL(T2.대표자명, '') AS 우성명, (ISNULL(T2.주소, '') + SPACE(1) + ISNULL(T2.번지, '')) AS 우사업장주소, 
--               ISNULL(T2.업태, '') AS 우업태, ISNULL(T2.업종, '') AS 우종목, 
--               T1.작성일자 AS 작성일자, T1.공급가액 AS 공급가액, T1.세액 AS 세액, T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--               T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.미수구분 AS 미수구분 
--          FROM 매출세금계산서장부 T1 
--          LEFT JOIN 매출처 T2 ON T2.매출처코드 = T1.매출처코드 
--          LEFT JOIN 사업장 T3 ON T3.사업장코드 = T1.사업장코드
--         WHERE T1.사업장코드 = @ParstrBranchCode AND T1.작성일자 = @ParstrMakeDate
--           AND T1.작성시간 = @ParstrMakeTime AND T1.매출처코드 = @ParstrSupplierCode
--           AND T1.사용구분 = 0
--         ORDER BY T1.사업장코드, T1.작성일자, T1.작성시간, T1.매출처코드
--      END
--   ELSE
--      BEGIN 
--        SELECT T1.사업장코드 AS 사업장코드, T1.작성년도 AS 작성년도, T1.책번호 AS 책번호, T1.일련번호 AS 일련번호, 
--               T1.매출처코드 AS 매출처코드, 
--               ISNULL(T3.사업자번호, '') AS 좌등록번호, ISNULL(T3.사업장명, '') AS 좌상호법인명,
--               ISNULL(T3.대표자명, '') AS 좌성명, (ISNULL(T3.주소, '') + SPACE(1) + ISNULL(T3.번지, '')) AS 좌사업장주소, 
--               ISNULL(T3.업태, '') AS 좌업태, ISNULL(T3.업종, '') AS 좌종목, 
--               ISNULL(T2.사업자번호, '') AS 우등록번호, ISNULL(T2.매출처명, '') AS 우상호법인명, 
--               ISNULL(T2.대표자명, '') AS 우성명, (ISNULL(T2.주소, '') + SPACE(1) + ISNULL(T2.번지, '')) AS 우사업장주소, 
--               ISNULL(T2.업태, '') AS 우업태, ISNULL(T2.업종, '') AS 우종목, 
--               T1.작성일자 AS 작성일자, T1.공급가액 AS 공급가액, T1.세액 AS 세액, T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--               T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.미수구분 AS 미수구분 
--          FROM 세금계산서 T1 
--          LEFT JOIN 매출처 T2 ON T2.매출처코드 = T1.매출처코드 
--          LEFT JOIN 사업장 T3 ON T3.사업장코드 = T1.사업장코드
--         WHERE T1.사업장코드 = @ParstrBranchCode AND T1.작성년도 = @ParstrMakeYear
--           AND T1.책번호 = @ParlngLogCnt1 AND T1.일련번호 = @ParlngLogCnt2 AND T1.사용구분 = 0 
--         ORDER BY T1.사업장코드, T1.작성년도, T1.책번호, T1.일련번호
--      END
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp수불부인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp수불부인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParMtCode VarChar(20) = '',  @ParBranchCode Varchar(2) = '01')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T4.자재명,'ERROR!') AS 자재명, 
--            ISNULL(T4.규격,'') AS 규격, ISNULL(T4.단위,'') AS 단위, 
--            (T1.마감년월 + '00') AS 일자, '(년 이월)' AS 적요, 
--            (T1.입고누계수량) AS 입고수량, (T1.출고누계수량) AS 출고수량, 
--            (T1.입고누계수량 - T1.출고누계수량) AS 재고수량 
--       FROM 자재원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) = '00' 
--        AND (T1.분류코드+T1.세부코드) LIKE '%' + LTRIM(@ParMtCode) + '%'
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T4.자재명,'ERROR!') AS 자재명, 
--            ISNULL(T4.규격,'') AS 규격, ISNULL(T4.단위,'') AS 단위, 
--            (T1.마감년월 + '00') AS 일자, '(월   계)' AS 적요, 
--            (T1.입고누계수량) AS 입고수량, (T1.출고누계수량) AS 출고수량, 
--            (T1.입고누계수량 - T1.출고누계수량) AS 재고수량 
--       FROM 자재원장마감 T1 LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) <> '00' 
--        AND (T1.분류코드+T1.세부코드) LIKE '%' + LTRIM(@ParMtCode) + '%'
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T4.자재명,'ERROR!') AS 자재명, 
--            ISNULL(T4.규격,'') AS 규격, ISNULL(T4.단위,'') AS 단위, 
--            (T1.입출고일자) AS 일자, '' AS 적요, 
--            SUM(T1.입고수량) AS 입고수량, SUM(T1.출고수량) AS 출고수량, 
--            SUM(T1.입고수량 - T1.출고수량) As 재고수량 
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND (T1.입출고구분 BETWEEN 1 AND 2)
--        AND (T1.분류코드+T1.세부코드) LIKE '%' + LTRIM(@ParMtCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.분류코드, T3.분류명, T1.세부코드, T4.자재명,             
--               T4.규격, T4.단위, T1.입출고일자 
--      ORDER BY T1.사업장코드, T1.자재명, 일자  
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매입현황_3개월간_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매입현황_3개월간_인쇄] 
--       (@ParBranchCode VARCHAR(02) ='01', @ParDate VARCHAR(08) = '', @ParBeforeYM VARCHAR(06) = '',
--        @ParFirstYM VARCHAR(06) = '', @ParSecondYM VARCHAR(06) = '', @ParThirdYM VARCHAR(06) = '')
-- 
-- AS
-- 
--    SELECT @ParBeforeYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 4) + '00')
--    SELECT @ParFirstYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParSecondYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -2, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParThirdYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -1, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T1.매입처코드 AS 매입처코드, ISNULL(T1.매입처명, '') AS 매입처명, T1.전화번호 AS 전화번호,
--           (SELECT ISNULL(SUM(미지급금누계금액 - 미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 >= @ParBeforeYM AND 마감년월 < @ParFirstYM) AS 삼개월전잔액,
--           (SELECT ISNULL(SUM(미지급금누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월매입,
--           (SELECT ISNULL(SUM(미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월지급,
--           (SELECT ISNULL(SUM(미지급금누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월매입,
--           (SELECT ISNULL(SUM(미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월지급,
--           (SELECT ISNULL(SUM(미지급금누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월매입,
--           (SELECT ISNULL(SUM(미지급금지급누계금액), 0) 
--              FROM 미지급금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월지급,
--           (SELECT ISNULL(SUM(공급가액+세액), 0) 
--              FROM 매입세금계산서장부
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드 AND 사용구분 = 0 AND 미지급구분 = 1
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월매입,      
--           (SELECT ISNULL(SUM(미지급금지급금액), 0) 
--              FROM 미지급금내역
--             WHERE 사업장코드 = T1.사업장코드 AND 매입처코드 = T1.매입처코드
--               AND 미지급금지급일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월지급
--      FROM 매입처 T1
--     WHERE T1.사업장코드 = @ParBranchCode
--     ORDER BY T1.사업장코드, T1.매입처명, T1.매입처코드
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매입현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매입현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, (T1.입고수량) AS 수량, 
--            (T1.입고수량 * T1.입고단가) AS 금액1,
--            (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, T1.입출고일자, T1.입출고시간
--    END
-- ELSE
--    BEGIN 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, (T1.입고수량) AS 수량, 
--            (T1.입고수량 * T1.입고단가) AS 금액1,
--            (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매입처명, T1.매입처코드, T1.입출고일자, T1.입출고시간
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매입현황_품목별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매입현황_품목별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(2) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * 입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * 입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T5.자재명
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매입현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매입현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(8) = '', @ParKindCode Varchar(2) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매입처명, T3.매입처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매입처명, T3.매입처코드
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매출현황_3개월간_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매출현황_3개월간_인쇄] 
--       (@ParBranchCode VARCHAR(02) ='01', @ParDate VARCHAR(08) = '', @ParBeforeYM VARCHAR(06) = '',
--        @ParFirstYM VARCHAR(06) = '', @ParSecondYM VARCHAR(06) = '', @ParThirdYM VARCHAR(06) = '')
-- 
-- AS
-- 
--    SELECT @ParBeforeYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 4) + '00')
--    SELECT @ParFirstYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -3, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParSecondYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -2, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
--    SELECT @ParThirdYM = (SUBSTRING(CONVERT(VARCHAR(8),DATEADD(MONTH, -1, CONVERT(DATETIME, @ParDate)), 112), 1, 6))
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T1.매출처코드 AS 매출처코드, ISNULL(T1.매출처명, '') AS 매출처명, T1.전화번호 AS 전화번호,
--           (SELECT ISNULL(SUM(미수금누계금액 - 미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 >= @ParBeforeYM AND 마감년월 < @ParFirstYM) AS 삼개월전잔액,
--           (SELECT ISNULL(SUM(미수금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월매출,
--           (SELECT ISNULL(SUM(미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParFirstYM) AS 첫번째월입금,
--           (SELECT ISNULL(SUM(미수금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월매출,
--           (SELECT ISNULL(SUM(미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParSecondYM) AS 두번째월입금,
--           (SELECT ISNULL(SUM(미수금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월매출,
--           (SELECT ISNULL(SUM(미수금입금누계금액), 0) 
--              FROM 미수금원장마감
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0
--               AND 마감년월 = @ParThirdYM) AS 세번째월입금,
--           (SELECT ISNULL(SUM(공급가액+세액), 0) 
--              FROM 매출세금계산서장부
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드 AND 사용구분 = 0 AND 미수구분 = 1
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월매출,      
--           (SELECT ISNULL(SUM(미수금입금금액), 0) 
--              FROM 미수금내역
--             WHERE 사업장코드 = T1.사업장코드 AND 매출처코드 = T1.매출처코드
--               AND 미수금입금일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 마지막월입금
--      FROM 매출처 T1
--     WHERE T1.사업장코드 = @ParBranchCode
--     ORDER BY T1.사업장코드, T1.매출처명, T1.매출처코드
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매출현황_매입단가출력_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매출현황_매입단가출력_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- AS
-- 
-- IF @ParKindCode = '00'
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--             (T1.출고수량) AS 수량, 
--             (T1.출고수량 * T1.출고단가) AS 금액1,
--             ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--             입고단가 = CASE WHEN T7.단가구분 = 1 THEN (T6.입고단가1 * T1.출고수량) 
--                             WHEN T7.단가구분 = 2 THEN (T6.입고단가2 * T1.출고수량)
--                             WHEN T7.단가구분 = 3 THEN (T6.입고단가3 * T1.출고수량) ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--             (T1.출고수량) AS 수량, 
--             (T1.출고수량 * T1.출고단가) AS 금액1,
--             ((T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--             입고단가 = CASE WHEN T7.단가구분 = 1 THEN (T6.입고단가1 * T1.출고수량) 
--                             WHEN T7.단가구분 = 2 THEN (T6.입고단가2 * T1.출고수량)
--                             WHEN T7.단가구분 = 3 THEN (T6.입고단가3 * T1.출고수량) ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매출현황_일자별_매입단가출력_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매출현황_일자별_매입단가출력_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- 
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            ISNULL(T6.주매입처코드, '') AS 주매입처코드, ISNULL(T7.매입처명, '') AS 주매입처명,
--            입고단가 = CASE WHEN T7.단가구분 = 1 THEN T6.입고단가1 
--                            WHEN T7.단가구분 = 2 THEN T6.입고단가2
--                            WHEN T7.단가구분 = 3 THEN T6.입고단가3 ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가,
--               T6.주매입처코드, T7.매입처명, T7.단가구분, T6.입고단가1, T6.입고단가2, T6.입고단가3
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2,
--            ISNULL(T6.주매입처코드, '') AS 주매입처코드, ISNULL(T7.매입처명, '') AS 주매입처명,
--            입고단가 = CASE WHEN T7.단가구분 = 1 THEN T6.입고단가1 
--                            WHEN T7.단가구분 = 2 THEN T6.입고단가2
--                            WHEN T7.단가구분 = 3 THEN T6.입고단가3 ELSE 0 END
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--       LEFT JOIN 자재원장 T6 ON T6.사업장코드 = T1.사업장코드 AND T6.분류코드 = T1.분류코드 AND T6.세부코드 = T1.세부코드
--       LEFT JOIN 매입처 T7 ON T7.사업장코드 = T1.사업장코드 AND T7.매입처코드 = T6.주매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드= LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가,
--               T6.주매입처코드, T7.매입처명, T7.단가구분, T6.입고단가1, T6.입고단가2, T6.입고단가3
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매출현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매출현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            T1.입출고일자 AS 거래일자,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드= LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T1.입출고일자,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.입출고일자, T5.자재명
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매출현황_품목별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매출현황_품목별_인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T5.자재명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명, '') AS 품명, ISNULL(T5.규격, '') AS 규격,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, 
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T5.자재명
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별매출현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별매출현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(08) = '', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END
-- ELSE
--    BEGIN
--      SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--             T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--             T3.전화번호 AS 전화번호,
--            SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별미수금현황_집계표_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별미수금현황_집계표_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(8) = '', @ParMSGbn int = 2)
-- 
-- AS
-- IF @ParMSGbn = 1 
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미수금누계금액) AS 미수금금액, SUM(T1.미수금입금누계금액) AS 미수금입금금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 미수금금액, 0 AS 미수금입금금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            0 AS 미수금금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 미수금입금금액 
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미수금누계금액) AS 미수금금액, SUM(T1.미수금입금누계금액) AS 미수금입금금액
--       FROM 미수금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.공급가액 + T1.세액)) AS 미수금금액, 0 AS 미수금입금금액
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  AND T1.사용구분 = 0 
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--     UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, T3.전화번호 AS 전화번호,
--            0 AS 미수금금액,
--            ISNULL(SUM(T1.미수금입금금액),0) AS 미수금입금금액 
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매출처명, T3.전화번호
--      ORDER BY T1.사업장코드, T3.매출처명
--    END   
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별미지급금현황_집계표_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별미지급금현황_집계표_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParTDate VarChar(08) = '', @ParSupplierCode VarChar(08) = '', @ParMJGbn int = 2)
-- 
-- AS
-- IF @ParMJGbn = 1 
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미지급금누계금액) AS 미지급금금액, SUM(T1.미지급금지급누계금액) AS 미지급금지급금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.입고수량*T1.입고단가) * 1.1) AS 미지급금금액, 0 AS 미지급금지급금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--        AND (T1.입출고구분 = 1)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            0 AS 미지급금금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 미지급금지급금액 
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T3.전화번호
--    END 
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호, 
--            SUM(T1.미지급금누계금액) AS 미지급금금액, SUM(T1.미지급금지급누계금액) AS 미지급금지급금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 >= (SUBSTRING(@ParTDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParTDate, 1, 6)
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            (SUM(T1.공급가액 + T1.세액)) AS 미지급금금액, 0 AS 미지급금지급금액
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  AND T1.사용구분 = 0 
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--     UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, T3.전화번호 AS 전화번호,
--            0 AS 미지급금금액,
--            ISNULL(SUM(T1.미지급금지급금액),0) AS 미지급금지급금액 
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T3.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParTDate, 1, 6) + '01') AND @ParTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명, T3.전화번호
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T3.전화번호
--    END 
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별수금현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별수금현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명,
--            T1.미수금입금일자 AS 수금일,            
--            결제구분 = CASE WHEN T1.결제방법 = 0 THEN '현금'
--                            WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음'
--                            ELSE '오류'
--                            END,
--            ISNULL(T1.미수금입금금액,0) AS 수금금액, 
--            만기일자 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.만기일자
--                            END,
--            어음번호 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.어음번호
--                            END,
--           T1.적요 AS 적요
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미수금입금일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T3.매출처명, T1.매출처코드, T1.미수금입금일자, T1.미수금입금시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp업체별지급현황_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp업체별지급현황_일자별_인쇄] 
--       (@ParBranchCode VarChar(02)='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParSupplierCode VarChar(08) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명,
--            T1.미지급금지급일자 AS 지불일,            
--            결제구분 = CASE WHEN T1.결제방법 = 0 THEN '현금'
--                            WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음'
--                            ELSE '오류'
--                            END,
--            ISNULL(T1.미지급금지급금액,0) AS 지불금액, 
--            만기일자 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.만기일자
--                            END,
--            어음번호 = CASE WHEN T1.결제방법 = 0 THEN ''
--                            WHEN T1.결제방법 = 1 THEN ''
--                            WHEN T1.결제방법 = 2 THEN T1.어음번호
--                            END,
--           T1.적요 AS 적요
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T1.매입처코드, T3.매입처명, T1.미지급금지급일자, T1.미지급금지급시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp일계표인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp일계표인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '1' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '경   비' AS 구분,
--           '' AS 계정코드, '전일이월' AS 계정명, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '1' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '경   비' AS 구분,
--           '' AS 계정코드, '전일이월' AS 계정명,
--           0 AS 수입1, 0 AS 수입2, 
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParDate, 1, 6) + '01') AND T1.작성일자 < @ParDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '1' AS 그룹1, '1' AS 그룹2, T1.작성시간 AS 작성시간,
--           '경   비' AS 구분,
--           T1.계정코드 AS 계정코드, T1.적요 AS 계정명,
--           SUM(T1.입금금액) AS 수입1, 0 AS 수입2, 
--           SUM(T1.출금금액) AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 =  @ParDate)
--     GROUP BY T1.사업장코드, T2.사업장명, T1.작성시간, T1.계정코드, T1.적요
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '2' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '매   입' AS 구분,
--           T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--           SUM(T1.입고수량 * T1.입고단가) AS 수입1, (SUM(T1.입고수량 * T1.입고단가) * 1.1) AS 수입2,
--           0 AS 지출1, 0 AS 지출2, 
--           0 AS 잔액
--      FROM 자재입출내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND T1.입출고일자 = @ParDate
--       AND T1.입출고구분 = 1
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매입처명, T1.매입처코드
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '2' AS 그룹1, '2' AS 그룹2, '' AS 작성시간,
--           '매   출' AS 구분,
--           T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명, 
--           0 AS 수입1, 0 AS 수입2,           
--           SUM(T1.출고수량 * T1.출고단가) AS 지출1, (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 지출2,
--           0 AS 잔액
--      FROM 자재입출내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND T1.입출고일자 = @ParDate
--       AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매출처명, T1.매출처코드
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '3' AS 그룹1, '1' AS 그룹2, '' AS 작성시간,
--           '입   금' AS 구분,
--           T1.매출처코드 AS 매출처코드, T3.매출처명 AS 매출처명,
--           SUM(ISNULL(T1.미수금입금금액,0)) AS 수입1, SUM(ISNULL(T1.미수금입금금액,0)) AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           0 AS 잔액 
--      FROM 미수금내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--     WHERE T1.사업장코드 = @ParBranchCode  
--       AND T1.미수금입금일자 = @ParDate
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매출처명, T1.매출처코드   
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '3' AS 그룹1, '2' AS 그룹2, '' AS 작성시간,
--           '출   금' AS 구분,
--           T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명,
--           0 AS 수입1, 0 AS 수입2,
--           SUM(ISNULL(T1.미지급금지급금액,0)) AS 지출1, SUM(ISNULL(T1.미지급금지급금액,0)) AS 지출2,
--           0 AS 잔액 
--      FROM 미지급금내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--     WHERE T1.사업장코드 = @ParBranchCode  
--       AND T1.미지급금지급일자 = @ParDate
--     GROUP BY T1.사업장코드, T2.사업장명, T3.매입처명, T1.매입처코드   
--     ORDER BY 사업장코드, 사업장명, 그룹1, 그룹2, 작성시간
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자동마감작업갱신
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp자동마감작업갱신] 
--       (@ParBranchCode VarChar(02) ='01', @ParDate VarChar(08) = '', @ParMagamGbn TinyInt = 0, 
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '', 
--        @ParIOGbn TinyInt = 1, @ParSupplierCode Varchar(08) = '', @ParAccountCode Varchar(04) = '' )
-- 
-- AS
-- 
-- SET @ParMagamGbn = (SELECT 마감구분 = CASE WHEN @ParMagamGbn = 1 AND (SUBSTRING(@ParDate, 1, 6) > T1.자재기초마감년월) THEN 1
--                                            WHEN @ParMagamGbn = 2 AND (SUBSTRING(@ParDate, 1, 6) > T1.미지급금기초마감년월) THEN 2
--                                            WHEN @ParMagamGbn = 3 AND (SUBSTRING(@ParDate, 1, 6) > T1.미수금기초마감년월)THEN 3  
--                                            WHEN @ParMagamGbn = 4 AND (SUBSTRING(@ParDate, 1, 6) > T1.회계기초마감년월)THEN 4
--                                       ELSE 0 END
--                       FROM 사업장 T1 WHERE T1.사업장코드 = @ParBranchCode )
-- 
-- IF @ParMagamGbn = 1
--    BEGIN
--      DELETE 자재원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = @ParKindCode AND 세부코드 = @ParMtCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6)
-- 
--      INSERT 자재원장마감
--      SELECT T1.사업장코드, T1.분류코드, T1.세부코드, SUBSTRING(T1.입출고일자, 1, 6), SUM(T1.입고수량), SUM(T1.출고수량), '', ''
--        FROM 자재입출내역 T1 
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--         AND SUBSTRING(T1.입출고일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--         AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode
--       GROUP BY T1.사업장코드, T1.분류코드, T1.세부코드, SUBSTRING(T1.입출고일자, 1, 6)
-- 
--      DELETE 자재원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = @ParKindCode AND 세부코드 = @ParMtCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 자재원장마감 
--      SELECT T1.사업장코드, T1.분류코드, T1.세부코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.입고누계수량), SUM(T1.출고누계수량), '', ''
--        FROM 자재원장마감 T1 
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode 
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.분류코드, T1.세부코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')          
-- 
--    END
-- ELSE
-- IF @ParMagamGbn = 2
--    BEGIN
--      DELETE 미지급금원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 매입처코드 = @ParSupplierCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT INTO 미지급금원장마감
--      SELECT T1.사업장코드, T1.매입처코드, SUBSTRING(T1.작성일자, 1, 6), ISNULL(SUM(T1.공급가액 + T1.세액), 0), 0, '', ''                   
--        FROM 매입세금계산서장부 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 AND T1.매입처코드 = @ParSupplierCode
--         AND T1.미지급구분 = 1 AND SUBSTRING(T1.작성일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--       GROUP BY T1.사업장코드, T1.매입처코드, SUBSTRING(T1.작성일자, 1, 6)
-- 
--      UPDATE 미지급금원장마감 SET 미지급금지급누계금액 =
--             ISNULL((SELECT SUM(T2.미지급금지급금액) FROM 미지급금내역 T2 
--                      WHERE T2.사업장코드 = T1.사업장코드 AND T2.매입처코드 = T1.매입처코드
--                        AND SUBSTRING(T2.미지급금지급일자, 1, 6) = T1.마감년월), 0)
--        FROM 미지급금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매입처코드 = @ParSupplierCode AND T1.마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT 미지급금원장마감 
--      SELECT T1.사업장코드, T1.매입처코드, SUBSTRING(T1.미지급금지급일자, 1, 6), 0, ISNULL(SUM(T1.미지급금지급금액), 0), '', ''
--        FROM 미지급금내역 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매입처코드 = @ParSupplierCode 
--         AND SUBSTRING(T1.미지급금지급일자, 1, 6) = SUBSTRING(@ParDate, 1, 6) 
--         AND NOT EXISTS 
--            (SELECT T2.마감년월
--               FROM 미지급금원장마감 T2 
--              WHERE T2.사업장코드 = T1.사업장코드 AND T2.매입처코드 = T1.매입처코드 
--                AND T2.마감년월 = SUBSTRING(@ParDate, 1, 6))
--       GROUP BY T1.사업장코드, T1.매입처코드, SUBSTRING(T1.미지급금지급일자, 1, 6)   
-- 
--      DELETE 미지급금원장마감 
--       WHERE 사업장코드 = @ParBranchCode And 매입처코드 = @ParSupplierCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 미지급금원장마감 
--      SELECT T1.사업장코드, T1.매입처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.미지급금누계금액 - T1.미지급금지급누계금액), 0, '', ''
--        FROM 미지급금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매입처코드 = @ParSupplierCode
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.매입처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')
-- 
--    END 
-- ELSE
-- IF @ParMagamGbn = 3
--    BEGIN
--      DELETE 미수금원장마감 
--       WHERE 사업장코드 = @ParBranchCode AND 매출처코드 = @ParSupplierCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT INTO 미수금원장마감
--      SELECT T1.사업장코드, T1.매출처코드, SUBSTRING(T1.작성일자, 1, 6), ISNULL(SUM(T1.공급가액 + T1.세액), 0), 0, '', ''                   
--        FROM 매출세금계산서장부 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 AND T1.매출처코드 = @ParSupplierCode
--         AND T1.미수구분 = 1 AND SUBSTRING(T1.작성일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--       GROUP BY T1.사업장코드, T1.매출처코드, SUBSTRING(T1.작성일자, 1, 6)
-- 
--      UPDATE 미수금원장마감 SET 미수금입금누계금액 =
--             ISNULL((SELECT SUM(T2.미수금입금금액) FROM 미수금내역 T2 
--                      WHERE T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드
--                        AND SUBSTRING(T2.미수금입금일자, 1, 6) = T1.마감년월), 0)
--        FROM 미수금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매출처코드 = @ParSupplierCode AND T1.마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT 미수금원장마감 
--      SELECT T1.사업장코드, T1.매출처코드, SUBSTRING(T1.미수금입금일자, 1, 6), 0, ISNULL(SUM(T1.미수금입금금액), 0), '', ''
--        FROM 미수금내역 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매출처코드 = @ParSupplierCode 
--         AND SUBSTRING(T1.미수금입금일자, 1, 6) = SUBSTRING(@ParDate, 1, 6) 
--         AND NOT EXISTS 
--            (SELECT T2.마감년월
--               FROM 미수금원장마감 T2 
--              WHERE T2.사업장코드 = T1.사업장코드 AND T2.매출처코드 = T1.매출처코드 
--                AND T2.마감년월 = SUBSTRING(@ParDate, 1, 6))
--       GROUP BY T1.사업장코드, T1.매출처코드, SUBSTRING(T1.미수금입금일자, 1, 6)   
-- 
--      DELETE 미수금원장마감 
--       WHERE 사업장코드 = @ParBranchCode And 매출처코드 = @ParSupplierCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 미수금원장마감 
--      SELECT T1.사업장코드, T1.매출처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.미수금누계금액 - T1.미수금입금누계금액), 0, '', ''
--        FROM 미수금원장마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.매출처코드 = @ParSupplierCode
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.매출처코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')
-- 
--    END 
-- ELSE
-- IF @ParMagamGbn = 4
--    BEGIN
--      DELETE 회계전표내역마감 
--       WHERE 사업장코드 = @ParBranchCode AND 계정코드 = @ParAccountCode AND 마감년월 = SUBSTRING(@ParDate, 1, 6) 
-- 
--      INSERT 회계전표내역마감 
--      SELECT T1.사업장코드, T1.계정코드, SUBSTRING(T1.작성일자, 1, 6), SUM(T1.입금금액), SUM(T1.출금금액), '', ''
--        FROM 회계전표내역 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0 
--         AND SUBSTRING(T1.작성일자, 1, 6) = SUBSTRING(@ParDate, 1, 6)
--         AND T1.계정코드 = @ParAccountCode
--       GROUP BY T1.사업장코드, T1.계정코드, SUBSTRING(T1.작성일자, 1, 6)
-- 
--      DELETE 회계전표내역마감 
--       WHERE 사업장코드 = @ParBranchCode AND 계정코드 = @ParAccountCode 
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--      INSERT 회계전표내역마감 
--      SELECT T1.사업장코드, T1.계정코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00'),
--             SUM(T1.입금누계금액), SUM(T1.출금누계금액), '', ''
--        FROM 회계전표내역마감 T1
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.계정코드 = @ParAccountCode
--         AND SUBSTRING(T1.마감년월, 1, 4) >= SUBSTRING(@ParDate, 1, 4)
--       GROUP BY T1.사업장코드, T1.계정코드, (CONVERT(VARCHAR(4), (CONVERT(INT, SUBSTRING(T1.마감년월, 1, 4)) + 1)) + '00')
-- 
--      UPDATE 회계전표내역마감 SET 
--             입금누계금액 = CASE WHEN (입금누계금액 > 출금누계금액) THEN (입금누계금액 - 출금누계금액) ELSE 0 END, 
--             출금누계금액 = CASE WHEN (입금누계금액 < 출금누계금액) THEN (출금누계금액 - 입금누계금액) ELSE 0 END 
--       WHERE 사업장코드 = @ParBranchCode AND 계정코드 = @ParAccountCode
--         AND 마감년월 > SUBSTRING(@ParDate, 1, 6) AND SUBSTRING(마감년월, 5, 2) = '00'
-- 
--    END
--  
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자재분류정보인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp자재분류정보인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0)
-- 
-- AS
-- 
--    SELECT T1.분류코드 AS 분류코드, T1.분류명 AS 분류명,
--           T1.적요 AS 적요, 
--           사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                           WHEN T1.사용구분 = 9 THEN '사용불가'
--                      ELSE '오    류' END                 
--      FROM 자재분류 T1 
--     ORDER BY T1.분류코드
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자재시세인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp자재시세인쇄] 
--       (@AppMtGroupCode VarChar(6) = '', @AppSupplierCode VarChar(8) = '', @AppStandardDate VarChar(8) = '', 
--        @AppMtName VarChar(20) = '', @AppChkCode int = 1, @AppStateCode int = 0, @AppBranchCode Varchar(2) = '01')
-- 
-- AS
-- IF @AppChkCode = 0
--    BEGIN
--        SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명,
--               ISNULL(T1.세부코드,'') AS 세부코드, ISNULL(T2.자재명,'') AS 자재명, 
--               ISNULL(T1.매입처코드,'') AS 매입처코드, ISNULL(T3.매입처명,'') AS 매입처명,
--               ISNULL(T1.적용일자,'') AS 적용일자, ISNULL(T2.규격,'') AS 규격, ISNULL(T2.단위,'') AS 단위, 
--               과세구분 = CASE WHEN T2.과세구분 = 0 THEN '비과세'
--                               WHEN T2.과세구분 = 1 THEN '과  세'
--                               ELSE '오  류'
--                         END,
--               ISNULl(T1.입고단가,0) AS 입고단가, ISNULL(T1.입고부가,0) AS 입고부가, 
--               ISNULl(T1.출고단가,0) AS 출고단가, ISNULL(T1.출고부가,0) AS 출고부가, 
--               ISNULL(T1.마진율,0) AS 마진율,
--               사용구분 = CASE WHEN T2.사용구분 = 0 THEN '정  상'
--                               WHEN T2.사용구분 = 9 THEN '삭  제'
--                               ELSE '오  류'
--                          END
--          FROM 자재시세 T1 
--          LEFT JOIN 자재 T2 
--                 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--          LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드 
--          LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--         WHERE (T1.사업장코드 = @AppBranchCode AND T1.사용구분 = @AppStateCode)
--           AND (T1.분류코드) LIKE '%' + LTRIM(@AppMtGroupCode) + '%'
--           AND (T1.매입처코드 LIKE '%' + LTRIM(@AppSupplierCode) + '%')
--           AND (T2.자재명 LIKE '%' + LTRIM(@AppMtName) + '%')
--           AND (T1.적용일자 BETWEEN 
--                           (SELECT TOP 1 적용일자 
--                              FROM 자재시세
--                             WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드
--                               AND 적용일자 <= @AppStandardDate
--                               AND 사업장코드 = @AppBranchCode
--                             ORDER BY T1.적용일자 DESC)
--                               AND @AppStandardDate)
--         ORDER BY T1.분류코드, T1.세부코드, T1.적용일자 DESC  
--    END
-- ELSE
--    BEGIN
--        SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명,
--               ISNULL(T1.세부코드,'') AS 세부코드, ISNULL(T2.자재명,'') AS 자재명, 
--               ISNULL(T1.매입처코드,'') AS 매입처코드, ISNULL(T3.매입처명,'') AS 매입처명,
--               ISNULL(T1.적용일자,'') AS 적용일자, ISNULL(T2.규격,'') AS 규격, ISNULL(T2.단위,'') 단위, 
--               과세구분 = CASE WHEN T2.과세구분 = 0 THEN '비과세'
--                               WHEN T2.과세구분 = 1 THEN '과  세'
--                               ELSE '오  류'
--                         END,
--               ISNULl(T1.입고단가,0) AS 입고단가, ISNULL(T1.입고부가,0) AS 입고부가, 
--               ISNULl(T1.출고단가,0) AS 출고단가, ISNULL(T1.출고부가,0) AS 출고부가, 
--               ISNULL(T1.마진율,0) AS 마진율,
--               사용구분 = CASE WHEN T2.사용구분 = 0 THEN '정  상'
--                               WHEN T2.사용구분 = 9 THEN '삭  제'
--                               ELSE '오  류'
--                          END
--          FROM 자재시세 T1 
--          LEFT JOIN 자재 T2 
--                 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--          LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드 
--          LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--         WHERE (T1.사업장코드 = @AppBranchCode AND T1.사용구분 = @AppStateCode)
--           AND (T1.분류코드) LIKE '%' + LTRIM(@AppMtGroupCode) + '%'
--           AND (T1.매입처코드 LIKE '%' + LTRIM(@AppSupplierCode) + '%')
--           AND (T2.자재명 LIKE '%' + LTRIM(@AppMtName) + '%')
--           AND (T1.적용일자 = (SELECT TOP 1 적용일자 FROM 자재시세 
--                                WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                                  AND 매입처코드 = T1.매입처코드 
--                                  AND 적용일자 <= @AppStandardDate
--                                  AND 사업장코드 = @AppBranchCode
--                                ORDER BY 적용일자 DESC))
--         ORDER BY T1.분류코드, T1.세부코드, T1.적용일자 DESC  
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자재원장인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp자재원장인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParKindCode VarChar(2) = '00', @ParMtCode VarChar(20) = '', 
--        @ParMtName VarChar(20) = '', @ParStateCode int = 0, @ParAppBranchCode VarChar(2) = '01', 
--        @ParExceptionCodeGbn TinyInt = 1, @ParSupCode VarChar(8) = '' )
-- 
-- AS
-- 
-- IF @ParExceptionCodeGbn = 1
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명, 
--            ISNULL(T1.세부코드,'') AS 세부코드, T3.자재명 AS 자재명, 
--            T3.규격 AS 규격, T3.단위 AS 단위, T3.폐기율 AS 폐기율, 
--            과세구분 = CASE WHEN T3.과세구분 = 0 THEN '비과세'
--                            WHEN T3.과세구분 = 1 THEN '과  세'
--                            ELSE '오  류'
--                       END,
--            사용구분 = CASE WHEN T3.사용구분 = 0 THEN '정    상'
--                            WHEN T3.사용구분 = 9 THEN '사용불가'
--                            ELSE '오    류'
--                       END,
--            T1.적정재고 AS 적정재고, 
--            ISNULL(T1.최종입고일자,'') AS 최종입고일자, ISNULL(T1.최종출고일자,'') AS 최종출고일자, 
--            (SELECT ISNULL(SUM(입고누계수량-출고누계수량),0) 
--               FROM 자재원장마감 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 마감년월 >= (SUBSTRING(@ParAppPGDate, 1, 4) + '00')
--                AND 마감년월 <  (SUBSTRING(@ParAppPGDate, 1, 6))) AS 이월재고, 
--            (SELECT ISNULL(SUM(입고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 1
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 입고수량,                                  
--            (SELECT ISNULL(SUM(출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 2
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 출고수량,
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 5 OR 입출고구분 = 6)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고조정수량,                                  
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 11 OR 입출고구분 = 12)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고이동수량,
--            ISNULL(T1.주매입처코드, '') AS 주매입처코드, ISNULL(T5.매입처명, '') AS 주매입처명,
--            T1.입고단가1 AS 입고단가1, T1.입고단가2 AS 입고단가2, T1.입고단가3 AS 입고단가3, 
--            T1.출고단가1 AS 출고단가1, T1.출고단가2 AS 출고단가2, T1.출고단가3 AS 출고단가3
--       FROM 자재원장 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재 T3 
--              ON T3.분류코드 = T1.분류코드 AND T3.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 매입처 T5 ON T5.사업장코드 = T1.사업장코드 AND T5.매입처코드 = T1.주매입처코드
--      WHERE (T1.사업장코드 = @ParAppBranchCode AND T1.사용구분 = @ParStateCode)
--        AND (T1.분류코드) LIKE '%' + LTRIM(@ParKindCode) + '%'
--        AND (T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%')
--        AND (T3.자재명 LIKE '%' + LTRIM(@ParMtName) + '%')
--        AND (T1.주매입처코드 LIKE '%' + LTRIM(@ParSupCode) + '%')
--        AND NOT (DATALENGTH(T1.세부코드) = 9 AND UPPER(SUBSTRING(T1.세부코드, 1, 4)) = 'CODE' 
--            AND T1.세부코드 LIKE 'CODE_____' AND ISNUMERIC(SUBSTRING(T1.세부코드, 5, 5)) = 1)             
--      ORDER BY T1.분류코드, T1.세부코드
--   END
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--            ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T4.분류명,'') AS 분류명, 
--            ISNULL(T1.세부코드,'') AS 세부코드, T3.자재명 AS 자재명, 
--            T3.규격 AS 규격, T3.단위 AS 단위, T3.폐기율 AS 폐기율, 
--            과세구분 = CASE WHEN T3.과세구분 = 0 THEN '비과세'
--                            WHEN T3.과세구분 = 1 THEN '과  세'
--                            ELSE '오  류'
--                       END,
--            사용구분 = CASE WHEN T3.사용구분 = 0 THEN '정    상'
--                            WHEN T3.사용구분 = 9 THEN '사용불가'
--                            ELSE '오    류'
--                       END,
--            T1.적정재고 AS 적정재고, 
--            ISNULL(T1.최종입고일자,'') AS 최종입고일자, ISNULL(T1.최종출고일자,'') AS 최종출고일자, 
--            (SELECT ISNULL(SUM(입고누계수량-출고누계수량),0) 
--               FROM 자재원장마감 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 마감년월 >= (SUBSTRING(@ParAppPGDate, 1, 4) + '00')
--                AND 마감년월 <  (SUBSTRING(@ParAppPGDate, 1, 6))) AS 이월재고, 
--            (SELECT ISNULL(SUM(입고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 1
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 입고수량,                                  
--            (SELECT ISNULL(SUM(출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND 입출고구분 = 2
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 출고수량,
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 5 OR 입출고구분 = 6)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고조정수량,                                  
--            (SELECT ISNULL(SUM(입고수량 - 출고수량),0) 
--               FROM 자재입출내역 
--              WHERE 분류코드 = T1.분류코드 AND 세부코드 = T1.세부코드 
--                AND 사업장코드 = T1.사업장코드 
--                AND (입출고구분 = 11 OR 입출고구분 = 12)
--                AND 입출고일자 BETWEEN (SUBSTRING(@ParAppPgDate, 1, 6) + '01') AND @ParAppPgDate) AS 재고이동수량,
--            ISNULL(T1.주매입처코드, '') AS 주매입처코드, ISNULL(T5.매입처명, '') AS 주매입처명,
--            T1.입고단가1 AS 입고단가1, T1.입고단가2 AS 입고단가2, T1.입고단가3 AS 입고단가3, 
--            T1.출고단가1 AS 출고단가1, T1.출고단가2 AS 출고단가2, T1.출고단가3 AS 출고단가3
--       FROM 자재원장 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재 T3 
--              ON T3.분류코드 = T1.분류코드 AND T3.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 매입처 T5 ON T5.사업장코드 = T1.사업장코드 AND T5.매입처코드 = T1.주매입처코드
--      WHERE (T1.사업장코드 = @ParAppBranchCode AND T1.사용구분 = @ParStateCode)
--        AND (T1.분류코드) LIKE '%' + LTRIM(@ParKindCode) + '%'
--        AND (T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%')
--        AND (T3.자재명 LIKE '%' + LTRIM(@ParMtName) + '%')
--        AND (T1.주매입처코드 LIKE '%' + LTRIM(@ParSupCode) + '%')
--      ORDER BY T1.분류코드, T1.세부코드
--   END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자재정보인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp자재정보인쇄] 
--       (@AppGroupCode VarChar(2) = '00', @AppStateCode int = 0)
-- 
-- AS
-- BEGIN
--     IF @AppGroupCode = '00'
--        BEGIN 
--            SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T2.분류명,'') AS 분류명, 
--                   ISNULL(T1.세부코드,'') AS 세부코드, T1.자재명 AS 자재명, 
--                   T1.바코드 AS 바코드, T1.규격 AS 규격, T1.단위 AS 단위, T1.폐기율 AS 폐기율, 
--                   과세구분 = CASE WHEN T1.과세구분 = 0 THEN '비과세' WHEN T1.과세구분 = 1 THEN '과  세' ELSE '오  류' END,
--                   사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정  상' WHEN T1.사용구분 = 9 THEN '삭  제' ELSE '오  류' END
--              FROM 자재 T1 
--              LEFT JOIN 자재분류 T2 
--                     ON T2.분류코드 = T1.분류코드 
--             WHERE T1.사용구분 = @AppStateCode 
--             ORDER BY T1.분류코드, T1.세부코드  
--        END     
--     ELSE 
--        BEGIN
--            SELECT ISNULL(T1.분류코드,'') AS 분류코드, ISNULL(T2.분류명,'') AS 분류명, 
--                   ISNULL(T1.세부코드,'') AS 세부코드, T1.자재명 AS 자재명, 
--                   T1.바코드 AS 바코드, T1.규격 AS 규격, T1.단위 AS 단위, T1.폐기율 AS 폐기율, 
--                   과세구분 = CASE WHEN T1.과세구분 = 0 THEN '비과세' WHEN T1.과세구분 = 1 THEN '과  세' ELSE '오  류' END,
--                   사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정  상' WHEN T1.사용구분 = 9 THEN '삭  제' ELSE '오  류' END
--              FROM 자재 T1 
--              LEFT JOIN 자재분류 T2 ON T2.분류코드 = T1.분류코드 
--             WHERE T1.분류코드 = SUBSTRING(@AppGroupCode,1,2) 
--               AND T1.사용구분 = @AppStateCode 
--             ORDER BY T1.분류코드, T1.세부코드  
--        END
-- END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자재최종단가갱신
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp자재최종단가갱신] 
--       (@ParBranchCode VarChar(02) ='01', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '', @ParIOGbn Tinyint = 1, 
--        @ParSupplierCode Varchar(8) = '', @ParLastPrice Money = 0, @ParIODate VarChar(8) = '')
-- AS
-- 
-- IF @ParIOGbn = 1
--    BEGIN
--      UPDATE 자재원장 SET 
--             입고단가1 = CASE WHEN T3.단가구분 = 1 THEN @ParLastPrice ELSE 입고단가1 END,
--             입고단가2 = CASE WHEN T3.단가구분 = 2 THEN @ParLastPrice ELSE 입고단가2 END,
--             입고단가3 = CASE WHEN T3.단가구분 = 3 THEN @ParLastPrice ELSE 입고단가3 END       
--        FROM 자재원장 T1
--       INNER JOIN 자재 T2 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드
--       INNER JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = @ParSupplierCode
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode AND T1.최종입고일자 <= @ParIODate
--    END
-- ELSE
--    BEGIN
--      UPDATE 자재원장 SET 
--             출고단가1 = CASE WHEN T3.단가구분 = 1 THEN @ParLastPrice ELSE 출고단가1 END,
--             출고단가2 = CASE WHEN T3.단가구분 = 2 THEN @ParLastPrice ELSE 출고단가2 END,
--             출고단가3 = CASE WHEN T3.단가구분 = 3 THEN @ParLastPrice ELSE 출고단가3 END       
--        FROM 자재원장 T1
--       INNER JOIN 자재 T2 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드
--       INNER JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = @ParSupplierCode
--       WHERE T1.사업장코드 = @ParBranchCode AND T1.분류코드 = @ParKindCode AND T1.세부코드 = @ParMtCode AND T1.최종출고일자 <= @ParIODate
--    END
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp자재최종입출고일자갱신
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp자재최종입출고일자갱신] 
--       (@ParBranchCode VarChar(02) ='01', @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '', @ParIOGbn Tinyint = 1)
-- AS
-- 
-- IF @ParIOGbn = 1
--    BEGIN
--      UPDATE 자재원장 
--         SET 최종입고일자 = ISNULL(
--            (SELECT TOP 1 T1.입출고일자 AS 최종입출고일자
--               FROM 자재입출내역 T1 
--               LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--               LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--               LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--              WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--                AND T1.입출고구분 = @ParIOGbn
--                AND T1.분류코드 = LTRIM(@ParKindCode) AND T1.세부코드 = LTRIM(@ParMtCode)
--              ORDER BY T1.입출고일자 DESC), '')
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = LTRIM(@ParKindCode) AND 세부코드 = LTRIM(@ParMtCode)            
--    END
-- ELSE
--    BEGIN
--      UPDATE 자재원장 
--         SET 최종출고일자 = ISNULL(
--            (SELECT TOP 1 T1.입출고일자 AS 최종입출고일자
--               FROM 자재입출내역 T1 
--               LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--               LEFT JOIN 자재분류 T3 ON T3.분류코드 = T1.분류코드 
--               LEFT JOIN 자재 T4 ON T4.분류코드 = T1.분류코드 AND T4.세부코드 = T1.세부코드
--              WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--                AND T1.입출고구분 = @ParIOGbn
--                AND T1.분류코드 = LTRIM(@ParKindCode) AND T1.세부코드 = LTRIM(@ParMtCode)
--              ORDER BY T1.입출고일자 DESC), '')
--       WHERE 사업장코드 = @ParBranchCode AND 분류코드 = LTRIM(@ParKindCode) AND 세부코드 = LTRIM(@ParMtCode)            
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp재고이동내역인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp재고이동내역인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.입고수량) AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           ((T1.입고수량) * T1.입고단가) AS 금액1, (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명, T1.재고이동사업장코드 AS 이동사업장코드, T6.사업장명 AS 이동사업장명
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--       LEFT JOIN 사업장 T6 
--              ON T6.사업장코드 = T1.재고이동사업장코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 11) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      UNION ALL
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.출고수량) AS 출고수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           ((T1.출고수량) * T1.출고단가) AS 금액1, (T1.출고수량 * T1.출고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명, T1.재고이동사업장코드 AS 이동사업장코드, T6.사업장명 AS 이동사업장명
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--       LEFT JOIN 사업장 T6 
--              ON T6.사업장코드 = T1.재고이동사업장코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 12) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T1.분류코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- 
-- 
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp재고조정내역인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp재고조정내역인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.입고수량) AS 수량, T1.입고단가 AS 단가, T1.입고부가 AS 부가,
--           ((T1.입고수량) * T1.입고단가) AS 금액1, (T1.입고수량 * T1.입고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 5) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      UNION ALL
--     SELECT T1.사업장코드, T1.입출고일자 AS 일자, T1.입출고시간 AS 시간,           
--            T1.분류코드 AS 분류코드, T3.분류명 AS 분류명,
--            T1.세부코드 AS 세부코드, ISNULL(T2.자재명,'') AS 자재명,  
--            T2.규격 AS 규격,  T2.단위 AS 단위, T1.입출고구분, T1.사용구분 AS 사용구분, T2.과세구분,
--           (T1.출고수량) AS 출고수량, T1.출고단가 AS 단가, T1.출고부가 AS 부가,
--           ((T1.출고수량) * T1.출고단가) AS 금액1, (T1.출고수량 * T1.출고단가 * 1.1) AS 금액2,
--            T1.적요, T1.사용자코드, T4.사용자명 
--       FROM 자재입출내역 T1
--       LEFT JOIN 자재 T2 
--              ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드 
--       LEFT JOIN 자재분류 T3 
--              ON T3.분류코드 = T1.분류코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사업장코드 = T1.사업장코드 AND T4.사용자코드= T1.사용자코드 
--       LEFT JOIN 자재원장 T5 
--              ON T5.사업장코드 = T1.사업장코드 AND T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND (T1.입출고구분 = 6) AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--      ORDER BY T1.사업장코드, T1.분류코드, T1.입출고일자, T1.입출고시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp출납관리_계정과목별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp출납관리_계정과목별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParFDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액        
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParFDate, 1, 6) + '01') AND T1.작성일자 < @ParFDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T1.작성일자 AS 작성일자,
--           T1.계정코드 AS 계정코드, T3.계정명 AS 계정명, T1.적요 AS 적요,
--           T1.입금금액 AS 수입1, 0 AS 수입2,
--           T1.출금금액 AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 BETWEEN @ParFDate AND @ParTDate)
--     ORDER BY 사업장코드, 계정코드, 작성일자
--  
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp출납관리_계정별집계_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp출납관리_계정별집계_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--           '' AS 계정코드, '전일이월' AS 계정명,
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParFDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, 
--           '' AS 계정코드, '전일이월' AS 계정명, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액        
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParFDate, 1, 6) + '01') AND T1.작성일자 < @ParFDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--           T1.계정코드 AS 계정코드, T3.계정명 AS 계정명,
--           SUM(T1.입금금액) AS 수입1, 0 AS 수입2,
--           SUM(T1.출금금액) AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 BETWEEN @ParFDate AND @ParTDate)
--     GROUP BY T1.사업장코드, T2.사업장명, T1.계정코드, T3.계정명
--     ORDER BY 사업장코드, 계정코드
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp출납관리_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp출납관리_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자, '' AS 작성시간,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금누계금액 - T1.출금누계금액) AS 잔액        
--      FROM 회계전표내역마감 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode
--       AND T1.마감년월 >= (SUBSTRING(@ParFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParFDate, 1, 6) 
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, '' AS 작성일자, '' AS 작성시간,
--           '' AS 계정코드, '전일이월' AS 계정명, '' AS 적요, 
--           0 AS 수입1, 0 AS 수입2,
--           0 AS 지출1, 0 AS 지출2,
--           SUM(T1.입금금액 - T1.출금금액) AS 잔액        
--      FROM 회계전표내역 T1 
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 >= (SUBSTRING(@ParFDate, 1, 6) + '01') AND T1.작성일자 < @ParFDate)
--     GROUP BY T1.사업장코드, T2.사업장명
--     UNION ALL
--    SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T1.작성일자 AS 작성일자, T1.작성시간 AS 작성시간,
--           T1.계정코드 AS 계정코드, T3.계정명 AS 계정명, T1.적요 AS 적요,
--           T1.입금금액 AS 수입1, 0 AS 수입2,
--           T1.출금금액 AS 지출1, 0 AS 지출2,
--           0 AS 잔액
--      FROM 회계전표내역 T1
--      LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--      LEFT JOIN 계정과목 T3 ON T3.계정코드 = T1.계정코드
--     WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--       AND (T1.작성일자 BETWEEN @ParFDate AND @ParTDate)
--     ORDER BY 사업장코드, 작성일자, 작성시간, 계정코드
--  
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp품목별매입현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp품목별매입현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격, T5.단위 AS 단위,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 + T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END
-- ELSE
--    BEGIN
--          SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, T5.자재명 AS 품명, T5.규격 AS 규격, T5.단위 AS 단위,
--            (T1.입고단가) AS 단가, (T1.입고부가) AS 부가, SUM(T1.입고수량) AS 수량, 
--            SUM(T1.입고수량 * T1.입고단가) AS 금액1,
--            (SUM(T1.입고수량 + T1.입고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.입출고구분 = 1
--        AND T1.분류코드 = LTRIM(@ParKindCode)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp품목별매출현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp품목별매출현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',
--        @ParKindCode Varchar(02) = '01', @ParMtCode VarChar(20) = '')
-- 
-- AS
-- IF @ParKindCode = '00'
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명,'') AS 품명, 
--            ISNULL(T5.규격,'') AS 규격, ISNULL(T5.단위, '') AS 단위,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END 
-- ELSE
--    BEGIN
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            (T1.분류코드+T1.세부코드) AS 자재코드, ISNULL(T5.자재명,'') AS 품명, 
--            ISNULL(T5.규격,'') AS 규격, ISNULL(T5.단위, '') AS 단위,
--            (T1.출고단가) AS 단가, (T1.출고부가) AS 부가, SUM(T1.출고수량) AS 수량, 
--            SUM(T1.출고수량 * T1.출고단가) AS 금액1,
--            (SUM(T1.출고수량 * T1.출고단가) * 1.1) AS 금액2
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T5 ON T5.분류코드 = T1.분류코드 AND T5.세부코드 = T1.세부코드
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.입출고일자 BETWEEN @ParFDate AND @ParTDate
--        AND (T1.입출고구분 = 2 OR T1.입출고구분 = 8)
--        AND T1.분류코드 = LTRIM(@ParKindCode) 
--        AND T1.세부코드 LIKE '%' + LTRIM(@ParMtCode) + '%'
--      GROUP BY T1.사업장코드, T2.사업장명,
--              (T1.분류코드 + T1.세부코드), T5.자재명, T5.규격, T5.단위, T1.출고단가, T1.출고부가
--      ORDER BY T1.사업장코드, (T1.분류코드 + T1.세부코드)
--    END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp합계시산표
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp합계시산표] 
--       (@ParBranchCode VarChar(02) ='01', @ParDate VarChar(8) = '')
-- 
-- AS
-- 
--    SELECT 0 AS 차변누계, 0 AS 차변당월,
--           '' AS 계정코드, '매     입' AS 계정명,
--           (SELECT ISNULL(SUM(입고단가 * 입고수량), 0) 
--              FROM 자재입출내역 
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND 입출고구분 = 1
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 대변당월,          
--           (SELECT ISNULL(SUM(입고단가 * 입고수량), 0) 
--              FROM 자재입출내역 
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND 입출고구분 = 1
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 대변누계
--     UNION ALL
--    SELECT (SELECT ISNULL(SUM(출고단가 * 출고수량), 0) 
--              FROM 자재입출내역
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND (입출고구분 = 2 OR 입출고구분 = 8)
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 차변누계,
--           (SELECT ISNULL(SUM(출고단가 * 출고수량), 0) 
--              FROM 자재입출내역 
--             WHERE 사업장코드 = @ParBranchCode AND 사용구분 = 0 AND (입출고구분 = 2 OR 입출고구분 = 8)
--               AND 입출고일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 차변당월,
--           '' AS 계정코드, '매     출' AS 계정명,
--           0 AS 대변당월, 0 AS 대변누계 
--     UNION ALL
--    SELECT (SELECT ISNULL(SUM(입금금액), 0) 
--              FROM 회계전표내역
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 차변누계,
--           (SELECT ISNULL(SUM(입금금액), 0) 
--              FROM 회계전표내역 
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 차변당월,
--           T1.계정코드 AS 계정코드, T1.계정명 AS 계정명,
--           (SELECT ISNULL(SUM(출금금액), 0) 
--              FROM 회계전표내역 
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 6) + '01') AND @ParDate) AS 대변당월,
--           (SELECT ISNULL(SUM(출금금액), 0) 
--              FROM 회계전표내역
--             WHERE 계정코드 = T1.계정코드 AND 사업장코드 = @ParBranchCode AND 사용구분 = 0
--               AND 작성일자 BETWEEN (SUBSTRING(@ParDate, 1, 4) + '0101') AND @ParDate) AS 대변누계
--      FROM 계정과목 T1
--     WHERE T1.합계시산표연결여부 = 'Y'
--     ORDER BY T1.계정코드
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_generateansiname
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /* 
-- **	Generate an ansi name that is unique in the dtproperties.value column 
-- */ 
-- create procedure dbo.dt_generateansiname(@name varchar(255) output) 
-- as 
-- 	declare @prologue varchar(20) 
-- 	declare @indexstring varchar(20) 
-- 	declare @index integer 
--  
-- 	set @prologue = 'MSDT-A-' 
-- 	set @index = 1 
--  
-- 	while 1 = 1 
-- 	begin 
-- 		set @indexstring = cast(@index as varchar(20)) 
-- 		set @name = @prologue + @indexstring 
-- 		if not exists (select value from dtproperties where value = @name) 
-- 			break 
-- 		 
-- 		set @index = @index + 1 
--  
-- 		if (@index = 10000) 
-- 			goto TooMany 
-- 	end 
--  
-- Leave: 
--  
-- 	return 
--  
-- TooMany: 
--  
-- 	set @name = 'DIAGRAM' 
-- 	goto Leave 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_adduserobject
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Add an object to the dtproperties table
-- */
-- create procedure dbo.dt_adduserobject
-- as
-- 	set nocount on
-- 	/*
-- 	** Create the user object if it does not exist already
-- 	*/
-- 	begin transaction
-- 		insert dbo.dtproperties (property) VALUES ('DtgSchemaOBJECT')
-- 		update dbo.dtproperties set objectid=@@identity 
-- 			where id=@@identity and property='DtgSchemaOBJECT'
-- 	commit
-- 	return @@identity
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_setpropertybyid
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	If the property already exists, reset the value; otherwise add property
-- **		id -- the id in sysobjects of the object
-- **		property -- the name of the property
-- **		value -- the text value of the property
-- **		lvalue -- the binary value of the property (image)
-- */
-- create procedure dbo.dt_setpropertybyid
-- 	@id int,
-- 	@property varchar(64),
-- 	@value varchar(255),
-- 	@lvalue image
-- as
-- 	set nocount on
-- 	declare @uvalue nvarchar(255) 
-- 	set @uvalue = convert(nvarchar(255), @value) 
-- 	if exists (select * from dbo.dtproperties 
-- 			where objectid=@id and property=@property)
-- 	begin
-- 		--
-- 		-- bump the version count for this row as we update it
-- 		--
-- 		update dbo.dtproperties set value=@value, uvalue=@uvalue, lvalue=@lvalue, version=version+1
-- 			where objectid=@id and property=@property
-- 	end
-- 	else
-- 	begin
-- 		--
-- 		-- version count is auto-set to 0 on initial insert
-- 		--
-- 		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
-- 			values (@property, @id, @value, @uvalue, @lvalue)
-- 	end
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_getobjwithprop
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Retrieve the owner object(s) of a given property
-- */
-- create procedure dbo.dt_getobjwithprop
-- 	@property varchar(30),
-- 	@value varchar(255)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 	begin
-- 		raiserror('Must specify a property name.',-1,-1)
-- 		return (1)
-- 	end
-- 
-- 	if (@value is null)
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property
-- 
-- 	else
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property and value=@value
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_getpropertiesbyid
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Retrieve properties by id's
-- **
-- **	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
-- **	dt_getproperties objid, property -- retrieve the property specified
-- */
-- create procedure dbo.dt_getpropertiesbyid
-- 	@id int,
-- 	@property varchar(64)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 		select property, version, value, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid
-- 	else
-- 		select property, version, value, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid and @property=property
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_setpropertybyid_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	If the property already exists, reset the value; otherwise add property
-- **		id -- the id in sysobjects of the object
-- **		property -- the name of the property
-- **		uvalue -- the text value of the property
-- **		lvalue -- the binary value of the property (image)
-- */
-- create procedure dbo.dt_setpropertybyid_u
-- 	@id int,
-- 	@property varchar(64),
-- 	@uvalue nvarchar(255),
-- 	@lvalue image
-- as
-- 	set nocount on
-- 	-- 
-- 	-- If we are writing the name property, find the ansi equivalent. 
-- 	-- If there is no lossless translation, generate an ansi name. 
-- 	-- 
-- 	declare @avalue varchar(255) 
-- 	set @avalue = null 
-- 	if (@uvalue is not null) 
-- 	begin 
-- 		if (convert(nvarchar(255), convert(varchar(255), @uvalue)) = @uvalue) 
-- 		begin 
-- 			set @avalue = convert(varchar(255), @uvalue) 
-- 		end 
-- 		else 
-- 		begin 
-- 			if 'DtgSchemaNAME' = @property 
-- 			begin 
-- 				exec dbo.dt_generateansiname @avalue output 
-- 			end 
-- 		end 
-- 	end 
-- 	if exists (select * from dbo.dtproperties 
-- 			where objectid=@id and property=@property)
-- 	begin
-- 		--
-- 		-- bump the version count for this row as we update it
-- 		--
-- 		update dbo.dtproperties set value=@avalue, uvalue=@uvalue, lvalue=@lvalue, version=version+1
-- 			where objectid=@id and property=@property
-- 	end
-- 	else
-- 	begin
-- 		--
-- 		-- version count is auto-set to 0 on initial insert
-- 		--
-- 		insert dbo.dtproperties (property, objectid, value, uvalue, lvalue)
-- 			values (@property, @id, @avalue, @uvalue, @lvalue)
-- 	end
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_getobjwithprop_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Retrieve the owner object(s) of a given property
-- */
-- create procedure dbo.dt_getobjwithprop_u
-- 	@property varchar(30),
-- 	@uvalue nvarchar(255)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 	begin
-- 		raiserror('Must specify a property name.',-1,-1)
-- 		return (1)
-- 	end
-- 
-- 	if (@uvalue is null)
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property
-- 
-- 	else
-- 		select objectid id from dbo.dtproperties
-- 			where property=@property and uvalue=@uvalue
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_getpropertiesbyid_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Retrieve properties by id's
-- **
-- **	dt_getproperties objid, null or '' -- retrieve all properties of the object itself
-- **	dt_getproperties objid, property -- retrieve the property specified
-- */
-- create procedure dbo.dt_getpropertiesbyid_u
-- 	@id int,
-- 	@property varchar(64)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 		select property, version, uvalue, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid
-- 	else
-- 		select property, version, uvalue, lvalue
-- 			from dbo.dtproperties
-- 			where  @id=objectid and @property=property
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_dropuserobjectbyid
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Drop an object from the dbo.dtproperties table
-- */
-- create procedure dbo.dt_dropuserobjectbyid
-- 	@id int
-- as
-- 	set nocount on
-- 	delete from dbo.dtproperties where objectid=@id
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_droppropertiesbyid
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	Drop one or all the associated properties of an object or an attribute 
-- **
-- **	dt_dropproperties objid, null or '' -- drop all properties of the object itself
-- **	dt_dropproperties objid, property -- drop the property
-- */
-- create procedure dbo.dt_droppropertiesbyid
-- 	@id int,
-- 	@property varchar(64)
-- as
-- 	set nocount on
-- 
-- 	if (@property is null) or (@property = '')
-- 		delete from dbo.dtproperties where objectid=@id
-- 	else
-- 		delete from dbo.dtproperties 
-- 			where objectid=@id and property=@property
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_verstamp006
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	This procedure returns the version number of the stored
-- **    procedures used by legacy versions of the Microsoft
-- **	Visual Database Tools.  Version is 7.0.00.
-- */
-- create procedure dbo.dt_verstamp006
-- as
-- 	select 7000
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_verstamp007
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- /*
-- **	This procedure returns the version number of the stored
-- **    procedures used by the the Microsoft Visual Database Tools.
-- **	Version is 7.0.05.
-- */
-- create procedure dbo.dt_verstamp007
-- as
-- 	select 7005
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_getpropertiesbyid_vcs
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create procedure dbo.dt_getpropertiesbyid_vcs
--     @id       int,
--     @property varchar(64),
--     @value    varchar(255) = NULL OUT
-- 
-- as
-- 
--     set nocount on
-- 
--     select @value = (
--         select value
--                 from dbo.dtproperties
--                 where @id=objectid and @property=property
--                 )
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_displayoaerror
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- CREATE PROCEDURE dbo.dt_displayoaerror
--     @iObject int,
--     @iresult int
-- as
-- 
-- set nocount on
-- 
-- declare @vchOutput      varchar(255)
-- declare @hr             int
-- declare @vchSource      varchar(255)
-- declare @vchDescription varchar(255)
-- 
--     exec @hr = master.dbo.sp_OAGetErrorInfo @iObject, @vchSource OUT, @vchDescription OUT
-- 
--     select @vchOutput = @vchSource + ': ' + @vchDescription
--     raiserror (@vchOutput,16,-1)
-- 
--     return
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_adduserobject_vcs
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create procedure dbo.dt_adduserobject_vcs
--     @vchProperty varchar(64)
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
--     /*
--     ** Create the user object if it does not exist already
--     */
--     begin transaction
--         select @iReturn = objectid from dbo.dtproperties where property = @vchProperty
--         if @iReturn IS NULL
--         begin
--             insert dbo.dtproperties (property) VALUES (@vchProperty)
--             update dbo.dtproperties set objectid=@@identity
--                     where id=@@identity and property=@vchProperty
--             select @iReturn = @@identity
--         end
--     commit
--     return @iReturn
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_addtosourcecontrol
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_addtosourcecontrol
--     @vchSourceSafeINI varchar(255) = '',
--     @vchProjectName   varchar(255) ='',
--     @vchComment       varchar(255) ='',
--     @vchLoginName     varchar(255) ='',
--     @vchPassword      varchar(255) =''
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
-- declare @iObjectId int
-- select @iObjectId = 0
-- 
-- declare @iStreamObjectId int
-- select @iStreamObjectId = 0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- declare @vchDatabaseName varchar(255)
-- select @vchDatabaseName = db_name()
-- 
-- declare @iReturnValue int
-- select @iReturnValue = 0
-- 
-- declare @iPropertyObjectId int
-- declare @vchParentId varchar(255)
-- 
-- declare @iObjectCount int
-- select @iObjectCount = 0
-- 
--     exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--     if @iReturn <> 0 GOTO E_OAError
-- 
-- 
--     /* Create Project in SS */
--     exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 											'AddProjectToSourceSafe',
-- 											NULL,
-- 											@vchSourceSafeINI,
-- 											@vchProjectName output,
-- 											@@SERVERNAME,
-- 											@vchDatabaseName,
-- 											@vchLoginName,
-- 											@vchPassword,
-- 											@vchComment
-- 
-- 
--     if @iReturn <> 0 GOTO E_OAError
-- 
--     /* Set Database Properties */
-- 
--     begin tran SetProperties
-- 
--     /* add high level object */
-- 
--     exec @iPropertyObjectId = dbo.dt_adduserobject_vcs 'VCSProjectID'
-- 
--     select @vchParentId = CONVERT(varchar(255),@iPropertyObjectId)
-- 
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSProjectID', @vchParentId , NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSProject' , @vchProjectName , NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSSourceSafeINI' , @vchSourceSafeINI , NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSSQLServer', @@SERVERNAME, NULL
--     exec dbo.dt_setpropertybyid @iPropertyObjectId, 'VCSSQLDatabase', @vchDatabaseName, NULL
-- 
--     if @@error <> 0 GOTO E_General_Error
-- 
--     commit tran SetProperties
--     
--     select @iObjectCount = 0;
-- 
-- CleanUp:
--     select @vchProjectName
--     select @iObjectCount
--     return
-- 
-- E_General_Error:
--     /* this is an all or nothing.  No specific error messages */
--     goto CleanUp
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     goto CleanUp
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_checkinobject
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_checkinobject
--     @chObjectType  char(4),
--     @vchObjectName varchar(255),
--     @vchComment    varchar(255)='',
--     @vchLoginName  varchar(255),
--     @vchPassword   varchar(255)='',
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0,   /* 0 => AddFile, 1 => CheckIn */
--     @txStream1     Text = '', /* drop stream   */ /* There is a bug that if items are NULL they do not pass to OLE servers */
--     @txStream2     Text = '', /* create stream */
--     @txStream3     Text = ''  /* grant stream  */
-- 
-- 
-- as
-- 
-- 	set nocount on
-- 
-- 	declare @iReturn int
-- 	declare @iObjectId int
-- 	select @iObjectId = 0
-- 	declare @iStreamObjectId int
-- 
-- 	declare @VSSGUID varchar(100)
-- 	select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- 	declare @iPropertyObjectId int
-- 	select @iPropertyObjectId  = 0
-- 
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     declare @iReturnValue	  int
--     declare @pos			  int
--     declare @vchProcLinePiece varchar(255)
-- 
--     
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if @chObjectType = 'PROC'
--     begin
--         if @iActionFlag = 1
--         begin
--             /* Procedure Can have up to three streams
--             Drop Stream, Create Stream, GRANT stream */
-- 
--             begin tran compile_all
-- 
--             /* try to compile the streams */
--             exec (@txStream1)
--             if @@error <> 0 GOTO E_Compile_Fail
-- 
--             exec (@txStream2)
--             if @@error <> 0 GOTO E_Compile_Fail
-- 
--             exec (@txStream3)
--             if @@error <> 0 GOTO E_Compile_Fail
--         end
-- 
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, 'GetStreamObject', @iStreamObjectId OUT
--         if @iReturn <> 0 GOTO E_OAError
--         
--         if @iActionFlag = 1
--         begin
--             
--             declare @iStreamLength int
-- 			
-- 			select @pos=1
-- 			select @iStreamLength = datalength(@txStream2)
-- 			
-- 			if @iStreamLength > 0
-- 			begin
-- 			
-- 				while @pos < @iStreamLength
-- 				begin
-- 						
-- 					select @vchProcLinePiece = substring(@txStream2, @pos, 255)
-- 					
-- 					exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'AddStream', @iReturnValue OUT, @vchProcLinePiece
--             		if @iReturn <> 0 GOTO E_OAError
--             		
-- 					select @pos = @pos + 255
-- 					
-- 				end
--             
-- 				exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 														'CheckIn_StoredProcedure',
-- 														NULL,
-- 														@sProjectName = @vchProjectName,
-- 														@sSourceSafeINI = @vchSourceSafeINI,
-- 														@sServerName = @vchServerName,
-- 														@sDatabaseName = @vchDatabaseName,
-- 														@sObjectName = @vchObjectName,
-- 														@sComment = @vchComment,
-- 														@sLoginName = @vchLoginName,
-- 														@sPassword = @vchPassword,
-- 														@iVCSFlags = @iVCSFlags,
-- 														@iActionFlag = @iActionFlag,
-- 														@sStream = ''
--                                         
-- 			end
--         end
--         else
--         begin
--         
--             select colid, text into #ProcLines
--             from syscomments
--             where id = object_id(@vchObjectName)
--             order by colid
-- 
--             declare @iCurProcLine int
--             declare @iProcLines int
--             select @iCurProcLine = 1
--             select @iProcLines = (select count(*) from #ProcLines)
--             while @iCurProcLine <= @iProcLines
--             begin
--                 select @pos = 1
--                 declare @iCurLineSize int
--                 select @iCurLineSize = len((select text from #ProcLines where colid = @iCurProcLine))
--                 while @pos <= @iCurLineSize
--                 begin                
--                     select @vchProcLinePiece = convert(varchar(255),
--                         substring((select text from #ProcLines where colid = @iCurProcLine),
--                                   @pos, 255 ))
--                     exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'AddStream', @iReturnValue OUT, @vchProcLinePiece
--                     if @iReturn <> 0 GOTO E_OAError
--                     select @pos = @pos + 255                  
--                 end
--                 select @iCurProcLine = @iCurProcLine + 1
--             end
--             drop table #ProcLines
-- 
--             exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 													'CheckIn_StoredProcedure',
-- 													NULL,
-- 													@sProjectName = @vchProjectName,
-- 													@sSourceSafeINI = @vchSourceSafeINI,
-- 													@sServerName = @vchServerName,
-- 													@sDatabaseName = @vchDatabaseName,
-- 													@sObjectName = @vchObjectName,
-- 													@sComment = @vchComment,
-- 													@sLoginName = @vchLoginName,
-- 													@sPassword = @vchPassword,
-- 													@iVCSFlags = @iVCSFlags,
-- 													@iActionFlag = @iActionFlag,
-- 													@sStream = ''
--         end
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         if @iActionFlag = 1
--         begin
--             commit tran compile_all
--             if @@error <> 0 GOTO E_Compile_Fail
--         end
-- 
--     end
-- 
-- CleanUp:
-- 	return
-- 
-- E_Compile_Fail:
-- 	declare @lerror int
-- 	select @lerror = @@error
-- 	rollback tran compile_all
-- 	RAISERROR (@lerror,16,-1)
-- 	goto CleanUp
-- 
-- E_OAError:
-- 	if @iActionFlag = 1 rollback tran compile_all
-- 	exec dbo.dt_displayoaerror @iObjectId, @iReturn
-- 	goto CleanUp
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_checkoutobject
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_checkoutobject
--     @chObjectType  char(4),
--     @vchObjectName varchar(255),
--     @vchComment    varchar(255),
--     @vchLoginName  varchar(255),
--     @vchPassword   varchar(255),
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0/* 0 => Checkout, 1 => GetLatest, 2 => UndoCheckOut */
-- 
-- as
-- 
-- 	set nocount on
-- 
-- 	declare @iReturn int
-- 	declare @iObjectId int
-- 	select @iObjectId =0
-- 
-- 	declare @VSSGUID varchar(100)
-- 	select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- 	declare @iReturnValue int
-- 	select @iReturnValue = 0
-- 
-- 	declare @vchTempText varchar(255)
-- 
-- 	/* this is for our strings */
-- 	declare @iStreamObjectId int
-- 	select @iStreamObjectId = 0
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if @chObjectType = 'PROC'
--     begin
--         /* Procedure Can have up to three streams
--            Drop Stream, Create Stream, GRANT stream */
-- 
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 												'CheckOut_StoredProcedure',
-- 												NULL,
-- 												@sProjectName = @vchProjectName,
-- 												@sSourceSafeINI = @vchSourceSafeINI,
-- 												@sObjectName = @vchObjectName,
-- 												@sServerName = @vchServerName,
-- 												@sDatabaseName = @vchDatabaseName,
-- 												@sComment = @vchComment,
-- 												@sLoginName = @vchLoginName,
-- 												@sPassword = @vchPassword,
-- 												@iVCSFlags = @iVCSFlags,
-- 												@iActionFlag = @iActionFlag
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
-- 
--         exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, 'GetStreamObject', @iStreamObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         create table #commenttext (id int identity, sourcecode varchar(255))
-- 
-- 
--         select @vchTempText = 'STUB'
--         while @vchTempText is not null
--         begin
--             exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'GetStream', @iReturnValue OUT, @vchTempText OUT
--             if @iReturn <> 0 GOTO E_OAError
--             
--             if (@vchTempText = '') set @vchTempText = null
--             if (@vchTempText is not null) insert into #commenttext (sourcecode) select @vchTempText
--         end
-- 
--         select 'VCS'=sourcecode from #commenttext order by id
--         select 'SQL'=text from syscomments where id = object_id(@vchObjectName) order by colid
-- 
--     end
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     GOTO CleanUp
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_isundersourcecontrol
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_isundersourcecontrol
--     @vchLoginName varchar(255) = '',
--     @vchPassword  varchar(255) = '',
--     @iWhoToo      int = 0 /* 0 => Just check project; 1 => get list of objs */
-- 
-- as
-- 
-- 	set nocount on
-- 
-- 	declare @iReturn int
-- 	declare @iObjectId int
-- 	select @iObjectId = 0
-- 
-- 	declare @VSSGUID varchar(100)
-- 	select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
-- 	declare @iReturnValue int
-- 	select @iReturnValue = 0
-- 
-- 	declare @iStreamObjectId int
-- 	select @iStreamObjectId   = 0
-- 
-- 	declare @vchTempText varchar(255)
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if (@vchProjectName = '')	set @vchProjectName		= null
--     if (@vchSourceSafeINI = '') set @vchSourceSafeINI	= null
--     if (@vchServerName = '')	set @vchServerName		= null
--     if (@vchDatabaseName = '')	set @vchDatabaseName	= null
--     
--     if (@vchProjectName is null) or (@vchSourceSafeINI is null) or (@vchServerName is null) or (@vchDatabaseName is null)
--     begin
--         RAISERROR('Not Under Source Control',16,-1)
--         return
--     end
-- 
--     if @iWhoToo = 1
--     begin
-- 
--         /* Get List of Procs in the project */
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 												'GetListOfObjects',
-- 												NULL,
-- 												@vchProjectName,
-- 												@vchSourceSafeINI,
-- 												@vchServerName,
-- 												@vchDatabaseName,
-- 												@vchLoginName,
-- 												@vchPassword
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         exec @iReturn = master.dbo.sp_OAGetProperty @iObjectId, 'GetStreamObject', @iStreamObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         create table #ObjectList (id int identity, vchObjectlist varchar(255))
-- 
--         select @vchTempText = 'STUB'
--         while @vchTempText is not null
--         begin
--             exec @iReturn = master.dbo.sp_OAMethod @iStreamObjectId, 'GetStream', @iReturnValue OUT, @vchTempText OUT
--             if @iReturn <> 0 GOTO E_OAError
--             
--             if (@vchTempText = '') set @vchTempText = null
--             if (@vchTempText is not null) insert into #ObjectList (vchObjectlist ) select @vchTempText
--         end
-- 
--         select vchObjectlist from #ObjectList order by id
--     end
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     goto CleanUp
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_removefromsourcecontrol
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create procedure dbo.dt_removefromsourcecontrol
-- 
-- as
-- 
--     set nocount on
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     exec dbo.dt_droppropertiesbyid @iPropertyObjectId, null
-- 
--     /* -1 is returned by dt_droppopertiesbyid */
--     if @@error <> 0 and @@error <> -1 return 1
-- 
--     return 0
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_validateloginparams
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_validateloginparams
--     @vchLoginName  varchar(255),
--     @vchPassword   varchar(255)
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
-- declare @iObjectId int
-- select @iObjectId =0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
--     declare @iPropertyObjectId int
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchSourceSafeINI varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
-- 
--     exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--     if @iReturn <> 0 GOTO E_OAError
-- 
--     exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 											'ValidateLoginParams',
-- 											NULL,
-- 											@sSourceSafeINI = @vchSourceSafeINI,
-- 											@sLoginName = @vchLoginName,
-- 											@sPassword = @vchPassword
--     if @iReturn <> 0 GOTO E_OAError
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     GOTO CleanUp
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_vcsenabled
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_vcsenabled
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iObjectId int
-- select @iObjectId = 0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
--     declare @iReturn int
--     exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
--     if @iReturn <> 0 raiserror('', 16, -1) /* Can't Load Helper DLLC */
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_whocheckedout
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_whocheckedout
--         @chObjectType  char(4),
--         @vchObjectName varchar(255),
--         @vchLoginName  varchar(255),
--         @vchPassword   varchar(255)
-- 
-- as
-- 
-- set nocount on
-- 
-- declare @iReturn int
-- declare @iObjectId int
-- select @iObjectId =0
-- 
-- declare @VSSGUID varchar(100)
-- select @VSSGUID = 'SQLVersionControl.VCS_SQL'
-- 
--     declare @iPropertyObjectId int
-- 
--     select @iPropertyObjectId = (select objectid from dbo.dtproperties where property = 'VCSProjectID')
-- 
--     declare @vchProjectName   varchar(255)
--     declare @vchSourceSafeINI varchar(255)
--     declare @vchServerName    varchar(255)
--     declare @vchDatabaseName  varchar(255)
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSProject',       @vchProjectName   OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSourceSafeINI', @vchSourceSafeINI OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLServer',     @vchServerName    OUT
--     exec dbo.dt_getpropertiesbyid_vcs @iPropertyObjectId, 'VCSSQLDatabase',   @vchDatabaseName  OUT
-- 
--     if @chObjectType = 'PROC'
--     begin
--         exec @iReturn = master.dbo.sp_OACreate @VSSGUID, @iObjectId OUT
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         declare @vchReturnValue varchar(255)
--         select @vchReturnValue = ''
-- 
--         exec @iReturn = master.dbo.sp_OAMethod @iObjectId,
-- 												'WhoCheckedOut',
-- 												@vchReturnValue OUT,
-- 												@sProjectName = @vchProjectName,
-- 												@sSourceSafeINI = @vchSourceSafeINI,
-- 												@sObjectName = @vchObjectName,
-- 												@sServerName = @vchServerName,
-- 												@sDatabaseName = @vchDatabaseName,
-- 												@sLoginName = @vchLoginName,
-- 												@sPassword = @vchPassword
-- 
--         if @iReturn <> 0 GOTO E_OAError
-- 
--         select @vchReturnValue
-- 
--     end
-- 
-- CleanUp:
--     return
-- 
-- E_OAError:
--     exec dbo.dt_displayoaerror @iObjectId, @iReturn
--     GOTO CleanUp
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_getpropertiesbyid_vcs_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create procedure dbo.dt_getpropertiesbyid_vcs_u
--     @id       int,
--     @property varchar(64),
--     @value    nvarchar(255) = NULL OUT
-- 
-- as
-- 
--     -- This procedure should no longer be called;  dt_getpropertiesbyid_vcsshould be called instead.
-- 	-- Calls are forwarded to dt_getpropertiesbyid_vcs to maintain backward compatibility.
-- 	set nocount on
--     exec dbo.dt_getpropertiesbyid_vcs
-- 		@id,
-- 		@property,
-- 		@value output
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_displayoaerror_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- CREATE PROCEDURE dbo.dt_displayoaerror_u
--     @iObject int,
--     @iresult int
-- as
-- 	-- This procedure should no longer be called;  dt_displayoaerror should be called instead.
-- 	-- Calls are forwarded to dt_displayoaerror to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_displayoaerror
-- 		@iObject,
-- 		@iresult
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_addtosourcecontrol_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_addtosourcecontrol_u
--     @vchSourceSafeINI nvarchar(255) = '',
--     @vchProjectName   nvarchar(255) ='',
--     @vchComment       nvarchar(255) ='',
--     @vchLoginName     nvarchar(255) ='',
--     @vchPassword      nvarchar(255) =''
-- 
-- as
-- 	-- This procedure should no longer be called;  dt_addtosourcecontrol should be called instead.
-- 	-- Calls are forwarded to dt_addtosourcecontrol to maintain backward compatibility
-- 	set nocount on
-- 	exec dbo.dt_addtosourcecontrol 
-- 		@vchSourceSafeINI, 
-- 		@vchProjectName, 
-- 		@vchComment, 
-- 		@vchLoginName, 
-- 		@vchPassword
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_checkinobject_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_checkinobject_u
--     @chObjectType  char(4),
--     @vchObjectName nvarchar(255),
--     @vchComment    nvarchar(255)='',
--     @vchLoginName  nvarchar(255),
--     @vchPassword   nvarchar(255)='',
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0,   /* 0 => AddFile, 1 => CheckIn */
--     @txStream1     text = '',  /* drop stream   */ /* There is a bug that if items are NULL they do not pass to OLE servers */
--     @txStream2     text = '',  /* create stream */
--     @txStream3     text = ''   /* grant stream  */
-- 
-- as	
-- 	-- This procedure should no longer be called;  dt_checkinobject should be called instead.
-- 	-- Calls are forwarded to dt_checkinobject to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_checkinobject
-- 		@chObjectType,
-- 		@vchObjectName,
-- 		@vchComment,
-- 		@vchLoginName,
-- 		@vchPassword,
-- 		@iVCSFlags,
-- 		@iActionFlag,   
-- 		@txStream1,		
-- 		@txStream2,		
-- 		@txStream3		
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_checkoutobject_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_checkoutobject_u
--     @chObjectType  char(4),
--     @vchObjectName nvarchar(255),
--     @vchComment    nvarchar(255),
--     @vchLoginName  nvarchar(255),
--     @vchPassword   nvarchar(255),
--     @iVCSFlags     int = 0,
--     @iActionFlag   int = 0/* 0 => Checkout, 1 => GetLatest, 2 => UndoCheckOut */
-- 
-- as
-- 
-- 	-- This procedure should no longer be called;  dt_checkoutobject should be called instead.
-- 	-- Calls are forwarded to dt_checkoutobject to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_checkoutobject
-- 		@chObjectType,  
-- 		@vchObjectName, 
-- 		@vchComment,    
-- 		@vchLoginName,  
-- 		@vchPassword,  
-- 		@iVCSFlags,    
-- 		@iActionFlag 
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_isundersourcecontrol_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_isundersourcecontrol_u
--     @vchLoginName nvarchar(255) = '',
--     @vchPassword  nvarchar(255) = '',
--     @iWhoToo      int = 0 /* 0 => Just check project; 1 => get list of objs */
-- 
-- as
-- 	-- This procedure should no longer be called;  dt_isundersourcecontrol should be called instead.
-- 	-- Calls are forwarded to dt_isundersourcecontrol to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_isundersourcecontrol
-- 		@vchLoginName,
-- 		@vchPassword,
-- 		@iWhoToo 
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_validateloginparams_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_validateloginparams_u
--     @vchLoginName  nvarchar(255),
--     @vchPassword   nvarchar(255)
-- as
-- 
-- 	-- This procedure should no longer be called;  dt_validateloginparams should be called instead.
-- 	-- Calls are forwarded to dt_validateloginparams to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_validateloginparams
-- 		@vchLoginName,
-- 		@vchPassword 
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.dt_whocheckedout_u
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- create proc dbo.dt_whocheckedout_u
--         @chObjectType  char(4),
--         @vchObjectName nvarchar(255),
--         @vchLoginName  nvarchar(255),
--         @vchPassword   nvarchar(255)
-- 
-- as
-- 
-- 	-- This procedure should no longer be called;  dt_whocheckedout should be called instead.
-- 	-- Calls are forwarded to dt_whocheckedout to maintain backward compatibility.
-- 	set nocount on
-- 	exec dbo.dt_whocheckedout
-- 		@chObjectType, 
-- 		@vchObjectName,
-- 		@vchLoginName, 
-- 		@vchPassword  
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_upgraddiagrams
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_upgraddiagrams
-- 	AS
-- 	BEGIN
-- 		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
-- 			return 0;
-- 	
-- 		CREATE TABLE dbo.sysdiagrams
-- 		(
-- 			name sysname NOT NULL,
-- 			principal_id int NOT NULL,	-- we may change it to varbinary(85)
-- 			diagram_id int PRIMARY KEY IDENTITY,
-- 			version int,
-- 	
-- 			definition varbinary(max)
-- 			CONSTRAINT UK_principal_name UNIQUE
-- 			(
-- 				principal_id,
-- 				name
-- 			)
-- 		);
-- 
-- 
-- 		/* Add this if we need to have some form of extended properties for diagrams */
-- 		/*
-- 		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
-- 		BEGIN
-- 			CREATE TABLE dbo.sysdiagram_properties
-- 			(
-- 				diagram_id int,
-- 				name sysname,
-- 				value varbinary(max) NOT NULL
-- 			)
-- 		END
-- 		*/
-- 
-- 		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
-- 		begin
-- 			insert into dbo.sysdiagrams
-- 			(
-- 				[name],
-- 				[principal_id],
-- 				[version],
-- 				[definition]
-- 			)
-- 			select	 
-- 				convert(sysname, dgnm.[uvalue]),
-- 				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
-- 				0,							-- zero for old format, dgdef.[version],
-- 				dgdef.[lvalue]
-- 			from dbo.[dtproperties] dgnm
-- 				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
-- 				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
-- 				
-- 			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
-- 			return 2;
-- 		end
-- 		return 1;
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_helpdiagrams
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_helpdiagrams
-- 	(
-- 		@diagramname sysname = NULL,
-- 		@owner_id int = NULL
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		DECLARE @user sysname
-- 		DECLARE @dboLogin bit
-- 		EXECUTE AS CALLER;
-- 			SET @user = USER_NAME();
-- 			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
-- 		REVERT;
-- 		SELECT
-- 			[Database] = DB_NAME(),
-- 			[Name] = name,
-- 			[ID] = diagram_id,
-- 			[Owner] = USER_NAME(principal_id),
-- 			[OwnerID] = principal_id
-- 		FROM
-- 			sysdiagrams
-- 		WHERE
-- 			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
-- 			(@diagramname IS NULL OR name = @diagramname) AND
-- 			(@owner_id IS NULL OR principal_id = @owner_id)
-- 		ORDER BY
-- 			4, 5, 1
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_helpdiagramdefinition
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_helpdiagramdefinition
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null 		
-- 	)
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 
-- 		declare @theId 		int
-- 		declare @IsDbo 		int
-- 		declare @DiagId		int
-- 		declare @UIDFound	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert; 
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 
-- 		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
-- 		return 0
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_creatediagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_creatediagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id		int	= null, 	
-- 		@version 		int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId int
-- 		declare @retval int
-- 		declare @IsDbo	int
-- 		declare @userName sysname
-- 		if(@version is null or @diagramname is null)
-- 		begin
-- 			RAISERROR (N'E_INVALIDARG', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID(); 
-- 		select @IsDbo = IS_MEMBER(N'db_owner');
-- 		revert; 
-- 		
-- 		if @owner_id is null
-- 		begin
-- 			select @owner_id = @theId;
-- 		end
-- 		else
-- 		begin
-- 			if @theId <> @owner_id
-- 			begin
-- 				if @IsDbo = 0
-- 				begin
-- 					RAISERROR (N'E_INVALIDARG', 16, 1);
-- 					return -1
-- 				end
-- 				select @theId = @owner_id
-- 			end
-- 		end
-- 		-- next 2 line only for test, will be removed after define name unique
-- 		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end
-- 	
-- 		insert into dbo.sysdiagrams(name, principal_id , version, definition)
-- 				VALUES(@diagramname, @theId, @version, @definition) ;
-- 		
-- 		select @retval = @@IDENTITY 
-- 		return @retval
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_renamediagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_renamediagram
-- 	(
-- 		@diagramname 		sysname,
-- 		@owner_id		int	= null,
-- 		@new_diagramname	sysname
-- 	
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @DiagIdTarg		int
-- 		declare @u_name			sysname
-- 		if((@diagramname is null) or (@new_diagramname is null))
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT;
-- 	
-- 		select @u_name = USER_NAME(@owner_id)
-- 	
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
-- 		--	return 0;
-- 	
-- 		if(@u_name is null)
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
-- 		else
-- 			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
-- 	
-- 		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
-- 		begin
-- 			RAISERROR ('The name is already used.', 16, 1);
-- 			return -2
-- 		end		
-- 	
-- 		if(@u_name is null)
-- 			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
-- 		else
-- 			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
-- 		return 0
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_alterdiagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_alterdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null,
-- 		@version 	int,
-- 		@definition 	varbinary(max)
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 	
-- 		declare @theId 			int
-- 		declare @retval 		int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 		declare @ShouldChangeUID	int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid ARG', 16, 1)
-- 			return -1
-- 		end
-- 	
-- 		execute as caller;
-- 		select @theId = DATABASE_PRINCIPAL_ID();	 
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		revert;
-- 	
-- 		select @ShouldChangeUID = 0
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
-- 			return -3
-- 		end
-- 	
-- 		if(@IsDbo <> 0)
-- 		begin
-- 			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
-- 			begin
-- 				select @ShouldChangeUID = 1 ;
-- 			end
-- 		end
-- 
-- 		-- update dds data			
-- 		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;
-- 
-- 		-- change owner
-- 		if(@ShouldChangeUID = 1)
-- 			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;
-- 
-- 		-- update dds version
-- 		if(@version is not null)
-- 			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;
-- 
-- 		return 0
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp_dropdiagram
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE PROCEDURE dbo.sp_dropdiagram
-- 	(
-- 		@diagramname 	sysname,
-- 		@owner_id	int	= null
-- 	)
-- 	WITH EXECUTE AS 'dbo'
-- 	AS
-- 	BEGIN
-- 		set nocount on
-- 		declare @theId 			int
-- 		declare @IsDbo 			int
-- 		
-- 		declare @UIDFound 		int
-- 		declare @DiagId			int
-- 	
-- 		if(@diagramname is null)
-- 		begin
-- 			RAISERROR ('Invalid value', 16, 1);
-- 			return -1
-- 		end
-- 	
-- 		EXECUTE AS CALLER;
-- 		select @theId = DATABASE_PRINCIPAL_ID();
-- 		select @IsDbo = IS_MEMBER(N'db_owner'); 
-- 		if(@owner_id is null)
-- 			select @owner_id = @theId;
-- 		REVERT; 
-- 		
-- 		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
-- 		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
-- 		begin
-- 			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
-- 			return -3
-- 		end
-- 	
-- 		delete from dbo.sysdiagrams where diagram_id = @DiagId;
-- 	
-- 		return 0;
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp제경비내역_일자별_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp제경비내역_일자별_인쇄] 
--       (@ParBranchCode VarChar(2) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '', @ParCode VarChar(4) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.제경비일자 AS 제경비일자, 
--            T1.제경비시간 AS 제경비시간, T1.제경비코드 AS 제경비코드, 
--            ISNULL(T2.제경비명, '') AS 제경비명, ISNULL(T1.제경비금액, 0) AS 제경비금액, 
--            ISNULL(T1.적요, '') AS 적요, T1.작성자코드 AS 작성자코드, 
--            T3.사용자명 AS 작성자명, T1.사용구분 AS 사용구분, 
--            T1.수정일자 AS 수정일자, T1.사용자코드 AS 사용자코드, 
--            T4.사용자명 AS 사용자명 
--       FROM 제경비내역 T1 
--      INNER JOIN 제경비코드 T2 
--              ON T2.제경비코드 = T1.제경비코드 
--       LEFT JOIN 사용자 T3 
--              ON T3.사용자코드 = T1.작성자코드 
--       LEFT JOIN 사용자 T4 
--              ON T4.사용자코드 = T1.사용자코드
--      WHERE T1.사업장코드 = @ParBranchCode  
--        AND T1.제경비코드 LIKE '%' + LTRIM(@ParCode) + '%'
--        AND T1.제경비일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.사용구분 = 0 
--      ORDER BY T1.사업장코드, T1.제경비일자, T1.제경비시간
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.spBackUpYmhDB
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[spBackUpYmhDB] 
--       (@ParToBackUpDeviceName VarChar(50) = '', @ParToBackUpPath VarChar(50) = '', @ParToBackUpFile VarChar(50) = '', @ParToBackUpName VarChar(50) = '', 
--        @ParR_Status Int = 0 OUTPUt, @ParR_MSG VarChar(100) = '' OUTPUT)
-- AS
-- SET @ParToBackUpName = (@ParToBackupPath+ '/' + @ParToBackUpDeviceName + @ParToBackUpFIle)
-- BEGIN
--   BACKUP DATABASE YmhDB TO DISK = @ParToBackUpName
--   WITH FORMAT, NAME = '판매관리시스템'
--   IF (@@ERROR <> 0)       
--      BEGIN       
--        GOTO Err_Rtn      
--      END      
-- END
-- /*-------*/            
--   pEXIT:      
-- /*-------*/      
-- -- CLOSE CURSOR      
-- -- DEALLOCATE CURSOR
-- SET @ParR_Status = '1'             
-- SET @ParR_MSG = '(' + @ParToBackUpName + ')'  + ' BACKUP DATABASE이(가) 정상적으로 종료되었습니다.'
-- SELECT @ParR_Status, @ParR_MSG
-- -- Commit Transaction       
-- RETURN             
-- /*-------*/            
--   Err_Rtn:      
-- /*-------*/      
-- -- CLOSE CURSOR      
-- -- DEALLOCATE CURSOR
-- SET @ParR_Status = '0'      
-- SET @ParR_MSG = '(' + @ParToBackUpName + ')'  + ' BACKUP DATABASE이(가) 비정상적으로 종료되었습니다.'
-- SELECT @ParR_Status, @ParR_MSG
-- --RollBack Transaction            
-- RETURN
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.spLogCounter
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[spLogCounter] 
--       (@varTableName VarChar(50) = '', @varBaseCode VarChar(50) = '', 
--        @mnyLastLog Money = 0, @mnyLastLog1 Money = 0, @varServerDate VarChar(8) = '', @varUserCode VarChar(4) = '')
-- 
-- AS
-- SELECT @varServerDate = Convert(VarChar(8),GETDATE(),112)
-- BEGIN 
--     IF NOT EXISTS(SELECT 최종로그 FROM [dbo].[로그]
--                    WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode )
--        BEGIN
--            IF @VarTableName = '세금계산서'
--               BEGIN
--                 INSERT [dbo].[로그] VALUES(@varTableName, @varBaseCode, 1, 1, @varServerDate, @varUserCode)
--                 SET @mnyLastLog = 1
--                 SET @mnyLastLog1 = 1
--               END
--            ELSE
--               BEGIN 
--                 INSERT [dbo].[로그] VALUES(@varTableName, @varBaseCode, 1, 0, @varServerDate, @varUserCode)
--                 SET @mnyLastLog = 1
--                 SET @mnyLastLog1 = 0
--               END           
--        END
--     ELSE
--        BEGIN
--            IF @VarTableName = '세금계산서'
--               BEGIN 
--                 SELECT @mnyLastLog = ISNULL(최종로그, 0), @mnyLastLog1 = ISNULL(최종로그1, 0)
--                   FROM [dbo].[로그]
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--                  IF @mnyLastLog1 = 50 
--                     BEGIN
--                        SET @mnyLastLog = @mnyLastLog + 1  
--                        SET @mnyLastLog1 = 1  
--                     END
--                  ELSE
--                     BEGIN
--                        SET @mnyLastLog1 = @mnyLastLog1 + 1  
--                     END
--                 UPDATE 로그 SET 최종로그 = @mnyLastLog, 최종로그1 = @mnyLastLog1
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--                 SELECT @mnyLastLog = ISNULL(최종로그, 0), @mnyLastLog1 = ISNULL(최종로그1, 0)
--                   FROM [dbo].[로그]
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--               END
--            ELSE
--               BEGIN
--                 UPDATE 로그 SET 최종로그 = 최종로그 + 1
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--                 SELECT @mnyLastLog = ISNULL(최종로그, 0), @mnyLastLog1 = ISNULL(최종로그1, 0)
--                   FROM [dbo].[로그]
--                  WHERE 테이블명 = @varTableName AND 베이스코드 = @varBaseCode
--               END
--        END 
--     SELECT @mnyLastLog, @mnyLastLog1
-- END
-- 
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp거래명세서A4백지_인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp거래명세서A4백지_인쇄] 
--       (@ParStrBranchCode VarChar(02) = '01', @ParStrDealDate VarChar(08) = '', @ParLngLogCnt Real = 0)
-- 
-- AS
-- 
--   SELECT T1.사업장코드 AS 사업장코드, T1.거래일자 AS 거래일자, T1.거래번호 AS 거래번호, 
--          T1.매출처코드 AS 매출처코드,
--          ISNULL(T4.사업자번호, '') AS 좌등록번호, ISNULL(T4.사업장명, '') AS 좌상호,
--          ISNULL(T4.대표자명, '') AS 좌성명, (ISNULL(T4.주소, '') + SPACE(1) + ISNULL(T4.번지, '')) AS 좌주소, 
--          ISNULL(T4.업태, '') AS 좌업태, ISNULL(T4.업종, '') AS 좌종목,
--          ISNULL(T3.사업자번호, '') AS 우등록번호, ISNULL(T3.매출처명, '') AS 우상호, 
--          ISNULL(T3.대표자명, '') AS 우성명, (ISNULL(T3.주소, '') + SPACE(1) + ISNULL(T3.번지, '')) AS 우주소, 
--          ISNULL(T3.업태, '') AS 우업태, ISNULL(T3.업종, '') AS 우종목, 
--         (SELECT SUM(출고수량 * 출고단가) FROM 자재입출내역 
--           WHERE 사업장코드 = @ParStrBranchCode
--             AND 입출고구분 = 2 AND 사용구분 = 0
--             AND 거래일자 = @ParStrDealDate
--             AND 거래번호 = @ParLngLogCnt) AS 총금액,
--         (SELECT COUNT(세부코드) FROM 자재입출내역 
--           WHERE 사업장코드 = @ParStrBranchCode
--             AND 입출고구분 = 2 AND 사용구분 = 0
--             AND 거래일자 = @ParStrDealDate
--             AND 거래번호 = @ParLngLogCnt) AS 건수,
--         (T1.분류코드 + T1.세부코드) AS 코드, T2.자재명 AS 품명, T2.규격 AS 규격, 
--          T1.출고수량 AS 수량, T2.단위 AS 단위, T1.출고단가 AS 단가, T1.출고부가 AS 부가, (T1.출고단가 * T1.출고수량) AS 출고금액
--     FROM 자재입출내역 T1 
--     LEFT JOIN 자재 T2 ON T2.분류코드 = T1.분류코드 AND T2.세부코드 = T1.세부코드
--     LEFT JOIN 매출처 T3 ON T3.매출처코드 = T1.매출처코드
--     LEFT JOIN 사업장 T4 ON T3.사업장코드 = T1.사업장코드
--    WHERE T1.사업장코드 = @ParStrBranchCode
--      AND T1.입출고구분 = 2 AND T1.사용구분 = 0 
--      AND T1.거래일자 = @ParStrDealDate
--      AND T1.거래번호 = @ParLngLogCnt
--    ORDER BY T1.사업장코드, T1.거래일자, T1.거래번호, T1.입출고시간
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp견적서인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp견적서인쇄] 
--       (@ParBranchCode VarChar(2) = '01', @ParOrderDate VarChar(8) = '', @ParOrderNo Real = 0, @ParOrderGbn Tinyint = 0)
-- 
-- AS
--   IF @ParOrderGbn = 0 
--      BEGIN 
--        SELECT T1.사업장코드, T1.견적일자, T1.견적번호, T1.출고희망일자,
--               T1.매출처코드, T3.매출처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.수량 AS 수량, T4.단위 AS 단위,
--               T2.계산서발행여부, 0 AS 출고단가, 0 AS 출고부가, (0 * T2.수량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수,
--               DATEDIFF(day, CONVERT(DATETIME, T1.견적일자), CONVERT(DATETIME, T1.출고희망일자)) AS 견적후납기일수
--         FROM 견적 T1
--        INNER JOIN 견적내역 T2
--                ON T2.사업장코드 = T1.사업장코드 AND T2.견적일자 = T1.견적일자 AND T2.견적번호 = T1.견적번호  
--         LEFT JOIN 매출처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매출처코드 = T2.매출처코드
--         LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--        WHERE T1.사업장코드 = @ParBranchCode
--          AND T1.견적일자 = @ParOrderDate
--          AND T1.견적번호 = @ParOrderNo
--          AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--          AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--        ORDER BY T1.사업장코드, T1.견적일자, T1.견적번호, T2.견적시간
--      END
--   ELSE
--      BEGIN 
--        SELECT T1.사업장코드, T1.견적일자, T1.견적번호, T1.출고희망일자,
--               T1.매출처코드, T3.매출처명, T3.담당자명 AS 참조, T1.제목 AS 제목, T1.적요 AS 참조란,
--               T2.자재코드, ISNULL(T4.자재명,'') AS 품명,                      
--               T4.규격 AS 규격, T2.수량 AS 수량,  T4.단위 AS 단위,
--               T2.계산서발행여부, T2.출고단가 AS 출고단가, T2.출고부가 AS 출고부가, (T2.출고단가 * T2.수량) AS 금액,
--               T2.적요 AS 적요, T1.유효일수 AS 유효일수, 
--               DATEDIFF(day, CONVERT(DATETIME, T1.견적일자), CONVERT(DATETIME, T1.출고희망일자)) AS 견적후납기일수
--          FROM 견적 T1
--         INNER JOIN 견적내역 T2
--                 ON T2.사업장코드 = T1.사업장코드 AND T2.견적일자 = T1.견적일자 AND T2.견적번호 = T1.견적번호  
--          LEFT JOIN 매출처 T3 ON T3.사업장코드 = T2.사업장코드 AND T3.매출처코드 = T2.매출처코드
--          LEFT JOIN 자재 T4 ON (T4.분류코드 + T4.세부코드) = T2.자재코드
--         WHERE T1.사업장코드 = @ParBranchCode
--           AND T1.견적일자 = @ParOrderDate
--           AND T1.견적번호 = @ParOrderNo
--           AND (T1.상태코드 = 1 OR T1.상태코드 = 2) AND T1.사용구분 = 0 
--           AND (T2.상태코드 = 1 OR T2.상태코드 = 2) AND T2.사용구분 = 0
--         ORDER BY T1.사업장코드, T1.견적일자, T1.견적번호, T2.견적시간
--      END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp계정코드관리보고서인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp계정코드관리보고서인쇄] 
--       (@ParBranchcode VarChar(2) = '01', @ParUsageCode int = 0, @ParSortGbn int = 0)
-- 
-- AS
-- 
-- IF @ParSortGbn = 0 
--    BEGIN
--      SELECT T1.계정코드 AS 계정코드, T1.계정명 AS 계정명,
--             T1.합계시산표연결여부 AS 합계시산표연결여부, T1.적요 AS 적요,             
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END
--        FROM 계정과목 T1 
--       ORDER BY T1.계정코드
--    END
-- ELSE
--    BEGIN
--      SELECT T1.계정코드 AS 계정코드, T1.계정명 AS 계정명,
--             T1.합계시산표연결여부 AS 합계시산표연결여부, T1.적요 AS 적요,             
--             사용구분 = CASE WHEN T1.사용구분 = 0 THEN '정    상'
--                             WHEN T1.사용구분 = 9 THEN '사용불가'
--                        ELSE '오    류' END
--        FROM 계정과목 T1 
--       ORDER BY T1.계정명
--    END
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매입매출처원장인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- CREATE PROCEDURE [dbo].[sp매입매출처원장인쇄] 
--       (@ParAppBranchCode VarChar(2) = '01', @ParAppPgDate VarChar(8) = '', 
--        @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(14) = '', @ParWayGbn int = 2) 
-- 
-- AS
-- 
-- IF @ParWayGbn = 1
--    BEGIN
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,         
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')
--             UNION ALL
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액, (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM 
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,
--                  '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--             UNION ALL 
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--                   T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액,
--                   (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND T3.매입처코드 IS NOT NULL
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            1 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.사용구분 = 0 AND T1.미지급구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            2 AS 구분, 0 AS 입고금액, (SUM(T1.공급가액 + T1.세액)) AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.사용구분 = 0 AND T1.미수구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매입처명,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            3 AS 구분, 0 AS 입고금액, ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매출처코드 AS 매입처코드, ISNULL(T3.매입처명, '') AS 매입처명, 
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            4 AS 구분, ISNULL(SUM(T1.미수금입금금액),0) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T1.매출처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T3.매입처코드 IS NOT NULL
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매출처코드, T3.매입처명,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY 사업장코드, 매입처코드, 매입처명, 일자, 시간, 구분
--    END
-- ELSE
--    BEGIN
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                   ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,         
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')
--             UNION ALL
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                  ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(년 이 월)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액, (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--               AND SUBSTRING(T1.마감년월,5,2) = '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)     
--               AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.일자, U1.적요, 
--            U1.구분, SUM(U1.입고금액) AS 입고금액, SUM(U1.지급금액) AS 지급금액, 
--            U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--       FROM 
--           (SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                   ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미지급금누계금액) AS 입고금액, (T1.미지급금지급누계금액) AS 지급금액,
--                  '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미지급금원장마감 T1
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--             UNION ALL 
--            SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--                   ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--                   (T1.마감년월 + '00') AS 일자, '(월    계)' AS 적요, 
--                   0 AS 구분, (T1.미수금입금누계금액) AS 입고금액,
--                   (T1.미수금누계금액) AS 지급금액,
--                   '' AS 결제방법, '' AS 만기일자, '' AS 어음번호, '' AS 비고, '' AS 시간
--              FROM 미수금원장마감 T1 
--              LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--              LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--             WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--               AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--               AND SUBSTRING(T1.마감년월,5,2) <> '00' AND (T1.미수금누계금액 <> 0 OR T1.미수금입금누계금액 <> 0)
--               AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)) AS U1
--      GROUP BY U1.사업장코드, U1.사업장명, U1.매입처코드, U1.매입처명, U1.구분, U1.일자, U1.적요,
--               U1.구분, U1.결제방법, U1.만기일자, U1.어음번호, U1.비고, U1.시간
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            1 AS 구분, (SUM(T1.공급가액 + T1.세액)) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.사용구분 = 0 AND T1.미지급구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.작성일자) AS 일자, '' AS 적요, 
--            2 AS 구분, 0 AS 입고금액, (SUM(T1.공급가액 + T1.세액)) AS 지급금액,
--            결제방법 = CASE WHEN T1.금액구분 = 0 THEN '현금' WHEN T1.금액구분 = 1 THEN '수표' 
--                            WHEN T1.금액구분 = 2 THEN '어음' ELSE '외상' END,  '' AS 만기일자, '' AS 어음번호 , 
--            T1.적요 AS 비고, T1.작성시간 AS 시간
--       FROM 매출세금계산서장부 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--        AND T1.사용구분 = 0 AND T1.미수구분 = 1
--        AND T1.작성일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.작성일자, T1.작성시간, T1.금액구분, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.미지급금지급일자) AS 일자, '' AS 적요, 
--            3 AS 구분, 0 AS 입고금액, ISNULL(SUM(T1.미지급금지급금액),0) AS 지급금액 ,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미지급금지급시간 AS 시간
--       FROM 미지급금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.미지급금지급일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.미지급금지급일자, T1.미지급금지급시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명, T3.사업자번호 AS 매입처코드,
--            ISNULL((SELECT TOP 1 S1.매입처명 FROM 매입처 S1 
--                           WHERE S1.사업장코드 = T1.사업장코드 AND S1.사업자번호 = T3.사업자번호), '') AS 매입처명,
--            (T1.미수금입금일자) AS 일자, '' AS 적요, 
--            4 AS 구분, ISNULL(SUM(T1.미수금입금금액),0) AS 입고금액, 0 AS 지급금액,
--            결제방법 = CASE WHEN T1.결제방법 = 0 THEN '현금' WHEN T1.결제방법 = 1 THEN '수표'
--                            WHEN T1.결제방법 = 2 THEN '어음' ELSE '기타' END, T1.만기일자, T1.어음번호,
--            T1.적요 AS 비고, T1.미수금입금시간 AS 시간
--       FROM 미수금내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매출처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매출처코드 = T1.매출처코드
--      WHERE T1.사업장코드 = @ParAppBranchCode AND T3.사업자번호 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND (EXISTS (SELECT 매입처코드 FROM 매입처 WHERE 사업장코드 = T1.사업장코드 AND 사업자번호 = T3.사업자번호)) 
--        AND T1.미수금입금일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--      GROUP BY T1.사업장코드, T2.사업장명, T3.사업자번호,
--               T1.미수금입금일자, T1.미수금입금시간, T1.결제방법, T1.만기일자, T1.어음번호, T1.적요
--      ORDER BY 사업장코드, 매입처코드, 매입처명, 일자, 시간, 구분
--    END
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매입세금계산서장부현황인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매입세금계산서장부현황인쇄] 
--       (@ParBranchCode VarChar(02) ='01', @ParFDate VarChar(8) = '', @ParTDate VarChar(8) = '',    
--        @ParSupplierCode Varchar(8) = '')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T1.작성일자 AS 작성일자, T1.작성시간,
--            T1.매입처코드 AS 매입처코드, T2.매입처명 AS 매입처명, 
--            T1.공급가액 AS 공급가액, T1.세액 AS 세액, 
--            T1.품목및규격 AS 품목및규격, T1.수량 AS 수량, 
--            T1.금액구분 AS 금액구분, T1.영청구분 AS 영청구분, T1.발행여부 AS 발행여부,
--            T1.작성구분 AS 작성구분, T1.미지급구분 AS 미지급구분, T1.사용구분 AS 사용구분 
--       FROM 매입세금계산서장부 T1 
--       LEFT JOIN 매입처 T2 ON T2.사업장코드 = T1.사업장코드 AND T2.매입처코드 = T1.매입처코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.작성일자 BETWEEN @ParFDate AND @ParTDate
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--      ORDER BY T1.사업장코드, T1.작성일자, T1.작성시간
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.sp매입처보조부인쇄
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 
-- CREATE PROCEDURE [dbo].[sp매입처보조부인쇄] 
--       (@ParAppPgDate VarChar(8) = '', @ParAppFDate VarChar(8) = '', @ParAppTDate VarChar(8) = '', 
--        @ParSupplierCode VarChar(8) = '', @ParBranchCode Varchar(2) = '01')
-- 
-- AS
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(년 이월)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 입고수량, 0 AS 입고단가,
--            0 AS 입고부가, (T1.미지급금누계금액 - T1.미지급금지급누계금액) AS 입고금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) = '00' 
--        AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <>0)
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 BETWEEN (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND (SUBSTRING(@ParAppTDate, 1, 4) + '00')                              
--      UNION ALL
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.마감년월 + '00') AS 일자, '(월   계)' AS 적요, 
--            '' AS 분류코드, '' AS 분류명, 
--            '' AS 세부코드, '' AS 자재명, 
--            '' AS 규격, '' AS 단위, 0 AS 구분,
--            0 AS 입고수량, 0 AS 입고단가,
--            0 AS 입고부가, (T1.미지급금누계금액 - T1.미지급금지급누계금액) AS 입고금액
--       FROM 미지급금원장마감 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--      WHERE T1.사업장코드 = @ParBranchCode AND SUBSTRING(T1.마감년월,5,2) <> '00' 
--        AND (T1.미지급금누계금액 <> 0 OR T1.미지급금지급누계금액 <> 0)
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.마감년월 > (SUBSTRING(@ParAppFDate, 1, 4) + '00') AND T1.마감년월 < SUBSTRING(@ParAppFDate, 1, 6)
--      UNION ALL 
--     SELECT T1.사업장코드 AS 사업장코드, T2.사업장명 AS 사업장명,
--            T1.매입처코드 AS 매입처코드, T3.매입처명 AS 매입처명, 
--            (T1.입출고일자) AS 일자, (T1.원래입출고일자) AS 적요, 
--            T1.분류코드 AS 분류코드, T4.분류명 AS 분류명, 
--            T1.세부코드 AS 세부코드, ISNULL(T7.자재명, '') AS 자재명, 
--            ISNULL(T7.규격,'') AS 규격, ISNULL(T7.단위,'') AS 단위, T1.입출고구분 AS 구분,
--            SUM(T1.입고수량) AS 입고수량, T1.입고단가 AS 입고단가, 
--            T1.입고부가 AS 입고부가, 
--            (SUM(T1.입고수량*T1.입고단가)) AS 입고금액
--       FROM 자재입출내역 T1 
--       LEFT JOIN 사업장 T2 ON T2.사업장코드 = T1.사업장코드 
--       LEFT JOIN 매입처 T3 ON T3.사업장코드 = T1.사업장코드 AND T3.매입처코드 = T1.매입처코드
--       LEFT JOIN 자재분류 T4 ON T4.분류코드 = T1.분류코드 
--       LEFT JOIN 자재 T7 ON T7.분류코드 = T1.분류코드 AND T7.세부코드 = T1.세부코드 
--      WHERE T1.사업장코드 = @ParBranchCode AND T1.사용구분 = 0
--        AND T1.매입처코드 LIKE '%' + LTRIM(@ParSupplierCode) + '%'
--        AND T1.입출고일자 BETWEEN (SUBSTRING(@ParAppFDate, 1, 6) + '01') AND @ParAppTDate
--        AND T1.입출고구분 = 1
--      GROUP BY T1.사업장코드, T2.사업장명, T1.매입처코드, T3.매입처명,
--               T1.입출고일자, T1.원래입출고일자,
--               T1.분류코드, T4.분류명, T1.세부코드, T7.자재명, 
--               T7.규격, T7.단위, T1.입출고구분, T1.입고단가, T1.입고부가
--      ORDER BY T1.사업장코드, T3.매입처명, 일자, 자재명, 구분  
-- 
-- $$
-- 
-- DELIMITER ;
-- 
-- ----------------------------------------------------------------------------
-- Routine YmhDB.fn_diagramobjects
-- ----------------------------------------------------------------------------
-- DELIMITER $$
-- 
-- DELIMITER $$
-- USE `YmhDB`$$
-- 
-- 	CREATE FUNCTION dbo.fn_diagramobjects() 
-- 	RETURNS int
-- 	WITH EXECUTE AS N'dbo'
-- 	AS
-- 	BEGIN
-- 		declare @id_upgraddiagrams		int
-- 		declare @id_sysdiagrams			int
-- 		declare @id_helpdiagrams		int
-- 		declare @id_helpdiagramdefinition	int
-- 		declare @id_creatediagram	int
-- 		declare @id_renamediagram	int
-- 		declare @id_alterdiagram 	int 
-- 		declare @id_dropdiagram		int
-- 		declare @InstalledObjects	int
-- 
-- 		select @InstalledObjects = 0
-- 
-- 		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
-- 			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
-- 			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
-- 			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
-- 			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
-- 			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
-- 			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
-- 			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')
-- 
-- 		if @id_upgraddiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 1
-- 		if @id_sysdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 2
-- 		if @id_helpdiagrams is not null
-- 			select @InstalledObjects = @InstalledObjects + 4
-- 		if @id_helpdiagramdefinition is not null
-- 			select @InstalledObjects = @InstalledObjects + 8
-- 		if @id_creatediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 16
-- 		if @id_renamediagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 32
-- 		if @id_alterdiagram  is not null
-- 			select @InstalledObjects = @InstalledObjects + 64
-- 		if @id_dropdiagram is not null
-- 			select @InstalledObjects = @InstalledObjects + 128
-- 		
-- 		return @InstalledObjects 
-- 	END
-- 	$$
-- 
-- DELIMITER ;
-- SET FOREIGN_KEY_CHECKS = 1;
