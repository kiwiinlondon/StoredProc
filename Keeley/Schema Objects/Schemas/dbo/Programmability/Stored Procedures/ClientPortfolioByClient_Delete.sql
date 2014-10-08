USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioByClient_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioByClient_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolioByClient_Delete]
		@ClientPortfolioByClientId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolioByClient_hst (
			ClientPortfolioByClientId, ClientId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPortfolioByClientId, ClientId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientPortfolioByClient
	WHERE	ClientPortfolioByClientId = @ClientPortfolioByClientId

	DELETE	ClientPortfolioByClient
	WHERE	ClientPortfolioByClientId = @ClientPortfolioByClientId
	AND		DataVersion = @DataVersion
GO
