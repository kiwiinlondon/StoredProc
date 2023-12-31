﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundCountryHoliday_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundCountryHoliday_Update]
GO

CREATE PROCEDURE DBO.[FundCountryHoliday_Update]
		@FundCountryHoldayId int, 
		@CountryId int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@AdministratorId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundCountryHoliday_hst (
			FundCountryHoldayId, CountryId, StartDt, UpdateUserID, DataVersion, AdministratorId, EndDt, LastActionUserID)
	SELECT	FundCountryHoldayId, CountryId, StartDt, UpdateUserID, DataVersion, AdministratorId, @StartDt, @UpdateUserID
	FROM	FundCountryHoliday
	WHERE	FundCountryHoldayId = @FundCountryHoldayId

	UPDATE	FundCountryHoliday
	SET		CountryId = @CountryId, UpdateUserID = @UpdateUserID, AdministratorId = @AdministratorId,  StartDt = @StartDt
	WHERE	FundCountryHoldayId = @FundCountryHoldayId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundCountryHoliday
	WHERE	FundCountryHoldayId = @FundCountryHoldayId
	AND		@@ROWCOUNT > 0

GO
