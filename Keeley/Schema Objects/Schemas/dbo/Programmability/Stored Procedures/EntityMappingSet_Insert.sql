USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityMappingSet_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityMappingSet_Insert]
GO

CREATE PROCEDURE DBO.[EntityMappingSet_Insert]
		@EntityTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityMappingSet
			(EntityTypeId, Name, UpdateUserID, StartDt)
	VALUES
			(@EntityTypeId, @Name, @UpdateUserID, @StartDt)

	SELECT	EntityMappingSetId, StartDt, DataVersion
	FROM	EntityMappingSet
	WHERE	EntityMappingSetId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
