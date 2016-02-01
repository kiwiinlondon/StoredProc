USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionFund_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionFund_Delete]
GO

CREATE PROCEDURE DBO.[AttributionFund_Delete]
		@AttributionFundId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionFund_hst (
			AttributionFundId, FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, StartDt, UpdateUserID, DataVersion, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationUnadjustedNav, EndDt, LastActionUserID)
	SELECT	AttributionFundId, FundId, ReferenceDate, AdjustmentFactor, AdjustedNav, KeeleyAdjustmentFactor, KeeleyAdjustedNav, AdministratorAdjustmentFactor, AdministratorAdjustedNav, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, KeeleyUnadjustedNav, KeeleyTodayCapitalChange, StartDt, UpdateUserID, DataVersion, PercentageOfFund, ValuationAdjustmentFactor, ValuationAdjustedNav, ValuationUnadjustedNav, @EndDt, @UpdateUserID
	FROM	AttributionFund
	WHERE	AttributionFundId = @AttributionFundId

	DELETE	AttributionFund
	WHERE	AttributionFundId = @AttributionFundId
	AND		DataVersion = @DataVersion
GO
