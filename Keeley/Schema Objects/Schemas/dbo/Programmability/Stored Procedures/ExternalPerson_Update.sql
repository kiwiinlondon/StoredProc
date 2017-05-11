USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExternalPerson_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExternalPerson_Update]
GO

CREATE PROCEDURE DBO.[ExternalPerson_Update]
		@ExternalPersonId int, 
		@Name varchar(100), 
		@ExternalEntityId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExternalPerson_hst (
			ExternalPersonId, Name, ExternalEntityId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExternalPersonId, Name, ExternalEntityId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExternalPerson
	WHERE	ExternalPersonId = @ExternalPersonId

	UPDATE	ExternalPerson
	SET		Name = @Name, ExternalEntityId = @ExternalEntityId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExternalPersonId = @ExternalPersonId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExternalPerson
	WHERE	ExternalPersonId = @ExternalPersonId
	AND		@@ROWCOUNT > 0

GO
