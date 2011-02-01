USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IdentifierType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IdentifierType_Update]
GO

CREATE PROCEDURE DBO.[IdentifierType_Update]
		@IdentifierTypeID int, 
		@FMIdentTypeId varchar(20), 
		@Name varchar(100), 
		@KeeleyTypeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IdentifierType_hst (
			IdentifierTypeID, FMIdentTypeId, Name, KeeleyTypeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IdentifierTypeID, FMIdentTypeId, Name, KeeleyTypeId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IdentifierType
	WHERE	IdentifierTypeID = @IdentifierTypeID

	UPDATE	IdentifierType
	SET		FMIdentTypeId = @FMIdentTypeId, Name = @Name, KeeleyTypeId = @KeeleyTypeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IdentifierTypeID = @IdentifierTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IdentifierType
	WHERE	IdentifierTypeID = @IdentifierTypeID
	AND		@@ROWCOUNT > 0

GO
