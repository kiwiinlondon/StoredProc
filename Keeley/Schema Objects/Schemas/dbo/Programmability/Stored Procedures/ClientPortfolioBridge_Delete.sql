USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientPortfolioBridge_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientPortfolioBridge_Delete]
GO

CREATE PROCEDURE DBO.[ClientPortfolioBridge_Delete]
		@ClientPortfolioBridgeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientPortfolioBridge_hst (
			ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, UpdateReturns, ClientFundReturnId, AccountFundReturnId, StartDt, UpdateUserID, DataVersion, CurrencyId, EndDt, LastActionUserID)
	SELECT	ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, UpdateReturns, ClientFundReturnId, AccountFundReturnId, StartDt, UpdateUserID, DataVersion, CurrencyId, @EndDt, @UpdateUserID
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId

	DELETE	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		DataVersion = @DataVersion
GO
