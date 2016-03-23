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
		@PercentageOfFund numeric(27,8), 
		@ValuationAdjustmentFactor numeric(27,8), 
		@ValuationAdjustedNav numeric(27,8), 
		@ValuationUnadjustedNav numeric(27,8), 
		@UseKeeleyAdjustmentFactor bit = 1
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionFund
			(FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, UpdateUserID, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationUnadjustedNav, UseKeeleyAdjustmentFactor, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @AdjustmentFactor, @AdjustedNav, @KeeleyAdjustmentFactor, @KeeleyAdjustedNav, @AdministratorAdjustmentFactor, @AdministratorAdjustedNav, @AdministratorSourced, @AdministratorPrevious, @FactsetSourced, @FactsetPrevious, @KeeleyUnadjustedNav, @KeeleyTodayCapitalChange, @UpdateUserID, @PercentageOfFund, @ValuationAdjustmentFactor, @ValuationAdjustedNav, @ValuationUnadjustedNav, @UseKeeleyAdjustmentFactor, @StartDt)

	SELECT	AttributionFundId, StartDt, DataVersion
	FROM	AttributionFund
	WHERE	AttributionFundId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
