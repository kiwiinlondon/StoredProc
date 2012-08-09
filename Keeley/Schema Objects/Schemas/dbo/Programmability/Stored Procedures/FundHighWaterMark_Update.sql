USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundHighWaterMark_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundHighWaterMark_Update]
GO

CREATE PROCEDURE DBO.[FundHighWaterMark_Update]
		@FundID int, 
		@HighWaterMark numeric(27,8), 
		@ReferenceDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundHighWaterMark_hst (
			FundID, HighWaterMark, ReferenceDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundID, HighWaterMark, ReferenceDate, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	FundHighWaterMark
	WHERE	FundID = @FundID

	UPDATE	FundHighWaterMark
	SET		HighWaterMark = @HighWaterMark, ReferenceDate = @ReferenceDate, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	FundID = @FundID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundHighWaterMark
	WHERE	FundID = @FundID
	AND		@@ROWCOUNT > 0

GO
