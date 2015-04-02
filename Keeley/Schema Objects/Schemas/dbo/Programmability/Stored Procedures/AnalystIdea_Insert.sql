USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalystIdea_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalystIdea_Insert]
GO

CREATE PROCEDURE DBO.[AnalystIdea_Insert]
		@InstrumentMarketId int, 
		@AnalystId int, 
		@ResearchNoteLastReceived datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AnalystIdea
			(InstrumentMarketId, AnalystId, ResearchNoteLastReceived, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @AnalystId, @ResearchNoteLastReceived, @UpdateUserID, @StartDt)

	SELECT	AnalystIdeaId, StartDt, DataVersion
	FROM	AnalystIdea
	WHERE	AnalystIdeaId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
