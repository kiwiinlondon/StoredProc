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
		@InstrumentMarketId int, 
		@PortfolioId int, 
		@ReferenceDate datetime, 
		@EquityExposure numeric(27,8), 
		@CurrencyExposure numeric(27,8), 
		@CommodityExposure numeric(27,8), 
		@FixedIncomeExposure numeric(27,8), 
		@OtherExposure numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
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

	INSERT INTO Exposure_hst (
			ExposureId, PositionId, InstrumentMarketId, PortfolioId, ReferenceDate, EquityExposure, CurrencyExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, StartDt, UpdateUserID, DataVersion, GovernmentBondExposure, ChangeEquityExposure, ChangeCurrencyExposure, ChangeCommodityExposure, ChangeFixedIncomeExposure, ChangeOtherExposure, ChangeGovernmentBondExposure, MaturityDate, IsPrimaryExposure, IsLong, InterestRateExposure, ChangeInterestRateExposure, BetaLongTerm, BetaShortTerm, HedgeRatio, CreditExposure, ChangeCreditExposure, EmergingMarketDebtExposure, ChangeEmergingMarketDebtExposure, EndDt, LastActionUserID)
	SELECT	ExposureId, PositionId, InstrumentMarketId, PortfolioId, ReferenceDate, EquityExposure, CurrencyExposure, CommodityExposure, FixedIncomeExposure, OtherExposure, StartDt, UpdateUserID, DataVersion, GovernmentBondExposure, ChangeEquityExposure, ChangeCurrencyExposure, ChangeCommodityExposure, ChangeFixedIncomeExposure, ChangeOtherExposure, ChangeGovernmentBondExposure, MaturityDate, IsPrimaryExposure, IsLong, InterestRateExposure, ChangeInterestRateExposure, BetaLongTerm, BetaShortTerm, HedgeRatio, CreditExposure, ChangeCreditExposure, EmergingMarketDebtExposure, ChangeEmergingMarketDebtExposure, @StartDt, @UpdateUserID
	FROM	Exposure
	WHERE	ExposureId = @ExposureId

	UPDATE	Exposure
	SET		PositionId = @PositionId, InstrumentMarketId = @InstrumentMarketId, PortfolioId = @PortfolioId, ReferenceDate = @ReferenceDate, EquityExposure = @EquityExposure, CurrencyExposure = @CurrencyExposure, CommodityExposure = @CommodityExposure, FixedIncomeExposure = @FixedIncomeExposure, OtherExposure = @OtherExposure, UpdateUserID = @UpdateUserID, GovernmentBondExposure = @GovernmentBondExposure, ChangeEquityExposure = @ChangeEquityExposure, ChangeCurrencyExposure = @ChangeCurrencyExposure, ChangeCommodityExposure = @ChangeCommodityExposure, ChangeFixedIncomeExposure = @ChangeFixedIncomeExposure, ChangeOtherExposure = @ChangeOtherExposure, ChangeGovernmentBondExposure = @ChangeGovernmentBondExposure, MaturityDate = @MaturityDate, IsPrimaryExposure = @IsPrimaryExposure, IsLong = @IsLong, InterestRateExposure = @InterestRateExposure, ChangeInterestRateExposure = @ChangeInterestRateExposure, BetaLongTerm = @BetaLongTerm, BetaShortTerm = @BetaShortTerm, HedgeRatio = @HedgeRatio, CreditExposure = @CreditExposure, ChangeCreditExposure = @ChangeCreditExposure, EmergingMarketDebtExposure = @EmergingMarketDebtExposure, ChangeEmergingMarketDebtExposure = @ChangeEmergingMarketDebtExposure,  StartDt = @StartDt
	WHERE	ExposureId = @ExposureId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Exposure
	WHERE	ExposureId = @ExposureId
	AND		@@ROWCOUNT > 0

GO
