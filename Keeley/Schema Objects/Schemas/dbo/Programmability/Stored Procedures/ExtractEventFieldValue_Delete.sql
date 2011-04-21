USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldValue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldValue_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldValue_Delete]
		@ExtractEventFieldValueID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEventFieldValue_hst (
			ExtractEventFieldValueID, ExtractEventID, EventFieldId, EventFieldIntValue, EventFieldStringValue, EventFieldDecimalValue, EventFieldDateTimeValue, EventFieldBitValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEventFieldValueID, ExtractEventID, EventFieldId, EventFieldIntValue, EventFieldStringValue, EventFieldDecimalValue, EventFieldDateTimeValue, EventFieldBitValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEventFieldValue
	WHERE	ExtractEventFieldValueID = @ExtractEventFieldValueID

	DELETE	ExtractEventFieldValue
	WHERE	ExtractEventFieldValueID = @ExtractEventFieldValueID
	AND		DataVersion = @DataVersion
GO
