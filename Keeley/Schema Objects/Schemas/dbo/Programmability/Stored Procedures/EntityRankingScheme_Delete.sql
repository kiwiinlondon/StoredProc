USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingScheme_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingScheme_Delete]
GO

CREATE PROCEDURE DBO.[EntityRankingScheme_Delete]
		@EntityRankingSchemeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityRankingScheme_hst (
			EntityRankingSchemeId, Name, FMValueSchemeId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityRankingSchemeId, Name, FMValueSchemeId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityRankingScheme
	WHERE	EntityRankingSchemeId = @EntityRankingSchemeId

	DELETE	EntityRankingScheme
	WHERE	EntityRankingSchemeId = @EntityRankingSchemeId
	AND		DataVersion = @DataVersion
GO
