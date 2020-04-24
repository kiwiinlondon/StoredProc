USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MarketDataMessageQueue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MarketDataMessageQueue_Delete]
GO

CREATE PROCEDURE DBO.[MarketDataMessageQueue_Delete]
		@MessageId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO MarketDataMessageQueue_hst (
			MessageId, EndPointId, MarketDataEntityTypeId, MarketDataEntityId, Message, StartDt, EndDt, LastActionUserID)
	SELECT	MessageId, EndPointId, MarketDataEntityTypeId, MarketDataEntityId, Message, StartDt, @EndDt, @UpdateUserID
	FROM	MarketDataMessageQueue
	WHERE	MessageId = @MessageId

	DELETE	MarketDataMessageQueue
	WHERE	MessageId = @MessageId
	AND		DataVersion = @DataVersion
GO
