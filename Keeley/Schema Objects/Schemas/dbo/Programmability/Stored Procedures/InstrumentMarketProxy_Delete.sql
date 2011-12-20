USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarketProxy_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarketProxy_Delete]
GO

CREATE PROCEDURE DBO.[InstrumentMarketProxy_Delete]
		@InstrumentMarketProxyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO InstrumentMarketProxy_hst (
			InstrumentMarketProxyId, InstrumentMarketId, ProxyInstrumentMarketId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	InstrumentMarketProxyId, InstrumentMarketId, ProxyInstrumentMarketId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	InstrumentMarketProxy
	WHERE	InstrumentMarketProxyId = @InstrumentMarketProxyId

	DELETE	InstrumentMarketProxy
	WHERE	InstrumentMarketProxyId = @InstrumentMarketProxyId
	AND		DataVersion = @DataVersion
GO
