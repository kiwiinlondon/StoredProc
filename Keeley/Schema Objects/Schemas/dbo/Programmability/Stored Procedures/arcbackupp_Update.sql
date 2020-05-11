USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[arcbackupp_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[arcbackupp_Update]
GO

CREATE PROCEDURE DBO.[arcbackupp_Update]
		@PriceId int, 
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeId int, 
		@RawPriceId int, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO arcbackupp_hst (
			PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	arcbackupp
	WHERE	 = @

	UPDATE	arcbackupp
	SET		PriceId = @PriceId, InstrumentMarketId = @InstrumentMarketId, ReferenceDate = @ReferenceDate, EntityRankingSchemeId = @EntityRankingSchemeId, RawPriceId = @RawPriceId, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	arcbackupp
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
