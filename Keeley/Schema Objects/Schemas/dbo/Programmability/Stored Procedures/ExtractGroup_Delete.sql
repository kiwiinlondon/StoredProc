USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractGroup_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractGroup_Delete]
GO

CREATE PROCEDURE DBO.[ExtractGroup_Delete]
		@ExtractGroupId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractGroup_hst (
			ExtractGroupId, ExtractRunnerTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractGroupId, ExtractRunnerTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractGroup
	WHERE	ExtractGroupId = @ExtractGroupId

	DELETE	ExtractGroup
	WHERE	ExtractGroupId = @ExtractGroupId
	AND		DataVersion = @DataVersion
GO
