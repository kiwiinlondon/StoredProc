USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Portfolio_Roll]    Script Date: 06/08/2011 17:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Portfolio_Roll]	
@UpdateUserId int
AS
	declare  @fromDt datetime
	
	select	@fromDt=RollDate
	from	PortfolioRollDate
	where	PortfolioAggregationLevelId = 2
	
	INSERT INTO [Keeley].[dbo].[Portfolio]
           ([PositionId]
           ,[ReferenceDate]
           ,[NetPosition]
           ,[NetCostInstrumentCurrency]
           ,[NetCostBookCurrency]
           ,[DeltaNetCostInstrumentCurrency]
           ,[DeltaNetCostBookCurrency]
           ,[TodayNetPostionChange]
           ,[TodayDeltaNetCostChangeInstrumentCurrency]
           ,[TodayDeltaNetCostChangeBookCurrency]
           ,[TodayNetCostChangeInstrumentCurrency]
           ,[TodayNetCostChangeBookCurrency]
           ,[StartDt]
           ,[UpdateUserID]
		   ,[CurrentPrice]
		   ,[CurrentPriceId]
		   ,[CurrentFXRate]
		   ,[CurrentFXRateId]
		   ,[NotionalMarketValue]
		   ,[TodayCashBenefit]
		   ,[TodayCashBenefitBookCurrency]
		   ,[TodayAccrual]
		   ,[TodayRealisedPricePnl]
		   ,[TodayRealisedFXPnl]
		   ,[TotalAccrual]
		   ,[TodayRealisedPricePnlBookCurrency]
		   ,[UnrealisedFXPnl]
		   ,[UnrealisedPricePnl]
		   ,[MarketValue])
     SELECT
           PositionId, 
           dbo.NextBusinessDate(p.ReferenceDate),
           NetPosition,
           NetCostInstrumentCurrency,
           NetCostBookCurrency,
           DeltaNetCostInstrumentCurrency,
           DeltaNetCostBookCurrency,
           0,
           0,
           0,
           0,
           0,
           GETDATE(),
           @UpdateUserId,
		   [CurrentPrice],
		   newprice.PriceId,
		   [CurrentFXRate],
		   newfx.FXRateId,
		   [NotionalMarketValue],
		   0,
		   0,
		   0,
		   0,
		   0,
		   [TotalAccrual],
		   0,
		   0,
		   0,
		   [MarketValue]
     FROM  [Portfolio] p
	 left outer join price pr on p.currentpriceId = pr.PriceId
	 left outer join price newprice on pr.instrumentMarketId = newprice.InstrumentMarketId and dbo.nextbusinessdate(p.ReferenceDate) = newprice.ReferenceDate and pr.entityrankingschemeid =  newprice.EntityRankingSchemeId
	 left outer join fxrate fx on p.currentfxrateId = fx.FXRateId
	 left outer join FXRate newfx on fx.FromCurrencyId = newfx.FromCurrencyId and fx.ToCurrencyId = newfx.ToCurrencyId and dbo.nextbusinessdate(fx.ReferenceDate) = newFX.ReferenceDate and fx.entityrankingschemeid =  newFX.EntityRankingSchemeId
					and newfx.ForwardDate = case fx.forwardDate when fx.ReferenceDate then dbo.NextBusinessDate(fx.ReferenceDate) else fx.[ForwardDate] end	
	 where p.ReferenceDate = @fromDt
	 and not exists (select 1 
					 from   Portfolio p2
					 where	p.PositionId = p2.PositionId
					 and	p2.ReferenceDate = dbo.NextBusinessDate(p.ReferenceDate))
	 and NetPosition != 0
	 
	 Update	PortfolioRollDate
	 SET	RollDate = dbo.NextBusinessDate(RollDate)
	 where	PortfolioAggregationLevelId = 2
	 
	 select RollDate 
	 from	PortfolioRollDate
	 where	PortfolioAggregationLevelId = 2
GO

