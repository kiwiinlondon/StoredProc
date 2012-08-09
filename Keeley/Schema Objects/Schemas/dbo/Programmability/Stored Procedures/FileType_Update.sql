USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileType_Update]
GO

CREATE PROCEDURE DBO.[FileType_Update]
		@FileTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileType_hst (
			FileTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileType
	WHERE	FileTypeId = @FileTypeId

	UPDATE	FileType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FileTypeId = @FileTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileType
	WHERE	FileTypeId = @FileTypeId
	AND		@@ROWCOUNT > 0

GO
