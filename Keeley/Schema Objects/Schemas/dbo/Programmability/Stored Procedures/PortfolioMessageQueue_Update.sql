USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioMessageQueue_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioMessageQueue_Update]
GO

CREATE PROCEDURE DBO.[PortfolioMessageQueue_Update]
		@MessageId int, 
		@PortfolioMessageTypeId int, 
		@Message varchar(-1), 
		@FundId int, 
		@InitiatingEntityId int, 
		@InitiatingEntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PortfolioMessageQueue_hst (
			MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, EndDt, LastActionUserID)
	SELECT	MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, @StartDt, @UpdateUserID
	FROM	PortfolioMessageQueue
	WHERE	MessageId = @MessageId

	UPDATE	PortfolioMessageQueue
	SET		PortfolioMessageTypeId = @PortfolioMessageTypeId, Message = @Message, FundId = @FundId, InitiatingEntityId = @InitiatingEntityId, InitiatingEntityTypeId = @InitiatingEntityTypeId,  StartDt = @StartDt
	WHERE	MessageId = @MessageId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PortfolioMessageQueue
	WHERE	MessageId = @MessageId
	AND		@@ROWCOUNT > 0

GO
