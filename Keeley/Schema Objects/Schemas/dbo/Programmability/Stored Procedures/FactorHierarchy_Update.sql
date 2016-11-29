USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorHierarchy_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorHierarchy_Update]
GO

CREATE PROCEDURE DBO.[FactorHierarchy_Update]
		@FactorHierarchyId int, 
		@HierarchyName varchar(256), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FactorHierarchy_hst (
			FactorHierarchyId, HierarchyName, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorHierarchyId, HierarchyName, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	FactorHierarchy
	WHERE	FactorHierarchyId = @FactorHierarchyId

	UPDATE	FactorHierarchy
	SET		HierarchyName = @HierarchyName, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	FactorHierarchyId = @FactorHierarchyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FactorHierarchy
	WHERE	FactorHierarchyId = @FactorHierarchyId
	AND		@@ROWCOUNT > 0

GO
