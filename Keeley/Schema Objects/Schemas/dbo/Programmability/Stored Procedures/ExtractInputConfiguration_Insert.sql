USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractInputConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractInputConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[ExtractInputConfiguration_Insert]
		@ExtractId int, 
		@EntityPropertyId int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@DecimalValue numeric(27,8), 
		@DateTimeValue datetime, 
		@BitValue bit, 
		@UpdateUserID int, 
		@IsNotEqual bit, 
		@IntValues varchar(100), 
		@SendCancel bit, 
		@EntityPropertyIdToLookup int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractInputConfiguration
			(ExtractId, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, UpdateUserID, IsNotEqual, IntValues, SendCancel, EntityPropertyIdToLookup, StartDt)
	VALUES
			(@ExtractId, @EntityPropertyId, @IntValue, @StringValue, @DecimalValue, @DateTimeValue, @BitValue, @UpdateUserID, @IsNotEqual, @IntValues, @SendCancel, @EntityPropertyIdToLookup, @StartDt)

	SELECT	ExtractFieldConfigurationID, StartDt, DataVersion
	FROM	ExtractInputConfiguration
	WHERE	ExtractFieldConfigurationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
