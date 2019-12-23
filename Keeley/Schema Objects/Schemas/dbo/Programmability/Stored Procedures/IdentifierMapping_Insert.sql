USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IdentifierMapping_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IdentifierMapping_Insert]
GO

CREATE PROCEDURE DBO.[IdentifierMapping_Insert]
		@IdentifierTypeId int, 
		@OriginalValue varchar(200), 
		@MappedValue varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IdentifierMapping
			(IdentifierTypeId, OriginalValue, MappedValue, UpdateUserID, StartDt)
	VALUES
			(@IdentifierTypeId, @OriginalValue, @MappedValue, @UpdateUserID, @StartDt)

	SELECT	IdentifierMappingId, StartDt, DataVersion
	FROM	IdentifierMapping
	WHERE	IdentifierMappingId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
