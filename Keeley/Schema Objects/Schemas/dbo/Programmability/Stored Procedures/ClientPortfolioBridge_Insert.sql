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
		@UpdateUserID int, 
		@ClientFundReturnId int, 
		@ClientAccountFundReturnId int, 
		@IsFirst bit, 
		@ClientReturnId int, 
		@MarketValue numeric(27,8)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientPortfolioBridge
			(ClientAccountId, FundId, ParentFundId, ReferenceDate, UpdateUserID, ClientFundReturnId, ClientAccountFundReturnId, IsFirst, ClientReturnId, MarketValue, StartDt)
	VALUES
			(@ClientAccountId, @FundId, @ParentFundId, @ReferenceDate, @UpdateUserID, @ClientFundReturnId, @ClientAccountFundReturnId, @IsFirst, @ClientReturnId, @MarketValue, @StartDt)

	SELECT	ClientPortfolioBridgeId, StartDt, DataVersion
	FROM	ClientPortfolioBridge
	WHERE	ClientPortfolioBridgeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
