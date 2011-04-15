USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClassRelationship_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClassRelationship_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentClassRelationship_Delete]
		@InstrumentClassRelationshipID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentClassRelationship_hst (
			InstrumentClassRelationshipID, InstrumentClassID, ParentInstrumentClassID, InstrumentClassHierarchyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentClassRelationshipID, InstrumentClassID, ParentInstrumentClassID, InstrumentClassHierarchyId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentClassRelationship
	WHERE	InstrumentClassRelationshipID = @InstrumentClassRelationshipID

	DELETE	InstrumentClassRelationship
	WHERE	InstrumentClassRelationshipID = @InstrumentClassRelationshipID
	AND		DataVersion = @DataVersion
GO
