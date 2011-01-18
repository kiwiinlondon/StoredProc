USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClass_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClass_Update]
GO

CREATE PROCEDURE DBO.[InstrumentClass_Update]
		@InstrumentClassID int, 
		@ParentInstrumentClassID int, 
		@FMInstClass varchar, 
		@Name varchar, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentClass_hst (
			InstrumentClassID, ParentInstrumentClassID, FMInstClass, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentClassID, ParentInstrumentClassID, FMInstClass, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentClass
	WHERE	InstrumentClassID = InstrumentClassID

	UPDATE	InstrumentClass
	SET		ParentInstrumentClassID = @ParentInstrumentClassID, FMInstClass = @FMInstClass, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentClassID = @InstrumentClassID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentClass
	WHERE	InstrumentClassID = @InstrumentClassID
	AND		@@ROWCOUNT > 0

GO
