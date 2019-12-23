USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClassHierarchy_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClassHierarchy_Update]
GO

CREATE PROCEDURE DBO.[InstrumentClassHierarchy_Update]
		@InstrumentClassHierarchyId int, 
		@Name varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentClassHierarchy_hst (
			InstrumentClassHierarchyId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentClassHierarchyId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentClassHierarchy
	WHERE	InstrumentClassHierarchyId = @InstrumentClassHierarchyId

	UPDATE	InstrumentClassHierarchy
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentClassHierarchyId = @InstrumentClassHierarchyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentClassHierarchy
	WHERE	InstrumentClassHierarchyId = @InstrumentClassHierarchyId
	AND		@@ROWCOUNT > 0

GO
