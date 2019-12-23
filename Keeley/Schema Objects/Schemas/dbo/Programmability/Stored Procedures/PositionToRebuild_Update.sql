USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionToRebuild_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionToRebuild_Update]
GO

CREATE PROCEDURE DBO.[PositionToRebuild_Update]
		@PositionId int, 
		@FundId int, 
		@Ordering int, 
		@IsErrored bit, 
		@RebuildFromDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PositionToRebuild_hst (
			PositionId, FundId, Ordering, IsErrored, RebuildFromDate, EndDt, LastActionUserID)
	SELECT	PositionId, FundId, Ordering, IsErrored, RebuildFromDate, @StartDt, @UpdateUserID
	FROM	PositionToRebuild
	WHERE	PositionId = @PositionId

	UPDATE	PositionToRebuild
	SET		FundId = @FundId, Ordering = @Ordering, IsErrored = @IsErrored, RebuildFromDate = @RebuildFromDate,  StartDt = @StartDt
	WHERE	PositionId = @PositionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PositionToRebuild
	WHERE	PositionId = @PositionId
	AND		@@ROWCOUNT > 0

GO
