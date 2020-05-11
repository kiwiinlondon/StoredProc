USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[arcbackuprp_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[arcbackuprp_Update]
GO

CREATE PROCEDURE DBO.[arcbackuprp_Update]
		@RawPriceId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeItemId int, 
		@BidValue numeric(27,8), 
		@BidUpdateDate datetime, 
		@AskValue numeric(27,8), 
		@AskUpdateDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO arcbackuprp_hst (
			RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	arcbackuprp
	WHERE	 = @

	UPDATE	arcbackuprp
	SET		RawPriceId = @RawPriceId, InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, EntityRankingSchemeItemId = @EntityRankingSchemeItemId, BidValue = @BidValue, BidUpdateDate = @BidUpdateDate, AskValue = @AskValue, AskUpdateDate = @AskUpdateDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	arcbackuprp
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
