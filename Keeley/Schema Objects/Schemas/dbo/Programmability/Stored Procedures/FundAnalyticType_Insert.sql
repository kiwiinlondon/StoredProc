USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundAnalyticType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundAnalyticType_Insert]
GO

CREATE PROCEDURE DBO.[FundAnalyticType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundAnalyticType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundAnalyticTypeId, StartDt, DataVersion
	FROM	FundAnalyticType
	WHERE	FundAnalyticTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
