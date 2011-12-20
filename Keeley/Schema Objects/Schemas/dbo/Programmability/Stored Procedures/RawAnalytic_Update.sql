USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawAnalytic_Update]
GO

CREATE PROCEDURE DBO.[RawAnalytic_Update]
		@RawAnalyticId int, 
		@InstrumentMarketId int, 
		@AnalyticTypeId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeItemId int, 
		@Value numeric(27,8), 
		@UpdateDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RawAnalytic_hst (
			RawAnalyticId, InstrumentMarketId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawAnalyticId, InstrumentMarketId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RawAnalytic
	WHERE	RawAnalyticId = @RawAnalyticId

	UPDATE	RawAnalytic
	SET		InstrumentMarketId = @InstrumentMarketId, AnalyticTypeId = @AnalyticTypeId, ReferenceDate = @ReferenceDate, EntityRankingSchemeItemId = @EntityRankingSchemeItemId, Value = @Value, UpdateDate = @UpdateDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RawAnalyticId = @RawAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RawAnalytic
	WHERE	RawAnalyticId = @RawAnalyticId
	AND		@@ROWCOUNT > 0

GO
