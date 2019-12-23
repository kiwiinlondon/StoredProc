USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileExtension_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileExtension_Delete]
GO

CREATE PROCEDURE DBO.[FileExtension_Delete]
		@FileExtensionTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileExtension_hst (
			FileExtensionTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileExtensionTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileExtension
	WHERE	FileExtensionTypeId = @FileExtensionTypeId

	DELETE	FileExtension
	WHERE	FileExtensionTypeId = @FileExtensionTypeId
	AND		DataVersion = @DataVersion
GO
