USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionFund_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionFund_Insert]
GO

CREATE PROCEDURE DBO.[AttributionFund_Insert]
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
		@PercentageOfFund numeric(27,8), 
		@ValuationAdjustmentFactor numeric(27,8), 
		@ValuationAdjustedNav numeric(27,8), 
		@ValuationOpeningAdjustedNav numeric(27,8), 
		@ValuationUnadjustedNav numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionFund
			(FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, AdjustedOpeningNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, KeeleyAdjustedOpeningNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorOpeningAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, UpdateUserID, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationOpeningAdjustedNav, ValuationUnadjustedNav, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @AdjustmentFactor, @AdjustedNav, @AdjustedOpeningNav, @KeeleyAdjustmentFactor, @KeeleyAdjustedNav, @KeeleyAdjustedOpeningNav, @AdministratorAdjustmentFactor, @AdministratorAdjustedNav, @AdministratorOpeningAdjustedNav, @AdministratorSourced, @AdministratorPrevious, @FactsetSourced, @FactsetPrevious, @KeeleyUnadjustedNav, @KeeleyTodayCapitalChange, @UpdateUserID, @PercentageOfFund, @ValuationAdjustmentFactor, @ValuationAdjustedNav, @ValuationOpeningAdjustedNav, @ValuationUnadjustedNav, @StartDt)

	SELECT	AttributionFundId, StartDt, DataVersion
	FROM	AttributionFund
	WHERE	AttributionFundId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
