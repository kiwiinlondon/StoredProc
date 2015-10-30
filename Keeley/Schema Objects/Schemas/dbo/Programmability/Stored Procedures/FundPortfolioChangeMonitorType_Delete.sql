USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChangeMonitorType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChangeMonitorType_Delete]
GO

CREATE PROCEDURE DBO.[FundPortfolioChangeMonitorType_Delete]
		@FundChangeMonitorTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundPortfolioChangeMonitorType_hst (
			FundChangeMonitorTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundChangeMonitorTypeID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundPortfolioChangeMonitorType
	WHERE	FundChangeMonitorTypeID = @FundChangeMonitorTypeID

	DELETE	FundPortfolioChangeMonitorType
	WHERE	FundChangeMonitorTypeID = @FundChangeMonitorTypeID
	AND		DataVersion = @DataVersion
GO
