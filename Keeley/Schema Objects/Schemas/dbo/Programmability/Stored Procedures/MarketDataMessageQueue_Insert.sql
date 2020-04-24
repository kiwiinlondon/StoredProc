USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[MarketDataMessageQueue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[MarketDataMessageQueue_Insert]
GO

CREATE PROCEDURE DBO.[MarketDataMessageQueue_Insert]
		@EndPointId int, 
		@MarketDataEntityTypeId int, 
		@MarketDataEntityId int, 
		@Message varchar(-1)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into MarketDataMessageQueue
			(EndPointId, MarketDataEntityTypeId, MarketDataEntityId, Message, StartDt)
	VALUES
			(@EndPointId, @MarketDataEntityTypeId, @MarketDataEntityId, @Message, @StartDt)

	SELECT	MessageId, StartDt, DataVersion
	FROM	MarketDataMessageQueue
	WHERE	MessageId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
