USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingSchemeOrder_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingSchemeOrder_Insert]
GO

CREATE PROCEDURE DBO.[EntityRankingSchemeOrder_Insert]
		@EntityRankingSchemeId int, 
		@EntityTypeId int, 
		@EntityRankingSchemeItemId int, 
		@Ordering int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityRankingSchemeOrder
			(EntityRankingSchemeId, EntityTypeId, EntityRankingSchemeItemId, Ordering, UpdateUserID, StartDt)
	VALUES
			(@EntityRankingSchemeId, @EntityTypeId, @EntityRankingSchemeItemId, @Ordering, @UpdateUserID, @StartDt)

	SELECT	EntityRankingSchemeOrderId, StartDt, DataVersion
	FROM	EntityRankingSchemeOrder
	WHERE	EntityRankingSchemeOrderId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
