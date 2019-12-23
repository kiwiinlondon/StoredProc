USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionToRebuild_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionToRebuild_Insert]
GO

CREATE PROCEDURE DBO.[PositionToRebuild_Insert]
		@PositionId int, 
		@FundId int, 
		@Ordering int, 
		@IsErrored bit, 
		@RebuildFromDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PositionToRebuild
			(PositionId, FundId, Ordering, IsErrored, RebuildFromDate, StartDt)
	VALUES
			(@PositionId, @FundId, @Ordering, @IsErrored, @RebuildFromDate, @StartDt)

	SELECT	PositionId, StartDt, DataVersion
	FROM	PositionToRebuild
	WHERE	PositionId = @PositionId
	AND		@@ROWCOUNT > 0

GO
