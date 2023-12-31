﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputConfiguration_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputConfiguration_Delete]
GO

CREATE PROCEDURE DBO.[ExtractOutputConfiguration_Delete]
		@ExtractOutputConfigurationID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ExtractOutputConfiguration_hst (
			ExtractOutputConfigurationID, ExtractId, Label, ChangesCanBeIgnored, OrderBy, StartDt, UpdateUserID, DataVersion, EntityPropertyId, EntityPropertyToWriteId, Format, FXRateEntityPropertyToApply, Absolute, IncludeForInstrumentClassId, InstrumentClassIds, IncludeForEntityStatusId, EntityStatusIds, EndDt, LastActionUserID)
	SELECT	ExtractOutputConfigurationID, ExtractId, Label, ChangesCanBeIgnored, OrderBy, StartDt, UpdateUserID, DataVersion, EntityPropertyId, EntityPropertyToWriteId, Format, FXRateEntityPropertyToApply, Absolute, IncludeForInstrumentClassId, InstrumentClassIds, IncludeForEntityStatusId, EntityStatusIds, @EndDt, @UpdateUserID
	FROM	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID

	DELETE	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = @ExtractOutputConfigurationID
	AND		DataVersion = @DataVersion
GO
