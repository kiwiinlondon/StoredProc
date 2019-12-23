USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileExtension_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileExtension_Update]
GO

CREATE PROCEDURE DBO.[FileExtension_Update]
		@FileExtensionTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileExtension_hst (
			FileExtensionTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileExtensionTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileExtension
	WHERE	FileExtensionTypeId = @FileExtensionTypeId

	UPDATE	FileExtension
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FileExtensionTypeId = @FileExtensionTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileExtension
	WHERE	FileExtensionTypeId = @FileExtensionTypeId
	AND		@@ROWCOUNT > 0

GO
