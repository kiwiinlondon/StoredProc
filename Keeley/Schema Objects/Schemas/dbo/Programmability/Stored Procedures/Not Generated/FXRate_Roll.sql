USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[Portfolio_Roll]    Script Date: 06/08/2011 17:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Alter PROCEDURE [dbo].[FXRate_Roll]	
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
		   ,[EntityRankingSchemeId]
           ,[Value]
           ,[StartDt]
           ,[UpdateUserID])
     SELECT
           FromCurrencyId, 
		   ToCurrencyId,
		   dbo.NextBusinessDate(p.ReferenceDate), 
		   case p.forwardDate when p.ReferenceDate then dbo.NextBusinessDate(p.ReferenceDate) else p.[ForwardDate] end,
           FromRawFXRateId,
		   ToRawFXRateId,
		   EntityRankingSchemeId,
           Value,           
           GETDATE(),
           @UpdateUserId
     FROM  FXRate p where ReferenceDate = @fromDt
	 and not exists (select 1 
					 from   FXRate p2
					 where	p.[FromCurrencyId] = p2.[FromCurrencyId]
					 and	p.[ToCurrencyId] = p2.[ToCurrencyId]
					 and	p2.forwardDate = (case p.forwardDate when p.ReferenceDate then p2.ReferenceDate else p.[ForwardDate] end)
					 and	p.[EntityRankingSchemeId] = p2.[EntityRankingSchemeId]
					 and	dbo.NextBusinessDate(p.ReferenceDate) = p2.ReferenceDate)	
	 and exists (select 1 
				 from	Portfolio port
				 where	port.FXRateId = p.FXRateId
				 and	port.NetPosition != 0
				 )

select dbo.NextBusinessDate(@fromDt)