USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarketProxy_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarketProxy_Update]
GO

CREATE PROCEDURE DBO.[InstrumentMarketProxy_Update]
		@InstrumentMarketProxyId int, 
		@InstrumentMarketId int, 
		@ProxyInstrumentMarketId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO InstrumentMarketProxy_hst (
			InstrumentMarketProxyId, InstrumentMarketId, ProxyInstrumentMarketId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentMarketProxyId, InstrumentMarketId, ProxyInstrumentMarketId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	InstrumentMarketProxy
	WHERE	InstrumentMarketProxyId = @InstrumentMarketProxyId

	UPDATE	InstrumentMarketProxy
	SET		InstrumentMarketId = @InstrumentMarketId, ProxyInstrumentMarketId = @ProxyInstrumentMarketId, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	InstrumentMarketProxyId = @InstrumentMarketProxyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	InstrumentMarketProxy
	WHERE	InstrumentMarketProxyId = @InstrumentMarketProxyId
	AND		@@ROWCOUNT > 0

GO
