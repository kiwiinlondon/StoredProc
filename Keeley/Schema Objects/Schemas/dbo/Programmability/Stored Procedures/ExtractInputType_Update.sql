USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractInputType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractInputType_Update]
GO

CREATE PROCEDURE DBO.[ExtractInputType_Update]
		@ExtractInputTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractInputType_hst (
			ExtractInputTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractInputTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractInputType
	WHERE	ExtractInputTypeID = @ExtractInputTypeID

	UPDATE	ExtractInputType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractInputTypeID = @ExtractInputTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractInputType
	WHERE	ExtractInputTypeID = @ExtractInputTypeID
	AND		@@ROWCOUNT > 0

GO
