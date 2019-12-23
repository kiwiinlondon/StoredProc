USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingScheme_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingScheme_Update]
GO

CREATE PROCEDURE DBO.[EntityRankingScheme_Update]
		@EntityRankingSchemeId int, 
		@Name varchar(100), 
		@FMValueSchemeId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityRankingScheme_hst (
			EntityRankingSchemeId, Name, FMValueSchemeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityRankingSchemeId, Name, FMValueSchemeId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityRankingScheme
	WHERE	EntityRankingSchemeId = @EntityRankingSchemeId

	UPDATE	EntityRankingScheme
	SET		Name = @Name, FMValueSchemeId = @FMValueSchemeId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityRankingSchemeId = @EntityRankingSchemeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityRankingScheme
	WHERE	EntityRankingSchemeId = @EntityRankingSchemeId
	AND		@@ROWCOUNT > 0

GO
