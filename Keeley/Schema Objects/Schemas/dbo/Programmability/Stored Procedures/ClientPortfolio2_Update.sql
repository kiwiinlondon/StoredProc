USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio2_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio2_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolio2_Update]
		@ClientPortfolioId varchar(50), 
		@ReferenceDate int, 
		@ClientName varchar(100), 
		@AccountName varchar(20), 
		@Value numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolio2_hst (
			ClientPortfolioId, ReferenceDate, ClientName, AccountName, Value, EndDt, LastActionUserID)
	SELECT	ClientPortfolioId, ReferenceDate, ClientName, AccountName, Value, @StartDt, @UpdateUserID
	FROM	ClientPortfolio2
	WHERE	ClientPortfolioId = @ClientPortfolioId

	UPDATE	ClientPortfolio2
	SET		ReferenceDate = @ReferenceDate, ClientName = @ClientName, AccountName = @AccountName, Value = @Value,  StartDt = @StartDt
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolio2
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		@@ROWCOUNT > 0

GO
