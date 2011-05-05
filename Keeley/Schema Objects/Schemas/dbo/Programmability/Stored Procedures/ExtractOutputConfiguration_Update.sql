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
		@Label varchar(1000), 
		@ChangesCanBeIgnored bit, 
		@OrderBy int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@EntityPropertyId int, 
		@EntityPropertyIdToWrite int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractOutputConfiguration_hst (
			ExtractOutputConfigurationID, ExtractId, Label, ChangesCanBeIgnored, OrderBy, StartDt, UpdateUserID, DataVersion, EntityPropertyId, EntityPropertyIdToWrite, EndDt, LastActionUserID)
	SELECT	ExtractOutputConfigurationID, ExtractId, Label, ChangesCanBeIgnored, OrderBy, StartDt, UpdateUserID, DataVersion, EntityPropertyId, EntityPropertyIdToWrite, @StartDt, @UpdateUserID
	FROM	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID

	UPDATE	ExtractOutputConfiguration
	SET		ExtractId = @ExtractId, Label = @Label, ChangesCanBeIgnored = @ChangesCanBeIgnored, OrderBy = @OrderBy, UpdateUserID = @UpdateUserID, EntityPropertyId = @EntityPropertyId, EntityPropertyIdToWrite = @EntityPropertyIdToWrite,  StartDt = @StartDt
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID
	AND		@@ROWCOUNT > 0

GO
