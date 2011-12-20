USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMappingSet_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMappingSet_Update]
GO

CREATE PROCEDURE DBO.[EntityMappingSet_Update]
		@EntityMappingSetId int, 
		@EntityTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityMappingSet_hst (
			EntityMappingSetId, EntityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityMappingSetId, EntityTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityMappingSet
	WHERE	EntityMappingSetId = @EntityMappingSetId

	UPDATE	EntityMappingSet
	SET		EntityTypeId = @EntityTypeId, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityMappingSetId = @EntityMappingSetId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityMappingSet
	WHERE	EntityMappingSetId = @EntityMappingSetId
	AND		@@ROWCOUNT > 0

GO
