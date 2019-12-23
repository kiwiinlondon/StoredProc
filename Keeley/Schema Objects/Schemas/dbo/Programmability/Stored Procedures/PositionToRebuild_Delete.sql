USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PositionToRebuild_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PositionToRebuild_Delete]
GO

CREATE PROCEDURE DBO.[PositionToRebuild_Delete]
		@PositionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PositionToRebuild_hst (
			PositionId, FundId, Ordering, IsErrored, RebuildFromDate, EndDt, LastActionUserID)
	SELECT	PositionId, FundId, Ordering, IsErrored, RebuildFromDate, @EndDt, @UpdateUserID
	FROM	PositionToRebuild
	WHERE	PositionId = @PositionId

	DELETE	PositionToRebuild
	WHERE	PositionId = @PositionId
	AND		DataVersion = @DataVersion
GO
