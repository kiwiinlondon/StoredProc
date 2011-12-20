USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundType_Delete]
GO

CREATE PROCEDURE DBO.[FundType_Delete]
		@FundTypeID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundType_hst (
			FundTypeID, Name, StartDt, UpdateUserID, DataVersion, ExternalTopHoldingCount, ExternalDelay, ExternalDisplayNonEquity, EndDt, LastActionUserID)
	SELECT	FundTypeID, Name, StartDt, UpdateUserID, DataVersion, ExternalTopHoldingCount, ExternalDelay, ExternalDisplayNonEquity, @EndDt, @UpdateUserID
	FROM	FundType
	WHERE	FundTypeID = @FundTypeID

	DELETE	FundType
	WHERE	FundTypeID = @FundTypeID
	AND		DataVersion = @DataVersion
GO
