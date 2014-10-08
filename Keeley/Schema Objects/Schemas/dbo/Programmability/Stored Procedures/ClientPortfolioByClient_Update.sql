USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioByClient_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioByClient_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolioByClient_Update]
		@ClientPortfolioByClientId int, 
		@ClientId int, 
		@ReferenceDate datetime, 
		@ITDReturn numeric(27,8), 
		@TodayReturn numeric(27,8), 
		@TodayRedemptionPnl numeric(27,8), 
		@OpeningValue numeric(27,8), 
		@OpeningValueAfterTodaysTrades numeric(27,8), 
		@TodayPnl numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioByClient_hst (
			ClientPortfolioByClientId, ClientId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPortfolioByClientId, ClientId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientPortfolioByClient
	WHERE	ClientPortfolioByClientId = @ClientPortfolioByClientId

	UPDATE	ClientPortfolioByClient
	SET		ClientId = @ClientId, ReferenceDate = @ReferenceDate, ITDReturn = @ITDReturn, TodayReturn = @TodayReturn, TodayRedemptionPnl = @TodayRedemptionPnl, OpeningValue = @OpeningValue, OpeningValueAfterTodaysTrades = @OpeningValueAfterTodaysTrades, TodayPnl = @TodayPnl, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientPortfolioByClientId = @ClientPortfolioByClientId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioByClient
	WHERE	ClientPortfolioByClientId = @ClientPortfolioByClientId
	AND		@@ROWCOUNT > 0

GO
