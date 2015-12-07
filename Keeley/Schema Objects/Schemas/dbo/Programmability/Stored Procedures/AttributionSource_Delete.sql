USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSource_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSource_Delete]
GO

CREATE PROCEDURE DBO.[AttributionSource_Delete]
		@AttributionSourceID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AttributionSource_hst (
			AttributionSourceID, FundId, ReferenceDate, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionSourceID, FundId, ReferenceDate, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AttributionSource
	WHERE	AttributionSourceID = @AttributionSourceID

	DELETE	AttributionSource
	WHERE	AttributionSourceID = @AttributionSourceID
	AND		DataVersion = @DataVersion
GO
