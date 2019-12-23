USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMapping_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMapping_Update]
GO

CREATE PROCEDURE DBO.[EntityMapping_Update]
		@EntityMappingID int, 
		@EntityId int, 
		@EntityMappingProxyId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityMapping_hst (
			EntityMappingID, EntityId, EntityMappingProxyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityMappingID, EntityId, EntityMappingProxyId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityMapping
	WHERE	EntityMappingID = @EntityMappingID

	UPDATE	EntityMapping
	SET		EntityId = @EntityId, EntityMappingProxyId = @EntityMappingProxyId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityMappingID = @EntityMappingID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityMapping
	WHERE	EntityMappingID = @EntityMappingID
	AND		@@ROWCOUNT > 0

GO
