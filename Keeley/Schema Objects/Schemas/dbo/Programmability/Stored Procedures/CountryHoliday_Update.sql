USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CountryHoliday_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CountryHoliday_Update]
GO

CREATE PROCEDURE DBO.[CountryHoliday_Update]
		@CountryHolidayId int, 
		@CountryId int, 
		@ReferenceDate datetime, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CountryHoliday_hst (
			CountryHolidayId, CountryId, ReferenceDate, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CountryHolidayId, CountryId, ReferenceDate, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	CountryHoliday
	WHERE	CountryHolidayId = @CountryHolidayId

	UPDATE	CountryHoliday
	SET		CountryId = @CountryId, ReferenceDate = @ReferenceDate, Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	CountryHolidayId = @CountryHolidayId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CountryHoliday
	WHERE	CountryHolidayId = @CountryHolidayId
	AND		@@ROWCOUNT > 0

GO
