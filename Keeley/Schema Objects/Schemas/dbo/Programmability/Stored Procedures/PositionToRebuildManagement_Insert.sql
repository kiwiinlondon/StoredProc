USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionToRebuildManagement_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionToRebuildManagement_Insert]
GO

CREATE PROCEDURE DBO.[PositionToRebuildManagement_Insert]
		@FundId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PositionToRebuildManagement
			(FundId, StartDt)
	VALUES
			(@FundId, @StartDt)

	SELECT	FundId, StartDt, DataVersion
	FROM	PositionToRebuildManagement
	WHERE	FundId = @FundId
	AND		@@ROWCOUNT > 0

GO
