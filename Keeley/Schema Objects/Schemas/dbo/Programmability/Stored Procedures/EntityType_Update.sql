USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityType_Update]
GO

CREATE PROCEDURE DBO.[EntityType_Update]
		@EntityTypeID int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@FullyQualifiedName varchar(500)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityType_hst (
			EntityTypeID, Name, StartDt, UpdateUserID, DataVersion, FullyQualifiedName, EndDt, LastActionUserID)
	SELECT	EntityTypeID, Name, StartDt, UpdateUserID, DataVersion, FullyQualifiedName, @StartDt, @UpdateUserID
	FROM	EntityType
	WHERE	EntityTypeID = @EntityTypeID

	UPDATE	EntityType
	SET		Name = @Name, UpdateUserID = @UpdateUserID, FullyQualifiedName = @FullyQualifiedName,  StartDt = @StartDt
	WHERE	EntityTypeID = @EntityTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityType
	WHERE	EntityTypeID = @EntityTypeID
	AND		@@ROWCOUNT > 0

GO
