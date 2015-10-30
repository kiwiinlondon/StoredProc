USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AccountMapping_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AccountMapping_Delete]
GO

CREATE PROCEDURE DBO.[AccountMapping_Delete]
		@AccountMappingId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AccountMapping_hst (
			AccountMappingId, Name, FundId, CounterpartyId, InstrumentClassId, AccountIdToMap, AccountId, UpdateUserID, DataVersion, ApplyToInstrumentOnly, CountryId, MarketId, SendAlertOnly, EndDt, LastActionUserID)
	SELECT	AccountMappingId, Name, FundId, CounterpartyId, InstrumentClassId, AccountIdToMap, AccountId, UpdateUserID, DataVersion, ApplyToInstrumentOnly, CountryId, MarketId, SendAlertOnly, @EndDt, @UpdateUserID
	FROM	AccountMapping
	WHERE	AccountMappingId = @AccountMappingId

	DELETE	AccountMapping
	WHERE	AccountMappingId = @AccountMappingId
	AND		DataVersion = @DataVersion
GO
