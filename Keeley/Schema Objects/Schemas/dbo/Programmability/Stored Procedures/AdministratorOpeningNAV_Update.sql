USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdministratorOpeningNAV_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdministratorOpeningNAV_Update]
GO

CREATE PROCEDURE DBO.[AdministratorOpeningNAV_Update]
		@AdministratorOpeningValueID int, 
		@FundId int, 
		@ReferenceDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AdministratorOpeningNAV_hst (
			AdministratorOpeningValueID, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AdministratorOpeningValueID, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AdministratorOpeningNAV
	WHERE	AdministratorOpeningValueID = @AdministratorOpeningValueID

	UPDATE	AdministratorOpeningNAV
	SET		FundId = @FundId, ReferenceDate = @ReferenceDate, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AdministratorOpeningValueID = @AdministratorOpeningValueID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AdministratorOpeningNAV
	WHERE	AdministratorOpeningValueID = @AdministratorOpeningValueID
	AND		@@ROWCOUNT > 0

GO
