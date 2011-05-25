USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EventInstrumentMap_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EventInstrumentMap_Insert]
GO

CREATE PROCEDURE DBO.[EventInstrumentMap_Insert]
		@EventID int, 
		@InstrumentID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EventInstrumentMap
			(EventID, InstrumentID, UpdateUserID, StartDt)
	VALUES
			(@EventID, @InstrumentID, @UpdateUserID, @StartDt)

	SELECT	InstrumentID, StartDt, DataVersion
	FROM	EventInstrumentMap
	WHERE	InstrumentID = @InstrumentID
	AND		@@ROWCOUNT > 0

GO
