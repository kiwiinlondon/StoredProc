USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileCollected_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileCollected_Update]
GO

CREATE PROCEDURE DBO.[FileCollected_Update]
		@FileCollectedId int, 
		@FileToBeCollectedId int, 
		@ResolvedFileName varchar(150), 
		@FileCreatedDate datetime, 
		@Processed bit, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FileHash varchar(64)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileCollected_hst (
			FileCollectedId, FileToBeCollectedId, ResolvedFileName, FileCreatedDate, Processed, StartDt, UpdateUserID, DataVersion, FileHash, EndDt, LastActionUserID)
	SELECT	FileCollectedId, FileToBeCollectedId, ResolvedFileName, FileCreatedDate, Processed, StartDt, UpdateUserID, DataVersion, FileHash, @StartDt, @UpdateUserID
	FROM	FileCollected
	WHERE	FileCollectedId = @FileCollectedId

	UPDATE	FileCollected
	SET		FileToBeCollectedId = @FileToBeCollectedId, ResolvedFileName = @ResolvedFileName, FileCreatedDate = @FileCreatedDate, Processed = @Processed, UpdateUserID = @UpdateUserID, FileHash = @FileHash,  StartDt = @StartDt
	WHERE	FileCollectedId = @FileCollectedId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileCollected
	WHERE	FileCollectedId = @FileCollectedId
	AND		@@ROWCOUNT > 0

GO
