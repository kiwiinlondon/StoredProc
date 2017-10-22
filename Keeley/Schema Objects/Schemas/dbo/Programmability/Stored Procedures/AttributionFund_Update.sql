USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionFund_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionFund_Update]
GO

CREATE PROCEDURE DBO.[AttributionFund_Update]
		@AttributionFundId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@AdjustmentFactor numeric(27,8), 
		@AdjustedNav numeric(27,8), 
		@KeeleyAdjustmentFactor numeric(27,8), 
		@KeeleyAdjustedNav numeric(27,8), 
		@AdministratorAdjustmentFactor numeric(27,8), 
		@AdministratorAdjustedNav numeric(27,8), 
		@AdministratorSourced bit, 
		@AdministratorPrevious datetime, 
		@FactsetSourced bit, 
		@FactsetPrevious datetime, 
		@KeeleyUnadjustedNav numeric(27,8), 
		@KeeleyTodayCapitalChange numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PercentageOfFund numeric(27,8), 
		@ValuationAdjustmentFactor numeric(27,8), 
		@ValuationAdjustedNav numeric(27,8), 
		@ValuationUnadjustedNav numeric(27,8), 
		@UseKeeleyAdjustmentFactor bit, 
		@AdministratorUnadjustedNav numeric(27,8), 
		@AdministratorTodayCapitalChange numeric(27,8), 
		@ITDOpeningAttributionFundId int, 
		@SumNetAssetValue numeric(27,0), 
		@NumberOfDays int, 
		@OpeningAdjustedNav numeric(27,8), 
		@OpeningKeeleyAdjustedNav numeric(27,8), 
		@OpeningAdministratorAdjustedNav numeric(27,8), 
		@OpeningValuationAdjustedNav numeric(27,8), 
		@OpeningNav numeric(27,8), 
		@OpeningKeeleyNav numeric(27,8), 
		@OpeningAdministratorNav numeric(27,8), 
		@OpeningValuationNav numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionFund_hst (
			AttributionFundId, FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, StartDt, UpdateUserID, DataVersion, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationUnadjustedNav, UseKeeleyAdjustmentFactor, AdministratorUnadjustedNav, AdministratorTodayCapitalChange, ITDOpeningAttributionFundId, SumNetAssetValue, NumberOfDays, OpeningAdjustedNav, OpeningKeeleyAdjustedNav, OpeningAdministratorAdjustedNav, OpeningValuationAdjustedNav, OpeningNav, OpeningKeeleyNav, OpeningAdministratorNav, OpeningValuationNav, EndDt, LastActionUserID)
	SELECT	AttributionFundId, FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, StartDt, UpdateUserID, DataVersion, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationUnadjustedNav, UseKeeleyAdjustmentFactor, AdministratorUnadjustedNav, AdministratorTodayCapitalChange, ITDOpeningAttributionFundId, SumNetAssetValue, NumberOfDays, OpeningAdjustedNav, OpeningKeeleyAdjustedNav, OpeningAdministratorAdjustedNav, OpeningValuationAdjustedNav, OpeningNav, OpeningKeeleyNav, OpeningAdministratorNav, OpeningValuationNav, @StartDt, @UpdateUserID
	FROM	AttributionFund
	WHERE	AttributionFundId = @AttributionFundId

	UPDATE	AttributionFund
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, AdjustmentFactor = @AdjustmentFactor, AdjustedNav = @AdjustedNav, KeeleyAdjustmentFactor = @KeeleyAdjustmentFactor, KeeleyAdjustedNav = @KeeleyAdjustedNav, AdministratorAdjustmentFactor = @AdministratorAdjustmentFactor, AdministratorAdjustedNav = @AdministratorAdjustedNav, AdministratorSourced = @AdministratorSourced, AdministratorPrevious = @AdministratorPrevious, FactsetSourced = @FactsetSourced, FactsetPrevious = @FactsetPrevious, KeeleyUnadjustedNav = @KeeleyUnadjustedNav, KeeleyTodayCapitalChange = @KeeleyTodayCapitalChange, UpdateUserID = @UpdateUserID, PercentageOfFund = @PercentageOfFund, ValuationAdjustmentFactor = @ValuationAdjustmentFactor, ValuationAdjustedNav = @ValuationAdjustedNav, ValuationUnadjustedNav = @ValuationUnadjustedNav, UseKeeleyAdjustmentFactor = @UseKeeleyAdjustmentFactor, AdministratorUnadjustedNav = @AdministratorUnadjustedNav, AdministratorTodayCapitalChange = @AdministratorTodayCapitalChange, ITDOpeningAttributionFundId = @ITDOpeningAttributionFundId, SumNetAssetValue = @SumNetAssetValue, NumberOfDays = @NumberOfDays, OpeningAdjustedNav = @OpeningAdjustedNav, OpeningKeeleyAdjustedNav = @OpeningKeeleyAdjustedNav, OpeningAdministratorAdjustedNav = @OpeningAdministratorAdjustedNav, OpeningValuationAdjustedNav = @OpeningValuationAdjustedNav, OpeningNav = @OpeningNav, OpeningKeeleyNav = @OpeningKeeleyNav, OpeningAdministratorNav = @OpeningAdministratorNav, OpeningValuationNav = @OpeningValuationNav,  StartDt = @StartDt
	WHERE	AttributionFundId = @AttributionFundId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionFund
	WHERE	AttributionFundId = @AttributionFundId
	AND		@@ROWCOUNT > 0

GO
