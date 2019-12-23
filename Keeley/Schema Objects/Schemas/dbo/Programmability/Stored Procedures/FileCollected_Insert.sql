USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileCollected_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileCollected_Insert]
GO

CREATE PROCEDURE DBO.[FileCollected_Insert]
		@FileToBeCollectedId int, 
		@ResolvedFileName varchar(150), 
		@FileCreatedDate datetime, 
		@Processed bit, 
		@UpdateUserID int, 
		@FileHash varchar(64)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FileCollected
			(FileToBeCollectedId, ResolvedFileName, FileCreatedDate, Processed, UpdateUserID, FileHash, StartDt)
	VALUES
			(@FileToBeCollectedId, @ResolvedFileName, @FileCreatedDate, @Processed, @UpdateUserID, @FileHash, @StartDt)

	SELECT	FileCollectedId, StartDt, DataVersion
	FROM	FileCollected
	WHERE	FileCollectedId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
