USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEntityPropertyValue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEntityPropertyValue_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEntityPropertyValue_Delete]
		@ExtractEntityPropertyValueID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEntityPropertyValue_hst (
			ExtractEntityPropertyValueID, ExtractEntityID, EntityPropertyId, PreviousIntValue, IntValue, StringValue, PreviousStringValue, DecimalValue, PreviousDecimalValue, DateTimeValue, PreviousDateTimeValue, BitValue, PreviousBitValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEntityPropertyValueID, ExtractEntityID, EntityPropertyId, PreviousIntValue, IntValue, StringValue, PreviousStringValue, DecimalValue, PreviousDecimalValue, DateTimeValue, PreviousDateTimeValue, BitValue, PreviousBitValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEntityPropertyValue
	WHERE	ExtractEntityPropertyValueID = @ExtractEntityPropertyValueID

	DELETE	ExtractEntityPropertyValue
	WHERE	ExtractEntityPropertyValueID = @ExtractEntityPropertyValueID
	AND		DataVersion = @DataVersion
GO
