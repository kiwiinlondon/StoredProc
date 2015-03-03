USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[ExtractConfiguration_Insert]
		@ExtractId int, 
		@ConfigurationKey varchar(100), 
		@ConfigurationValue varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractConfiguration
			(ExtractId, ConfigurationKey, ConfigurationValue, UpdateUserID, StartDt)
	VALUES
			(@ExtractId, @ConfigurationKey, @ConfigurationValue, @UpdateUserID, @StartDt)

	SELECT	ExtractConfigurationId, StartDt, DataVersion
	FROM	ExtractConfiguration
	WHERE	ExtractConfigurationId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
