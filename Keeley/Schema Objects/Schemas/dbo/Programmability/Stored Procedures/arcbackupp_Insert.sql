USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[arcbackupp_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[arcbackupp_Insert]
GO

CREATE PROCEDURE DBO.[arcbackupp_Insert]
		@InstrumentMarketId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeId int, 
		@RawPriceId int, 
		@Value numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into arcbackupp
			(InstrumentMarketId, ReferenceDate, EntityRankingSchemeId, RawPriceId, Value, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @ReferenceDate, @EntityRankingSchemeId, @RawPriceId, @Value, @UpdateUserID, @StartDt)

	SELECT	, StartDt, DataVersion
	FROM	arcbackupp
	WHERE	 = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
