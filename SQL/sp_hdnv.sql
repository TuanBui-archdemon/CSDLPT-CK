USE [QLVT_DATHANG]
GO

/****** Object:  StoredProcedure [dbo].[sp_hdnv]    Script Date: 11/17/2021 06:28:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_hdnv] @MANV INT,
@BEGIN NCHAR(10),
@END NCHAR(10)
AS
BEGIN
SET NOCOUNT ON;
	IF 1=0 BEGIN
	SET FMTONLY OFF
END

  -- PHIEU NHAP
    SELECT FORMAT(PN.NGAY,'MM/yyyy') AS THANGNAM,
		SUBSTRING(CONVERT(VARCHAR, PN.NGAY, 103),0,11) AS NGAY,
		PN.MAPN , PN.HOTENKH , VT.TENVT , 
		TENKHO ,SOLUONG ,
		DONGIA , SOLUONG * DONGIA AS TRIGIA,
		MANV , HOTENNV  into #phieuNhap
	FROM (
			SELECT MAPN, NGAY, HOTENKH = '',
			TENKHO = (SELECT TENKHO FROM KHO WHERE KHO.MAKHO = PNP.MAKHO),
			NV.MANV, HO+ ' '+TEN AS HOTENNV  
			FROM DBO.PHIEUNHAP AS PNP ,NHANVIEN AS NV
			WHERE NV.MANV = @MANV AND  PNP.MANV= NV.MANV AND NGAY BETWEEN @BEGIN AND @END 
		 ) PN, CTPN,(SELECT TENVT, MAVT FROM VATTU) VT
	WHERE VT.MAVT = CTPN.MAVT AND CTPN.MAPN = PN.MAPN 
	ORDER BY THANGNAM, NGAY

	-- PHIEU XUAT
      SELECT FORMAT(PX.NGAY,'MM/yyyy') AS THANGNAM,
	    SUBSTRING(CONVERT(VARCHAR, PX.NGAY, 103),0,11) AS NGAY ,
		PX.MAPX , HOTENKH , VT.TENVT , 
		TENKHO ,SOLUONG ,
		DONGIA , SOLUONG * DONGIA AS TRIGIA,
		MANV , HOTENNV into #phieuXuat
		FROM (
			SELECT MAPX, NGAY, HOTENKH,
			TENKHO = (SELECT TENKHO FROM KHO WHERE KHO.MAKHO = PXP.MAKHO),
			NV.MANV, HO+ ' '+TEN AS HOTENNV  
			FROM DBO.PHIEUXUAT AS PXP ,NHANVIEN AS NV
			WHERE NV.MANV = @MANV AND  PXP.MANV= NV.MANV AND NGAY BETWEEN @BEGIN AND @END 
		 ) PX, CTPX,(SELECT TENVT, MAVT FROM VATTU) VT
	WHERE VT.MAVT = CTPX.MAVT AND CTPX.MAPX = PX.MAPX
	ORDER BY THANGNAM, NGAY

-- GOP
	SELECT N.THANGNAM ,  N.NGAY, N.MAPN , N.HOTENKH, N.TENVT  , N.TENKHO , N.SOLUONG , N.DONGIA  ,N.TRIGIA , N.MANV , N.HOTENNV 
	FROM #phieuNhap N
	UNION
	SELECT X.THANGNAM ,X.NGAY, X.MAPX, X.HOTENKH , X.TENVT  , X.TENKHO , X.SOLUONG  , X.DONGIA  , X.TRIGIA , X.MANV, X.HOTENNV 
	FROM #phieuXuat X
END

GO
