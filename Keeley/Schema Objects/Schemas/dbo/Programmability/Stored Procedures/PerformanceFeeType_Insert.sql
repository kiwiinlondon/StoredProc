USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PerformanceFeeType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PerformanceFeeType_Insert]
GO

CREATE PROCEDURE DBO.[PerformanceFeeType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PerformanceFeeType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	PerformanceFeeTypeId, StartDt, DataVersion
	FROM	PerformanceFeeType
	WHERE	PerformanceFeeTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
