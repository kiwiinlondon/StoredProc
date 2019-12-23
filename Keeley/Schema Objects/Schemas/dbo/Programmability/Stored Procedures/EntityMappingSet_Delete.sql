USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMappingSet_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMappingSet_Delete]
GO

CREATE PROCEDURE DBO.[EntityMappingSet_Delete]
		@EntityMappingSetId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityMappingSet_hst (
			EntityMappingSetId, EntityTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityMappingSetId, EntityTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityMappingSet
	WHERE	EntityMappingSetId = @EntityMappingSetId

	DELETE	EntityMappingSet
	WHERE	EntityMappingSetId = @EntityMappingSetId
	AND		DataVersion = @DataVersion
GO
