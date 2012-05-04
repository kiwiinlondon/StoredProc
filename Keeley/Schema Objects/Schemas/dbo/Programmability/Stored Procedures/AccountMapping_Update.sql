USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AccountMapping_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AccountMapping_Update]
GO

CREATE PROCEDURE DBO.[AccountMapping_Update]
		@AccountMappingId int, 
		@Name varchar(100), 
		@FundId int, 
		@CounterpartyId int, 
		@InstrumentClassId int, 
		@AccountIdToMap int, 
		@AccountId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ApplyToInstrumentOnly bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AccountMapping_hst (
			AccountMappingId, Name, FundId, CounterpartyId, InstrumentClassId, AccountIdToMap, AccountId, UpdateUserID, DataVersion, ApplyToInstrumentOnly, EndDt, LastActionUserID)
	SELECT	AccountMappingId, Name, FundId, CounterpartyId, InstrumentClassId, AccountIdToMap, AccountId, UpdateUserID, DataVersion, ApplyToInstrumentOnly, @StartDt, @UpdateUserID
	FROM	AccountMapping
	WHERE	AccountMappingId = @AccountMappingId

	UPDATE	AccountMapping
	SET		Name = @Name, FundId = @FundId, CounterpartyId = @CounterpartyId, InstrumentClassId = @InstrumentClassId, AccountIdToMap = @AccountIdToMap, AccountId = @AccountId, UpdateUserID = @UpdateUserID, ApplyToInstrumentOnly = @ApplyToInstrumentOnly,  StartDt = @StartDt
	WHERE	AccountMappingId = @AccountMappingId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AccountMapping
	WHERE	AccountMappingId = @AccountMappingId
	AND		@@ROWCOUNT > 0

GO
