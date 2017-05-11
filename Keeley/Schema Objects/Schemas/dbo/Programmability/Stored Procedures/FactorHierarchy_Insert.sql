USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorHierarchy_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorHierarchy_Insert]
GO

CREATE PROCEDURE DBO.[FactorHierarchy_Insert]
		@HierarchyName varchar(256), 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FactorHierarchy
			(HierarchyName, UpdateUserId, StartDt)
	VALUES
			(@HierarchyName, @UpdateUserId, @StartDt)

	SELECT	FactorHierarchyId, StartDt, DataVersion
	FROM	FactorHierarchy
	WHERE	FactorHierarchyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
