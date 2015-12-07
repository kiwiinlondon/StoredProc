USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Attribution_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Attribution_Insert]
GO

CREATE PROCEDURE DBO.[Attribution_Insert]
		@PositionId int, 
		@ReferenceDate datetime, 
		@ITDFundAdministratorPrice numeric(27,8), 
		@ITDFundAdministratorFX numeric(27,8), 
		@ITDFundAdministratorCarry numeric(27,8), 
		@ITDFundAdministratorOther numeric(27,8), 
		@ITDFundKeeleyPrice numeric(27,8), 
		@ITDFundKeeleyFX numeric(27,8), 
		@ITDFundKeeleyCarry numeric(27,8), 
		@ITDBookKeeleyPrice numeric(27,8), 
		@ITDBookKeeleyFX numeric(27,8), 
		@ITDBookKeeleyCarry numeric(27,8), 
		@ITDFundValuationPrice numeric(27,8), 
		@ITDFundValuationFX numeric(27,8), 
		@ITDFundValuationCarry numeric(27,8), 
		@ITDFundFactsetPrice numeric(27,8), 
		@ITDFundFactsetFX numeric(27,8), 
		@ITDFundFactsetCarry numeric(27,8), 
		@ITDBookFactsetPrice numeric(27,8), 
		@ITDBookFactsetFX numeric(27,8), 
		@ITDBookFactsetCarry numeric(27,8), 
		@ITDFundPrice numeric(27,8), 
		@ITDFundFX numeric(27,8), 
		@ITDFundCarry numeric(27,8), 
		@ITDBookPrice numeric(27,8), 
		@ITDBookFX numeric(27,8), 
		@ITDBookCarry numeric(27,8), 
		@TodayFundAdministratorPrice numeric(27,8), 
		@TodayFundAdministratorFX numeric(27,8), 
		@TodayFundAdministratorCarry numeric(27,8), 
		@TodayFundAdministratorOther numeric(27,8), 
		@TodayFundKeeleyPrice numeric(27,8), 
		@TodayFundKeeleyFX numeric(27,8), 
		@TodayFundKeeleyCarry numeric(27,8), 
		@TodayBookKeeleyPrice numeric(27,8), 
		@TodayBookKeeleyFX numeric(27,8), 
		@TodayBookKeeleyCarry numeric(27,8), 
		@TodayFundValuationPrice numeric(27,8), 
		@TodayFundValuationFX numeric(27,8), 
		@TodayFundValuationCarry numeric(27,8), 
		@TodayFundFactsetPrice numeric(27,8), 
		@TodayFundFactsetFX numeric(27,8), 
		@TodayFundFactsetCarry numeric(27,8), 
		@TodayBookFactsetPrice numeric(27,8), 
		@TodayBookFactsetFX numeric(27,8), 
		@TodayBookFactsetCarry numeric(27,8), 
		@TodayFundPrice numeric(27,8), 
		@TodayFundFX numeric(27,8), 
		@TodayFundCarry numeric(27,8), 
		@TodayBookPrice numeric(27,8), 
		@TodayBookFX numeric(27,8), 
		@TodayBookCarry numeric(27,8), 
		@UpdateUserID int, 
		@PortfolioId int, 
		@OpeningBookNav numeric(27,8), 
		@OpeningFundNav numeric(27,8), 
		@CapitalChangeBook numeric(27,8), 
		@CapitalChangeFund numeric(27,8), 
		@AdministratorOpeningNav numeric(27,8), 
		@OpeningValuationNav numeric(27,8), 
		@TotalContributionSinceLastValuation numeric(27,8), 
		@AttributionSourceId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Attribution
			(PositionId, ReferenceDate, ITDFundAdministratorPrice, ITDFundAdministratorFX, ITDFundAdministratorCarry, ITDFundAdministratorOther, ITDFundKeeleyPrice, ITDFundKeeleyFX, ITDFundKeeleyCarry, ITDBookKeeleyPrice, ITDBookKeeleyFX, ITDBookKeeleyCarry, ITDFundValuationPrice, ITDFundValuationFX, ITDFundValuationCarry, ITDFundFactsetPrice, ITDFundFactsetFX, ITDFundFactsetCarry, ITDBookFactsetPrice, ITDBookFactsetFX, ITDBookFactsetCarry, ITDFundPrice, ITDFundFX, ITDFundCarry, ITDBookPrice, ITDBookFX, ITDBookCarry, TodayFundAdministratorPrice, TodayFundAdministratorFX, TodayFundAdministratorCarry, TodayFundAdministratorOther, TodayFundKeeleyPrice, TodayFundKeeleyFX, TodayFundKeeleyCarry, TodayBookKeeleyPrice, TodayBookKeeleyFX, TodayBookKeeleyCarry, TodayFundValuationPrice, TodayFundValuationFX, TodayFundValuationCarry, TodayFundFactsetPrice, TodayFundFactsetFX, TodayFundFactsetCarry, TodayBookFactsetPrice, TodayBookFactsetFX, TodayBookFactsetCarry, TodayFundPrice, TodayFundFX, TodayFundCarry, TodayBookPrice, TodayBookFX, TodayBookCarry, UpdateUserID, PortfolioId, OpeningBookNav, OpeningFundNav, CapitalChangeBook, CapitalChangeFund, AdministratorOpeningNav, OpeningValuationNav, TotalContributionSinceLastValuation, AttributionSourceId, StartDt)
	VALUES
			(@PositionId, @ReferenceDate, @ITDFundAdministratorPrice, @ITDFundAdministratorFX, @ITDFundAdministratorCarry, @ITDFundAdministratorOther, @ITDFundKeeleyPrice, @ITDFundKeeleyFX, @ITDFundKeeleyCarry, @ITDBookKeeleyPrice, @ITDBookKeeleyFX, @ITDBookKeeleyCarry, @ITDFundValuationPrice, @ITDFundValuationFX, @ITDFundValuationCarry, @ITDFundFactsetPrice, @ITDFundFactsetFX, @ITDFundFactsetCarry, @ITDBookFactsetPrice, @ITDBookFactsetFX, @ITDBookFactsetCarry, @ITDFundPrice, @ITDFundFX, @ITDFundCarry, @ITDBookPrice, @ITDBookFX, @ITDBookCarry, @TodayFundAdministratorPrice, @TodayFundAdministratorFX, @TodayFundAdministratorCarry, @TodayFundAdministratorOther, @TodayFundKeeleyPrice, @TodayFundKeeleyFX, @TodayFundKeeleyCarry, @TodayBookKeeleyPrice, @TodayBookKeeleyFX, @TodayBookKeeleyCarry, @TodayFundValuationPrice, @TodayFundValuationFX, @TodayFundValuationCarry, @TodayFundFactsetPrice, @TodayFundFactsetFX, @TodayFundFactsetCarry, @TodayBookFactsetPrice, @TodayBookFactsetFX, @TodayBookFactsetCarry, @TodayFundPrice, @TodayFundFX, @TodayFundCarry, @TodayBookPrice, @TodayBookFX, @TodayBookCarry, @UpdateUserID, @PortfolioId, @OpeningBookNav, @OpeningFundNav, @CapitalChangeBook, @CapitalChangeFund, @AdministratorOpeningNav, @OpeningValuationNav, @TotalContributionSinceLastValuation, @AttributionSourceId, @StartDt)

	SELECT	AttributionID, StartDt, DataVersion
	FROM	Attribution
	WHERE	AttributionID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
