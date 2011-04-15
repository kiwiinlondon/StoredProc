USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClassRelationship_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClassRelationship_Update]
GO

CREATE PROCEDURE DBO.[InstrumentClassRelationship_Update]
		@InstrumentClassRelationshipID int, 
		@InstrumentClassID int, 
		@ParentInstrumentClassID int, 
		@InstrumentClassHierarchyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentClassRelationship_hst (
			InstrumentClassRelationshipID, InstrumentClassID, ParentInstrumentClassID, InstrumentClassHierarchyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentClassRelationshipID, InstrumentClassID, ParentInstrumentClassID, InstrumentClassHierarchyId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentClassRelationship
	WHERE	InstrumentClassRelationshipID = @InstrumentClassRelationshipID

	UPDATE	InstrumentClassRelationship
	SET		InstrumentClassID = @InstrumentClassID, ParentInstrumentClassID = @ParentInstrumentClassID, InstrumentClassHierarchyId = @InstrumentClassHierarchyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentClassRelationshipID = @InstrumentClassRelationshipID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentClassRelationship
	WHERE	InstrumentClassRelationshipID = @InstrumentClassRelationshipID
	AND		@@ROWCOUNT > 0

GO
