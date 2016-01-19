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
		@AdjustedOpeningNav numeric(27,8), 
		@KeeleyAdjustmentFactor numeric(27,8), 
		@KeeleyAdjustedNav numeric(27,8), 
		@KeeleyAdjustedOpeningNav numeric(27,8), 
		@AdministratorAdjustmentFactor numeric(27,8), 
		@AdministratorAdjustedNav numeric(27,8), 
		@AdministratorOpeningAdjustedNav numeric(27,8), 
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
		@ValuationOpeningAdjustedNav numeric(27,8), 
		@ValuationUnadjustedNav numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionFund_hst (
			AttributionFundId, FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, AdjustedOpeningNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, KeeleyAdjustedOpeningNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorOpeningAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, StartDt, UpdateUserID, DataVersion, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationOpeningAdjustedNav, ValuationUnadjustedNav, EndDt, LastActionUserID)
	SELECT	AttributionFundId, FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, AdjustedOpeningNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, KeeleyAdjustedOpeningNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorOpeningAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, StartDt, UpdateUserID, DataVersion, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationOpeningAdjustedNav, ValuationUnadjustedNav, @StartDt, @UpdateUserID
	FROM	AttributionFund
	WHERE	AttributionFundId = @AttributionFundId

	UPDATE	AttributionFund
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, AdjustmentFactor = @AdjustmentFactor, AdjustedNav = @AdjustedNav, AdjustedOpeningNav = @AdjustedOpeningNav, KeeleyAdjustmentFactor = @KeeleyAdjustmentFactor, KeeleyAdjustedNav = @KeeleyAdjustedNav, KeeleyAdjustedOpeningNav = @KeeleyAdjustedOpeningNav, AdministratorAdjustmentFactor = @AdministratorAdjustmentFactor, AdministratorAdjustedNav = @AdministratorAdjustedNav, AdministratorOpeningAdjustedNav = @AdministratorOpeningAdjustedNav, AdministratorSourced = @AdministratorSourced, AdministratorPrevious = @AdministratorPrevious, FactsetSourced = @FactsetSourced, FactsetPrevious = @FactsetPrevious, KeeleyUnadjustedNav = @KeeleyUnadjustedNav, KeeleyTodayCapitalChange = @KeeleyTodayCapitalChange, UpdateUserID = @UpdateUserID, PercentageOfFund = @PercentageOfFund, ValuationAdjustmentFactor = @ValuationAdjustmentFactor, ValuationAdjustedNav = @ValuationAdjustedNav, ValuationOpeningAdjustedNav = @ValuationOpeningAdjustedNav, ValuationUnadjustedNav = @ValuationUnadjustedNav,  StartDt = @StartDt
	WHERE	AttributionFundId = @AttributionFundId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionFund
	WHERE	AttributionFundId = @AttributionFundId
	AND		@@ROWCOUNT > 0

GO
