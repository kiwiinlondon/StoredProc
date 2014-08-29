USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioByClientShareClass_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioByClientShareClass_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolioByClientShareClass_Delete]
		@ClientPortfolioByClientShareClassId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolioByClientShareClass_hst (
			ClientPortfolioByClientShareClassId, ClientId, FundId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientPortfolioByClientShareClassId, ClientId, FundId, ReferenceDate, ITDReturn, TodayReturn, TodayRedemptionPnl, OpeningValue, OpeningValueAfterTodaysTrades, TodayPnl, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientPortfolioByClientShareClass
	WHERE	ClientPortfolioByClientShareClassId = @ClientPortfolioByClientShareClassId

	DELETE	ClientPortfolioByClientShareClass
	WHERE	ClientPortfolioByClientShareClassId = @ClientPortfolioByClientShareClassId
	AND		DataVersion = @DataVersion
GO
