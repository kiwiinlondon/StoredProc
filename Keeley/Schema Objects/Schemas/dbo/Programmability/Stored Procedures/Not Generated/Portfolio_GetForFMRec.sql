USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Portfolio_GetForFMRec]    Script Date: 06/23/2011 07:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Portfolio_GetForFMRec]
	@fundId int, 
	@fromDt datetime,
	@toDt datetime
AS
	select	p.ReferenceDate,
		b.FMOrgId,
		im.FMSecId,
		ccy.Name,
		sum(NetPosition) NetPosition, 
		--UnitCost,
		avg(Price*p.priceToPositionFXRate) Price,
		avg(FXRate) FXRate,
		sum(MarketValue) MarketValue,
		sum(DeltaMarketValue)DeltaMarketValue,
		--sum(TodayAccrual*FXRate) TodayAccrual,
		--casesum(TotalAccrual*FXRate) TotalAccrual,
		--sum(TodayCashBenefitBookCurrency) CashIncome,
		--sum(TodayRealisedFXPNL) RealisedFXPNL,
		--sum(TodayUnRealisedFXPNL)TodayUnRealisedFXPNL,
		--sum(TodayUnRealisedPricePNL) UnRealisedPNL,
		--sum(TodayRealisedPricePNLBookCurrency) RealisedPricePNL,
		sum((case rp.entityrankingschemeitemid when 14 then 0 else TodayUnRealisedFXPNL end) + TodayUnRealisedPricePNL + TodayRealisedFXPNL + TodayRealisedPricePNLBookCurrency) TotalPnl
from	Portfolio p
join	Position pos on p.PositionID = pos.PositionID
join	Book b on pos.BookID = b.BookID
join 	InstrumentMarket im on pos.InstrumentMarketID = im.InstrumentMarketID
join 	Instrument ccy on pos.CurrencyID = ccy.InstrumentID
left outer join Price pr on p.priceid = pr.priceid
left outer join RawPrice rp on pr.rawpriceid = rp.rawpriceid
where	b.FundID = @fundId
and		p.ReferenceDate between @fromDt and @toDt
group by p.ReferenceDate,
		b.FMOrgId,
		im.FMSecId,
		ccy.Name
order by  
		b.FMOrgId,
		im.FMSecId,
		p.ReferenceDate
		
[Portfolio_GetForFMRec] 741 , '8-jun-2011','8-jun-2011'

362165

select * from tradeevent where grossconsideration = 0 and netprice != 0

select * from instrument where instrumentid in (2541)

select * from instrumentmarket where fmsecid = 106037
select * from book where 

select * from position where instrumentmarketid = 199
select p.deltanetcostinstrumentcurrency/netposition, p.realisepnl,p.quantity,netPosition,p.* from portfolioevent p where positionid in (3603) and portfolioaggregationlevelid = 2 
and referencedate between '10-may-2011' and '9-jun-2011'
order by changenumber

select * from internalaccountingevent where internalaccountingeventtypeid = 2 and quantity <0

select * from internalallocation where eventid = 68147

 and referencedate between '8-jun-2011' and '9-jun-2011'

select * from portfolioevent where positionid in (5619) --and referencedate between '8-jun-2011' and '9-jun-2011'
and portfolioaggregationlevelid = 2

update p set fxrateid = null 
from portfolio p
where fxrateid in (

delete
from	rawfxrate
where	forwarddate != referencedate)
