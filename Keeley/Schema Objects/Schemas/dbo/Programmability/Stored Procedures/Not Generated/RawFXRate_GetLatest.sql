USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Price_Getlatest]    Script Date: 05/19/2011 18:28:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RawFXRate_GetLatest]
		@CurrencyID int,
		@ReferenceDate datetime,	
		@EntityRankingSchemeId int,
		@RawFXRateIdToIgnore int = null
AS		

DECLARE @MaxReferenceDate datetime

	if @RawFXRateIdToIgnore is null 
		begin
			SELECT	@MaxReferenceDate = MAX(ReferenceDate)
			FROM	RawFXRate
			WHERE	CurrencyID = @CurrencyID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate <= @ReferenceDate
	
			SELECT	*
			FROM	RawFXRate
			WHERE	CurrencyID = @CurrencyID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate = @MaxReferenceDate
		end
	else
		begin
			SELECT	@MaxReferenceDate = MAX(ReferenceDate)
			FROM	RawFXRate
			WHERE	CurrencyID = @CurrencyID
			AND		ReferenceDate <= @ReferenceDate
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			and		RawFXRateId != @RawFXRateIdToIgnore;
	
			SELECT	*
			FROM	RawFXRate
			WHERE	CurrencyID = @CurrencyID
			AND		ReferenceDate = @MaxReferenceDate
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemeId from entityRankingSchemeOrdering o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			and		RawFXRateId != @RawFXRateIdToIgnore
		end
