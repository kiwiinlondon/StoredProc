USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AccountMapping_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AccountMapping_Insert]
GO

CREATE PROCEDURE DBO.[AccountMapping_Insert]
		@Name varchar(100), 
		@FundId int, 
		@CounterpartyId int, 
		@InstrumentClassId int, 
		@AccountIdToMap int, 
		@AccountId int, 
		@UpdateUserID int, 
		@ApplyToInstrumentOnly bit, 
		@CountryId int, 
		@MarketId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AccountMapping
			(Name, FundId, CounterpartyId, InstrumentClassId, AccountIdToMap, AccountId, UpdateUserID, ApplyToInstrumentOnly, CountryId, MarketId, StartDt)
	VALUES
			(@Name, @FundId, @CounterpartyId, @InstrumentClassId, @AccountIdToMap, @AccountId, @UpdateUserID, @ApplyToInstrumentOnly, @CountryId, @MarketId, @StartDt)

	SELECT	AccountMappingId, StartDt, DataVersion
	FROM	AccountMapping
	WHERE	AccountMappingId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
