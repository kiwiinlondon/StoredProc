USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollected_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollected_Delete]
GO

CREATE PROCEDURE DBO.[FileToBeCollected_Delete]
		@FileToBeCollectedId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileToBeCollected_hst (
			FileToBeCollectedId, Name, FileCollectionTypeId, FileCollectionTypeProfileName, FileDestinationPath, FileNameTemplate, FileNameResolutionTypeId, FileTypeId, StartDt, UpdateUserID, DataVersion, EmailWhenReceived, FileToBeCollectedGroupId, FundId, DeleteFromServer, EndDt, LastActionUserID)
	SELECT	FileToBeCollectedId, Name, FileCollectionTypeId, FileCollectionTypeProfileName, FileDestinationPath, FileNameTemplate, FileNameResolutionTypeId, FileTypeId, StartDt, UpdateUserID, DataVersion, EmailWhenReceived, FileToBeCollectedGroupId, FundId, DeleteFromServer, @EndDt, @UpdateUserID
	FROM	FileToBeCollected
	WHERE	FileToBeCollectedId = @FileToBeCollectedId

	DELETE	FileToBeCollected
	WHERE	FileToBeCollectedId = @FileToBeCollectedId
	AND		DataVersion = @DataVersion
GO
