USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BloombergIdentifier_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BloombergIdentifier_Delete]
GO

CREATE PROCEDURE DBO.[BloombergIdentifier_Delete]
		@BloombergIdentifierId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO BloombergIdentifier_hst (
			BloombergIdentifierId, InstrumentMarketId, CurrencyId, Id509, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	BloombergIdentifierId, InstrumentMarketId, CurrencyId, Id509, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	BloombergIdentifier
	WHERE	BloombergIdentifierId = @BloombergIdentifierId

	DELETE	BloombergIdentifier
	WHERE	BloombergIdentifierId = @BloombergIdentifierId
	AND		DataVersion = @DataVersion
GO
