USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollected_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollected_Update]
GO

CREATE PROCEDURE DBO.[FileToBeCollected_Update]
		@FileToBeCollectedId int, 
		@Name varchar(70), 
		@FileCollectionTypeId int, 
		@FileCollectionTypeProfileName varchar(70), 
		@FileDestinationPath varchar(150), 
		@FileNameTemplate varchar(150), 
		@FileNameResolutionTypeId int, 
		@FileTypeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@EmailWhenReceived varchar(1000), 
		@FileToBeCollectedGroupId int, 
		@FundId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileToBeCollected_hst (
			FileToBeCollectedId, Name, FileCollectionTypeId, FileCollectionTypeProfileName, FileDestinationPath, FileNameTemplate, FileNameResolutionTypeId, FileTypeId, StartDt, UpdateUserID, DataVersion, EmailWhenReceived, FileToBeCollectedGroupId, FundId, EndDt, LastActionUserID)
	SELECT	FileToBeCollectedId, Name, FileCollectionTypeId, FileCollectionTypeProfileName, FileDestinationPath, FileNameTemplate, FileNameResolutionTypeId, FileTypeId, StartDt, UpdateUserID, DataVersion, EmailWhenReceived, FileToBeCollectedGroupId, FundId, @StartDt, @UpdateUserID
	FROM	FileToBeCollected
	WHERE	FileToBeCollectedId = @FileToBeCollectedId

	UPDATE	FileToBeCollected
	SET		Name = @Name, FileCollectionTypeId = @FileCollectionTypeId, FileCollectionTypeProfileName = @FileCollectionTypeProfileName, FileDestinationPath = @FileDestinationPath, FileNameTemplate = @FileNameTemplate, FileNameResolutionTypeId = @FileNameResolutionTypeId, FileTypeId = @FileTypeId, UpdateUserID = @UpdateUserID, EmailWhenReceived = @EmailWhenReceived, FileToBeCollectedGroupId = @FileToBeCollectedGroupId, FundId = @FundId,  StartDt = @StartDt
	WHERE	FileToBeCollectedId = @FileToBeCollectedId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileToBeCollected
	WHERE	FileToBeCollectedId = @FileToBeCollectedId
	AND		@@ROWCOUNT > 0

GO
