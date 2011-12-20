USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PeriodicityInterval_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PeriodicityInterval_Delete]
GO

CREATE PROCEDURE DBO.[PeriodicityInterval_Delete]
		@PeriodicityIntervalId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PeriodicityInterval_hst (
			PeriodicityIntervalId, PeriodicityId, OccuranceInPeriod, DayOfWeek, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PeriodicityIntervalId, PeriodicityId, OccuranceInPeriod, DayOfWeek, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PeriodicityInterval
	WHERE	PeriodicityIntervalId = @PeriodicityIntervalId

	DELETE	PeriodicityInterval
	WHERE	PeriodicityIntervalId = @PeriodicityIntervalId
	AND		DataVersion = @DataVersion
GO
