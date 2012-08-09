USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundHighWaterMark_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundHighWaterMark_Insert]
GO

CREATE PROCEDURE DBO.[FundHighWaterMark_Insert]
		@FundID int, 
		@HighWaterMark numeric(27,8), 
		@ReferenceDate datetime, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundHighWaterMark
			(FundID, HighWaterMark, ReferenceDate, UpdateUserID, StartDt)
	VALUES
			(@FundID, @HighWaterMark, @ReferenceDate, @UpdateUserID, @StartDt)

	SELECT	FundID, StartDt, DataVersion
	FROM	FundHighWaterMark
	WHERE	FundID = @FundID
	AND		@@ROWCOUNT > 0

GO
