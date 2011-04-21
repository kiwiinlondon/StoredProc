USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldConfiguration_Update]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldConfiguration_Update]
		@ExtractFieldConfigurationID int, 
		@ExtractId int, 
		@EventFieldId int, 
		@EventFieldIntValue int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEventFieldConfiguration_hst (
			ExtractFieldConfigurationID, ExtractId, EventFieldId, EventFieldIntValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractFieldConfigurationID, ExtractId, EventFieldId, EventFieldIntValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractEventFieldConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID

	UPDATE	ExtractEventFieldConfiguration
	SET		ExtractId = @ExtractId, EventFieldId = @EventFieldId, EventFieldIntValue = @EventFieldIntValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEventFieldConfiguration
	WHERE	ExtractFieldConfigurationID = @ExtractFieldConfigurationID
	AND		@@ROWCOUNT > 0

GO
