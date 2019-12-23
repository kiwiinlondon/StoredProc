USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundCountryStatus_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundCountryStatus_Delete]
GO

CREATE PROCEDURE DBO.[FundCountryStatus_Delete]
		@FundCountryStatusId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundCountryStatus_hst (
			FundCountryStatusId, FundId, CountryId, HasReportingStatus, IsRegistered, StartDt, UpdateUserID, DataVersion, RegistrationRestrictionId, EndDt, LastActionUserID)
	SELECT	FundCountryStatusId, FundId, CountryId, HasReportingStatus, IsRegistered, StartDt, UpdateUserID, DataVersion, RegistrationRestrictionId, @EndDt, @UpdateUserID
	FROM	FundCountryStatus
	WHERE	FundCountryStatusId = @FundCountryStatusId

	DELETE	FundCountryStatus
	WHERE	FundCountryStatusId = @FundCountryStatusId
	AND		DataVersion = @DataVersion
GO
