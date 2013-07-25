USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Exposure_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Exposure_Delete]
GO

CREATE PROCEDURE DBO.[Exposure_Delete]
		@ExposureId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Exposure_hst (
			ExposureId, PositionId, InstrumentMarketId, PortfolioId, ReferenceDate, EquityExposure, CurrencyExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, StartDt, UpdateUserID, DataVersion, GovernmentBondExposure, ChangeEquityExposure, ChangeCurrencyExposure, ChangeCommodityExposure, ChangeFixedIncomeExposure, ChangeOtherExposure, ChangeGovernmentBondExposure, MaturityDate, IsPrimaryExposure, IsLong, EndDt, LastActionUserID)
	SELECT	ExposureId, PositionId, InstrumentMarketId, PortfolioId, ReferenceDate, EquityExposure, CurrencyExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, StartDt, UpdateUserID, DataVersion, GovernmentBondExposure, ChangeEquityExposure, ChangeCurrencyExposure, ChangeCommodityExposure, ChangeFixedIncomeExposure, ChangeOtherExposure, ChangeGovernmentBondExposure, MaturityDate, IsPrimaryExposure, IsLong, @EndDt, @UpdateUserID
	FROM	Exposure
	WHERE	ExposureId = @ExposureId

	DELETE	Exposure
	WHERE	ExposureId = @ExposureId
	AND		DataVersion = @DataVersion
GO
