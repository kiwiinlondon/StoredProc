USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RiskAnalyticType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RiskAnalyticType_Insert]
GO

CREATE PROCEDURE DBO.[RiskAnalyticType_Insert]
		@Name varchar(160), 
		@UpdateUserID int, 
		@FileColumnName varchar(100)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into RiskAnalyticType
			(Name, UpdateUserID, FileColumnName, StartDt)
	VALUES
			(@Name, @UpdateUserID, @FileColumnName, @StartDt)

	SELECT	RiskAnalyticTypeId, StartDt, DataVersion
	FROM	RiskAnalyticType
	WHERE	RiskAnalyticTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
