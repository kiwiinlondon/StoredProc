USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Analytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Analytic_Delete]
GO

CREATE PROCEDURE DBO.[Analytic_Delete]
		@AnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Analytic_hst (
			AnalyticId, AnalyticTypeID, InstrumentMarketId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, rawanalyticId, EndDt, LastActionUserID)
	SELECT	AnalyticId, AnalyticTypeID, InstrumentMarketId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, rawanalyticId, @EndDt, @UpdateUserID
	FROM	Analytic
	WHERE	AnalyticId = @AnalyticId

	DELETE	Analytic
	WHERE	AnalyticId = @AnalyticId
	AND		DataVersion = @DataVersion
GO
