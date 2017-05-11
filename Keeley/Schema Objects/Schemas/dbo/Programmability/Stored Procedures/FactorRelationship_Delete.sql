USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorRelationship_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorRelationship_Delete]
GO

CREATE PROCEDURE DBO.[FactorRelationship_Delete]
		@FactorRelationshipId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FactorRelationship_hst (
			FactorRelationshipId, FactorHierarchyId, FactorName, BloombergFactorName, ParentFactorRelationshipId, EntityTypeId, EntityId, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorRelationshipId, FactorHierarchyId, FactorName, BloombergFactorName, ParentFactorRelationshipId, EntityTypeId, EntityId, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	FactorRelationship
	WHERE	FactorRelationshipId = @FactorRelationshipId

	DELETE	FactorRelationship
	WHERE	FactorRelationshipId = @FactorRelationshipId
	AND		DataVersion = @DataVersion
GO
