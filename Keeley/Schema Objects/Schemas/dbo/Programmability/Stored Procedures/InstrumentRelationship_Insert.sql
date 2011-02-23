USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentRelationship_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentRelationship_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentRelationship_Insert]
		@OverlyingInstrumentID int, 
		@UnderlyingInstrumentID int, 
		@UnderlyerPerOverlyer numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentRelationship
			(OverlyingInstrumentID, UnderlyingInstrumentID, UnderlyerPerOverlyer, UpdateUserID, StartDt)
	VALUES
			(@OverlyingInstrumentID, @UnderlyingInstrumentID, @UnderlyerPerOverlyer, @UpdateUserID, @StartDt)

	SELECT	OverlyingInstrumentID, StartDt, DataVersion
	FROM	InstrumentRelationship
	WHERE	OverlyingInstrumentID = @OverlyingInstrumentID
	AND		@@ROWCOUNT > 0

GO
