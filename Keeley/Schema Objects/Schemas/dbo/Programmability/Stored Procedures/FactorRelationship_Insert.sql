USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorRelationship_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorRelationship_Insert]
GO

CREATE PROCEDURE DBO.[FactorRelationship_Insert]
		@FactorHierarchyId int, 
		@FactorName varchar(256), 
		@BloombergFactorName varchar(256), 
		@ParentFactorRelationshipId int, 
		@EntityTypeId int, 
		@EntityId int, 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FactorRelationship
			(FactorHierarchyId, FactorName, BloombergFactorName, ParentFactorRelationshipId, EntityTypeId, EntityId, UpdateUserId, StartDt)
	VALUES
			(@FactorHierarchyId, @FactorName, @BloombergFactorName, @ParentFactorRelationshipId, @EntityTypeId, @EntityId, @UpdateUserId, @StartDt)

	SELECT	FactorRelationshipId, StartDt, DataVersion
	FROM	FactorRelationship
	WHERE	FactorRelationshipId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
