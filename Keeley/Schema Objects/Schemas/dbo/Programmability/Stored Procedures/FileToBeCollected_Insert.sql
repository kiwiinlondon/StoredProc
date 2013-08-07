USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollected_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollected_Insert]
GO

CREATE PROCEDURE DBO.[FileToBeCollected_Insert]
		@Name varchar(70), 
		@FileCollectionTypeId int, 
		@FileCollectionTypeProfileName varchar(70), 
		@FileDestinationPath varchar(150), 
		@FileNameTemplate varchar(150), 
		@FileNameResolutionTypeId int, 
		@FileTypeId int, 
		@UpdateUserID int, 
		@EmailWhenReceived varchar(1000), 
		@FileToBeCollectedGroupId int, 
		@FundId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileToBeCollected
			(Name, FileCollectionTypeId, FileCollectionTypeProfileName, FileDestinationPath, FileNameTemplate, FileNameResolutionTypeId, FileTypeId, UpdateUserID, EmailWhenReceived, FileToBeCollectedGroupId, FundId, StartDt)
	VALUES
			(@Name, @FileCollectionTypeId, @FileCollectionTypeProfileName, @FileDestinationPath, @FileNameTemplate, @FileNameResolutionTypeId, @FileTypeId, @UpdateUserID, @EmailWhenReceived, @FileToBeCollectedGroupId, @FundId, @StartDt)

	SELECT	FileToBeCollectedId, StartDt, DataVersion
	FROM	FileToBeCollected
	WHERE	FileToBeCollectedId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
