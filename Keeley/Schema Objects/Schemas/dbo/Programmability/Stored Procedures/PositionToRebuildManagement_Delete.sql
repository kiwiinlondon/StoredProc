USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionToRebuildManagement_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionToRebuildManagement_Delete]
GO

CREATE PROCEDURE DBO.[PositionToRebuildManagement_Delete]
		@FundId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PositionToRebuildManagement_hst (
			FundId, EndDt, LastActionUserID)
	SELECT	FundId, @EndDt, @UpdateUserID
	FROM	PositionToRebuildManagement
	WHERE	FundId = @FundId

	DELETE	PositionToRebuildManagement
	WHERE	FundId = @FundId
	AND		DataVersion = @DataVersion
GO
