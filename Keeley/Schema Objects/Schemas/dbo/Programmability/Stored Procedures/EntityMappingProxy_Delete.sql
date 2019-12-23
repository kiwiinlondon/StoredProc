USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMappingProxy_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMappingProxy_Delete]
GO

CREATE PROCEDURE DBO.[EntityMappingProxy_Delete]
		@EntityMappingProxyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityMappingProxy_hst (
			EntityMappingProxyId, EntityMappingSetId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityMappingProxyId, EntityMappingSetId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityMappingProxy
	WHERE	EntityMappingProxyId = @EntityMappingProxyId

	DELETE	EntityMappingProxy
	WHERE	EntityMappingProxyId = @EntityMappingProxyId
	AND		DataVersion = @DataVersion
GO
