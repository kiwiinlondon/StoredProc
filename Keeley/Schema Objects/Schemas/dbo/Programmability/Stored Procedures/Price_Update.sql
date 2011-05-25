USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Price_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Price_Update]
GO

CREATE PROCEDURE DBO.[Price_Update]
		@PriceId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeId int, 
		@RawPriceId int, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@EntityRankingSchemeItemId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Price_hst (
			PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, EntityRankingSchemeItemId, EndDt, LastActionUserID)
	SELECT	PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, EntityRankingSchemeItemId, @StartDt, @UpdateUserID
	FROM	Price
	WHERE	PriceId = @PriceId

	UPDATE	Price
	SET		InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, EntityRankingSchemeId = @EntityRankingSchemeId, RawPriceId = @RawPriceId, Value = @Value, UpdateUserID = @UpdateUserID, EntityRankingSchemeItemId = @EntityRankingSchemeItemId,  StartDt = @StartDt
	WHERE	PriceId = @PriceId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Price
	WHERE	PriceId = @PriceId
	AND		@@ROWCOUNT > 0

GO
