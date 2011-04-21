USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractEventConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractEventConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[ExtractEventConfiguration_Insert]
		@ExtractId int, 
		@BuildForInternalAllocationOnly bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractEventConfiguration
			(ExtractId, BuildForInternalAllocationOnly, UpdateUserID, StartDt)
	VALUES
			(@ExtractId, @BuildForInternalAllocationOnly, @UpdateUserID, @StartDt)

	SELECT	ExtractEventConfigurationID, StartDt, DataVersion
	FROM	ExtractEventConfiguration
	WHERE	ExtractEventConfigurationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
