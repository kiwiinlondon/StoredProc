USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealing_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealing_Update]
GO

CREATE PROCEDURE DBO.[PADealing_Update]
		@PADealingID int, 
		@RequestUserID int, 
		@InstrumentMarketID int, 
		@PADealingAccountID int, 
		@RequestQuantity numeric(27,8), 
		@RequestValue numeric(27,8), 
		@RequestNotes varchar(150), 
		@RequestTimeStamp datetime, 
		@IsAutomaticRejection bit, 
		@RejectionReasonID int, 
		@ActualQuantity numeric(27,8), 
		@IsContractReceived bit, 
		@IsComplianceApproved bit, 
		@ComplianceUserID int, 
		@ComplianceNotes varchar(150), 
		@ComplianceTimeStamp datetime, 
		@IsTraderApproved bit, 
		@TraderUserID int, 
		@TraderNotes varchar(150), 
		@TraderTimeStamp datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IsExistingHolding bit, 
		@IsPending bit, 
		@ContractNoteFile varbinary(MAX), 
		@ContractNoteTimeStamp datetime, 
		@IsCancelled bit, 
		@ContractNoteFileName varchar(150)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealing_hst (
			PADealingID, RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestNotes, RequestTimeStamp, IsAutomaticRejection, RejectionReasonID, ActualQuantity, IsContractReceived, IsComplianceApproved, ComplianceUserID, ComplianceNotes, ComplianceTimeStamp, IsTraderApproved, TraderUserID, TraderNotes, TraderTimeStamp, StartDt, UpdateUserID, DataVersion, IsExistingHolding, IsPending, ContractNoteFile, ContractNoteTimeStamp, IsCancelled, ContractNoteFileName, EndDt, LastActionUserID)
	SELECT	PADealingID, RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestNotes, RequestTimeStamp, IsAutomaticRejection, RejectionReasonID, ActualQuantity, IsContractReceived, IsComplianceApproved, ComplianceUserID, ComplianceNotes, ComplianceTimeStamp, IsTraderApproved, TraderUserID, TraderNotes, TraderTimeStamp, StartDt, UpdateUserID, DataVersion, IsExistingHolding, IsPending, ContractNoteFile, ContractNoteTimeStamp, IsCancelled, ContractNoteFileName, @StartDt, @UpdateUserID
	FROM	PADealing
	WHERE	PADealingID = @PADealingID

	UPDATE	PADealing
	SET		RequestUserID = @RequestUserID, InstrumentMarketID = @InstrumentMarketID, PADealingAccountID = @PADealingAccountID, RequestQuantity = @RequestQuantity, RequestValue = @RequestValue, RequestNotes = @RequestNotes, RequestTimeStamp = @RequestTimeStamp, IsAutomaticRejection = @IsAutomaticRejection, RejectionReasonID = @RejectionReasonID, ActualQuantity = @ActualQuantity, IsContractReceived = @IsContractReceived, IsComplianceApproved = @IsComplianceApproved, ComplianceUserID = @ComplianceUserID, ComplianceNotes = @ComplianceNotes, ComplianceTimeStamp = @ComplianceTimeStamp, IsTraderApproved = @IsTraderApproved, TraderUserID = @TraderUserID, TraderNotes = @TraderNotes, TraderTimeStamp = @TraderTimeStamp, UpdateUserID = @UpdateUserID, IsExistingHolding = @IsExistingHolding, IsPending = @IsPending, ContractNoteFile = @ContractNoteFile, ContractNoteTimeStamp = @ContractNoteTimeStamp, IsCancelled = @IsCancelled, ContractNoteFileName = @ContractNoteFileName,  StartDt = @StartDt
	WHERE	PADealingID = @PADealingID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealing
	WHERE	PADealingID = @PADealingID
	AND		@@ROWCOUNT > 0

GO
