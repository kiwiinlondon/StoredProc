USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEntityPropertyValue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEntityPropertyValue_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEntityPropertyValue_Insert]
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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEntityPropertyValue
			(ExtractEntityID, EntityPropertyId, PreviousIntValue, IntValue, StringValue, PreviousStringValue, DecimalValue, PreviousDecimalValue, DateTimeValue, PreviousDateTimeValue, BitValue, PreviousBitValue, UpdateUserID, StartDt)
	VALUES
			(@ExtractEntityID, @EntityPropertyId, @PreviousIntValue, @IntValue, @StringValue, @PreviousStringValue, @DecimalValue, @PreviousDecimalValue, @DateTimeValue, @PreviousDateTimeValue, @BitValue, @PreviousBitValue, @UpdateUserID, @StartDt)

	SELECT	ExtractEntityPropertyValueID, StartDt, DataVersion
	FROM	ExtractEntityPropertyValue
	WHERE	ExtractEntityPropertyValueID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
