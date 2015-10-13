USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Attribution_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Attribution_Delete]
GO

CREATE PROCEDURE DBO.[Attribution_Delete]
		@AttributionID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Attribution_hst (
			AttributionID, PositionId, ReferenceDate, ITDFundAdministratorPrice, ITDFundAdministratorFX, ITDFundAdministratorCarry, ITDFundAdministratorOther, ITDFundKeeleyPrice, ITDFundKeeleyFX, ITDFundKeeleyCarry, ITDBookKeeleyPrice, ITDBookKeeleyFX, ITDBookKeeleyCarry, ITDFundValuationPrice, ITDFundValuationFX, ITDFundValuationCarry, ITDFundFactsetPrice, ITDFundFactsetFX, ITDFundFactsetCarry, ITDBookFactsetPrice, ITDBookFactsetFX, ITDBookFactsetCarry, ITDFundPrice, ITDFundFX, ITDFundCarry, ITDBookPrice, ITDBookFX, ITDBookCarry, TodayFundAdministratorPrice, TodayFundAdministratorFX, TodayFundAdministratorCarry, TodayFundAdministratorOther, TodayFundKeeleyPrice, TodayFundKeeleyFX, TodayFundKeeleyCarry, TodayBookKeeleyPrice, TodayBookKeeleyFX, TodayBookKeeleyCarry, TodayFundValuationPrice, TodayFundValuationFX, TodayFundValuationCarry, TodayFundFactsetPrice, TodayFundFactsetFX, TodayFundFactsetCarry, TodayBookFactsetPrice, TodayBookFactsetFX, TodayBookFactsetCarry, TodayFundPrice, TodayFundFX, TodayFundCarry, TodayBookPrice, TodayBookFX, TodayBookCarry, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionID, PositionId, ReferenceDate, ITDFundAdministratorPrice, ITDFundAdministratorFX, ITDFundAdministratorCarry, ITDFundAdministratorOther, ITDFundKeeleyPrice, ITDFundKeeleyFX, ITDFundKeeleyCarry, ITDBookKeeleyPrice, ITDBookKeeleyFX, ITDBookKeeleyCarry, ITDFundValuationPrice, ITDFundValuationFX, ITDFundValuationCarry, ITDFundFactsetPrice, ITDFundFactsetFX, ITDFundFactsetCarry, ITDBookFactsetPrice, ITDBookFactsetFX, ITDBookFactsetCarry, ITDFundPrice, ITDFundFX, ITDFundCarry, ITDBookPrice, ITDBookFX, ITDBookCarry, TodayFundAdministratorPrice, TodayFundAdministratorFX, TodayFundAdministratorCarry, TodayFundAdministratorOther, TodayFundKeeleyPrice, TodayFundKeeleyFX, TodayFundKeeleyCarry, TodayBookKeeleyPrice, TodayBookKeeleyFX, TodayBookKeeleyCarry, TodayFundValuationPrice, TodayFundValuationFX, TodayFundValuationCarry, TodayFundFactsetPrice, TodayFundFactsetFX, TodayFundFactsetCarry, TodayBookFactsetPrice, TodayBookFactsetFX, TodayBookFactsetCarry, TodayFundPrice, TodayFundFX, TodayFundCarry, TodayBookPrice, TodayBookFX, TodayBookCarry, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Attribution
	WHERE	AttributionID = @AttributionID

	DELETE	Attribution
	WHERE	AttributionID = @AttributionID
	AND		DataVersion = @DataVersion
GO
