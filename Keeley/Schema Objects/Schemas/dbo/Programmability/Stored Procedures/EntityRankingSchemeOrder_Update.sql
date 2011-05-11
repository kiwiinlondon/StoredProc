USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingSchemeOrder_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingSchemeOrder_Update]
GO

CREATE PROCEDURE DBO.[EntityRankingSchemeOrder_Update]
		@EntityRankingSchemeOrderId int, 
		@EntityRankingSchemeId int, 
		@EntityTypeId int, 
		@EntityRankingSchemeItemId int, 
		@Ordering int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO EntityRankingSchemeOrder_hst (
			EntityRankingSchemeOrderId, EntityRankingSchemeId, EntityTypeId, EntityRankingSchemeItemId, Ordering, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	EntityRankingSchemeOrderId, EntityRankingSchemeId, EntityTypeId, EntityRankingSchemeItemId, Ordering, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	EntityRankingSchemeOrder
	WHERE	EntityRankingSchemeOrderId = @EntityRankingSchemeOrderId

	UPDATE	EntityRankingSchemeOrder
	SET		EntityRankingSchemeId = @EntityRankingSchemeId, EntityTypeId = @EntityTypeId, EntityRankingSchemeItemId = @EntityRankingSchemeItemId, Ordering = @Ordering, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	EntityRankingSchemeOrderId = @EntityRankingSchemeOrderId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	EntityRankingSchemeOrder
	WHERE	EntityRankingSchemeOrderId = @EntityRankingSchemeOrderId
	AND		@@ROWCOUNT > 0

GO
