USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldValue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldValue_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldValue_Insert]
		@ExtractEventID int, 
		@EventFieldId int, 
		@EventFieldIntValue int, 
		@EventFieldStringValue varchar(1000), 
		@EventFieldDecimalValue decimal, 
		@EventFieldDateTimeValue datetime, 
		@EventFieldBitValue bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEventFieldValue
			(ExtractEventID, EventFieldId, EventFieldIntValue, EventFieldStringValue, EventFieldDecimalValue, EventFieldDateTimeValue, EventFieldBitValue, UpdateUserID, StartDt)
	VALUES
			(@ExtractEventID, @EventFieldId, @EventFieldIntValue, @EventFieldStringValue, @EventFieldDecimalValue, @EventFieldDateTimeValue, @EventFieldBitValue, @UpdateUserID, @StartDt)

	SELECT	ExtractEventFieldValueID, StartDt, DataVersion
	FROM	ExtractEventFieldValue
	WHERE	ExtractEventFieldValueID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
