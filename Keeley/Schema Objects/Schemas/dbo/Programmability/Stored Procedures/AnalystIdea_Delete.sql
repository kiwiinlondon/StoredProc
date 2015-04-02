USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalystIdea_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalystIdea_Delete]
GO

CREATE PROCEDURE DBO.[AnalystIdea_Delete]
		@AnalystIdeaId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AnalystIdea_hst (
			AnalystIdeaId, InstrumentMarketId, AnalystId, ResearchNoteLastReceived, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AnalystIdeaId, InstrumentMarketId, AnalystId, ResearchNoteLastReceived, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AnalystIdea
	WHERE	AnalystIdeaId = @AnalystIdeaId

	DELETE	AnalystIdea
	WHERE	AnalystIdeaId = @AnalystIdeaId
	AND		DataVersion = @DataVersion
GO
