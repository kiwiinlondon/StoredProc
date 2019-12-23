USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundType_Update]
GO

CREATE PROCEDURE DBO.[FundType_Update]
		@FundTypeID int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@ExternalTopHoldingCount int, 
		@ExternalDelay int, 
		@ExternalDisplayNonEquity bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundType_hst (
			FundTypeID, Name, StartDt, UpdateUserID, DataVersion, ExternalTopHoldingCount, ExternalDelay, ExternalDisplayNonEquity, EndDt, LastActionUserID)
	SELECT	FundTypeID, Name, StartDt, UpdateUserID, DataVersion, ExternalTopHoldingCount, ExternalDelay, ExternalDisplayNonEquity, @StartDt, @UpdateUserID
	FROM	FundType
	WHERE	FundTypeID = @FundTypeID

	UPDATE	FundType
	SET		Name = @Name, UpdateUserID = @UpdateUserID, ExternalTopHoldingCount = @ExternalTopHoldingCount, ExternalDelay = @ExternalDelay, ExternalDisplayNonEquity = @ExternalDisplayNonEquity,  StartDt = @StartDt
	WHERE	FundTypeID = @FundTypeID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundType
	WHERE	FundTypeID = @FundTypeID
	AND		@@ROWCOUNT > 0

GO
