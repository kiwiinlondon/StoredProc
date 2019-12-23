USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMapping_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMapping_Delete]
GO

CREATE PROCEDURE DBO.[EntityMapping_Delete]
		@EntityMappingID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityMapping_hst (
			EntityMappingID, EntityId, EntityMappingProxyId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityMappingID, EntityId, EntityMappingProxyId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityMapping
	WHERE	EntityMappingID = @EntityMappingID

	DELETE	EntityMapping
	WHERE	EntityMappingID = @EntityMappingID
	AND		DataVersion = @DataVersion
GO
