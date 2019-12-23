USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEntityPropertyValue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEntityPropertyValue_Update]
GO

CREATE PROCEDURE DBO.[ExtractEntityPropertyValue_Update]
		@ExtractEntityPropertyValueID int, 
		@ExtractEntityID int, 
		@EntityPropertyId int, 
		@PreviousIntValue int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@PreviousStringValue varchar(1000), 
		@DecimalValue numeric(27,8), 
		@PreviousDecimalValue numeric(27,8), 
		@DateTimeValue datetime, 
		@PreviousDateTimeValue datetime, 
		@BitValue bit, 
		@PreviousBitValue bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEntityPropertyValue_hst (
			ExtractEntityPropertyValueID, ExtractEntityID, EntityPropertyId, PreviousIntValue, IntValue, StringValue, PreviousStringValue, DecimalValue, PreviousDecimalValue, DateTimeValue, PreviousDateTimeValue, BitValue, PreviousBitValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEntityPropertyValueID, ExtractEntityID, EntityPropertyId, PreviousIntValue, IntValue, StringValue, PreviousStringValue, DecimalValue, PreviousDecimalValue, DateTimeValue, PreviousDateTimeValue, BitValue, PreviousBitValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractEntityPropertyValue
	WHERE	ExtractEntityPropertyValueID = @ExtractEntityPropertyValueID

	UPDATE	ExtractEntityPropertyValue
	SET		ExtractEntityID = @ExtractEntityID, EntityPropertyId = @EntityPropertyId, PreviousIntValue = @PreviousIntValue, IntValue = @IntValue, StringValue = @StringValue, PreviousStringValue = @PreviousStringValue, DecimalValue = @DecimalValue, PreviousDecimalValue = @PreviousDecimalValue, DateTimeValue = @DateTimeValue, PreviousDateTimeValue = @PreviousDateTimeValue, BitValue = @BitValue, PreviousBitValue = @PreviousBitValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractEntityPropertyValueID = @ExtractEntityPropertyValueID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEntityPropertyValue
	WHERE	ExtractEntityPropertyValueID = @ExtractEntityPropertyValueID
	AND		@@ROWCOUNT > 0

GO
