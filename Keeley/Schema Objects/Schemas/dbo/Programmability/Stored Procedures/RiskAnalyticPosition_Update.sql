USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalyticPosition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalyticPosition_Update]
GO

CREATE PROCEDURE DBO.[RiskAnalyticPosition_Update]
		@RiskAnalyticPositionId int, 
		@RiskAnalyticTypeId int, 
		@ReferenceDate datetime, 
		@InstrumentMarketId int, 
		@FundId int, 
		@Value1d numeric(28,16), 
		@DataVersion rowversion, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RiskAnalyticPosition_hst (
			RiskAnalyticPositionId, RiskAnalyticTypeId, ReferenceDate, InstrumentMarketId, FundId, Value1d, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	RiskAnalyticPositionId, RiskAnalyticTypeId, ReferenceDate, InstrumentMarketId, FundId, Value1d, StartDt, DataVersion, UpdateUserID, @StartDt, @UpdateUserID
	FROM	RiskAnalyticPosition
	WHERE	RiskAnalyticPositionId = @RiskAnalyticPositionId

	UPDATE	RiskAnalyticPosition
	SET		RiskAnalyticTypeId = @RiskAnalyticTypeId, ReferenceDate = @ReferenceDate, InstrumentMarketId = @InstrumentMarketId, FundId = @FundId, Value1d = @Value1d, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RiskAnalyticPositionId = @RiskAnalyticPositionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RiskAnalyticPosition
	WHERE	RiskAnalyticPositionId = @RiskAnalyticPositionId
	AND		@@ROWCOUNT > 0

GO
