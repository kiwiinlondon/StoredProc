USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[arcbackuprp_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[arcbackuprp_Delete]
GO

CREATE PROCEDURE DBO.[arcbackuprp_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO arcbackuprp_hst (
			RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawPriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeItemId, BidValue, BidUpdateDate, AskValue, AskUpdateDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	arcbackuprp
	WHERE	 = @

	DELETE	arcbackuprp
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
