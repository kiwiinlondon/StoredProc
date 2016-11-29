USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorHierarchy_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorHierarchy_Delete]
GO

CREATE PROCEDURE DBO.[FactorHierarchy_Delete]
		@FactorHierarchyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FactorHierarchy_hst (
			FactorHierarchyId, HierarchyName, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorHierarchyId, HierarchyName, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	FactorHierarchy
	WHERE	FactorHierarchyId = @FactorHierarchyId

	DELETE	FactorHierarchy
	WHERE	FactorHierarchyId = @FactorHierarchyId
	AND		DataVersion = @DataVersion
GO
