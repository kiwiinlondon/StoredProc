USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClassHierarchy_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClassHierarchy_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentClassHierarchy_Delete]
		@InstrumentClassHierarchyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentClassHierarchy_hst (
			InstrumentClassHierarchyId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentClassHierarchyId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentClassHierarchy
	WHERE	InstrumentClassHierarchyId = @InstrumentClassHierarchyId

	DELETE	InstrumentClassHierarchy
	WHERE	InstrumentClassHierarchyId = @InstrumentClassHierarchyId
	AND		DataVersion = @DataVersion
GO
