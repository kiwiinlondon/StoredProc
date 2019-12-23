USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundHighWaterMark_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundHighWaterMark_Delete]
GO

CREATE PROCEDURE DBO.[FundHighWaterMark_Delete]
		@FundID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundHighWaterMark_hst (
			FundID, HighWaterMark, ReferenceDate, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	FundID, HighWaterMark, ReferenceDate, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	FundHighWaterMark
	WHERE	FundID = @FundID

	DELETE	FundHighWaterMark
	WHERE	FundID = @FundID
	AND		DataVersion = @DataVersion
GO
