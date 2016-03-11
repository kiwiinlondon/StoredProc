USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Position_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Position_Insert]
GO

CREATE PROCEDURE DBO.[Position_Insert]
		@AccountID int, 
		@UpdateUserID int, 
		@BookID int, 
		@InstrumentMarketID int, 
		@CurrencyID int, 
		@EntityRankingSchemeId int, 
		@IsAccrual bit, 
		@StrategyId int =1
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Position
			(AccountID, UpdateUserID, BookID, InstrumentMarketID, CurrencyID, EntityRankingSchemeId, IsAccrual, StrategyId, StartDt)
	VALUES
			(@AccountID, @UpdateUserID, @BookID, @InstrumentMarketID, @CurrencyID, @EntityRankingSchemeId, @IsAccrual, @StrategyId, @StartDt)

	SELECT	PositionId, StartDt, DataVersion
	FROM	Position
	WHERE	PositionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
