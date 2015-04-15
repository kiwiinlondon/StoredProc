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
			PADealingID, RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestNotes, RequestTimeStamp, IsAutomaticRejection, RejectionReasonID, ActualQuantity, IsContractReceived, IsComplianceApproved, ComplianceUserID, ComplianceNotes, ComplianceTimeStamp, IsTraderApproved, TraderUserID, TraderNotes, TraderTimeStamp, StartDt, UpdateUserID, DataVersion, IsExistingHolding, IsPending, ContractNoteFile, ContractNoteTimeStamp, IsCancelled, ContractNoteFileName, ActualValue, InputUserId, EndDt, LastActionUserID)
	SELECT	PADealingID, RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestNotes, RequestTimeStamp, IsAutomaticRejection, RejectionReasonID, ActualQuantity, IsContractReceived, IsComplianceApproved, ComplianceUserID, ComplianceNotes, ComplianceTimeStamp, IsTraderApproved, TraderUserID, TraderNotes, TraderTimeStamp, StartDt, UpdateUserID, DataVersion, IsExistingHolding, IsPending, ContractNoteFile, ContractNoteTimeStamp, IsCancelled, ContractNoteFileName, ActualValue, InputUserId, @EndDt, @UpdateUserID
	FROM	PADealing
	WHERE	PADealingID = @PADealingID

	DELETE	PADealing
	WHERE	PADealingID = @PADealingID
	AND		DataVersion = @DataVersion
GO
