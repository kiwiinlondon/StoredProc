USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PortfolioMessageQueue_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PortfolioMessageQueue_Insert]
GO

CREATE PROCEDURE DBO.[PortfolioMessageQueue_Insert]
		@PortfolioMessageTypeId int, 
		@Message varchar(-1), 
		@FundId int, 
		@InitiatingEntityId int, 
		@InitiatingEntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PortfolioMessageQueue
			(PortfolioMessageTypeId, Message, FundId, InitiatingEntityId, InitiatingEntityTypeId, StartDt)
	VALUES
			(@PortfolioMessageTypeId, @Message, @FundId, @InitiatingEntityId, @InitiatingEntityTypeId, @StartDt)

	SELECT	MessageId, StartDt, DataVersion
	FROM	PortfolioMessageQueue
	WHERE	MessageId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
