USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalystIdea2_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalystIdea2_Delete]
GO

CREATE PROCEDURE DBO.[AnalystIdea2_Delete]
		@AnalystIdeaId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AnalystIdea2_hst (
			AnalystIdeaId, IssuerId, IsLong, EffectiveFromDate, EffectiveToDate, AnalystId, OriginatiorId, FocusListId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AnalystIdeaId, IssuerId, IsLong, EffectiveFromDate, EffectiveToDate, AnalystId, OriginatiorId, FocusListId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AnalystIdea2
	WHERE	AnalystIdeaId = @AnalystIdeaId

	DELETE	AnalystIdea2
	WHERE	AnalystIdeaId = @AnalystIdeaId
	AND		DataVersion = @DataVersion
GO
