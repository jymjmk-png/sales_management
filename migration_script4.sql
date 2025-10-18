-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: YmhDB
-- Source Schemata: YmhDB
-- Created: Sat Oct 18 12:22:23 2025
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
SET FOREIGN_KEY_CHECKS = 1;
