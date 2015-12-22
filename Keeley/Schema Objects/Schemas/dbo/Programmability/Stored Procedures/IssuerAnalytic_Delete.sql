USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerAnalytic_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerAnalytic_Delete]
GO

CREATE PROCEDURE DBO.[IssuerAnalytic_Delete]
		@IssuerAnalyticId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IssuerAnalytic_hst (
			IssuerAnalyticId, AnalyticTypeID, IssuerId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, RawIssuerAnalyticId, EndDt, LastActionUserID)
	SELECT	IssuerAnalyticId, AnalyticTypeID, IssuerId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, RawIssuerAnalyticId, @EndDt, @UpdateUserID
	FROM	IssuerAnalytic
	WHERE	IssuerAnalyticId = @IssuerAnalyticId

	DELETE	IssuerAnalytic
	WHERE	IssuerAnalyticId = @IssuerAnalyticId
	AND		DataVersion = @DataVersion
GO
