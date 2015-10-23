USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalyticType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalyticType_Delete]
GO

CREATE PROCEDURE DBO.[RiskAnalyticType_Delete]
		@RiskAnalyticTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RiskAnalyticType_hst (
			RiskAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, FileColumnName, EndDt, LastActionUserID)
	SELECT	RiskAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, FileColumnName, @EndDt, @UpdateUserID
	FROM	RiskAnalyticType
	WHERE	RiskAnalyticTypeId = @RiskAnalyticTypeId

	DELETE	RiskAnalyticType
	WHERE	RiskAnalyticTypeId = @RiskAnalyticTypeId
	AND		DataVersion = @DataVersion
GO
