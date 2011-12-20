USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CountryHoliday_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CountryHoliday_Insert]
GO

CREATE PROCEDURE DBO.[CountryHoliday_Insert]
		@CountryId int, 
		@ReferenceDate datetime, 
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CountryHoliday
			(CountryId, ReferenceDate, Name, UpdateUserID, StartDt)
	VALUES
			(@CountryId, @ReferenceDate, @Name, @UpdateUserID, @StartDt)

	SELECT	CountryHolidayId, StartDt, DataVersion
	FROM	CountryHoliday
	WHERE	CountryHolidayId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
