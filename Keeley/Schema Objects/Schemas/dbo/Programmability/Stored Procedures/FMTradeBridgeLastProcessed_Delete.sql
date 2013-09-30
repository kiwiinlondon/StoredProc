USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMTradeBridgeLastProcessed_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMTradeBridgeLastProcessed_Delete]
GO

CREATE PROCEDURE DBO.[FMTradeBridgeLastProcessed_Delete]
		@FMTradeBridgeLastProcessedId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FMTradeBridgeLastProcessed_hst (
			FMTradeBridgeLastProcessedId, LastContEventId, MaxInputDate, DataVersion, IsTrade, LastProcessedTime, EndDt, LastActionUserID)
	SELECT	FMTradeBridgeLastProcessedId, LastContEventId, MaxInputDate, DataVersion, IsTrade, LastProcessedTime, @EndDt, @UpdateUserID
	FROM	FMTradeBridgeLastProcessed
	WHERE	FMTradeBridgeLastProcessedId = @FMTradeBridgeLastProcessedId

	DELETE	FMTradeBridgeLastProcessed
	WHERE	FMTradeBridgeLastProcessedId = @FMTradeBridgeLastProcessedId
	AND		DataVersion = @DataVersion
GO
