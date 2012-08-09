USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileCollected_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileCollected_Delete]
GO

CREATE PROCEDURE DBO.[FileCollected_Delete]
		@FileCollectedId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileCollected_hst (
			FileCollectedId, FileToBeCollectedId, IsLast, ResolvedFileName, FileCreatedDate, Processed, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileCollectedId, FileToBeCollectedId, IsLast, ResolvedFileName, FileCreatedDate, Processed, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileCollected
	WHERE	FileCollectedId = @FileCollectedId

	DELETE	FileCollected
	WHERE	FileCollectedId = @FileCollectedId
	AND		DataVersion = @DataVersion
GO
