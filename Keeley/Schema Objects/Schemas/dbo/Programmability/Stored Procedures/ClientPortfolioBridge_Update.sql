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
		@IsFirst bit, 
		@MarketValue numeric(27,8), 
		@Cost numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ClientPortfolioBridge_hst (
			ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, StartDt, UpdateUserID, DataVersion, IsFirst, MarketValue, Cost, EndDt, LastActionUserID)
	SELECT	ClientPortfolioBridgeId, ClientAccountId, FundId, ParentFundId, ReferenceDate, StartDt, UpdateUserID, DataVersion, IsFirst, MarketValue, Cost, @StartDt, @UpdateUserID
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId

	UPDATE	ClientPortfolioBridge
	SET		ClientAccountId = @ClientAccountId, FundId = @FundId, ParentFundId = @ParentFundId, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID, IsFirst = @IsFirst, MarketValue = @MarketValue, Cost = @Cost,  StartDt = @StartDt
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = @ClientPortfolioBridgeId
	AND		@@ROWCOUNT > 0

GO
