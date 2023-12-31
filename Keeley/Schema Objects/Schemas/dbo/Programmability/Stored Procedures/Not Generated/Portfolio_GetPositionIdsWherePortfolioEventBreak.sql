USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Portfolio_GetPositionIdsWherePortfolioEventBreak]    Script Date: 06/22/2011 18:53:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Portfolio_GetPositionIdsWherePortfolioEventBreak] as
select	distinct p.PositionId--,a.ReferenceDate,a.PortfolioAggregationLevelId 
from	PortfolioEvent p,
		PortfolioEvent b
where	p.positionId = b.positionId
and		p.portfolioaggregationlevelid = b.portfolioaggregationlevelid
and		p.changeNumber = b.changeNumber-1
and		((p.referencedate > b.referencedate) or 
		 (p.referencedate = b.referencedate and p.inputdate > b.inputdate) or
		 (p.referencedate = b.referencedate and p.inputdate = b.inputdate and p.orderingresolution >= b.orderingresolution))		 

select distinct positionid from portfolio where   positionid in (
select  positionid from position where instrumentmarketid 
in (select instrumentmarketid from instrumentmarket where instrumentid in ( select instrumentid from instrument where instrumentclassid in (26,3))))

select * from instrumentclass

select distinct isnull(e.positionid,p.positionid) 
from	PortfolioEvent e join
	(select	dateadd(dd,0, datediff(dd,0, referencedate)) referencedate,PositionId,MAX(ChangeNumber)changeNumber,PortfolioAggregationLevelId
	from	PortfolioEvent
	where	PortfolioAggregationLevelId = 2
	and		ReferenceDate < = GETDATE()
	group by PositionId,dateadd(dd,0, datediff(dd,0, referencedate)),PortfolioAggregationLevelId) m
	on	m.PositionId = e.PositionId	
	and		m.changeNumber = e.changeNumber
	and		m.PortfolioAggregationLevelId = e.PortfolioAggregationLevelId
 full outer join Portfolio  p on m.referencedate = p.ReferenceDate and m.PositionId = p.PositionId
where isnull(e.NetPosition,p.NetPosition) != isnull(p.NetPosition,0) 
or isnull(e.TodayNetPositionChange,0) != isnull(p.TodayNetPostionChange,0)
or isnull(e.TodayAccrual,0) != isnull(p.TodayAccrual,0)
or isnull(e.TotalAccrual,0) != isnull(p.TotalAccrual,0)
or isnull(e.TodayCashBenefit,0) != isnull(p.TodayCashBenefit,0)
or isnull(e.TodayCashBenefitBookCurrency,0) != isnull(p.TodayCashBenefitBookCurrency,0)
union
select distinct p.PositionID from PortfolioEvent p where ChangeNumber = -1
union 
select distinct p.PositionID from PortfolioEvent p where NetPosition between -.9999 and .99999 and NetPosition !=0 
union 
select	distinct p.PositionId--,a.ReferenceDate,a.PortfolioAggregationLevelId 
from	PortfolioEvent p,
		PortfolioEvent b
where	p.positionId = b.positionId
and		p.portfolioaggregationlevelid = b.portfolioaggregationlevelid
and		p.changeNumber = b.changeNumber-1
and		((p.referencedate > b.referencedate) or 
		 (p.referencedate = b.referencedate and p.inputdate > b.inputdate) or
		 (p.referencedate = b.referencedate and p.inputdate = b.inputdate and p.orderingresolution >= b.orderingresolution))		 
union
select	distinct b.positionid
from	PortfolioEvent b
left outer join PortfolioEvent a on a.positionId = b.positionId and	a.portfolioaggregationlevelid = b.portfolioaggregationlevelid and a.changeNumber = b.changeNumber-1
where isnull(a.NetPosition,0) + case b.realisepnl when 1 then 0 else b.Quantity end not between b.NetPosition-1 and b.NetPosition+1	

