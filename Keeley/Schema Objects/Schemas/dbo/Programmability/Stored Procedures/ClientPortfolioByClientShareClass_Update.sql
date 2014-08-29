USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioByClientShareClass_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioByClientShareClass_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolioByClientShareClass_Update]
		@ClientPortfolioByClientShareClassId int, 
		@ClientId int, 
		@FundId int, 
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

	INSERT INTO ClientPortfolioByClientShareClass_hst (
			ClientPortfolioByClientShareClassId, ClientId, FundId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPortfolioByClientShareClassId, ClientId, FundId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ClientPortfolioByClientShareClass
	WHERE	ClientPortfolioByClientShareClassId = @ClientPortfolioByClientShareClassId

	UPDATE	ClientPortfolioByClientShareClass
	SET		ClientId = @ClientId, FundId = @FundId, ReferenceDate = @ReferenceDate, ITDReturn = @ITDReturn, TodayReturn = @TodayReturn, TodayRedemptionPnl = @TodayRedemptionPnl, OpeningValue = @OpeningValue, OpeningValueAfterTodaysTrades = @OpeningValueAfterTodaysTrades, TodayPnl = @TodayPnl, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ClientPortfolioByClientShareClassId = @ClientPortfolioByClientShareClassId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioByClientShareClass
	WHERE	ClientPortfolioByClientShareClassId = @ClientPortfolioByClientShareClassId
	AND		@@ROWCOUNT > 0

GO
