﻿USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundPortfolioChangeMonitorType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundPortfolioChangeMonitorType_Update]
GO

CREATE PROCEDURE DBO.[FundPortfolioChangeMonitorType_Update]
		@FundChangeMonitorTypeID int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundPortfolioChangeMonitorType_hst (
			FundChangeMonitorTypeID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundChangeMonitorTypeID, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundPortfolioChangeMonitorType
	WHERE	FundChangeMonitorTypeID = @FundChangeMonitorTypeID

	UPDATE	FundPortfolioChangeMonitorType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundChangeMonitorTypeID = @FundChangeMonitorTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundPortfolioChangeMonitorType
	WHERE	FundChangeMonitorTypeID = @FundChangeMonitorTypeID
	AND		@@ROWCOUNT > 0

GO