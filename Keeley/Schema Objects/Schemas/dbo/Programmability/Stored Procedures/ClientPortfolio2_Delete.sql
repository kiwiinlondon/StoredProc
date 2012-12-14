USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio2_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio2_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolio2_Delete]
		@ClientPortfolioId varchar,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolio2_hst (
			ClientPortfolioId, ReferenceDate, ClientName, AccountName, Value, EndDt, LastActionUserID)
	SELECT	ClientPortfolioId, ReferenceDate, ClientName, AccountName, Value, @EndDt, @UpdateUserID
	FROM	ClientPortfolio2
	WHERE	ClientPortfolioId = @ClientPortfolioId

	DELETE	ClientPortfolio2
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		DataVersion = @DataVersion
GO
