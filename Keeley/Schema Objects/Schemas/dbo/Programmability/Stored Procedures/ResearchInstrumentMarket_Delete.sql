USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchInstrumentMarket_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchInstrumentMarket_Delete]
GO

CREATE PROCEDURE DBO.[ResearchInstrumentMarket_Delete]
		@ResearchInstrumentMarketId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ResearchInstrumentMarket_hst (
			ResearchInstrumentMarketId, ResearchId, InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IsPrimary, EndDt, LastActionUserID)
	SELECT	ResearchInstrumentMarketId, ResearchId, InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IsPrimary, @EndDt, @UpdateUserID
	FROM	ResearchInstrumentMarket
	WHERE	ResearchInstrumentMarketId = @ResearchInstrumentMarketId

	DELETE	ResearchInstrumentMarket
	WHERE	ResearchInstrumentMarketId = @ResearchInstrumentMarketId
	AND		DataVersion = @DataVersion
GO
