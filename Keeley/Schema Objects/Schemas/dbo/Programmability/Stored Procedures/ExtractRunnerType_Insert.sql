USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractRunnerType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractRunnerType_Insert]
GO

CREATE PROCEDURE DBO.[ExtractRunnerType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractRunnerType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ExtractRunnerTypeID, StartDt, DataVersion
	FROM	ExtractRunnerType
	WHERE	ExtractRunnerTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
