REM Workbench Table Data copy script
REM Workbench Version: 8.0.43
REM 
REM Execute this to copy table data from a source RDBMS to MySQL.
REM Edit the options below to customize it. You will need to provide passwords, at least.
REM 
REM Source DB: Mssql@MSSQL_YMHDB (Microsoft SQL Server)
REM Target DB: Mysql@127.0.0.1:3306


@ECHO OFF
REM Source and target DB passwords
set arg_source_password=
set arg_target_password=
set arg_source_ssh_password=
set arg_target_ssh_password=


REM Set the location for wbcopytables.exe in this variable
set "wbcopytables_path=C:\Program Files\MySQL\MySQL Workbench 8.0"

if not [%wbcopytables_path%] == [] set wbcopytables_path=%wbcopytables_path%
set wbcopytables=%wbcopytables_path%\wbcopytables.exe

if not exist "%wbcopytables%" (
	echo "wbcopytables.exe doesn't exist in the supplied path. Please set 'wbcopytables_path' with the proper path(e.g. to Workbench binaries)"
	exit 1
)

IF [%arg_source_password%] == [] (
    IF [%arg_target_password%] == [] (
        IF [%arg_source_ssh_password%] == [] (
            IF [%arg_target_ssh_password%] == [] (
                ECHO WARNING: All source and target passwords are empty. You should edit this file to set them.
            )
        )
    )
)
set arg_worker_count=2
REM Uncomment the following options according to your needs

REM Whether target tables should be truncated before copy
set arg_truncate_target=--truncate-target
REM Enable debugging output
set arg_debug_output=--log-level=debug3


REM Creation of file with table definitions for copytable

