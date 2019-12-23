USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DayCountConvention_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DayCountConvention_Insert]
GO

CREATE PROCEDURE DBO.[DayCountConvention_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into DayCountConvention
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	DayConventionID, StartDt, DataVersion
	FROM	DayCountConvention
	WHERE	DayConventionID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
