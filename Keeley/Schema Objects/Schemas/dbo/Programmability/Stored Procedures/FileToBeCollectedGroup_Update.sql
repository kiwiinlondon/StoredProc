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
		@FileToBeCollectedGroupId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FileGroupTypeId int, 
		@Email varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileToBeCollectedGroup_hst (
			FileToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, FileGroupTypeId, Email, EndDt, LastActionUserID)
	SELECT	FileToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, FileGroupTypeId, Email, @StartDt, @UpdateUserID
	FROM	FileToBeCollectedGroup
	WHERE	FileToBeCollectedGroupId = @FileToBeCollectedGroupId

	UPDATE	FileToBeCollectedGroup
	SET		Name = @Name, UpdateUserID = @UpdateUserID, FileGroupTypeId = @FileGroupTypeId, Email = @Email,  StartDt = @StartDt
	WHERE	FileToBeCollectedGroupId = @FileToBeCollectedGroupId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileToBeCollectedGroup
	WHERE	FileToBeCollectedGroupId = @FileToBeCollectedGroupId
	AND		@@ROWCOUNT > 0

GO
