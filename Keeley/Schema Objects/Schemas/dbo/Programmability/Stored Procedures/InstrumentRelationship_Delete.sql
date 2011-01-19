USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentRelationship_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentRelationship_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentRelationship_Delete]
		@UnderlyingInstrumentID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentRelationship_hst (
			UnderlyingInstrumentID, OverlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	UnderlyingInstrumentID, OverlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentRelationship
	WHERE	UnderlyingInstrumentID = @UnderlyingInstrumentID

	DELETE	InstrumentRelationship
	WHERE	UnderlyingInstrumentID = @UnderlyingInstrumentID
	AND		DataVersion = @DataVersion
GO
