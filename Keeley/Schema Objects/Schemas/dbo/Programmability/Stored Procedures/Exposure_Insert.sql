USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Exposure_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Exposure_Insert]
GO

CREATE PROCEDURE DBO.[Exposure_Insert]
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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Exposure
			(PositionId, InstrumentId, PortfolioId, ReferenceDate, NetPosition, EquityExposure, FXExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, UpdateUserID, StartDt)
	VALUES
			(@PositionId, @InstrumentId, @PortfolioId, @ReferenceDate, @NetPosition, @EquityExposure, @FXExposure, @CommodityExposure, @FixedIncomeExposure, @OtherExposure, @UpdateUserID, @StartDt)

	SELECT	ExposureId, StartDt, DataVersion
	FROM	Exposure
	WHERE	ExposureId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
