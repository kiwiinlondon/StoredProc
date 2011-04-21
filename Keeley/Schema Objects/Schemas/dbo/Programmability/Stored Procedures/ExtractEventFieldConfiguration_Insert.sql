USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldConfiguration_Insert]
		@ExtractId int, 
		@EventFieldId int, 
		@EventFieldIntValue int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEventFieldConfiguration
			(ExtractId, EventFieldId, EventFieldIntValue, UpdateUserID, StartDt)
	VALUES
			(@ExtractId, @EventFieldId, @EventFieldIntValue, @UpdateUserID, @StartDt)

	SELECT	ExtractFieldConfigurationID, StartDt, DataVersion
	FROM	ExtractEventFieldConfiguration
	WHERE	ExtractFieldConfigurationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
