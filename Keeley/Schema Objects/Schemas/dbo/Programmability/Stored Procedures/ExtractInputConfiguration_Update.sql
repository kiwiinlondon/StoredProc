USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractInputConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractInputConfiguration_Update]
GO

CREATE PROCEDURE DBO.[ExtractInputConfiguration_Update]
		@ExtractFieldConfigurationID int, 
		@ExtractId int, 
		@EntityPropertyId int, 
		@IntValue int, 
		@StringValue varchar(1000), 
		@DecimalValue decimal, 
		@DateTimeValue datetime, 
		@BitValue bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractInputConfiguration_hst (
			ExtractFieldConfigurationID, ExtractId, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractFieldConfigurationID, ExtractId, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractInputConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID

	UPDATE	ExtractInputConfiguration
	SET		ExtractId = @ExtractId, EntityPropertyId = @EntityPropertyId, IntValue = @IntValue, StringValue = @StringValue, DecimalValue = @DecimalValue, DateTimeValue = @DateTimeValue, BitValue = @BitValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractInputConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID
	AND		@@ROWCOUNT > 0

GO
