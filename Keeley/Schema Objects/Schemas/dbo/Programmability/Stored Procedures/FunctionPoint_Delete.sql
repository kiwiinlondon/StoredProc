USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FunctionPoint_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FunctionPoint_Delete]
GO

CREATE PROCEDURE DBO.[FunctionPoint_Delete]
		@FunctionPointId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FunctionPoint_hst (
			FunctionPointId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FunctionPointId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FunctionPoint
	WHERE	FunctionPointId = @FunctionPointId

	DELETE	FunctionPoint
	WHERE	FunctionPointId = @FunctionPointId
	AND		DataVersion = @DataVersion
GO
