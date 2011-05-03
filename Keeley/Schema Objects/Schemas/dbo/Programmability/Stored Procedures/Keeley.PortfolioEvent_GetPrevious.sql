USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioEvent_GetPrevious]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.PortfolioEvent_GetPrevious
GO

CREATE PROCEDURE [DBO].[PortfolioEvent_GetPrevious]
		@PositionAccountID int,
		@ReferenceDate date,
		@PortfolioAggregationLevelId int,
		@PortfolioEventId int = null		
AS		

DECLARE @ChangeNumber int

if @PortfolioEventId is null 
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioEvent m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ReferenceDate <= @ReferenceDate
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		
		SELECT	*
		FROM	PortfolioEvent m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	end
else
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioEvent m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ReferenceDate <= @ReferenceDate
		AND		m.PortfolioEventId != @PortfolioEventId
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		
		SELECT	*
		FROM	PortfolioEvent m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		AND		m.PortfolioEventId != @PortfolioEventId
	end
