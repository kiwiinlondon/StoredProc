USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputConfiguration_Update]
GO

CREATE PROCEDURE DBO.[ExtractOutputConfiguration_Update]
		@ExtractOutputConfigurationID int, 
		@ExtractId int, 
		@EntityPropertyId int, 
		@Label varchar(1000), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ChangesCanBeIgnored bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractOutputConfiguration_hst (
			ExtractOutputConfigurationID, ExtractId, EntityPropertyId, Label, StartDt, UpdateUserID, DataVersion, ChangesCanBeIgnored, EndDt, LastActionUserID)
	SELECT	ExtractOutputConfigurationID, ExtractId, EntityPropertyId, Label, StartDt, UpdateUserID, DataVersion, ChangesCanBeIgnored, @StartDt, @UpdateUserID
	FROM	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID

	UPDATE	ExtractOutputConfiguration
	SET		ExtractId = @ExtractId, EntityPropertyId = @EntityPropertyId, Label = @Label, UpdateUserID = @UpdateUserID, ChangesCanBeIgnored = @ChangesCanBeIgnored,  StartDt = @StartDt
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID
	AND		@@ROWCOUNT > 0

GO
