USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InstrumentMarketProxy_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InstrumentMarketProxy_Insert]
GO

CREATE PROCEDURE DBO.[InstrumentMarketProxy_Insert]
		@InstrumentMarketId int, 
		@ProxyInstrumentMarketId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InstrumentMarketProxy
			(InstrumentMarketId, ProxyInstrumentMarketId, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @ProxyInstrumentMarketId, @UpdateUserID, @StartDt)

	SELECT	InstrumentMarketProxyId, StartDt, DataVersion
	FROM	InstrumentMarketProxy
	WHERE	InstrumentMarketProxyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
