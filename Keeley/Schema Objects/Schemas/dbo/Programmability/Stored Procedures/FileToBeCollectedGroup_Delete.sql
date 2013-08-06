USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FileToBeCollectedGroup_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FileToBeCollectedGroup_Delete]
GO

CREATE PROCEDURE DBO.[FileToBeCollectedGroup_Delete]
		@FilesToBeCollectedGroupId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FileToBeCollectedGroup_hst (
			FilesToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FilesToBeCollectedGroupId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FileToBeCollectedGroup
	WHERE	FilesToBeCollectedGroupId = @FilesToBeCollectedGroupId

	DELETE	FileToBeCollectedGroup
	WHERE	FilesToBeCollectedGroupId = @FilesToBeCollectedGroupId
	AND		DataVersion = @DataVersion
GO
