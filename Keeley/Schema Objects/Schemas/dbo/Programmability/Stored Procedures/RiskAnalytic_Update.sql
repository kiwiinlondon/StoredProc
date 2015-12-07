USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalytic_Update]
GO

CREATE PROCEDURE DBO.[RiskAnalytic_Update]
		@RiskAnalyticId int, 
		@InstrumentMarketId int, 
		@RiskAnalyticTypeId int, 
		@ReferenceDate datetime, 
		@CurrencyId int, 
		@Value1Day numeric(27,8), 
		@Value20Day numeric(27,8), 
		@Value1DayMixedModel numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@Value20DaysMixedModel numeric(27,8), 
		@IsRollValue bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RiskAnalytic_hst (
			RiskAnalyticId, InstrumentMarketId, RiskAnalyticTypeId, ReferenceDate, CurrencyId, Value1Day, Value20Day, Value1DayMixedModel, StartDt, UpdateUserID, DataVersion, Value20DaysMixedModel, IsRollValue, EndDt, LastActionUserID)
	SELECT	RiskAnalyticId, InstrumentMarketId, RiskAnalyticTypeId, ReferenceDate, CurrencyId, Value1Day, Value20Day, Value1DayMixedModel, StartDt, UpdateUserID, DataVersion, Value20DaysMixedModel, IsRollValue, @StartDt, @UpdateUserID
	FROM	RiskAnalytic
	WHERE	RiskAnalyticId = @RiskAnalyticId

	UPDATE	RiskAnalytic
	SET		InstrumentMarketId = @InstrumentMarketId, RiskAnalyticTypeId = @RiskAnalyticTypeId, ReferenceDate = @ReferenceDate, CurrencyId = @CurrencyId, Value1Day = @Value1Day, Value20Day = @Value20Day, Value1DayMixedModel = @Value1DayMixedModel, UpdateUserID = @UpdateUserID, Value20DaysMixedModel = @Value20DaysMixedModel, IsRollValue = @IsRollValue,  StartDt = @StartDt
	WHERE	RiskAnalyticId = @RiskAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RiskAnalytic
	WHERE	RiskAnalyticId = @RiskAnalyticId
	AND		@@ROWCOUNT > 0

GO
