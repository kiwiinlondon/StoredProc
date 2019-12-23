USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalystIdea2_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalystIdea2_Update]
GO

CREATE PROCEDURE DBO.[AnalystIdea2_Update]
		@AnalystIdeaId int, 
		@IssuerId int, 
		@IsLong bit, 
		@EffectiveFromDate datetime, 
		@EffectiveToDate datetime, 
		@AnalystId int, 
		@OriginatiorId int, 
		@FocusListId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AnalystIdea2_hst (
			AnalystIdeaId, IssuerId, IsLong, EffectiveFromDate, EffectiveToDate, AnalystId, OriginatiorId, FocusListId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AnalystIdeaId, IssuerId, IsLong, EffectiveFromDate, EffectiveToDate, AnalystId, OriginatiorId, FocusListId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AnalystIdea2
	WHERE	AnalystIdeaId = @AnalystIdeaId

	UPDATE	AnalystIdea2
	SET		IssuerId = @IssuerId, IsLong = @IsLong, EffectiveFromDate = @EffectiveFromDate, EffectiveToDate = @EffectiveToDate, AnalystId = @AnalystId, OriginatiorId = @OriginatiorId, FocusListId = @FocusListId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AnalystIdeaId = @AnalystIdeaId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AnalystIdea2
	WHERE	AnalystIdeaId = @AnalystIdeaId
	AND		@@ROWCOUNT > 0

GO
