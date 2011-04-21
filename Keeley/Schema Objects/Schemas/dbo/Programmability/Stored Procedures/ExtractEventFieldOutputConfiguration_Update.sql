USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldOutputConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldOutputConfiguration_Update]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldOutputConfiguration_Update]
		@ExtractFieldOutputConfigurationID int, 
		@ExtractId int, 
		@EventFieldId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEventFieldOutputConfiguration_hst (
			ExtractFieldOutputConfigurationID, ExtractId, EventFieldId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractFieldOutputConfigurationID, ExtractId, EventFieldId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractEventFieldOutputConfiguration
	WHERE	ExtractFieldOutputConfigurationID = @ExtractFieldOutputConfigurationID

	UPDATE	ExtractEventFieldOutputConfiguration
	SET		ExtractId = @ExtractId, EventFieldId = @EventFieldId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractFieldOutputConfigurationID = @ExtractFieldOutputConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEventFieldOutputConfiguration
	WHERE	ExtractFieldOutputConfigurationID = @ExtractFieldOutputConfigurationID
	AND		@@ROWCOUNT > 0

GO
