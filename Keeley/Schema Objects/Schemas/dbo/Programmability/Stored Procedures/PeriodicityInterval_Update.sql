USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PeriodicityInterval_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PeriodicityInterval_Update]
GO

CREATE PROCEDURE DBO.[PeriodicityInterval_Update]
		@PeriodicityIntervalId int, 
		@PeriodicityId int, 
		@OccuranceInPeriod int, 
		@DayOfWeek int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PeriodicityInterval_hst (
			PeriodicityIntervalId, PeriodicityId, OccuranceInPeriod, DayOfWeek, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PeriodicityIntervalId, PeriodicityId, OccuranceInPeriod, DayOfWeek, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PeriodicityInterval
	WHERE	PeriodicityIntervalId = @PeriodicityIntervalId

	UPDATE	PeriodicityInterval
	SET		PeriodicityId = @PeriodicityId, OccuranceInPeriod = @OccuranceInPeriod, DayOfWeek = @DayOfWeek, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PeriodicityIntervalId = @PeriodicityIntervalId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PeriodicityInterval
	WHERE	PeriodicityIntervalId = @PeriodicityIntervalId
	AND		@@ROWCOUNT > 0

GO
