USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileCollectionType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileCollectionType_Update]
GO

CREATE PROCEDURE DBO.[FileCollectionType_Update]
		@FileCollectionTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileCollectionType_hst (
			FileCollectionTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileCollectionTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileCollectionType
	WHERE	FileCollectionTypeId = @FileCollectionTypeId

	UPDATE	FileCollectionType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FileCollectionTypeId = @FileCollectionTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileCollectionType
	WHERE	FileCollectionTypeId = @FileCollectionTypeId
	AND		@@ROWCOUNT > 0

GO
