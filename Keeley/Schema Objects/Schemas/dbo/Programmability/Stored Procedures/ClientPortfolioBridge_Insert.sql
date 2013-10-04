USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioBridge_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioBridge_Insert]
GO

CREATE PROCEDURE DBO.[ClientPortfolioBridge_Insert]
		@ClientAccountId int, 
		@FundId int, 
		@ParentFundId int, 
		@ReferenceDate datetime, 
		@UpdateReturns bit, 
		@ClientFundReturnId int, 
		@AccountFundReturnId int, 
		@UpdateUserID int, 
		@CurrencyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolioBridge
			(ClientAccountId, FundId, ParentFundId, ReferenceDate, UpdateReturns, ClientFundReturnId, AccountFundReturnId, UpdateUserID, CurrencyId, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @ParentFundId, @ReferenceDate, @UpdateReturns, @ClientFundReturnId, @AccountFundReturnId, @UpdateUserID, @CurrencyId, @StartDt)

	SELECT	ClientPortfolioBridgeId, StartDt, DataVersion
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
