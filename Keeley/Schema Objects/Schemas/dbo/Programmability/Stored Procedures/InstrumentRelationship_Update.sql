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
		@OverlyingInstrumentID int, 
		@UnderlyingInstrumentID int, 
		@UnderlyerPerOverlyer numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentRelationship_hst (
			OverlyingInstrumentID, UnderlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	OverlyingInstrumentID, UnderlyingInstrumentID, UnderlyerPerOverlyer, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentRelationship
	WHERE	OverlyingInstrumentID = @OverlyingInstrumentID

	UPDATE	InstrumentRelationship
	SET		UnderlyingInstrumentID = @UnderlyingInstrumentID, UnderlyerPerOverlyer = @UnderlyerPerOverlyer, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	OverlyingInstrumentID = @OverlyingInstrumentID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentRelationship
	WHERE	OverlyingInstrumentID = @OverlyingInstrumentID
	AND		@@ROWCOUNT > 0

GO
