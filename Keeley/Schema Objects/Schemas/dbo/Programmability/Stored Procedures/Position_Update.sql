USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Position_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Position_Update]
GO

CREATE PROCEDURE DBO.[Position_Update]
		@PositionId int, 
		@AccountID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@BookID int, 
		@InstrumentMarketID int, 
		@CurrencyID int, 
		@EntityRankingSchemeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Position_hst (
			PositionId, AccountID, StartDt, UpdateUserID, DataVersion, BookID, InstrumentMarketID, CurrencyID, EntityRankingSchemeId, EndDt, LastActionUserID)
	SELECT	PositionId, AccountID, StartDt, UpdateUserID, DataVersion, BookID, InstrumentMarketID, CurrencyID, EntityRankingSchemeId, @StartDt, @UpdateUserID
	FROM	Position
	WHERE	PositionId = @PositionId

	UPDATE	Position
	SET		AccountID = @AccountID, UpdateUserID = @UpdateUserID, BookID = @BookID, InstrumentMarketID = @InstrumentMarketID, CurrencyID = @CurrencyID, EntityRankingSchemeId = @EntityRankingSchemeId,  StartDt = @StartDt
	WHERE	PositionId = @PositionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Position
	WHERE	PositionId = @PositionId
	AND		@@ROWCOUNT > 0

GO
