﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioPositionAccountMovement_GetPrevious]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioPositionAccountMovement_GetPrevious]
GO

CREATE PROCEDURE [DBO].[PortfolioPositionAccountMovement_GetPrevious]
		@PositionAccountID int,
		@ReferenceDate date,
		@PortfolioAggregationLevelId int,
		@PositionAccountMovementId int = null		
AS		

DECLARE @ChangeNumber int

DECLARE @ChangeNumber int

if @PositionAccountMovementId is null 
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioPositionAccountMovement m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ReferenceDate <= @ReferenceDate
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		
		SELECT	*
		FROM	PortfolioPositionAccountMovement m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
	end
else
	begin
		SELECT	@ChangeNumber = MAX(m.ChangeNumber)
		FROM	PortfolioPositionAccountMovement m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ReferenceDate <= @ReferenceDate
		AND		m.PositionAccountMovementId != @PositionAccountMovementId
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		
		SELECT	*
		FROM	PortfolioPositionAccountMovement m
		WHERE	m.PositionAccountId = @PositionAccountID
		AND		m.ChangeNumber = @ChangeNumber
		AND		m.PortfolioAggregationLevelId = @PortfolioAggregationLevelId
		AND		m.PositionAccountMovementId != @PositionAccountMovementId
	end
