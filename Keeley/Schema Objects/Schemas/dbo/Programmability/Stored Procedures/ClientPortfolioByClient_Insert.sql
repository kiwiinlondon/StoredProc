USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioByClient_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioByClient_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolioByClient_Insert]
		@ClientId int, 
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

	INSERT into ClientPortfolioByClient
			(ClientId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, UpdateUserID, StartDt)
	VALUES
			(@ClientId, @ReferenceDate, @ITDReturn, @TodayReturn, @TodayRedemptionPnl, @OpeningValue, @OpeningValueAfterTodaysTrades, @TodayPnl, @UpdateUserID, @StartDt)

	SELECT	ClientPortfolioByClientId, StartDt, DataVersion
	FROM	ClientPortfolioByClient
	WHERE	ClientPortfolioByClientId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
