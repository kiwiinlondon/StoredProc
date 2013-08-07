USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileGroupType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileGroupType_Update]
GO

CREATE PROCEDURE DBO.[FileGroupType_Update]
		@FileGroupTypeId int, 
		@Name varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FileGroupType_hst (
			FileGroupTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileGroupTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FileGroupType
	WHERE	FileGroupTypeId = @FileGroupTypeId

	UPDATE	FileGroupType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FileGroupTypeId = @FileGroupTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FileGroupType
	WHERE	FileGroupTypeId = @FileGroupTypeId
	AND		@@ROWCOUNT > 0

GO
