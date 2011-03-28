USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentEventType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentEventType_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentEventType_Delete]
		@InstrumentEventTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentEventType_hst (
			InstrumentEventTypeID, Name, StartDt, UpdateUserID, DataVersion, FmCnevSubType, EndDt, LastActionUserID)
	SELECT	InstrumentEventTypeID, Name, StartDt, UpdateUserID, DataVersion, FmCnevSubType, @EndDt, @UpdateUserID
	FROM	InstrumentEventType
	WHERE	InstrumentEventTypeID = @InstrumentEventTypeID

	DELETE	InstrumentEventType
	WHERE	InstrumentEventTypeID = @InstrumentEventTypeID
	AND		DataVersion = @DataVersion
GO
