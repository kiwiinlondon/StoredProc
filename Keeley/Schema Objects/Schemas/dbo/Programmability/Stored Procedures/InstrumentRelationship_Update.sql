USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentRelationship_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentRelationship_Update]
GO

CREATE PROCEDURE DBO.[InstrumentRelationship_Update]
		@UnderlyingInstrumentID int, 
		@OverlyingInstrumentID int, 
		@UnderlyerPerOverlyer numeric, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentRelationship_hst (
			UnderlyingInstrumentID, OverlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	UnderlyingInstrumentID, OverlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentRelationship
	WHERE	UnderlyingInstrumentID = UnderlyingInstrumentID

	UPDATE	InstrumentRelationship
	SET		OverlyingInstrumentID = @OverlyingInstrumentID, UnderlyerPerOverlyer = @UnderlyerPerOverlyer, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	UnderlyingInstrumentID = @UnderlyingInstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentRelationship
	WHERE	UnderlyingInstrumentID = @UnderlyingInstrumentID
	AND		@@ROWCOUNT > 0

GO
