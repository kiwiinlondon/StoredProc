USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExternalPerson_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExternalPerson_Delete]
GO

CREATE PROCEDURE DBO.[ExternalPerson_Delete]
		@ExternalPersonId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExternalPerson_hst (
			ExternalPersonId, Name, ExternalEntityId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExternalPersonId, Name, ExternalEntityId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExternalPerson
	WHERE	ExternalPersonId = @ExternalPersonId

	DELETE	ExternalPerson
	WHERE	ExternalPersonId = @ExternalPersonId
	AND		DataVersion = @DataVersion
GO
