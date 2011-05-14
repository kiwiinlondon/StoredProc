USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ExtractOutputConfiguration_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ExtractOutputConfiguration_Insert]
GO

CREATE PROCEDURE DBO.[ExtractOutputConfiguration_Insert]
		@ExtractId int, 
		@Label varchar(1000), 
		@ChangesCanBeIgnored bit, 
		@OrderBy int, 
		@UpdateUserID int, 
		@EntityPropertyId int, 
		@EntityPropertyToWriteId int, 
		@Format varchar(1000)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ExtractOutputConfiguration
			(ExtractId, Label, ChangesCanBeIgnored, OrderBy, UpdateUserID, EntityPropertyId, EntityPropertyToWriteId, Format, StartDt)
	VALUES
			(@ExtractId, @Label, @ChangesCanBeIgnored, @OrderBy, @UpdateUserID, @EntityPropertyId, @EntityPropertyToWriteId, @Format, @StartDt)

	SELECT	ExtractOutputConfigurationID, StartDt, DataVersion
	FROM	ExtractOutputConfiguration
	WHERE	ExtractOutputConfigurationID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
