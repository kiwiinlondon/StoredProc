USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IdentifierType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IdentifierType_Delete]
GO

CREATE PROCEDURE DBO.[IdentifierType_Delete]
		@IdentifierTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IdentifierType_hst (
			IdentifierTypeID, FMIdentType, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IdentifierTypeID, FMIdentType, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	IdentifierType
	WHERE	IdentifierTypeID = @IdentifierTypeID

	DELETE	IdentifierType
	WHERE	IdentifierTypeID = @IdentifierTypeID
	AND		DataVersion = @DataVersion
GO
