USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEvent_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEvent_Update]
GO

CREATE PROCEDURE DBO.[ExtractEvent_Update]
		@ExtractEventID int, 
		@ExtractId int, 
		@EventId int, 
		@LastSentInExtractRunId int, 
		@SendInNextRun bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEvent_hst (
			ExtractEventID, ExtractId, EventId, LastSentInExtractRunId, SendInNextRun, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEventID, ExtractId, EventId, LastSentInExtractRunId, SendInNextRun, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractEvent
	WHERE	ExtractEventID = @ExtractEventID

	UPDATE	ExtractEvent
	SET		ExtractId = @ExtractId, EventId = @EventId, LastSentInExtractRunId = @LastSentInExtractRunId, SendInNextRun = @SendInNextRun, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractEventID = @ExtractEventID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEvent
	WHERE	ExtractEventID = @ExtractEventID
	AND		@@ROWCOUNT > 0

GO
