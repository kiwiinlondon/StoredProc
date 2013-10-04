USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioBridge_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioBridge_Update]
GO

CREATE PROCEDURE DBO.[ClientPortfolioBridge_Update]
		@ClientPortfolioBridgeId int, 
		@ClientAccountId int, 
		@FundId int, 
		@ParentFundId int, 
		@ReferenceDate datetime, 
		@UpdateReturns bit, 
		@ClientFundReturnId int, 
		@AccountFundReturnId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@CurrencyId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioBridge_hst (
			ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, UpdateReturns, ClientFundReturnId, AccountFundReturnId, StartDt, UpdateUserID, DataVersion, CurrencyId, EndDt, LastActionUserID)
	SELECT	ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, UpdateReturns, ClientFundReturnId, AccountFundReturnId, StartDt, UpdateUserID, DataVersion, CurrencyId, @StartDt, @UpdateUserID
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId

	UPDATE	ClientPortfolioBridge
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ParentFundId = @ParentFundId, ReferenceDate = @ReferenceDate, UpdateReturns = @UpdateReturns, ClientFundReturnId = @ClientFundReturnId, AccountFundReturnId = @AccountFundReturnId, UpdateUserID = @UpdateUserID, CurrencyId = @CurrencyId,  StartDt = @StartDt
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		@@ROWCOUNT > 0

GO
