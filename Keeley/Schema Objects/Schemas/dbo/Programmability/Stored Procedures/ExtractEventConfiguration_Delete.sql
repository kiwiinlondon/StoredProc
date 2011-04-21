USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEventConfiguration_Delete]
		@ExtractEventConfigurationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEventConfiguration_hst (
			ExtractEventConfigurationID, ExtractId, BuildForInternalAllocationOnly, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractEventConfigurationID, ExtractId, BuildForInternalAllocationOnly, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEventConfiguration
	WHERE	ExtractEventConfigurationID = @ExtractEventConfigurationID

	DELETE	ExtractEventConfiguration
	WHERE	ExtractEventConfigurationID = @ExtractEventConfigurationID
	AND		DataVersion = @DataVersion
GO
