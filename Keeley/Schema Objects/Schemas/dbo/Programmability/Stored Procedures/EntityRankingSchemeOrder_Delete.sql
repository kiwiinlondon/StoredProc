USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityRankingSchemeOrder_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityRankingSchemeOrder_Delete]
GO

CREATE PROCEDURE DBO.[EntityRankingSchemeOrder_Delete]
		@EntityRankingSchemeOrderId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO EntityRankingSchemeOrder_hst (
			EntityRankingSchemeOrderId, EntityRankingSchemeId, EntityTypeId, EntityRankingSchemeItemId, Ordering, StartDt, UpdateUserID, DataVersion, AlwaysStore, EndDt, LastActionUserID)
	SELECT	EntityRankingSchemeOrderId, EntityRankingSchemeId, EntityTypeId, EntityRankingSchemeItemId, Ordering, StartDt, UpdateUserID, DataVersion, AlwaysStore, @EndDt, @UpdateUserID
	FROM	EntityRankingSchemeOrder
	WHERE	EntityRankingSchemeOrderId = @EntityRankingSchemeOrderId

	DELETE	EntityRankingSchemeOrder
	WHERE	EntityRankingSchemeOrderId = @EntityRankingSchemeOrderId
	AND		DataVersion = @DataVersion
GO
