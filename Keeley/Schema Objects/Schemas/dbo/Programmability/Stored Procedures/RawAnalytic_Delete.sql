USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[RawAnalytic_Delete]
		@RawAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RawAnalytic_hst (
			RawAnalyticId, InstrumentMarketId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawAnalyticId, InstrumentMarketId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	RawAnalytic
	WHERE	RawAnalyticId = @RawAnalyticId

	DELETE	RawAnalytic
	WHERE	RawAnalyticId = @RawAnalyticId
	AND		DataVersion = @DataVersion
GO
