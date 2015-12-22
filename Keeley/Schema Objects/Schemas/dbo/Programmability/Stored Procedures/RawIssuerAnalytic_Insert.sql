USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RawIssuerAnalytic_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RawIssuerAnalytic_Insert]
GO

CREATE PROCEDURE DBO.[RawIssuerAnalytic_Insert]
		@IssuerId int, 
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

	INSERT into RawIssuerAnalytic
			(IssuerId, AnalyticTypeId, ReferenceDate, EntityRankingSchemeItemId, Value, UpdateDate, UpdateUserID, StartDt)
	VALUES
			(@IssuerId, @AnalyticTypeId, @ReferenceDate, @EntityRankingSchemeItemId, @Value, @UpdateDate, @UpdateUserID, @StartDt)

	SELECT	RawIssuerAnalyticId, StartDt, DataVersion
	FROM	RawIssuerAnalytic
	WHERE	RawIssuerAnalyticId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
