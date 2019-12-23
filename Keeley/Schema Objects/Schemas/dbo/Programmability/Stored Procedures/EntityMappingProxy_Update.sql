USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMappingProxy_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMappingProxy_Update]
GO

CREATE PROCEDURE DBO.[EntityMappingProxy_Update]
		@EntityMappingProxyId int, 
		@EntityMappingSetId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityMappingProxy_hst (
			EntityMappingProxyId, EntityMappingSetId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityMappingProxyId, EntityMappingSetId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityMappingProxy
	WHERE	EntityMappingProxyId = @EntityMappingProxyId

	UPDATE	EntityMappingProxy
	SET		EntityMappingSetId = @EntityMappingSetId, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityMappingProxyId = @EntityMappingProxyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityMappingProxy
	WHERE	EntityMappingProxyId = @EntityMappingProxyId
	AND		@@ROWCOUNT > 0

GO
