USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchInstrumentMarketAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchInstrumentMarketAnalytic_Update]
GO

CREATE PROCEDURE DBO.[ResearchInstrumentMarketAnalytic_Update]
		@ResearchInstrumentMarketAnalyticId int, 
		@ResearchInstrumentMarketId int, 
		@AnalyticTypeId int, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@AsOfDt datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ResearchInstrumentMarketAnalytic_hst (
			ResearchInstrumentMarketAnalyticId, ResearchInstrumentMarketId, AnalyticTypeId, Value, StartDt, UpdateUserID, DataVersion, AsOfDt, EndDt, LastActionUserID)
	SELECT	ResearchInstrumentMarketAnalyticId, ResearchInstrumentMarketId, AnalyticTypeId, Value, StartDt, UpdateUserID, DataVersion, AsOfDt, @StartDt, @UpdateUserID
	FROM	ResearchInstrumentMarketAnalytic
	WHERE	ResearchInstrumentMarketAnalyticId = @ResearchInstrumentMarketAnalyticId

	UPDATE	ResearchInstrumentMarketAnalytic
	SET		ResearchInstrumentMarketId = @ResearchInstrumentMarketId, AnalyticTypeId = @AnalyticTypeId, Value = @Value, UpdateUserID = @UpdateUserID, AsOfDt = @AsOfDt,  StartDt = @StartDt
	WHERE	ResearchInstrumentMarketAnalyticId = @ResearchInstrumentMarketAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ResearchInstrumentMarketAnalytic
	WHERE	ResearchInstrumentMarketAnalyticId = @ResearchInstrumentMarketAnalyticId
	AND		@@ROWCOUNT > 0

GO
