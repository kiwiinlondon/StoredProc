USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExternalPerson_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExternalPerson_Insert]
GO

CREATE PROCEDURE DBO.[ExternalPerson_Insert]
		@Name varchar(100), 
		@ExternalEntityId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExternalPerson
			(Name, ExternalEntityId, UpdateUserID, StartDt)
	VALUES
			(@Name, @ExternalEntityId, @UpdateUserID, @StartDt)

	SELECT	ExternalPersonId, StartDt, DataVersion
	FROM	ExternalPerson
	WHERE	ExternalPersonId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
