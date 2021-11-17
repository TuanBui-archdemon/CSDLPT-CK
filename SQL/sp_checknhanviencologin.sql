USE [QLVT_DATHANG]
GO

/****** Object:  StoredProcedure [dbo].[sp_checknhanviencologin]    Script Date: 11/17/2021 06:27:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure  [dbo].[sp_checknhanviencologin]
@TENLOGIN NVARCHAR(50)
AS
BEGIN
SELECT MANV, HOTEN= HO +''+TEN 
FROM NHANVIEN
WHERE CONVERT(VARCHAR, MANV) IN (SELECT NAME FROM SYS.SYSUSERS)AND TRANGTHAIXOA=0 AND MANV= @TENLOGIN
END

GO

