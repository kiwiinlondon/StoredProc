USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalyticPosition_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalyticPosition_Delete]
GO

CREATE PROCEDURE DBO.[RiskAnalyticPosition_Delete]
		@RiskAnalyticPositionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RiskAnalyticPosition_hst (
			RiskAnalyticPositionId, RiskAnalyticTypeId, ReferenceDate, InstrumentMarketId, FundId, Value1d, StartDt, DataVersion, UpdateUserID, EndDt, LastActionUserID)
	SELECT	RiskAnalyticPositionId, RiskAnalyticTypeId, ReferenceDate, InstrumentMarketId, FundId, Value1d, StartDt, DataVersion, UpdateUserID, @EndDt, @UpdateUserID
	FROM	RiskAnalyticPosition
	WHERE	RiskAnalyticPositionId = @RiskAnalyticPositionId

	DELETE	RiskAnalyticPosition
	WHERE	RiskAnalyticPositionId = @RiskAnalyticPositionId
	AND		DataVersion = @DataVersion
GO
