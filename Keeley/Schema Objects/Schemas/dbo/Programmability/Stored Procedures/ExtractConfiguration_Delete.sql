USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[ExtractConfiguration_Delete]
		@ExtractConfigurationId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractConfiguration_hst (
			ExtractConfigurationId, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractConfigurationId, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractConfiguration
	WHERE	ExtractConfigurationId = @ExtractConfigurationId

	DELETE	ExtractConfiguration
	WHERE	ExtractConfigurationId = @ExtractConfigurationId
	AND		DataVersion = @DataVersion
GO
