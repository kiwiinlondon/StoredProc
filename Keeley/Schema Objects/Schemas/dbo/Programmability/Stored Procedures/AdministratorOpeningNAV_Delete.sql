USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AdministratorOpeningNAV_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AdministratorOpeningNAV_Delete]
GO

CREATE PROCEDURE DBO.[AdministratorOpeningNAV_Delete]
		@AdministratorOpeningValueID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AdministratorOpeningNAV_hst (
			AdministratorOpeningValueID, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AdministratorOpeningValueID, FundId, ReferenceDate, Value, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AdministratorOpeningNAV
	WHERE	AdministratorOpeningValueID = @AdministratorOpeningValueID

	DELETE	AdministratorOpeningNAV
	WHERE	AdministratorOpeningValueID = @AdministratorOpeningValueID
	AND		DataVersion = @DataVersion
GO
