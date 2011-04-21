USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldConfiguration_Delete]
		@ExtractFieldConfigurationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEventFieldConfiguration_hst (
			ExtractFieldConfigurationID, ExtractId, EventFieldId, EventFieldIntValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractFieldConfigurationID, ExtractId, EventFieldId, EventFieldIntValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEventFieldConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID

	DELETE	ExtractEventFieldConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID
	AND		DataVersion = @DataVersion
GO
