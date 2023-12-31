USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[PortfolioEvent_GetPrevious]    Script Date: 07/29/2011 14:06:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PortfolioEvent_GetPrevious]
		@PositionID int,
		@ReferenceDate datetime,
		@InputDate datetime,
		@OrderingResolution int,
		@PortfolioAggregationLevelId int,
		@PortfolioEventId int = null		
AS		

DECLARE @ChangeNumber int
if @PortfolioEventId is null 
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		(m.ReferenceDate < @ReferenceDate or (m.ReferenceDate = @ReferenceDate and m.InputDate <= @InputDate))
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
		AND		(m.ReferenceDate < @ReferenceDate or (m.ReferenceDate = @ReferenceDate and m.InputDate <= @InputDate))
		AND		m.PortfolioEventId != @PortfolioEventId
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	
		SELECT	*
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		AND		m.PortfolioEventId != @PortfolioEventId
	end
	
	[PortfolioEvent_GetPrevious] 5924,'2011-07-28 14:01:50.000','2011-07-28 15:11:00.000',null,2,null
	
select * from portfolioevent where positionid = 5924 and changenumber >= 1072 and portfolioaggregationlevelid = 2 order by changenumber desc