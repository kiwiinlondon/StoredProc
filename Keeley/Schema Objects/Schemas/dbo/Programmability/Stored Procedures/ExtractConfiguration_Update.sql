USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractConfiguration_Update]
GO

CREATE PROCEDURE DBO.[ExtractConfiguration_Update]
		@ExtracttConfigurationID int, 
		@ExtractId int, 
		@ConfigurationKey varchar(100), 
		@ConfigurationValue varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractConfiguration_hst (
			ExtracttConfigurationID, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtracttConfigurationID, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractConfiguration
	WHERE	ExtracttConfigurationID = @ExtracttConfigurationID

	UPDATE	ExtractConfiguration
	SET		ExtractId = @ExtractId, ConfigurationKey = @ConfigurationKey, ConfigurationValue = @ConfigurationValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtracttConfigurationID = @ExtracttConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractConfiguration
	WHERE	ExtracttConfigurationID = @ExtracttConfigurationID
	AND		@@ROWCOUNT > 0

GO
