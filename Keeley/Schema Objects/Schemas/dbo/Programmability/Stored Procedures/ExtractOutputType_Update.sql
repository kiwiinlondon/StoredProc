USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputType_Update]
GO

CREATE PROCEDURE DBO.[ExtractOutputType_Update]
		@ExtractOutputTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractOutputType_hst (
			ExtractOutputTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractOutputTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractOutputType
	WHERE	ExtractOutputTypeID = @ExtractOutputTypeID

	UPDATE	ExtractOutputType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractOutputTypeID = @ExtractOutputTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractOutputType
	WHERE	ExtractOutputTypeID = @ExtractOutputTypeID
	AND		@@ROWCOUNT > 0

GO
