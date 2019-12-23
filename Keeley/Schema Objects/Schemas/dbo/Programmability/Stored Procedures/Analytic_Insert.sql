USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Analytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Analytic_Insert]
GO

CREATE PROCEDURE DBO.[Analytic_Insert]
		@AnalyticTypeID int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@rawanalyticId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Analytic
			(AnalyticTypeID, InstrumentMarketId, ReferenceDate, Value, UpdateUserID, rawanalyticId, StartDt)
	VALUES
			(@AnalyticTypeID, @InstrumentMarketId, @ReferenceDate, @Value, @UpdateUserID, @rawanalyticId, @StartDt)

	SELECT	AnalyticId, StartDt, DataVersion
	FROM	Analytic
	WHERE	AnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
