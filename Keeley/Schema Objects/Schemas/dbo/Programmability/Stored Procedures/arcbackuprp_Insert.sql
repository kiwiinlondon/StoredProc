USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[arcbackuprp_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[arcbackuprp_Insert]
GO

CREATE PROCEDURE DBO.[arcbackuprp_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeItemId int, 
		@BidValue numeric(27,8), 
		@BidUpdateDate datetime, 
		@AskValue numeric(27,8), 
		@AskUpdateDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into arcbackuprp
			(InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @EntityRankingSchemeItemId, @BidValue, @BidUpdateDate, @AskValue, @AskUpdateDate, @UpdateUserID, @StartDt)

	SELECT	, StartDt, DataVersion
	FROM	arcbackuprp
	WHERE	 = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
