USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMTradeBridgeLastProcessed_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMTradeBridgeLastProcessed_Update]
GO

CREATE PROCEDURE DBO.[FMTradeBridgeLastProcessed_Update]
		@FMTradeBridgeLastProcessedId int, 
		@LastContEventId int, 
		@MaxInputDate datetime, 
		@DataVersion rowversion, 
		@IsTrade bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FMTradeBridgeLastProcessed_hst (
			FMTradeBridgeLastProcessedId, LastContEventId, MaxInputDate, DataVersion, IsTrade, EndDt, LastActionUserID)
	SELECT	FMTradeBridgeLastProcessedId, LastContEventId, MaxInputDate, DataVersion, IsTrade, @StartDt, @UpdateUserID
	FROM	FMTradeBridgeLastProcessed
	WHERE	FMTradeBridgeLastProcessedId = @FMTradeBridgeLastProcessedId

	UPDATE	FMTradeBridgeLastProcessed
	SET		LastContEventId = @LastContEventId, MaxInputDate = @MaxInputDate, IsTrade = @IsTrade,  StartDt = @StartDt
	WHERE	FMTradeBridgeLastProcessedId = @FMTradeBridgeLastProcessedId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FMTradeBridgeLastProcessed
	WHERE	FMTradeBridgeLastProcessedId = @FMTradeBridgeLastProcessedId
	AND		@@ROWCOUNT > 0

GO
