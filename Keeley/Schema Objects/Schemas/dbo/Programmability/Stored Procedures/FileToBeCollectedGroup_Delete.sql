USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollectedGroup_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollectedGroup_Delete]
GO

CREATE PROCEDURE DBO.[FileToBeCollectedGroup_Delete]
		@FileToBeCollectedGroupId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileToBeCollectedGroup_hst (
			FileToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, FileGroupTypeId, Email, EndDt, LastActionUserID)
	SELECT	FileToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, FileGroupTypeId, Email, @EndDt, @UpdateUserID
	FROM	FileToBeCollectedGroup
	WHERE	FileToBeCollectedGroupId = @FileToBeCollectedGroupId

	DELETE	FileToBeCollectedGroup
	WHERE	FileToBeCollectedGroupId = @FileToBeCollectedGroupId
	AND		DataVersion = @DataVersion
GO
