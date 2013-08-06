USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollectedGroup_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollectedGroup_Update]
GO

CREATE PROCEDURE DBO.[FileToBeCollectedGroup_Update]
		@FilesToBeCollectedGroupId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileToBeCollectedGroup_hst (
			FilesToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FilesToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileToBeCollectedGroup
	WHERE	FilesToBeCollectedGroupId = @FilesToBeCollectedGroupId

	UPDATE	FileToBeCollectedGroup
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FilesToBeCollectedGroupId = @FilesToBeCollectedGroupId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileToBeCollectedGroup
	WHERE	FilesToBeCollectedGroupId = @FilesToBeCollectedGroupId
	AND		@@ROWCOUNT > 0

GO
