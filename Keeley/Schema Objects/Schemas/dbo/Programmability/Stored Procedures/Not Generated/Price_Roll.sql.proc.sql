USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Portfolio_Roll]    Script Date: 06/08/2011 17:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[Price_Roll]	
@UpdateUserId int
AS
	declare  @fromDt datetime
	
	select	@fromDt=RollDate
	from	PortfolioRollDate
	where	PortfolioAggregationLevelId = 2
	
	INSERT INTO [Keeley].[dbo].[Price]
           ([InstrumentMarketId]
           ,[ReferenceDate]
           ,[RawPriceId]
		   ,[EntityRankingSchemeId]
           ,[Value]
           ,[StartDt]
           ,[UpdateUserID])
     SELECT
           InstrumentMarketId, 
           dbo.NextBusinessDate(p.ReferenceDate),
           RawPriceId,
		   EntityRankingSchemeId,
           Value,           
           GETDATE(),
           @UpdateUserId
     FROM  Price p where ReferenceDate = @fromDt
	 and not exists (select 1 
					 from   Price p2
					 where	p.[InstrumentMarketId] = p2.[InstrumentMarketId]
					 and	p.[EntityRankingSchemeId] = p2.[EntityRankingSchemeId]
					 and	dbo.NextBusinessDate(p.ReferenceDate) = p2.ReferenceDate)	
	 and exists (select 1 
				 from	Portfolio port
				 where	port.PriceId = p.PriceId
				 and	not (port.NetPosition = 0 and port.TotalAccrual = 0)
				 )

select dbo.NextBusinessDate(@fromDt)
		