USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputContainerType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputContainerType_Insert]
GO

CREATE PROCEDURE DBO.[ExtractOutputContainerType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractOutputContainerType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ExtractOutputContainerTypeID, StartDt, DataVersion
	FROM	ExtractOutputContainerType
	WHERE	ExtractOutputContainerTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
