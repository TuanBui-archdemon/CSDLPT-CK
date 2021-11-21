USE [QLVT_DATHANG]
GO

/****** Object:  StoredProcedure [dbo].[sp_vattutrongddh]    Script Date: 11/17/2021 06:34:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_vattutrongddh]
@MASODDH NCHAR(8)
AS
BEGIN
SELECT VATTU.MAVT, VATTU.TENVT, VT.SOLUONG
FROM VATTU, (SELECT MAVT, CTDDH.SOLUONG FROM CTDDH,DATHANG  WHERE CTDDH.MASODDH= DATHANG.MASODDH AND DATHANG.MASODDH= @MASODDH) VT
WHERE VATTU.MAVT= VT.MAVT
END 

GO
