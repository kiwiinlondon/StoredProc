USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundCountryStatus_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundCountryStatus_Insert]
GO

CREATE PROCEDURE DBO.[FundCountryStatus_Insert]
		@FundId int, 
		@CountryId int, 
		@HasReportingStatus bit, 
		@IsRegistered bit, 
		@UpdateUserID int, 
		@RegistrationRestrictionId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundCountryStatus
			(FundId, CountryId, HasReportingStatus, IsRegistered, UpdateUserID, RegistrationRestrictionId, StartDt)
	VALUES
			(@FundId, @CountryId, @HasReportingStatus, @IsRegistered, @UpdateUserID, @RegistrationRestrictionId, @StartDt)

	SELECT	FundCountryStatusId, StartDt, DataVersion
	FROM	FundCountryStatus
	WHERE	FundCountryStatusId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
