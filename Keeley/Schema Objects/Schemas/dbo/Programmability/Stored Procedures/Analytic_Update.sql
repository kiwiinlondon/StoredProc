USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Analytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Analytic_Update]
GO

CREATE PROCEDURE DBO.[Analytic_Update]
		@AnalyticId int, 
		@AnalyticTypeID int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@rawanalyticId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Analytic_hst (
			AnalyticId, AnalyticTypeID, InstrumentMarketId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, rawanalyticId, EndDt, LastActionUserID)
	SELECT	AnalyticId, AnalyticTypeID, InstrumentMarketId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, rawanalyticId, @StartDt, @UpdateUserID
	FROM	Analytic
	WHERE	AnalyticId = @AnalyticId

	UPDATE	Analytic
	SET		AnalyticTypeID = @AnalyticTypeID, InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID, rawanalyticId = @rawanalyticId,  StartDt = @StartDt
	WHERE	AnalyticId = @AnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Analytic
	WHERE	AnalyticId = @AnalyticId
	AND		@@ROWCOUNT > 0

GO
