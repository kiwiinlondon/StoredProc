USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[portfoliomessageq_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[portfoliomessageq_Update]
GO

CREATE PROCEDURE DBO.[portfoliomessageq_Update]
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

	INSERT INTO portfoliomessageq_hst (
			MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, EndDt, LastActionUserID)
	SELECT	MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, @StartDt, @UpdateUserID
	FROM	portfoliomessageq
	WHERE	 = @

	UPDATE	portfoliomessageq
	SET		MessageId = @MessageId, PortfolioMessageTypeId = @PortfolioMessageTypeId, Message = @Message, FundId = @FundId, InitiatingEntityId = @InitiatingEntityId, InitiatingEntityTypeId = @InitiatingEntityTypeId,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	portfoliomessageq
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
