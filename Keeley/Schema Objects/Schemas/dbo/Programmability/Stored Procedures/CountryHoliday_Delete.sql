USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CountryHoliday_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CountryHoliday_Delete]
GO

CREATE PROCEDURE DBO.[CountryHoliday_Delete]
		@CountryHolidayId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CountryHoliday_hst (
			CountryHolidayId, CountryId, ReferenceDate, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CountryHolidayId, CountryId, ReferenceDate, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	CountryHoliday
	WHERE	CountryHolidayId = @CountryHolidayId

	DELETE	CountryHoliday
	WHERE	CountryHolidayId = @CountryHolidayId
	AND		DataVersion = @DataVersion
GO
