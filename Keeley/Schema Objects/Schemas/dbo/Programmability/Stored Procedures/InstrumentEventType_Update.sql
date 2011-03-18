USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentEventType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentEventType_Update]
GO

CREATE PROCEDURE DBO.[InstrumentEventType_Update]
		@InstrumentEventTypeID int, 
		@Name varchar(70), 
		@FmContClass varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentEventType_hst (
			InstrumentEventTypeID, Name, FmContClass, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentEventTypeID, Name, FmContClass, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentEventType
	WHERE	InstrumentEventTypeID = @InstrumentEventTypeID

	UPDATE	InstrumentEventType
	SET		Name = @Name, FmContClass = @FmContClass, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentEventTypeID = @InstrumentEventTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentEventType
	WHERE	InstrumentEventTypeID = @InstrumentEventTypeID
	AND		@@ROWCOUNT > 0

GO
