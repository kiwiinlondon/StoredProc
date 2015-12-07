USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSource_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSource_Update]
GO

CREATE PROCEDURE DBO.[AttributionSource_Update]
		@AttributionSourceID int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@AdministratorSourced bit, 
		@AdministratorPrevious datetime, 
		@FactsetSourced bit, 
		@FactsetPrevious datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AttributionSource_hst (
			AttributionSourceID, FundId, ReferenceDate, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AttributionSourceID, FundId, ReferenceDate, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AttributionSource
	WHERE	AttributionSourceID = @AttributionSourceID

	UPDATE	AttributionSource
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, AdministratorSourced = @AdministratorSourced, AdministratorPrevious = @AdministratorPrevious, FactsetSourced = @FactsetSourced, FactsetPrevious = @FactsetPrevious, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AttributionSourceID = @AttributionSourceID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AttributionSource
	WHERE	AttributionSourceID = @AttributionSourceID
	AND		@@ROWCOUNT > 0

GO
