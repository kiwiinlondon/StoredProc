USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingSchemeItem_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingSchemeItem_Update]
GO

CREATE PROCEDURE DBO.[EntityRankingSchemeItem_Update]
		@EntityRankingSchemeItemId int, 
		@Name varchar(100), 
		@EntityTypeId int, 
		@FMValueSpecId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityRankingSchemeItem_hst (
			EntityRankingSchemeItemId, Name, EntityTypeId, FMValueSpecId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityRankingSchemeItemId, Name, EntityTypeId, FMValueSpecId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityRankingSchemeItem
	WHERE	EntityRankingSchemeItemId = @EntityRankingSchemeItemId

	UPDATE	EntityRankingSchemeItem
	SET		Name = @Name, EntityTypeId = @EntityTypeId, FMValueSpecId = @FMValueSpecId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityRankingSchemeItemId = @EntityRankingSchemeItemId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityRankingSchemeItem
	WHERE	EntityRankingSchemeItemId = @EntityRankingSchemeItemId
	AND		@@ROWCOUNT > 0

GO
