USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentClass_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentClass_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentClass_Delete]
		@InstrumentClassID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentClass_hst (
			InstrumentClassID, ParentInstrumentClassID, FMInstClass, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentClassID, ParentInstrumentClassID, FMInstClass, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentClass
	WHERE	InstrumentClassID = @InstrumentClassID

	DELETE	InstrumentClass
	WHERE	InstrumentClassID = @InstrumentClassID
	AND		DataVersion = @DataVersion
GO
