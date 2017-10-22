USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionToRebuildManagement_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionToRebuildManagement_Update]
GO

CREATE PROCEDURE DBO.[PositionToRebuildManagement_Update]
		@FundId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PositionToRebuildManagement_hst (
			FundId, EndDt, LastActionUserID)
	SELECT	FundId, @StartDt, @UpdateUserID
	FROM	PositionToRebuildManagement
	WHERE	FundId = @FundId

	UPDATE	PositionToRebuildManagement
	SET		 StartDt = @StartDt
	WHERE	FundId = @FundId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PositionToRebuildManagement
	WHERE	FundId = @FundId
	AND		@@ROWCOUNT > 0

GO
