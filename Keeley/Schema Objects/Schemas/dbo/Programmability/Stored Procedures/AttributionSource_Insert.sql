USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSource_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSource_Insert]
GO

CREATE PROCEDURE DBO.[AttributionSource_Insert]
		@FundId int, 
		@ReferenceDate datetime, 
		@AdministratorSourced bit, 
		@AdministratorPrevious datetime, 
		@FactsetSourced bit, 
		@FactsetPrevious datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionSource
			(FundId, ReferenceDate, AdministratorSourced, AdministratorPrevious, FactsetSourced, FactsetPrevious, UpdateUserID, StartDt)
	VALUES
			(@FundId, @ReferenceDate, @AdministratorSourced, @AdministratorPrevious, @FactsetSourced, @FactsetPrevious, @UpdateUserID, @StartDt)

	SELECT	AttributionSourceID, StartDt, DataVersion
	FROM	AttributionSource
	WHERE	AttributionSourceID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
