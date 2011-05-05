USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityProperty_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityProperty_Update]
GO

CREATE PROCEDURE DBO.[EntityProperty_Update]
		@EntityPropertyID int, 
		@EntityTypeId int, 
		@NeedsToBeCalculated bit, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@PropertyOnChildEntity bit, 
		@TypeCode int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityProperty_hst (
			EntityPropertyID, EntityTypeId, NeedsToBeCalculated, Name, StartDt, UpdateUserID, DataVersion, PropertyOnChildEntity, TypeCode, EndDt, LastActionUserID)
	SELECT	EntityPropertyID, EntityTypeId, NeedsToBeCalculated, Name, StartDt, UpdateUserID, DataVersion, PropertyOnChildEntity, TypeCode, @StartDt, @UpdateUserID
	FROM	EntityProperty
	WHERE	EntityPropertyID = @EntityPropertyID

	UPDATE	EntityProperty
	SET		EntityTypeId = @EntityTypeId, NeedsToBeCalculated = @NeedsToBeCalculated, Name = @Name, UpdateUserID = @UpdateUserID, PropertyOnChildEntity = @PropertyOnChildEntity, TypeCode = @TypeCode,  StartDt = @StartDt
	WHERE	EntityPropertyID = @EntityPropertyID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityProperty
	WHERE	EntityPropertyID = @EntityPropertyID
	AND		@@ROWCOUNT > 0

GO
