USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawIssuerAnalytic_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawIssuerAnalytic_Update]
GO

CREATE PROCEDURE DBO.[RawIssuerAnalytic_Update]
		@RawIssuerAnalyticId int, 
		@IssuerId int, 
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

	INSERT INTO RawIssuerAnalytic_hst (
			RawIssuerAnalyticId, IssuerId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RawIssuerAnalyticId, IssuerId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RawIssuerAnalytic
	WHERE	RawIssuerAnalyticId = @RawIssuerAnalyticId

	UPDATE	RawIssuerAnalytic
	SET		IssuerId = @IssuerId, AnalyticTypeId = @AnalyticTypeId, ReferenceDate = @ReferenceDate, EntityRankingSchemeItemId = @EntityRankingSchemeItemId, Value = @Value, UpdateDate = @UpdateDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RawIssuerAnalyticId = @RawIssuerAnalyticId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RawIssuerAnalytic
	WHERE	RawIssuerAnalyticId = @RawIssuerAnalyticId
	AND		@@ROWCOUNT > 0

GO
