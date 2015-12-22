USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerAnalytic_Update]
GO

CREATE PROCEDURE DBO.[IssuerAnalytic_Update]
		@IssuerAnalyticId int, 
		@AnalyticTypeID int, 
		@IssuerId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@RawIssuerAnalyticId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IssuerAnalytic_hst (
			IssuerAnalyticId, AnalyticTypeID, IssuerId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, RawIssuerAnalyticId, EndDt, LastActionUserID)
	SELECT	IssuerAnalyticId, AnalyticTypeID, IssuerId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, RawIssuerAnalyticId, @StartDt, @UpdateUserID
	FROM	IssuerAnalytic
	WHERE	IssuerAnalyticId = @IssuerAnalyticId

	UPDATE	IssuerAnalytic
	SET		AnalyticTypeID = @AnalyticTypeID, IssuerId = @IssuerId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID, RawIssuerAnalyticId = @RawIssuerAnalyticId,  StartDt = @StartDt
	WHERE	IssuerAnalyticId = @IssuerAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IssuerAnalytic
	WHERE	IssuerAnalyticId = @IssuerAnalyticId
	AND		@@ROWCOUNT > 0

GO
