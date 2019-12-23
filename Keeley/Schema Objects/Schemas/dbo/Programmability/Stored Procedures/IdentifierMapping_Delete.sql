USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IdentifierMapping_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IdentifierMapping_Delete]
GO

CREATE PROCEDURE DBO.[IdentifierMapping_Delete]
		@IdentifierMappingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IdentifierMapping_hst (
			IdentifierMappingId, IdentifierTypeId, OriginalValue, MappedValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IdentifierMappingId, IdentifierTypeId, OriginalValue, MappedValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	IdentifierMapping
	WHERE	IdentifierMappingId = @IdentifierMappingId

	DELETE	IdentifierMapping
	WHERE	IdentifierMappingId = @IdentifierMappingId
	AND		DataVersion = @DataVersion
GO
