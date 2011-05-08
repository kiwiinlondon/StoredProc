USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingSchemeItem_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingSchemeItem_Insert]
GO

CREATE PROCEDURE DBO.[EntityRankingSchemeItem_Insert]
		@Name varchar(100), 
		@EntityTypeId int, 
		@EntityRankingSchemeId int, 
		@FMValueSpecId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityRankingSchemeItem
			(Name, EntityTypeId, EntityRankingSchemeId, FMValueSpecId, UpdateUserID, StartDt)
	VALUES
			(@Name, @EntityTypeId, @EntityRankingSchemeId, @FMValueSpecId, @UpdateUserID, @StartDt)

	SELECT	EntityRankingSchemeItemId, StartDt, DataVersion
	FROM	EntityRankingSchemeItem
	WHERE	EntityRankingSchemeItemId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
