USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[RiskAnalytic_Insert]
		@InstrumentMarketId int, 
		@RiskAnalyticTypeId int, 
		@ReferenceDate datetime, 
		@CurrencyId int, 
		@Value1Day numeric(27,8), 
		@Value20Day numeric(27,8), 
		@Value1DayMixedModel numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RiskAnalytic
			(InstrumentMarketId, RiskAnalyticTypeId, ReferenceDate, CurrencyId, Value1Day, Value20Day, Value1DayMixedModel, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @RiskAnalyticTypeId, @ReferenceDate, @CurrencyId, @Value1Day, @Value20Day, @Value1DayMixedModel, @UpdateUserID, @StartDt)

	SELECT	RiskAnalyticId, StartDt, DataVersion
	FROM	RiskAnalytic
	WHERE	RiskAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
