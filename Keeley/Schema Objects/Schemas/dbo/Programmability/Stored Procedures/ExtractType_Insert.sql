USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractType_Insert]
GO

CREATE PROCEDURE DBO.[ExtractType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ExtractTypeID, StartDt, DataVersion
	FROM	ExtractType
	WHERE	ExtractTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
