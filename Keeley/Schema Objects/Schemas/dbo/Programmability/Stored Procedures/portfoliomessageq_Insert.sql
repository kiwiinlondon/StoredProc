USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[portfoliomessageq_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[portfoliomessageq_Insert]
GO

CREATE PROCEDURE DBO.[portfoliomessageq_Insert]
		@PortfolioMessageTypeId int, 
		@Message varchar(-1), 
		@FundId int, 
		@InitiatingEntityId int, 
		@InitiatingEntityTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into portfoliomessageq
			(PortfolioMessageTypeId, Message, FundId, InitiatingEntityId, InitiatingEntityTypeId, StartDt)
	VALUES
			(@PortfolioMessageTypeId, @Message, @FundId, @InitiatingEntityId, @InitiatingEntityTypeId, @StartDt)

	SELECT	, StartDt, DataVersion
	FROM	portfoliomessageq
	WHERE	 = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
