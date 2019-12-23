USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileProcessingMethod_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileProcessingMethod_Update]
GO

CREATE PROCEDURE DBO.[FileProcessingMethod_Update]
		@FileProcessingMethodId int, 
		@Name varchar(70), 
		@FileTypeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileProcessingMethod_hst (
			FileProcessingMethodId, Name, FileTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileProcessingMethodId, Name, FileTypeId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileProcessingMethod
	WHERE	FileProcessingMethodId = @FileProcessingMethodId

	UPDATE	FileProcessingMethod
	SET		Name = @Name, FileTypeId = @FileTypeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FileProcessingMethodId = @FileProcessingMethodId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileProcessingMethod
	WHERE	FileProcessingMethodId = @FileProcessingMethodId
	AND		@@ROWCOUNT > 0

GO
