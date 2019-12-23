USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputType_Insert]
GO

CREATE PROCEDURE DBO.[ExtractOutputType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractOutputType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ExtractOutputTypeID, StartDt, DataVersion
	FROM	ExtractOutputType
	WHERE	ExtractOutputTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
