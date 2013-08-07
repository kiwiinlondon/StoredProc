USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileGroupType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileGroupType_Delete]
GO

CREATE PROCEDURE DBO.[FileGroupType_Delete]
		@FileGroupTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileGroupType_hst (
			FileGroupTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FileGroupTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileGroupType
	WHERE	FileGroupTypeId = @FileGroupTypeId

	DELETE	FileGroupType
	WHERE	FileGroupTypeId = @FileGroupTypeId
	AND		DataVersion = @DataVersion
GO
