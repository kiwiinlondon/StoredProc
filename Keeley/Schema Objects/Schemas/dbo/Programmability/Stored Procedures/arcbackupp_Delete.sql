USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[arcbackupp_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[arcbackupp_Delete]
GO

CREATE PROCEDURE DBO.[arcbackupp_Delete]
		@ ,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO arcbackupp_hst (
			PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PriceId, InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	arcbackupp
	WHERE	 = @

	DELETE	arcbackupp
	WHERE	 = @
	AND		DataVersion = @DataVersion
GO
