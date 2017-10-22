USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundCountryStatus_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundCountryStatus_Update]
GO

CREATE PROCEDURE DBO.[FundCountryStatus_Update]
		@FundCountryStatusId int, 
		@FundId int, 
		@CountryId int, 
		@HasReportingStatus bit, 
		@IsRegistered bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundCountryStatus_hst (
			FundCountryStatusId, FundId, CountryId, HasReportingStatus, IsRegistered, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundCountryStatusId, FundId, CountryId, HasReportingStatus, IsRegistered, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundCountryStatus
	WHERE	FundCountryStatusId = @FundCountryStatusId

	UPDATE	FundCountryStatus
	SET		FundId = @FundId, CountryId = @CountryId, HasReportingStatus = @HasReportingStatus, IsRegistered = @IsRegistered, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundCountryStatusId = @FundCountryStatusId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundCountryStatus
	WHERE	FundCountryStatusId = @FundCountryStatusId
	AND		@@ROWCOUNT > 0

GO
