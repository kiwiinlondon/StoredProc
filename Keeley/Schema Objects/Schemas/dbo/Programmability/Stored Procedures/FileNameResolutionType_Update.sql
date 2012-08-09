USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileNameResolutionType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileNameResolutionType_Update]
GO

CREATE PROCEDURE DBO.[FileNameResolutionType_Update]
		@FileNameResolutionTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileNameResolutionType_hst (
			FileNameResolutionTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileNameResolutionTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileNameResolutionType
	WHERE	FileNameResolutionTypeId = @FileNameResolutionTypeId

	UPDATE	FileNameResolutionType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FileNameResolutionTypeId = @FileNameResolutionTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileNameResolutionType
	WHERE	FileNameResolutionTypeId = @FileNameResolutionTypeId
	AND		@@ROWCOUNT > 0

GO
