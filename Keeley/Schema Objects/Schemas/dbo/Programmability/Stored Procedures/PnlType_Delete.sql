USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PnlType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PnlType_Delete]
GO

CREATE PROCEDURE DBO.[PnlType_Delete]
		@PnlTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PnlType_hst (
			PnlTypeId, Name, StartDt, UpdateUserID, DataVersion, MultiplyByPercentageOfFund, IsOtherPnl, EndDt, LastActionUserID)
	SELECT	PnlTypeId, Name, StartDt, UpdateUserID, DataVersion, MultiplyByPercentageOfFund, IsOtherPnl, @EndDt, @UpdateUserID
	FROM	PnlType
	WHERE	PnlTypeId = @PnlTypeId

	DELETE	PnlType
	WHERE	PnlTypeId = @PnlTypeId
	AND		DataVersion = @DataVersion
GO
