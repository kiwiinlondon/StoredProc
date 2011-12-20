USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[RawAnalytic_Insert]
		@InstrumentMarketId int, 
		@AnalyticTypeId int, 
		@ReferenceDate datetime, 
		@EntityRankingSchemeItemId int, 
		@Value numeric(27,8), 
		@UpdateDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RawAnalytic
			(InstrumentMarketId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, UpdateUserID, StartDt)
	VALUES
			(@InstrumentMarketId, @AnalyticTypeId, @ReferenceDate, @EntityRankingSchemeItemId, @Value, @UpdateDate, @UpdateUserID, @StartDt)

	SELECT	RawAnalyticId, StartDt, DataVersion
	FROM	RawAnalytic
	WHERE	RawAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
