USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClassRelationship_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClassRelationship_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentClassRelationship_Insert]
		@InstrumentClassID int, 
		@ParentInstrumentClassID int, 
		@InstrumentClassHierarchyId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentClassRelationship
			(InstrumentClassID, ParentInstrumentClassID, InstrumentClassHierarchyId, UpdateUserID, StartDt)
	VALUES
			(@InstrumentClassID, @ParentInstrumentClassID, @InstrumentClassHierarchyId, @UpdateUserID, @StartDt)

	SELECT	InstrumentClassRelationshipID, StartDt, DataVersion
	FROM	InstrumentClassRelationship
	WHERE	InstrumentClassRelationshipID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
