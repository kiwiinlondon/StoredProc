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
		@InstrumentMarketId int, 
		@PortfolioId int, 
		@ReferenceDate datetime, 
		@EquityExposure numeric(27,8), 
		@CurrencyExposure numeric(27,8), 
		@CommodityExposure numeric(27,8), 
		@FixedIncomeExposure numeric(27,8), 
		@OtherExposure numeric(27,8), 
		@UpdateUserID int, 
		@GovernmentBondExposure numeric(27,8), 
		@ChangeEquityExposure numeric(27,8), 
		@ChangeCurrencyExposure numeric(27,8), 
		@ChangeCommodityExposure numeric(27,8), 
		@ChangeFixedIncomeExposure numeric(27,8), 
		@ChangeOtherExposure numeric(27,8), 
		@ChangeGovernmentBondExposure numeric(27,8), 
		@MaturityDate datetime, 
		@IsPrimaryExposure bit, 
		@IsLong bit, 
		@InterestRateExposure numeric(27,8), 
		@ChangeInterestRateExposure numeric(27,8), 
		@BetaLongTerm numeric(27,8), 
		@BetaShortTerm numeric(27,8), 
		@HedgeRatio numeric(27,8), 
		@CreditExposure numeric(27,8), 
		@ChangeCreditExposure numeric(27,8), 
		@EmergingMarketDebtExposure numeric(27,8), 
		@ChangeEmergingMarketDebtExposure numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Exposure
			(PositionId, InstrumentMarketId, PortfolioId, ReferenceDate, EquityExposure, CurrencyExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, UpdateUserID, GovernmentBondExposure, ChangeEquityExposure, ChangeCurrencyExposure, ChangeCommodityExposure, ChangeFixedIncomeExposure, ChangeOtherExposure, ChangeGovernmentBondExposure, MaturityDate, IsPrimaryExposure, IsLong, InterestRateExposure, ChangeInterestRateExposure, BetaLongTerm, BetaShortTerm, HedgeRatio, CreditExposure, ChangeCreditExposure, EmergingMarketDebtExposure, ChangeEmergingMarketDebtExposure, StartDt)
	VALUES
			(@PositionId, @InstrumentMarketId, @PortfolioId, @ReferenceDate, @EquityExposure, @CurrencyExposure, @CommodityExposure, @FixedIncomeExposure, @OtherExposure, @UpdateUserID, @GovernmentBondExposure, @ChangeEquityExposure, @ChangeCurrencyExposure, @ChangeCommodityExposure, @ChangeFixedIncomeExposure, @ChangeOtherExposure, @ChangeGovernmentBondExposure, @MaturityDate, @IsPrimaryExposure, @IsLong, @InterestRateExposure, @ChangeInterestRateExposure, @BetaLongTerm, @BetaShortTerm, @HedgeRatio, @CreditExposure, @ChangeCreditExposure, @EmergingMarketDebtExposure, @ChangeEmergingMarketDebtExposure, @StartDt)

	SELECT	ExposureId, StartDt, DataVersion
	FROM	Exposure
	WHERE	ExposureId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
