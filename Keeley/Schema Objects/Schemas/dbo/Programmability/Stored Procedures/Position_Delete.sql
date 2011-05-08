USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Position_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Position_Delete]
GO

CREATE PROCEDURE DBO.[Position_Delete]
		@PositionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Position_hst (
			PositionId, AccountID, StartDt, UpdateUserID, DataVersion, BookID, InstrumentMarketID, CurrencyID, EntityRankingSchemeId, EndDt, LastActionUserID)
	SELECT	PositionId, AccountID, StartDt, UpdateUserID, DataVersion, BookID, InstrumentMarketID, CurrencyID, EntityRankingSchemeId, @EndDt, @UpdateUserID
	FROM	Position
	WHERE	PositionId = @PositionId

	DELETE	Position
	WHERE	PositionId = @PositionId
	AND		DataVersion = @DataVersion
GO
