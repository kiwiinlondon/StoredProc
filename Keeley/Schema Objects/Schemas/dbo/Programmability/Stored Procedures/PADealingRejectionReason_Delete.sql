USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingRejectionReason_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingRejectionReason_Delete]
GO

CREATE PROCEDURE DBO.[PADealingRejectionReason_Delete]
		@PADealingRejectionReasonID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PADealingRejectionReason_hst (
			PADealingRejectionReasonID, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingRejectionReasonID, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PADealingRejectionReason
	WHERE	PADealingRejectionReasonID = @PADealingRejectionReasonID

	DELETE	PADealingRejectionReason
	WHERE	PADealingRejectionReasonID = @PADealingRejectionReasonID
	AND		DataVersion = @DataVersion
GO
