USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldValue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldValue_Update]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldValue_Update]
		@ExtractEventFieldValueID int, 
		@ExtractEventID int, 
		@EventFieldId int, 
		@EventFieldIntValue int, 
		@EventFieldStringValue varchar(1000), 
		@EventFieldDecimalValue decimal, 
		@EventFieldDateTimeValue datetime, 
		@EventFieldBitValue bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEventFieldValue_hst (
			ExtractEventFieldValueID, ExtractEventID, EventFieldId, EventFieldIntValue, EventFieldStringValue, EventFieldDecimalValue, EventFieldDateTimeValue, EventFieldBitValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEventFieldValueID, ExtractEventID, EventFieldId, EventFieldIntValue, EventFieldStringValue, EventFieldDecimalValue, EventFieldDateTimeValue, EventFieldBitValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractEventFieldValue
	WHERE	ExtractEventFieldValueID = @ExtractEventFieldValueID

	UPDATE	ExtractEventFieldValue
	SET		ExtractEventID = @ExtractEventID, EventFieldId = @EventFieldId, EventFieldIntValue = @EventFieldIntValue, EventFieldStringValue = @EventFieldStringValue, EventFieldDecimalValue = @EventFieldDecimalValue, EventFieldDateTimeValue = @EventFieldDateTimeValue, EventFieldBitValue = @EventFieldBitValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractEventFieldValueID = @ExtractEventFieldValueID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEventFieldValue
	WHERE	ExtractEventFieldValueID = @ExtractEventFieldValueID
	AND		@@ROWCOUNT > 0

GO
