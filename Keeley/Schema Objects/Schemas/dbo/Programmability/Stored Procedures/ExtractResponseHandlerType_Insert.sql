USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractResponseHandlerType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractResponseHandlerType_Insert]
GO

CREATE PROCEDURE DBO.[ExtractResponseHandlerType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractResponseHandlerType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ExtractResponseHandlerTypeId, StartDt, DataVersion
	FROM	ExtractResponseHandlerType
	WHERE	ExtractResponseHandlerTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
