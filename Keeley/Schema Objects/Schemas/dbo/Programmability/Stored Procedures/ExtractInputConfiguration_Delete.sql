USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractInputConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractInputConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[ExtractInputConfiguration_Delete]
		@ExtractFieldConfigurationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractInputConfiguration_hst (
			ExtractFieldConfigurationID, ExtractId, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, StartDt, UpdateUserID, DataVersion, IsNotEqual, IntValues, SendCancel, EntityPropertyIdToLookup, EndDt, LastActionUserID)
	SELECT	ExtractFieldConfigurationID, ExtractId, EntityPropertyId, IntValue, StringValue, DecimalValue, DateTimeValue, BitValue, StartDt, UpdateUserID, DataVersion, IsNotEqual, IntValues, SendCancel, EntityPropertyIdToLookup, @EndDt, @UpdateUserID
	FROM	ExtractInputConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID

	DELETE	ExtractInputConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID
	AND		DataVersion = @DataVersion
GO
