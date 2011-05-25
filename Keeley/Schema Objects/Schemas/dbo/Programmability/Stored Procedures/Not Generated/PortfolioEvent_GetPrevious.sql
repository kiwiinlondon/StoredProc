USE [Keeley]
GO
/****** Object:  StoredProcedure [dbo].[PortfolioEvent_GetPrevious]    Script Date: 05/19/2011 18:28:51 ******/
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
		AND		m.ReferenceDate <= @ReferenceDate 
		and		m.InputDate <= @InputDate
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
		AND		m.InputDate <= @InputDate
		AND		m.PortfolioEventId != @PortfolioEventId
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	
		SELECT	*
		FROM	PortfolioEvent m
		WHERE	m.PositionId = @PositionID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		AND		m.PortfolioEventId != @PortfolioEventId
	end

[PortfolioEvent_GetPrevious] 1117,'19-may-2011 17:27:50','19-may-2011 17:28:46',null,2,null

		SELECT	MAX(ChangeNumber)
		FROM	PortfolioEvent m
		WHERE	m.PositionId = 1117
		AND		m.ReferenceDate <= '19-may-2011 17:27:50' 
		and		m.InputDate <= '19-may-2011 17:28:46'
		AND		m.PortfolioAggregationLevelId = 2