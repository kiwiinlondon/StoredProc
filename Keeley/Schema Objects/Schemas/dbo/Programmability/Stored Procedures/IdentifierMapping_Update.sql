USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IdentifierMapping_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IdentifierMapping_Update]
GO

CREATE PROCEDURE DBO.[IdentifierMapping_Update]
		@IdentifierMappingId int, 
		@IdentifierTypeId int, 
		@OriginalValue varchar(200), 
		@MappedValue varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IdentifierMapping_hst (
			IdentifierMappingId, IdentifierTypeId, OriginalValue, MappedValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IdentifierMappingId, IdentifierTypeId, OriginalValue, MappedValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IdentifierMapping
	WHERE	IdentifierMappingId = @IdentifierMappingId

	UPDATE	IdentifierMapping
	SET		IdentifierTypeId = @IdentifierTypeId, OriginalValue = @OriginalValue, MappedValue = @MappedValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IdentifierMappingId = @IdentifierMappingId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IdentifierMapping
	WHERE	IdentifierMappingId = @IdentifierMappingId
	AND		@@ROWCOUNT > 0

GO
