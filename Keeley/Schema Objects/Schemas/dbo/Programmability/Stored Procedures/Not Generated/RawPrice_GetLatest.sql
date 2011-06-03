USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Price_Getlatest]    Script Date: 05/19/2011 18:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RawPrice_GetLatest]
		@InstrumentMarketID int,
		@ReferenceDate datetime,	
		@EntityRankingSchemeId int,
		@RawPriceIdToIgnore int = null
AS		

DECLARE @MaxReferenceDate datetime

	if @RawPriceIdToIgnore is null 
		begin
			SELECT	@MaxReferenceDate = MAX(ReferenceDate)
			FROM	RawPrice
			WHERE	InstrumentMarketID = @InstrumentMarketID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate <= @ReferenceDate
	
			SELECT	*
			FROM	RawPrice
			WHERE	InstrumentMarketID = @InstrumentMarketID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate = @MaxReferenceDate
		end
	else
		begin
			SELECT	@MaxReferenceDate = MAX(ReferenceDate)
			FROM	RawPrice
			WHERE	InstrumentMarketID = @InstrumentMarketID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate <= @ReferenceDate
			and		RawPriceId != @RawPriceIdToIgnore;
	
			SELECT	*
			FROM	RawPrice
			WHERE	InstrumentMarketID = @InstrumentMarketID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate = @MaxReferenceDate
			and		RawPriceId != @RawPriceIdToIgnore
		end
