USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundCountryHoliday_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundCountryHoliday_Insert]
GO

CREATE PROCEDURE DBO.[FundCountryHoliday_Insert]
		@FundId int, 
		@CountryId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundCountryHoliday
			(FundId, CountryId, UpdateUserID, StartDt)
	VALUES
			(@FundId, @CountryId, @UpdateUserID, @StartDt)

	SELECT	FundCountryHoldayId, StartDt, DataVersion
	FROM	FundCountryHoliday
	WHERE	FundCountryHoldayId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
