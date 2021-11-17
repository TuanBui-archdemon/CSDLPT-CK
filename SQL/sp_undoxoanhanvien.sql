USE [QLVT_DATHANG]
GO

/****** Object:  StoredProcedure [dbo].[sp_undoxoanhanvien]    Script Date: 11/17/2021 06:33:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_undoxoanhanvien] 
	@LGNAME VARCHAR(50),
	@USERNAME VARCHAR(50),
	@HO NVARCHAR(50),
	@TEN NVARCHAR(50),
	@DIACHI NVARCHAR(50),
	@NGAYSINH VARCHAR(50),
	@LUONG VARCHAR(50),
	@MACN VARCHAR(50),
	@ROLE NVARCHAR(50)
AS
BEGIN

	INSERT INTO NHANVIEN (MANV, HO, TEN, DIACHI, NGAYSINH, LUONG, MACN, TRANGTHAIXOA) VALUES (@USERNAME,@HO,@TEN,@DIACHI,@NGAYSINH,@LUONG,@MACN,0)


	DECLARE @RET INT
		EXEC @RET = SP_ADDLOGIN @LGNAME, '123456', 'QLVT_DATHANG'
			IF (@RET =1) --LOGINNAME BI TRUNG
				RETURN 1
		EXEC @RET = SP_GRANTDBACCESS @LGNAME, @USERNAME
		IF(@RET =1) --USER NAME BI TRUNG
		BEGIN
			EXEC SP_DROPLOGIN @LGNAME
			RETURN 2
		END
		EXEC SP_ADDROLEMEMBER  @ROLENAME =  @ROLE,  @MEMBERNAME =  @USERNAME
		IF @ROLE='CONGTY' OR @ROLE='CHINHANH'
			EXEC SP_ADDSRVROLEMEMBER @LGNAME, 'SECURITYADMIN'
			RETURN 0 -- THANH CONG
		COMMIT	
		RETURN 0 -- THANH CONG

	
END



GO

