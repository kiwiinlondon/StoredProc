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
		@ExtracttConfigurationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractConfiguration_hst (
			ExtracttConfigurationID, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtracttConfigurationID, ExtractId, ConfigurationKey, ConfigurationValue, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractConfiguration
	WHERE	ExtracttConfigurationID = @ExtracttConfigurationID

	DELETE	ExtractConfiguration
	WHERE	ExtracttConfigurationID = @ExtracttConfigurationID
	AND		DataVersion = @DataVersion
GO
