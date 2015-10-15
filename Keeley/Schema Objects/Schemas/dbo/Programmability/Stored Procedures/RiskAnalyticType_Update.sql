USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalyticType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalyticType_Update]
GO

CREATE PROCEDURE DBO.[RiskAnalyticType_Update]
		@RiskAnalyticTypeId int, 
		@Name varchar(160), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO RiskAnalyticType_hst (
			RiskAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RiskAnalyticTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	RiskAnalyticType
	WHERE	RiskAnalyticTypeId = @RiskAnalyticTypeId

	UPDATE	RiskAnalyticType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	RiskAnalyticTypeId = @RiskAnalyticTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	RiskAnalyticType
	WHERE	RiskAnalyticTypeId = @RiskAnalyticTypeId
	AND		@@ROWCOUNT > 0

GO
