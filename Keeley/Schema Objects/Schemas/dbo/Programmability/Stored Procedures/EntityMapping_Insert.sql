USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMapping_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMapping_Insert]
GO

CREATE PROCEDURE DBO.[EntityMapping_Insert]
		@EntityId int, 
		@EntityMappingProxyId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityMapping
			(EntityId, EntityMappingProxyId, UpdateUserID, StartDt)
	VALUES
			(@EntityId, @EntityMappingProxyId, @UpdateUserID, @StartDt)

	SELECT	EntityMappingID, StartDt, DataVersion
	FROM	EntityMapping
	WHERE	EntityMappingID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
