USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Exposure_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Exposure_Update]
GO

CREATE PROCEDURE DBO.[Exposure_Update]
		@ExposureId int, 
		@PositionId int, 
		@InstrumentId int, 
		@PortfolioId int, 
		@ReferenceDate datetime, 
		@NetPosition numeric(27,8), 
		@EquityExposure numeric(27,8), 
		@FXExposure numeric(27,8), 
		@CommodityExposure numeric(27,8), 
		@FixedIncomeExposure numeric(27,8), 
		@OtherExposure numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Exposure_hst (
			ExposureId, PositionId, InstrumentId, PortfolioId, ReferenceDate, NetPosition, EquityExposure, FXExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExposureId, PositionId, InstrumentId, PortfolioId, ReferenceDate, NetPosition, EquityExposure, FXExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Exposure
	WHERE	ExposureId = @ExposureId

	UPDATE	Exposure
	SET		PositionId = @PositionId, InstrumentId = @InstrumentId, PortfolioId = @PortfolioId, ReferenceDate = @ReferenceDate, NetPosition = @NetPosition, EquityExposure = @EquityExposure, FXExposure = @FXExposure, CommodityExposure = @CommodityExposure, FixedIncomeExposure = @FixedIncomeExposure, OtherExposure = @OtherExposure, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExposureId = @ExposureId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Exposure
	WHERE	ExposureId = @ExposureId
	AND		@@ROWCOUNT > 0

GO
