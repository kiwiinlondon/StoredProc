USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractType_Update]
GO

CREATE PROCEDURE DBO.[ExtractType_Update]
		@ExtractTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractType_hst (
			ExtractTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractType
	WHERE	ExtractTypeID = @ExtractTypeID

	UPDATE	ExtractType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractTypeID = @ExtractTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractType
	WHERE	ExtractTypeID = @ExtractTypeID
	AND		@@ROWCOUNT > 0

GO
