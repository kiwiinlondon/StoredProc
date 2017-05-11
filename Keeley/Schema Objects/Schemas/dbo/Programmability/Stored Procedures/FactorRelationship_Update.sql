USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorRelationship_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorRelationship_Update]
GO

CREATE PROCEDURE DBO.[FactorRelationship_Update]
		@FactorRelationshipId int, 
		@FactorHierarchyId int, 
		@FactorName varchar(256), 
		@BloombergFactorName varchar(256), 
		@ParentFactorRelationshipId int, 
		@EntityTypeId int, 
		@EntityId int, 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FactorRelationship_hst (
			FactorRelationshipId, FactorHierarchyId, FactorName, BloombergFactorName, ParentFactorRelationshipId, EntityTypeId, EntityId, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorRelationshipId, FactorHierarchyId, FactorName, BloombergFactorName, ParentFactorRelationshipId, EntityTypeId, EntityId, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	FactorRelationship
	WHERE	FactorRelationshipId = @FactorRelationshipId

	UPDATE	FactorRelationship
	SET		FactorHierarchyId = @FactorHierarchyId, FactorName = @FactorName, BloombergFactorName = @BloombergFactorName, ParentFactorRelationshipId = @ParentFactorRelationshipId, EntityTypeId = @EntityTypeId, EntityId = @EntityId, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	FactorRelationshipId = @FactorRelationshipId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FactorRelationship
	WHERE	FactorRelationshipId = @FactorRelationshipId
	AND		@@ROWCOUNT > 0

GO
