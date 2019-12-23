USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AnalystIdea2_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AnalystIdea2_Insert]
GO

CREATE PROCEDURE DBO.[AnalystIdea2_Insert]
		@IssuerId int, 
		@IsLong bit, 
		@EffectiveFromDate datetime, 
		@EffectiveToDate datetime, 
		@AnalystId int, 
		@OriginatiorId int, 
		@FocusListId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AnalystIdea2
			(IssuerId, IsLong, EffectiveFromDate, EffectiveToDate, AnalystId, OriginatiorId, FocusListId, UpdateUserID, StartDt)
	VALUES
			(@IssuerId, @IsLong, @EffectiveFromDate, @EffectiveToDate, @AnalystId, @OriginatiorId, @FocusListId, @UpdateUserID, @StartDt)

	SELECT	AnalystIdeaId, StartDt, DataVersion
	FROM	AnalystIdea2
	WHERE	AnalystIdeaId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
