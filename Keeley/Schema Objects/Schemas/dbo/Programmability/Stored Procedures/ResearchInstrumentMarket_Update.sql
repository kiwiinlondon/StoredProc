USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchInstrumentMarket_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchInstrumentMarket_Update]
GO

CREATE PROCEDURE DBO.[ResearchInstrumentMarket_Update]
		@ResearchInstrumentMarketId int, 
		@ResearchId int, 
		@InstrumentMarketId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsPrimary bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ResearchInstrumentMarket_hst (
			ResearchInstrumentMarketId, ResearchId, InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IsPrimary, EndDt, LastActionUserID)
	SELECT	ResearchInstrumentMarketId, ResearchId, InstrumentMarketId, StartDt, UpdateUserID, DataVersion, IsPrimary, @StartDt, @UpdateUserID
	FROM	ResearchInstrumentMarket
	WHERE	ResearchInstrumentMarketId = @ResearchInstrumentMarketId

	UPDATE	ResearchInstrumentMarket
	SET		ResearchId = @ResearchId, InstrumentMarketId = @InstrumentMarketId, UpdateUserID = @UpdateUserID, IsPrimary = @IsPrimary,  StartDt = @StartDt
	WHERE	ResearchInstrumentMarketId = @ResearchInstrumentMarketId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ResearchInstrumentMarket
	WHERE	ResearchInstrumentMarketId = @ResearchInstrumentMarketId
	AND		@@ROWCOUNT > 0

GO