set table_file=%TMP%\wb_tables_to_migrate.txt
TYPE NUL > %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[계정과목]	`YmhDB`	`계정과목`	-	-	CAST([계정코드] as NVARCHAR(4)) as [계정코드], CAST([계정명] as NVARCHAR(30)) as [계정명], CAST([합계시산표연결여부] as NVARCHAR(1)) as [합계시산표연결여부], CAST([적요] as NVARCHAR(60)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[우편번호]	`YmhDB`	`우편번호`	-	-	[우편번호], [주소1], [주소2], [읍면동], [번지], [지역번호] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[매출처]	`YmhDB`	`매출처`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([매출처명] as NVARCHAR(30)) as [매출처명], CAST([사업자번호] as NVARCHAR(14)) as [사업자번호], CAST([법인번호] as NVARCHAR(14)) as [법인번호], CAST([대표자명] as NVARCHAR(30)) as [대표자명], CAST([대표자주민번호] as NVARCHAR(14)) as [대표자주민번호], CAST([개업일자] as NVARCHAR(8)) as [개업일자], CAST([우편번호] as NVARCHAR(7)) as [우편번호], CAST([주소] as NVARCHAR(60)) as [주소], CAST([번지] as NVARCHAR(60)) as [번지], CAST([업태] as NVARCHAR(30)) as [업태], CAST([업종] as NVARCHAR(30)) as [업종], CAST([전화번호] as NVARCHAR(20)) as [전화번호], CAST([팩스번호] as NVARCHAR(14)) as [팩스번호], CAST([은행코드] as NVARCHAR(2)) as [은행코드], CAST([계좌번호] as NVARCHAR(20)) as [계좌번호], [계산서발행여부], [계산서발행율], CAST([담당자명] as NVARCHAR(30)) as [담당자명], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([비고란] as NVARCHAR(100)) as [비고란], [단가구분] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[은행]	`YmhDB`	`은행`	-	-	CAST([은행코드] as NVARCHAR(2)) as [은행코드], CAST([은행명] as NVARCHAR(30)) as [은행명], CAST([적요] as NVARCHAR(60)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재]	`YmhDB`	`자재`	-	-	CAST([분류코드] as NVARCHAR(2)) as [분류코드], CAST([세부코드] as NVARCHAR(16)) as [세부코드], CAST([자재명] as NVARCHAR(30)) as [자재명], CAST([바코드] as NVARCHAR(13)) as [바코드], CAST([규격] as NVARCHAR(30)) as [규격], CAST([단위] as NVARCHAR(20)) as [단위], [폐기율], [과세구분], CAST([적요] as NVARCHAR(60)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재분류]	`YmhDB`	`자재분류`	-	-	CAST([분류코드] as NVARCHAR(2)) as [분류코드], CAST([분류명] as NVARCHAR(30)) as [분류명], CAST([적요] as NVARCHAR(60)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재원장마감]	`YmhDB`	`자재원장마감`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([분류코드] as NVARCHAR(2)) as [분류코드], CAST([세부코드] as NVARCHAR(16)) as [세부코드], CAST([마감년월] as NVARCHAR(6)) as [마감년월], [입고누계수량], [출고누계수량], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재시세]	`YmhDB`	`자재시세`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([분류코드] as NVARCHAR(2)) as [분류코드], CAST([세부코드] as NVARCHAR(16)) as [세부코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([적용일자] as NVARCHAR(8)) as [적용일자], [입고단가], [입고부가], [출고단가], [출고부가], [마진율], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[클라이언트정보]	`YmhDB`	`클라이언트정보`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([클라이언트이름] as NVARCHAR(20)) as [클라이언트이름], [핸디스캐너유무] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재코드변경]	`YmhDB`	`자재코드변경`	-	-	CAST([변경전분류코드] as NVARCHAR(2)) as [변경전분류코드], CAST([변경전세부코드] as NVARCHAR(16)) as [변경전세부코드], CAST([변경일시] as NVARCHAR(17)) as [변경일시], CAST([변경후분류코드] as NVARCHAR(2)) as [변경후분류코드], CAST([변경후세부코드] as NVARCHAR(16)) as [변경후세부코드], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[dtproperties]	`YmhDB`	`dtproperties`	-	-	[id], [objectid], CAST([property] as NVARCHAR(64)) as [property], CAST([value] as NVARCHAR(255)) as [value], [uvalue], [lvalue], [version] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[미수금내역]	`YmhDB`	`미수금내역`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([미수금입금일자] as NVARCHAR(8)) as [미수금입금일자], CAST([미수금입금시간] as NVARCHAR(9)) as [미수금입금시간], [미수금입금금액], [결제방법], CAST([만기일자] as NVARCHAR(8)) as [만기일자], CAST([어음번호] as NVARCHAR(20)) as [어음번호], CAST([적요] as NVARCHAR(50)) as [적요], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재입출내역]	`YmhDB`	`자재입출내역`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([분류코드] as NVARCHAR(2)) as [분류코드], CAST([세부코드] as NVARCHAR(16)) as [세부코드], [입출고구분], CAST([입출고일자] as NVARCHAR(8)) as [입출고일자], CAST([입출고시간] as NVARCHAR(9)) as [입출고시간], [입고수량], [입고단가], [입고부가], [출고수량], [출고단가], [출고부가], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([원래입출고일자] as NVARCHAR(8)) as [원래입출고일자], [직송구분], CAST([발견일자] as NVARCHAR(8)) as [발견일자], [발견번호], CAST([거래일자] as NVARCHAR(8)) as [거래일자], [거래번호], [계산서발행여부], [현금구분], [감가구분], CAST([적요] as NVARCHAR(50)) as [적요], CAST([작성년도] as NVARCHAR(4)) as [작성년도], [책번호], [일련번호], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([재고이동사업장코드] as NVARCHAR(2)) as [재고이동사업장코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[매출세금계산서장부]	`YmhDB`	`매출세금계산서장부`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([작성일자] as NVARCHAR(8)) as [작성일자], CAST([작성시간] as NVARCHAR(9)) as [작성시간], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([품목및규격] as NVARCHAR(50)) as [품목및규격], [수량], [공급가액], [세액], [금액구분], [영청구분], [발행여부], [작성구분], [미수구분], CAST([적요] as NVARCHAR(50)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([작성년도] as NVARCHAR(4)) as [작성년도], [책번호], [일련번호] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[매입세금계산서장부]	`YmhDB`	`매입세금계산서장부`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([작성일자] as NVARCHAR(8)) as [작성일자], CAST([작성시간] as NVARCHAR(9)) as [작성시간], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([품목및규격] as NVARCHAR(50)) as [품목및규격], [수량], [공급가액], [세액], [금액구분], [영청구분], [발행여부], [작성구분], [미지급구분], CAST([적요] as NVARCHAR(50)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([작성년도] as NVARCHAR(4)) as [작성년도], [책번호], [일련번호] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[미수금원장]	`YmhDB`	`미수금원장`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([최종미수금일자] as NVARCHAR(8)) as [최종미수금일자], CAST([최종입금일자] as NVARCHAR(8)) as [최종입금일자], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[미수금원장마감]	`YmhDB`	`미수금원장마감`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([마감년월] as NVARCHAR(6)) as [마감년월], [미수금누계금액], [미수금입금누계금액], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[프린터환경설정]	`YmhDB`	`프린터환경설정`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], [거래명세서공급자란인쇄유무], [거래명세서상단마진], [거래명세서왼쪽마진], [세금계산서공급자란인쇄유무], [세금계산서상단마진], [세금계산서왼쪽마진] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[사용자]	`YmhDB`	`사용자`	-	-	CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([사용자명] as NVARCHAR(30)) as [사용자명], CAST([사용자권한] as NVARCHAR(200)) as [사용자권한], CAST([로그인여부] as NVARCHAR(1)) as [로그인여부], CAST([로그인비밀번호] as NVARCHAR(4)) as [로그인비밀번호], CAST([결재비밀번호] as NVARCHAR(4)) as [결재비밀번호], CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([시작일시] as NVARCHAR(17)) as [시작일시], CAST([종료일시] as NVARCHAR(17)) as [종료일시] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[사업장]	`YmhDB`	`사업장`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([사업장명] as NVARCHAR(30)) as [사업장명], CAST([사업자번호] as NVARCHAR(14)) as [사업자번호], CAST([법인번호] as NVARCHAR(14)) as [법인번호], CAST([대표자명] as NVARCHAR(30)) as [대표자명], CAST([대표자주민번호] as NVARCHAR(14)) as [대표자주민번호], CAST([개업일자] as NVARCHAR(8)) as [개업일자], CAST([우편번호] as NVARCHAR(7)) as [우편번호], CAST([주소] as NVARCHAR(60)) as [주소], CAST([번지] as NVARCHAR(60)) as [번지], CAST([업태] as NVARCHAR(30)) as [업태], CAST([업종] as NVARCHAR(30)) as [업종], CAST([전화번호] as NVARCHAR(20)) as [전화번호], CAST([팩스번호] as NVARCHAR(14)) as [팩스번호], [부가세율], [미지급금발생구분], [미수금발생구분], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([이메일주소] as NVARCHAR(50)) as [이메일주소], CAST([홈페이지주소] as NVARCHAR(50)) as [홈페이지주소], CAST([백업폴더] as NVARCHAR(50)) as [백업폴더], CAST([자재기초마감년월] as NVARCHAR(6)) as [자재기초마감년월], CAST([미지급금기초마감년월] as NVARCHAR(6)) as [미지급금기초마감년월], CAST([미수금기초마감년월] as NVARCHAR(6)) as [미수금기초마감년월], CAST([회계기초마감년월] as NVARCHAR(6)) as [회계기초마감년월], [출력타입구분], [거래명세서상단마진], [거래명세서왼쪽마진], [세금계산서상단마진], [세금계산서왼쪽마진], [최종입고단가자동갱신구분], [최종출고단가자동갱신구분] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[미지급금내역]	`YmhDB`	`미지급금내역`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([미지급금지급일자] as NVARCHAR(8)) as [미지급금지급일자], CAST([미지급금지급시간] as NVARCHAR(9)) as [미지급금지급시간], [미지급금지급금액], [결제방법], CAST([만기일자] as NVARCHAR(8)) as [만기일자], CAST([어음번호] as NVARCHAR(20)) as [어음번호], CAST([적요] as NVARCHAR(50)) as [적요], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[제조처]	`YmhDB`	`제조처`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([제조처코드] as NVARCHAR(8)) as [제조처코드], CAST([제조처명] as NVARCHAR(30)) as [제조처명], CAST([사업자번호] as NVARCHAR(14)) as [사업자번호], CAST([법인번호] as NVARCHAR(14)) as [법인번호], CAST([대표자명] as NVARCHAR(30)) as [대표자명], CAST([대표자주민번호] as NVARCHAR(14)) as [대표자주민번호], CAST([개업일자] as NVARCHAR(8)) as [개업일자], CAST([우편번호] as NVARCHAR(7)) as [우편번호], CAST([주소] as NVARCHAR(60)) as [주소], CAST([번지] as NVARCHAR(60)) as [번지], CAST([업태] as NVARCHAR(30)) as [업태], CAST([업종] as NVARCHAR(30)) as [업종], CAST([전화번호] as NVARCHAR(20)) as [전화번호], CAST([팩스번호] as NVARCHAR(14)) as [팩스번호], CAST([은행코드] as NVARCHAR(2)) as [은행코드], CAST([계좌번호] as NVARCHAR(20)) as [계좌번호], CAST([담당자명] as NVARCHAR(30)) as [담당자명], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[미지급금원장]	`YmhDB`	`미지급금원장`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([최종미지급금일자] as NVARCHAR(8)) as [최종미지급금일자], CAST([최종지급일자] as NVARCHAR(8)) as [최종지급일자], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[견적]	`YmhDB`	`견적`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([견적일자] as NVARCHAR(8)) as [견적일자], [견적번호], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([출고희망일자] as NVARCHAR(8)) as [출고희망일자], [결제방법], CAST([결제예정일자] as NVARCHAR(8)) as [결제예정일자], [유효일수], CAST([제목] as NVARCHAR(30)) as [제목], CAST([적요] as NVARCHAR(50)) as [적요], [상태코드], CAST([입고일자] as NVARCHAR(8)) as [입고일자], CAST([출고일자] as NVARCHAR(8)) as [출고일자], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[회계전표내역]	`YmhDB`	`회계전표내역`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([작성일자] as NVARCHAR(8)) as [작성일자], CAST([작성시간] as NVARCHAR(9)) as [작성시간], CAST([계정코드] as NVARCHAR(4)) as [계정코드], [입출구분], [입금금액], [출금금액], CAST([적요] as NVARCHAR(60)) as [적요], [사용구분], CAST([작성자코드] as NVARCHAR(4)) as [작성자코드], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[회계전표내역마감]	`YmhDB`	`회계전표내역마감`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([계정코드] as NVARCHAR(4)) as [계정코드], CAST([마감년월] as NVARCHAR(6)) as [마감년월], [입금누계금액], [출금누계금액], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[미지급금원장마감]	`YmhDB`	`미지급금원장마감`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([마감년월] as NVARCHAR(6)) as [마감년월], [미지급금누계금액], [미지급금지급누계금액], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[sysdiagrams]	`YmhDB`	`sysdiagrams`	-	-	CAST([name] as VARCHAR(128)) as [name], [principal_id], [diagram_id], [version], CONVERT(VARBINARY(MAX), [definition], 0) as [definition] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[발주]	`YmhDB`	`발주`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([발주일자] as NVARCHAR(8)) as [발주일자], [발주번호], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([입고희망일자] as NVARCHAR(8)) as [입고희망일자], [결제방법], CAST([결제예정일자] as NVARCHAR(8)) as [결제예정일자], [유효일수], CAST([제목] as NVARCHAR(30)) as [제목], CAST([적요] as NVARCHAR(50)) as [적요], [상태코드], CAST([입고일자] as NVARCHAR(8)) as [입고일자], CAST([출고일자] as NVARCHAR(8)) as [출고일자], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[견적내역]	`YmhDB`	`견적내역`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([견적일자] as NVARCHAR(8)) as [견적일자], [견적번호], CAST([견적시간] as NVARCHAR(9)) as [견적시간], CAST([자재코드] as NVARCHAR(18)) as [자재코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], [수량], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], [계산서발행여부], [입고단가], [입고부가], [출고단가], [출고부가], [상태코드], CAST([입고일자] as NVARCHAR(8)) as [입고일자], CAST([출고일자] as NVARCHAR(8)) as [출고일자], CAST([적요] as NVARCHAR(50)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[발주내역]	`YmhDB`	`발주내역`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([발주일자] as NVARCHAR(8)) as [발주일자], [발주번호], CAST([발주시간] as NVARCHAR(9)) as [발주시간], CAST([자재코드] as NVARCHAR(18)) as [자재코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], [발주량], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], [직송구분], [입고단가], [입고부가], [출고단가], [출고부가], [상태코드], CAST([입고일자] as NVARCHAR(8)) as [입고일자], CAST([출고일자] as NVARCHAR(8)) as [출고일자], CAST([적요] as NVARCHAR(50)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[매입처]	`YmhDB`	`매입처`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([매입처코드] as NVARCHAR(8)) as [매입처코드], CAST([매입처명] as NVARCHAR(30)) as [매입처명], CAST([사업자번호] as NVARCHAR(14)) as [사업자번호], CAST([법인번호] as NVARCHAR(14)) as [법인번호], CAST([대표자명] as NVARCHAR(30)) as [대표자명], CAST([대표자주민번호] as NVARCHAR(14)) as [대표자주민번호], CAST([개업일자] as NVARCHAR(8)) as [개업일자], CAST([우편번호] as NVARCHAR(7)) as [우편번호], CAST([주소] as NVARCHAR(60)) as [주소], CAST([번지] as NVARCHAR(60)) as [번지], CAST([업태] as NVARCHAR(30)) as [업태], CAST([업종] as NVARCHAR(30)) as [업종], CAST([전화번호] as NVARCHAR(20)) as [전화번호], CAST([팩스번호] as NVARCHAR(14)) as [팩스번호], CAST([은행코드] as NVARCHAR(2)) as [은행코드], CAST([계좌번호] as NVARCHAR(20)) as [계좌번호], [계산서발행여부], [계산서발행율], CAST([담당자명] as NVARCHAR(30)) as [담당자명], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([비고란] as NVARCHAR(100)) as [비고란], [단가구분] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[로그]	`YmhDB`	`로그`	-	-	CAST([테이블명] as NVARCHAR(50)) as [테이블명], CAST([베이스코드] as NVARCHAR(50)) as [베이스코드], [최종로그], [최종로그1], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[세금계산서]	`YmhDB`	`세금계산서`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([작성년도] as NVARCHAR(4)) as [작성년도], [책번호], [일련번호], CAST([매출처코드] as NVARCHAR(8)) as [매출처코드], CAST([작성일자] as NVARCHAR(8)) as [작성일자], CAST([품목및규격] as NVARCHAR(50)) as [품목및규격], [수량], [공급가액], [세액], [금액구분], [영청구분], [발행여부], [작성구분], [미수구분], CAST([적요] as NVARCHAR(50)) as [적요], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드] >> %TMP%\wb_tables_to_migrate.txt
ECHO [YmhDB]	[dbo].[자재원장]	`YmhDB`	`자재원장`	-	-	CAST([사업장코드] as NVARCHAR(2)) as [사업장코드], CAST([분류코드] as NVARCHAR(2)) as [분류코드], CAST([세부코드] as NVARCHAR(16)) as [세부코드], [적정재고], [최저재고], CAST([최종입고일자] as NVARCHAR(8)) as [최종입고일자], CAST([최종출고일자] as NVARCHAR(8)) as [최종출고일자], [사용구분], CAST([수정일자] as NVARCHAR(8)) as [수정일자], CAST([사용자코드] as NVARCHAR(4)) as [사용자코드], CAST([비고란] as NVARCHAR(100)) as [비고란], CAST([주매입처코드] as NVARCHAR(8)) as [주매입처코드], [입고단가1], [입고단가2], [입고단가3], [출고단가1], [출고단가2], [출고단가3] >> %TMP%\wb_tables_to_migrate.txt


"%wbcopytables%" ^
 --odbc-source="DSN=MSSQL_YMHDB;DATABASE=;UID=sa" ^
 --source-rdbms-type=Mssql ^
 --target="root@127.0.0.1:3306" ^
 --source-password="%arg_source_password%" ^
 --target-password="%arg_target_password%" ^
 --table-file="%table_file%" ^
 --target-ssh-port="22" ^
 --target-ssh-host="" ^
 --target-ssh-user="" ^
 --source-ssh-password="%arg_source_ssh_password%" ^
 --target-ssh-password="%arg_target_ssh_password%" --thread-count=%arg_worker_count% ^
 %arg_truncate_target% ^
 %arg_debug_output%

REM Removes the file with the table definitions
DEL %TMP%\wb_tables_to_migrate.txt


