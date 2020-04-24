USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MarketDataMessageQueue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MarketDataMessageQueue_Update]
GO

CREATE PROCEDURE DBO.[MarketDataMessageQueue_Update]
		@MessageId int, 
		@EndPointId int, 
		@MarketDataEntityTypeId int, 
		@MarketDataEntityId int, 
		@Message varchar(-1)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO MarketDataMessageQueue_hst (
			MessageId, EndPointId, MarketDataEntityTypeId, MarketDataEntityId, Message, StartDt, EndDt, LastActionUserID)
	SELECT	MessageId, EndPointId, MarketDataEntityTypeId, MarketDataEntityId, Message, StartDt, @StartDt, @UpdateUserID
	FROM	MarketDataMessageQueue
	WHERE	MessageId = @MessageId

	UPDATE	MarketDataMessageQueue
	SET		EndPointId = @EndPointId, MarketDataEntityTypeId = @MarketDataEntityTypeId, MarketDataEntityId = @MarketDataEntityId, Message = @Message,  StartDt = @StartDt
	WHERE	MessageId = @MessageId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	MarketDataMessageQueue
	WHERE	MessageId = @MessageId
	AND		@@ROWCOUNT > 0

GO
