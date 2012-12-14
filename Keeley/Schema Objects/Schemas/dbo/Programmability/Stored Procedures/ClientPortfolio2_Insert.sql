USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolio2_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolio2_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolio2_Insert]
		@ClientPortfolioId varchar(50), 
		@ReferenceDate int, 
		@ClientName varchar(100), 
		@AccountName varchar(20), 
		@Value numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolio2
			(ClientPortfolioId, ReferenceDate, ClientName, AccountName, Value, StartDt)
	VALUES
			(@ClientPortfolioId, @ReferenceDate, @ClientName, @AccountName, @Value, @StartDt)

	SELECT	ClientPortfolioId, StartDt, DataVersion
	FROM	ClientPortfolio2
	WHERE	ClientPortfolioId = @ClientPortfolioId
	AND		@@ROWCOUNT > 0

GO
