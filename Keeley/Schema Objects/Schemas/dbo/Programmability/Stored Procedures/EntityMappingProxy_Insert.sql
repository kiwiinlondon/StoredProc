USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMappingProxy_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMappingProxy_Insert]
GO

CREATE PROCEDURE DBO.[EntityMappingProxy_Insert]
		@EntityMappingSetId int, 
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityMappingProxy
			(EntityMappingSetId, Name, UpdateUserID, StartDt)
	VALUES
			(@EntityMappingSetId, @Name, @UpdateUserID, @StartDt)

	SELECT	EntityMappingProxyId, StartDt, DataVersion
	FROM	EntityMappingProxy
	WHERE	EntityMappingProxyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
