USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingReason_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingReason_Delete]
GO

CREATE PROCEDURE DBO.[PADealingReason_Delete]
		@PADealingReasonID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PADealingReason_hst (
			PADealingReasonID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingReasonID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PADealingReason
	WHERE	PADealingReasonID = @PADealingReasonID

	DELETE	PADealingReason
	WHERE	PADealingReasonID = @PADealingReasonID
	AND		DataVersion = @DataVersion
GO
