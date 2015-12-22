USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawIssuerAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawIssuerAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[RawIssuerAnalytic_Delete]
		@RawIssuerAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RawIssuerAnalytic_hst (
			RawIssuerAnalyticId, IssuerId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawIssuerAnalyticId, IssuerId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	RawIssuerAnalytic
	WHERE	RawIssuerAnalyticId = @RawIssuerAnalyticId

	DELETE	RawIssuerAnalytic
	WHERE	RawIssuerAnalyticId = @RawIssuerAnalyticId
	AND		DataVersion = @DataVersion
GO
