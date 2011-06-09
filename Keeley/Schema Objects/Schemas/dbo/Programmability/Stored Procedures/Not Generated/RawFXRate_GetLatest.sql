USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[RawFXRate_Getlatest]    Script Date: 06/06/2011 08:54:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[RawFXRate_Getlatest]
		@CurrencyID int,
		@ReferenceDate datetime,	
		@ForwardDate datetime,	
		@EntityRankingSchemeId int,
		@RawFXRateIdToIgnore int = null
AS		

DECLARE @MaxReferenceDate datetime

	if @ForwardDate = @ReferenceDate
		begin
			if @RawFXRateIdToIgnore is null
				begin
					SELECT	@MaxReferenceDate = MAX(ReferenceDate)
					FROM	RawFXRate
					WHERE	CurrencyID = @CurrencyID
					AND		ForwardDate = ReferenceDate
					AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
					AND		ReferenceDate <= @ReferenceDate
				end
			else
				begin
					SELECT	@MaxReferenceDate = MAX(ReferenceDate)
					FROM	RawFXRate
					WHERE	CurrencyID = @CurrencyID
					AND		ReferenceDate <= @ReferenceDate
					AND		ForwardDate = ReferenceDate
					AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
					and		RawFXRateId != @RawFXRateIdToIgnore;
				end
			SET @ForwardDate = @MaxReferenceDate
		end
		
	else
		begin
			if @RawFXRateIdToIgnore is null
				begin
					SELECT	@MaxReferenceDate = MAX(ReferenceDate)
					FROM	RawFXRate
					WHERE	CurrencyID = @CurrencyID
					AND		ForwardDate = @ForwardDate
					AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
					AND		ReferenceDate <= @ReferenceDate
				end
			else
				begin
					SELECT	@MaxReferenceDate = MAX(ReferenceDate)
					FROM	RawFXRate
					WHERE	CurrencyID = @CurrencyID
					AND		ReferenceDate <= @ReferenceDate
					AND		ForwardDate = @ForwardDate
					AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
					and		RawFXRateId != @RawFXRateIdToIgnore;
				end
		end
	if @RawFXRateIdToIgnore is null 
		begin	
			SELECT	*
			FROM	RawFXRate
			WHERE	CurrencyID = @CurrencyID
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			AND		ReferenceDate = @MaxReferenceDate
			AND		ForwardDate = @ForwardDate
		end
	else
		begin
			SELECT	*
			FROM	RawFXRate
			WHERE	CurrencyID = @CurrencyID
			AND		ReferenceDate = @MaxReferenceDate
			AND		EntityRankingSchemeItemId in (select o.entityrankingSchemeItemId from entityRankingSchemeOrder o where o.entityRankingSchemeId = @EntityRankingSchemeId)
			and		RawFXRateId != @RawFXRateIdToIgnore
			AND		ForwardDate = @ForwardDate
		end