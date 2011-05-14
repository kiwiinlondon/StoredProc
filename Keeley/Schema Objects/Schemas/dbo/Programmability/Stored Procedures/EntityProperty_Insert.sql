USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityProperty_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityProperty_Insert]
GO

CREATE PROCEDURE DBO.[EntityProperty_Insert]
		@EntityTypeId int, 
		@NeedsToBeCalculated bit, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@PropertyOnChildEntity bit, 
		@TypeCode int, 
		@IdentifierTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityProperty
			(EntityTypeId, NeedsToBeCalculated, Name, UpdateUserID, PropertyOnChildEntity, TypeCode, IdentifierTypeId, StartDt)
	VALUES
			(@EntityTypeId, @NeedsToBeCalculated, @Name, @UpdateUserID, @PropertyOnChildEntity, @TypeCode, @IdentifierTypeId, @StartDt)

	SELECT	EntityPropertyID, StartDt, DataVersion
	FROM	EntityProperty
	WHERE	EntityPropertyID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
