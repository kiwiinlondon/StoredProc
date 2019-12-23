USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchInstrumentMarket_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchInstrumentMarket_Insert]
GO

CREATE PROCEDURE DBO.[ResearchInstrumentMarket_Insert]
		@ResearchId int, 
		@InstrumentMarketId int, 
		@UpdateUserID int, 
		@IsPrimary bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ResearchInstrumentMarket
			(ResearchId, InstrumentMarketId, UpdateUserID, IsPrimary, StartDt)
	VALUES
			(@ResearchId, @InstrumentMarketId, @UpdateUserID, @IsPrimary, @StartDt)

	SELECT	ResearchInstrumentMarketId, StartDt, DataVersion
	FROM	ResearchInstrumentMarket
	WHERE	ResearchInstrumentMarketId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
