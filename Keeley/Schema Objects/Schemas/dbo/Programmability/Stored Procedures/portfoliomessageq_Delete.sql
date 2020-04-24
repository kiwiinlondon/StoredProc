USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[portfoliomessageq_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[portfoliomessageq_Delete]
GO

CREATE PROCEDURE DBO.[portfoliomessageq_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO portfoliomessageq_hst (
			MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, EndDt, LastActionUserID)
	SELECT	MessageId, PortfolioMessageTypeId, Message, StartDt, FundId, InitiatingEntityId, InitiatingEntityTypeId, @EndDt, @UpdateUserID
	FROM	portfoliomessageq
	WHERE	 = @

	DELETE	portfoliomessageq
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
