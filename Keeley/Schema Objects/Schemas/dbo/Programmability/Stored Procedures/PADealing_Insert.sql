USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealing_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealing_Insert]
GO

CREATE PROCEDURE DBO.[PADealing_Insert]
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
		@IsExistingHolding bit, 
		@IsPending bit, 
		@ContractNoteFile varbinary(MAX), 
		@ContractNoteTimeStamp datetime, 
		@IsCancelled bit, 
		@ContractNoteFileName varchar(150), 
		@ActualValue numeric(27,8), 
		@InputUserId int, 
		@Cost numeric(27,8), 
		@NextTraderToSendEmail varchar(50) = null
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealing
			(RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestNotes, RequestTimeStamp, IsAutomaticRejection, RejectionReasonID, ActualQuantity, IsContractReceived, IsComplianceApproved, ComplianceUserID, ComplianceNotes, ComplianceTimeStamp, IsTraderApproved, TraderUserID, TraderNotes, TraderTimeStamp, UpdateUserID, IsExistingHolding, IsPending, ContractNoteFile, ContractNoteTimeStamp, IsCancelled, ContractNoteFileName, ActualValue, InputUserId, Cost, NextTraderToSendEmail, StartDt)
	VALUES
			(@RequestUserID, @InstrumentMarketID, @PADealingAccountID, @RequestQuantity, @RequestValue, @RequestNotes, @RequestTimeStamp, @IsAutomaticRejection, @RejectionReasonID, @ActualQuantity, @IsContractReceived, @IsComplianceApproved, @ComplianceUserID, @ComplianceNotes, @ComplianceTimeStamp, @IsTraderApproved, @TraderUserID, @TraderNotes, @TraderTimeStamp, @UpdateUserID, @IsExistingHolding, @IsPending, @ContractNoteFile, @ContractNoteTimeStamp, @IsCancelled, @ContractNoteFileName, @ActualValue, @InputUserId, @Cost, @NextTraderToSendEmail, @StartDt)

	SELECT	PADealingID, StartDt, DataVersion
	FROM	PADealing
	WHERE	PADealingID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
