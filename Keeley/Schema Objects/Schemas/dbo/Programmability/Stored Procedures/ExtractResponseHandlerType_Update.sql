USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractResponseHandlerType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractResponseHandlerType_Update]
GO

CREATE PROCEDURE DBO.[ExtractResponseHandlerType_Update]
		@ExtractResponseHandlerTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractResponseHandlerType_hst (
			ExtractResponseHandlerTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractResponseHandlerTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractResponseHandlerType
	WHERE	ExtractResponseHandlerTypeId = @ExtractResponseHandlerTypeId

	UPDATE	ExtractResponseHandlerType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractResponseHandlerTypeId = @ExtractResponseHandlerTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractResponseHandlerType
	WHERE	ExtractResponseHandlerTypeId = @ExtractResponseHandlerTypeId
	AND		@@ROWCOUNT > 0

GO
