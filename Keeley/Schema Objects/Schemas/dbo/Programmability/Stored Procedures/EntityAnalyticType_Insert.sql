USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[EntityAnalyticType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[EntityAnalyticType_Insert]
GO

CREATE PROCEDURE DBO.[EntityAnalyticType_Insert]
		@Name varchar(100), 
		@UpdateUserID int, 
		@InputMonthCount int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into EntityAnalyticType
			(Name, UpdateUserID, InputMonthCount, StartDt)
	VALUES
			(@Name, @UpdateUserID, @InputMonthCount, @StartDt)

	SELECT	EntityAnalyticTypeId, StartDt, DataVersion
	FROM	EntityAnalyticType
	WHERE	EntityAnalyticTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
