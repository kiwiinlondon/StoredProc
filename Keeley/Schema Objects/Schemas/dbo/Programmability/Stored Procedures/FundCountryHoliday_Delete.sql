USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundCountryHoliday_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundCountryHoliday_Delete]
GO

CREATE PROCEDURE DBO.[FundCountryHoliday_Delete]
		@FundCountryHoldayId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundCountryHoliday_hst (
			FundCountryHoldayId, FundId, CountryId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundCountryHoldayId, FundId, CountryId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundCountryHoliday
	WHERE	FundCountryHoldayId = @FundCountryHoldayId

	DELETE	FundCountryHoliday
	WHERE	FundCountryHoldayId = @FundCountryHoldayId
	AND		DataVersion = @DataVersion
GO
