USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingSchemeItem_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingSchemeItem_Delete]
GO

CREATE PROCEDURE DBO.[EntityRankingSchemeItem_Delete]
		@EntityRankingSchemeItemId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityRankingSchemeItem_hst (
			EntityRankingSchemeItemId, Name, EntityTypeId, FMValueSpecId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityRankingSchemeItemId, Name, EntityTypeId, FMValueSpecId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	EntityRankingSchemeItem
	WHERE	EntityRankingSchemeItemId = @EntityRankingSchemeItemId

	DELETE	EntityRankingSchemeItem
	WHERE	EntityRankingSchemeItemId = @EntityRankingSchemeItemId
	AND		DataVersion = @DataVersion
GO
