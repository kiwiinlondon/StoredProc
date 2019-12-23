USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileProcessingMethod_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileProcessingMethod_Delete]
GO

CREATE PROCEDURE DBO.[FileProcessingMethod_Delete]
		@FileProcessingMethodId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileProcessingMethod_hst (
			FileProcessingMethodId, Name, FileTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileProcessingMethodId, Name, FileTypeId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileProcessingMethod
	WHERE	FileProcessingMethodId = @FileProcessingMethodId

	DELETE	FileProcessingMethod
	WHERE	FileProcessingMethodId = @FileProcessingMethodId
	AND		DataVersion = @DataVersion
GO
