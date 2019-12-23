USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractGroup_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractGroup_Update]
GO

CREATE PROCEDURE DBO.[ExtractGroup_Update]
		@ExtractGroupId int, 
		@ExtractRunnerTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractGroup_hst (
			ExtractGroupId, ExtractRunnerTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractGroupId, ExtractRunnerTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractGroup
	WHERE	ExtractGroupId = @ExtractGroupId

	UPDATE	ExtractGroup
	SET		ExtractRunnerTypeId = @ExtractRunnerTypeId, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractGroupId = @ExtractGroupId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractGroup
	WHERE	ExtractGroupId = @ExtractGroupId
	AND		@@ROWCOUNT > 0

GO
