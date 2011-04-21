USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventConfiguration_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventConfiguration_Update]
GO

CREATE PROCEDURE DBO.[ExtractEventConfiguration_Update]
		@ExtractEventConfigurationID int, 
		@ExtractId int, 
		@BuildForInternalAllocationOnly bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ExtractEventConfiguration_hst (
			ExtractEventConfigurationID, ExtractId, BuildForInternalAllocationOnly, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEventConfigurationID, ExtractId, BuildForInternalAllocationOnly, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ExtractEventConfiguration
	WHERE	ExtractEventConfigurationID = @ExtractEventConfigurationID

	UPDATE	ExtractEventConfiguration
	SET		ExtractId = @ExtractId, BuildForInternalAllocationOnly = @BuildForInternalAllocationOnly, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ExtractEventConfigurationID = @ExtractEventConfigurationID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ExtractEventConfiguration
	WHERE	ExtractEventConfigurationID = @ExtractEventConfigurationID
	AND		@@ROWCOUNT > 0

GO
