USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IdentifierType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IdentifierType_Insert]
GO

CREATE PROCEDURE DBO.[IdentifierType_Insert]
		@FMIdentType varchar(20), 
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IdentifierType
			(FMIdentType, Name, UpdateUserID, StartDt)
	VALUES
			(@FMIdentType, @Name, @UpdateUserID, @StartDt)

	SELECT	IdentifierTypeID, StartDt, DataVersion
	FROM	IdentifierType
	WHERE	IdentifierTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
