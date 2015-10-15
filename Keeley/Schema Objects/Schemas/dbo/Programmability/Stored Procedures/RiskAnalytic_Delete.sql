USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[RiskAnalytic_Delete]
		@RiskAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RiskAnalytic_hst (
			RiskAnalyticId, InstrumentMarketId, RiskAnalyticTypeId, ReferenceDate, CurrencyId, Value1Day, Value20Day, Value1DayMixedModel, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RiskAnalyticId, InstrumentMarketId, RiskAnalyticTypeId, ReferenceDate, CurrencyId, Value1Day, Value20Day, Value1DayMixedModel, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	RiskAnalytic
	WHERE	RiskAnalyticId = @RiskAnalyticId

	DELETE	RiskAnalytic
	WHERE	RiskAnalyticId = @RiskAnalyticId
	AND		DataVersion = @DataVersion
GO
