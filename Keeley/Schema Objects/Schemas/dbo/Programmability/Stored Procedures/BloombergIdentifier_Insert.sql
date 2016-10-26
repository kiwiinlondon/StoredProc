USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BloombergIdentifier_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BloombergIdentifier_Insert]
GO

CREATE PROCEDURE DBO.[BloombergIdentifier_Insert]
		@InstrumentMarketId int, 
		@CurrencyId int, 
		@Id509 varchar(250), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BloombergIdentifier
			(InstrumentMarketId, CurrencyId, Id509, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @CurrencyId, @Id509, @UpdateUserID, @StartDt)

	SELECT	BloombergIdentifierId, StartDt, DataVersion
	FROM	BloombergIdentifier
	WHERE	BloombergIdentifierId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
