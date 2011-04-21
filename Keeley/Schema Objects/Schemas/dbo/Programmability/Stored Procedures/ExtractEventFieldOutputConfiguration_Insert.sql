USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventFieldOutputConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventFieldOutputConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEventFieldOutputConfiguration_Insert]
		@ExtractId int, 
		@EventFieldId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEventFieldOutputConfiguration
			(ExtractId, EventFieldId, UpdateUserID, StartDt)
	VALUES
			(@ExtractId, @EventFieldId, @UpdateUserID, @StartDt)

	SELECT	ExtractFieldOutputConfigurationID, StartDt, DataVersion
	FROM	ExtractEventFieldOutputConfiguration
	WHERE	ExtractFieldOutputConfigurationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
