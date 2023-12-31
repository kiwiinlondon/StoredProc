USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[FXRate_Roll]    Script Date: 07/29/2011 08:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[FXRate_Roll]	
@UpdateUserId int
AS
	declare  @fromDt datetime
	
	select	@fromDt=RollDate
	from	PortfolioRollDate
	where	PortfolioAggregationLevelId = 2
	
	INSERT INTO [Keeley].[dbo].[FXRate]
           ([FromCurrencyId]
		   ,[ToCurrencyId]
           ,[ReferenceDate]
		   ,[ForwardDate]
           ,[FromRawFXRateId]
		   ,[ToRawFXRateId]
           ,[FromSecondRawFXRateId]
		   ,[ToSecondRawFXRateId]		   
		   ,[EntityRankingSchemeId]
           ,[Value]
           ,[StartDt]
           ,[UpdateUserID])
     SELECT
           FromCurrencyId, 
		   ToCurrencyId,
		   dbo.NextBusinessDate(p.ReferenceDate), 
		   dbo.NextForwardDate(p.ReferenceDate,p.ForwardDate), 
           FromRawFXRateId,
		   ToRawFXRateId,
		   FromSecondRawFXRateId,
		   ToSecondRawFXRateId,
		   EntityRankingSchemeId,
           Value,           
           GETDATE(),
           @UpdateUserId
     FROM  FXRate p where ReferenceDate = @fromDt
     and	datediff(dd,p.ReferenceDate,p.ForwardDate) not between 1 and 2 
	 and not exists (select 1 
					 from   FXRate p2
					 where	p.[FromCurrencyId] = p2.[FromCurrencyId]
					 and	p.[ToCurrencyId] = p2.[ToCurrencyId]
					 and	dbo.NextForwardDate(p.ReferenceDate,p.forwardDate) =  p2.[ForwardDate]
					 and	p.[EntityRankingSchemeId] = p2.[EntityRankingSchemeId]
					 and	dbo.NextBusinessDate(p.ReferenceDate) = p2.ReferenceDate)	
	 and (exists (select 1 
				 from	Portfolio port
				 where	port.FXRateId = p.FXRateId
				 and	not (port.NetPosition = 0 and port.TotalAccrual = 0)) or
		exists (select 1 
				 from	Portfolio port
				 where	port.PriceToPositionFXRateId = p.FXRateId
				 and	not (port.NetPosition = 0 and port.TotalAccrual = 0))		 				 
				 )
select dbo.NextBusinessDate(@fromDt)


	