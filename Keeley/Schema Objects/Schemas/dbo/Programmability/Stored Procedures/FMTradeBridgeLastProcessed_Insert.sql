USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMTradeBridgeLastProcessed_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMTradeBridgeLastProcessed_Insert]
GO

CREATE PROCEDURE DBO.[FMTradeBridgeLastProcessed_Insert]
		@LastContEventId int, 
		@MaxInputDate datetime, 
		@IsTrade bit, 
		@LastProcessedTime datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FMTradeBridgeLastProcessed
			(LastContEventId, MaxInputDate, IsTrade, LastProcessedTime, StartDt)
	VALUES
			(@LastContEventId, @MaxInputDate, @IsTrade, @LastProcessedTime, @StartDt)

	SELECT	FMTradeBridgeLastProcessedId, StartDt, DataVersion
	FROM	FMTradeBridgeLastProcessed
	WHERE	FMTradeBridgeLastProcessedId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
