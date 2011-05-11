USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioSettlementDate_Roll]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioSettlementDate_Roll]
GO

CREATE PROCEDURE [DBO].[PortfolioSettlementDate_Roll]	
	@fromDt datetime,
	@UpdateUserId int
AS
	INSERT INTO [Keeley].[dbo].[PortfolioSettlementDate]
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
           ,[UpdateUserID])
     SELECT
           PositionId, 
           ReferenceDate+1,
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
           @UpdateUserId
     FROM  [PortfolioSettlementDate] p where ReferenceDate = @fromDt
	 and not exists (select 1 
					 from   PortfolioSettlementDate p2
					 where	p.PositionId = p2.PositionId
					 and	p2.ReferenceDate = p.ReferenceDate+1)	
	 and NetPosition != 0
	 
	 declare @rowcount int 
	 set @rowcount = @@ROWCOUNT
	 select @rowcount
GO

