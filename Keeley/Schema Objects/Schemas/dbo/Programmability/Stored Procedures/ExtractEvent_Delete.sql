USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEvent_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEvent_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEvent_Delete]
		@ExtractEventID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEvent_hst (
			ExtractEventID, ExtractId, EventId, LastSentInExtractRunId, SendInNextRun, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEventID, ExtractId, EventId, LastSentInExtractRunId, SendInNextRun, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEvent
	WHERE	ExtractEventID = @ExtractEventID

	DELETE	ExtractEvent
	WHERE	ExtractEventID = @ExtractEventID
	AND		DataVersion = @DataVersion
GO
