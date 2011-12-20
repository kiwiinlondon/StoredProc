USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PeriodicityInterval_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PeriodicityInterval_Insert]
GO

CREATE PROCEDURE DBO.[PeriodicityInterval_Insert]
		@PeriodicityId int, 
		@OccuranceInPeriod int, 
		@DayOfWeek int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PeriodicityInterval
			(PeriodicityId, OccuranceInPeriod, DayOfWeek, UpdateUserID, StartDt)
	VALUES
			(@PeriodicityId, @OccuranceInPeriod, @DayOfWeek, @UpdateUserID, @StartDt)

	SELECT	PeriodicityIntervalId, StartDt, DataVersion
	FROM	PeriodicityInterval
	WHERE	PeriodicityIntervalId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
