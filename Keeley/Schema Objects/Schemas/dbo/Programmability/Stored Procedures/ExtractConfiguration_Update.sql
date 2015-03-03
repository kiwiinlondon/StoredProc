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
		@ExtractConfigurationId int, 
		@ExtractId int, 
		@ConfigurationKey varchar(100), 
		@ConfigurationValue varchar(200), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractConfiguration_hst (
			ExtractConfigurationId, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractConfigurationId, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractConfiguration
	WHERE	ExtractConfigurationId = @ExtractConfigurationId

	UPDATE	ExtractConfiguration
	SET		ExtractId = @ExtractId, ConfigurationKey = @ConfigurationKey, ConfigurationValue = @ConfigurationValue, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractConfigurationId = @ExtractConfigurationId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractConfiguration
	WHERE	ExtractConfigurationId = @ExtractConfigurationId
	AND		@@ROWCOUNT > 0

GO
