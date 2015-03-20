﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FMPortfolio_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FMPortfolio_Insert]
GO

CREATE PROCEDURE DBO.[FMPortfolio_Insert]
		@ReferenceDate datetime, 
		@ISecID int, 
		@BookId int, 
		@Currency varchar(3), 
		@MaturityDate datetime, 
		@NetPosition decimal, 
		@Price decimal, 
		@FXRate decimal, 
		@MarketValue decimal, 
		@DeltaMarketValue decimal, 
		@TotalAccrual decimal, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FMPortfolio
			(ReferenceDate, ISecID, BookId, Currency, MaturityDate, NetPosition, Price, FXRate, MarketValue, DeltaMarketValue, TotalAccrual, UpdateUserID, StartDt)
	VALUES
			(@ReferenceDate, @ISecID, @BookId, @Currency, @MaturityDate, @NetPosition, @Price, @FXRate, @MarketValue, @DeltaMarketValue, @TotalAccrual, @UpdateUserID, @StartDt)

	SELECT	FMPortfolioID, StartDt, DataVersion
	FROM	FMPortfolio
	WHERE	FMPortfolioID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
