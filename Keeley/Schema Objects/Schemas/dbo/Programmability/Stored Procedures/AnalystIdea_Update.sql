USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalystIdea_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalystIdea_Update]
GO

CREATE PROCEDURE DBO.[AnalystIdea_Update]
		@AnalystIdeaId int, 
		@AnalystId int, 
		@ResearchNoteLastReceived datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IssuerId int, 
		@ExternalOriginatorId int, 
		@InternalOriginatorId int, 
		@InternalOriginatorId2 int, 
		@OriginatingDate datetime, 
		@IsOriginatedLong bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AnalystIdea_hst (
			AnalystIdeaId, AnalystId, ResearchNoteLastReceived, StartDt, UpdateUserID, DataVersion, IssuerId, ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, OriginatingDate, IsOriginatedLong, EndDt, LastActionUserID)
	SELECT	AnalystIdeaId, AnalystId, ResearchNoteLastReceived, StartDt, UpdateUserID, DataVersion, IssuerId, ExternalOriginatorId, InternalOriginatorId, InternalOriginatorId2, OriginatingDate, IsOriginatedLong, @StartDt, @UpdateUserID
	FROM	AnalystIdea
	WHERE	AnalystIdeaId = @AnalystIdeaId

	UPDATE	AnalystIdea
	SET		AnalystId = @AnalystId, ResearchNoteLastReceived = @ResearchNoteLastReceived, UpdateUserID = @UpdateUserID, IssuerId = @IssuerId, ExternalOriginatorId = @ExternalOriginatorId, InternalOriginatorId = @InternalOriginatorId, InternalOriginatorId2 = @InternalOriginatorId2, OriginatingDate = @OriginatingDate, IsOriginatedLong = @IsOriginatedLong,  StartDt = @StartDt
	WHERE	AnalystIdeaId = @AnalystIdeaId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AnalystIdea
	WHERE	AnalystIdeaId = @AnalystIdeaId
	AND		@@ROWCOUNT > 0

GO
