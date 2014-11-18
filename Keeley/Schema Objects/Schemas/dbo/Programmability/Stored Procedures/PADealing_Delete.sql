USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealing_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealing_Delete]
GO

CREATE PROCEDURE DBO.[PADealing_Delete]
		@PADealingID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PADealing_hst (
			PADealingID, RequestingUserID, InstrumentMarketID, IsBuy, Quantity, RequestTimeStamp, RequestNote, IsAutomaticRejection, IsComplianceApproved, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNote, IsTraderApproved, TraderTimeStamp, TraderRejectionReasonID, TraderNote, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingID, RequestingUserID, InstrumentMarketID, IsBuy, Quantity, RequestTimeStamp, RequestNote, IsAutomaticRejection, IsComplianceApproved, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNote, IsTraderApproved, TraderTimeStamp, TraderRejectionReasonID, TraderNote, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PADealing
	WHERE	PADealingID = @PADealingID

	DELETE	PADealing
	WHERE	PADealingID = @PADealingID
	AND		DataVersion = @DataVersion
GO
