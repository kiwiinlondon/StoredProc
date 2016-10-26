USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BloombergIdentifier_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BloombergIdentifier_Update]
GO

CREATE PROCEDURE DBO.[BloombergIdentifier_Update]
		@BloombergIdentifierId int, 
		@InstrumentMarketId int, 
		@CurrencyId int, 
		@Id509 varchar(250), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO BloombergIdentifier_hst (
			BloombergIdentifierId, InstrumentMarketId, CurrencyId, Id509, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BloombergIdentifierId, InstrumentMarketId, CurrencyId, Id509, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	BloombergIdentifier
	WHERE	BloombergIdentifierId = @BloombergIdentifierId

	UPDATE	BloombergIdentifier
	SET		InstrumentMarketId = @InstrumentMarketId, CurrencyId = @CurrencyId, Id509 = @Id509, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	BloombergIdentifierId = @BloombergIdentifierId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	BloombergIdentifier
	WHERE	BloombergIdentifierId = @BloombergIdentifierId
	AND		@@ROWCOUNT > 0

GO
