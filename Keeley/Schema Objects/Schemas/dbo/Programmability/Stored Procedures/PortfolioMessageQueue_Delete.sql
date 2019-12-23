USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioMessageQueue_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioMessageQueue_Delete]
GO

CREATE PROCEDURE DBO.[PortfolioMessageQueue_Delete]
		@MessageId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PortfolioMessageQueue_hst (
			MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, EndDt, LastActionUserID)
	SELECT	MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, @EndDt, @UpdateUserID
	FROM	PortfolioMessageQueue
	WHERE	MessageId = @MessageId

	DELETE	PortfolioMessageQueue
	WHERE	MessageId = @MessageId
	AND		DataVersion = @DataVersion
GO
