USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioByClientShareClass_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioByClientShareClass_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolioByClientShareClass_Insert]
		@ClientId int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@ITDReturn numeric(27,8), 
		@TodayReturn numeric(27,8), 
		@TodayRedemptionPnl numeric(27,8), 
		@OpeningValue numeric(27,8), 
		@OpeningValueAfterTodaysTrades numeric(27,8), 
		@TodayPnl numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolioByClientShareClass
			(ClientId, FundId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, UpdateUserID, StartDt)
	VALUES
			(@ClientId, @FundId, @ReferenceDate, @ITDReturn, @TodayReturn, @TodayRedemptionPnl, @OpeningValue, @OpeningValueAfterTodaysTrades, @TodayPnl, @UpdateUserID, @StartDt)

	SELECT	ClientPortfolioByClientShareClassId, StartDt, DataVersion
	FROM	ClientPortfolioByClientShareClass
	WHERE	ClientPortfolioByClientShareClassId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
