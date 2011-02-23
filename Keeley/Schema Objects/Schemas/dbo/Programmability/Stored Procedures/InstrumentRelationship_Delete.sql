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
		@OverlyingInstrumentID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentRelationship_hst (
			OverlyingInstrumentID, UnderlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OverlyingInstrumentID, UnderlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentRelationship
	WHERE	OverlyingInstrumentID = @OverlyingInstrumentID

	DELETE	InstrumentRelationship
	WHERE	OverlyingInstrumentID = @OverlyingInstrumentID
	AND		DataVersion = @DataVersion
GO
