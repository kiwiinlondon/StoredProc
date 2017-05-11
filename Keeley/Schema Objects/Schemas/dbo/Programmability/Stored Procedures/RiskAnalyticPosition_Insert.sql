USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalyticPosition_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalyticPosition_Insert]
GO

CREATE PROCEDURE DBO.[RiskAnalyticPosition_Insert]
		@RiskAnalyticTypeId int, 
		@ReferenceDate datetime, 
		@InstrumentMarketId int, 
		@FundId int, 
		@Value1d numeric(28,16), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RiskAnalyticPosition
			(RiskAnalyticTypeId, ReferenceDate, InstrumentMarketId, FundId, Value1d, UpdateUserID, StartDt)
	VALUES
			(@RiskAnalyticTypeId, @ReferenceDate, @InstrumentMarketId, @FundId, @Value1d, @UpdateUserID, @StartDt)

	SELECT	RiskAnalyticPositionId, StartDt, DataVersion
	FROM	RiskAnalyticPosition
	WHERE	RiskAnalyticPositionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
