USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileCollectionType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileCollectionType_Delete]
GO

CREATE PROCEDURE DBO.[FileCollectionType_Delete]
		@FileCollectionTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileCollectionType_hst (
			FileCollectionTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileCollectionTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileCollectionType
	WHERE	FileCollectionTypeId = @FileCollectionTypeId

	DELETE	FileCollectionType
	WHERE	FileCollectionTypeId = @FileCollectionTypeId
	AND		DataVersion = @DataVersion
GO
