USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldOutputConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldOutputConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldOutputConfiguration_Delete]
		@ExtractFieldOutputConfigurationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractEventFieldOutputConfiguration_hst (
			ExtractFieldOutputConfigurationID, ExtractId, EventFieldId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ExtractFieldOutputConfigurationID, ExtractId, EventFieldId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ExtractEventFieldOutputConfiguration
	WHERE	ExtractFieldOutputConfigurationID = @ExtractFieldOutputConfigurationID

	DELETE	ExtractEventFieldOutputConfiguration
	WHERE	ExtractFieldOutputConfigurationID = @ExtractFieldOutputConfigurationID
	AND		DataVersion = @DataVersion
GO
