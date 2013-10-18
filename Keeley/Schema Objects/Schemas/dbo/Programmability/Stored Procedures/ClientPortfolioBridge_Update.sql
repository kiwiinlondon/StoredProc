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
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ClientFundReturnId int, 
		@ClientAccountFundReturnId int, 
		@IsFirst bit, 
		@ClientReturnId int, 
		@MarketValue numeric(27,8), 
		@ClientId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioBridge_hst (
			ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, StartDt, UpdateUserID, DataVersion, ClientFundReturnId, ClientAccountFundReturnId, IsFirst, ClientReturnId, MarketValue, ClientId, EndDt, LastActionUserID)
	SELECT	ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, StartDt, UpdateUserID, DataVersion, ClientFundReturnId, ClientAccountFundReturnId, IsFirst, ClientReturnId, MarketValue, ClientId, @StartDt, @UpdateUserID
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId

	UPDATE	ClientPortfolioBridge
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ParentFundId = @ParentFundId, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID, ClientFundReturnId = @ClientFundReturnId, ClientAccountFundReturnId = @ClientAccountFundReturnId, IsFirst = @IsFirst, ClientReturnId = @ClientReturnId, MarketValue = @MarketValue, ClientId = @ClientId,  StartDt = @StartDt
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		@@ROWCOUNT > 0

GO
