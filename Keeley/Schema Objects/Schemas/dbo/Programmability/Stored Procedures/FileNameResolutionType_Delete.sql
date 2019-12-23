USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileNameResolutionType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileNameResolutionType_Delete]
GO

CREATE PROCEDURE DBO.[FileNameResolutionType_Delete]
		@FileNameResolutionTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileNameResolutionType_hst (
			FileNameResolutionTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileNameResolutionTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileNameResolutionType
	WHERE	FileNameResolutionTypeId = @FileNameResolutionTypeId

	DELETE	FileNameResolutionType
	WHERE	FileNameResolutionTypeId = @FileNameResolutionTypeId
	AND		DataVersion = @DataVersion
GO
