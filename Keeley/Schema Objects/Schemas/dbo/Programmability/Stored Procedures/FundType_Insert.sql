USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundType_Insert]
GO

CREATE PROCEDURE DBO.[FundType_Insert]
		@Name varchar(70), 
		@UpdateUserID int, 
		@ExternalTopHoldingCount int, 
		@ExternalDelay int, 
		@ExternalDisplayNonEquity bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundType
			(Name, UpdateUserID, ExternalTopHoldingCount, ExternalDelay, ExternalDisplayNonEquity, StartDt)
	VALUES
			(@Name, @UpdateUserID, @ExternalTopHoldingCount, @ExternalDelay, @ExternalDisplayNonEquity, @StartDt)

	SELECT	FundTypeID, StartDt, DataVersion
	FROM	FundType
	WHERE	FundTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
