USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FunctionPoint_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FunctionPoint_Update]
GO

CREATE PROCEDURE DBO.[FunctionPoint_Update]
		@FunctionPointId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FunctionPoint_hst (
			FunctionPointId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FunctionPointId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FunctionPoint
	WHERE	FunctionPointId = @FunctionPointId

	UPDATE	FunctionPoint
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FunctionPointId = @FunctionPointId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FunctionPoint
	WHERE	FunctionPointId = @FunctionPointId
	AND		@@ROWCOUNT > 0

GO
