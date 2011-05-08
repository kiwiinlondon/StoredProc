USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[PortfolioEvent_GetPrevious]    Script Date: 05/07/2011 13:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[PortfolioEvent_GetPrevious]
		@PositionID int,
		@ReferenceDate date,
		@PortfolioAggregationLevelId int,
		@PortfolioEventId int = null		
AS		

DECLARE @ChangeNumber int

if @PortfolioEventId is null 
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		m.ReferenceDate <= @ReferenceDate
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		
		SELECT	*
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	end
else
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		m.ReferenceDate <= @ReferenceDate
		AND		m.PortfolioEventId != @PortfolioEventId
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		
		SELECT	*
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		AND		m.PortfolioEventId != @PortfolioEventId
	end

sp_rename 'Portfolio.PortfolioTradeDateId', 'PortfolioId'

sp_rename PortfolioTradeDate, Portfolio

drop table Portfolio_hst