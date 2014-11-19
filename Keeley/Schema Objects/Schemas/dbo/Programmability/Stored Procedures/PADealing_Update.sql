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
		@RequestTimeStamp datetime, 
		@RequestNotes varchar(150), 
		@ActualQuantity numeric(27,8), 
		@IsAutomaticRejection bit, 
		@IsComplianceApproved bit, 
		@IsContractRecieved bit, 
		@ComplianceUserID int, 
		@ComplianceTimeStamp datetime, 
		@ComplianceRejectionReasonID int, 
		@ComplianceNotes varchar(150), 
		@IsTraderApproved bit, 
		@TraderUserId int, 
		@TraderTimeStamp datetime, 
		@TraderRejectionReasonID int, 
		@TraderNotes varchar(150), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealing_hst (
			PADealingID, RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestTimeStamp, RequestNotes, ActualQuantity, IsAutomaticRejection, IsComplianceApproved, IsContractRecieved, ComplianceUserID, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNotes, IsTraderApproved, TraderUserId, TraderTimeStamp, TraderRejectionReasonID, TraderNotes, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingID, RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestTimeStamp, RequestNotes, ActualQuantity, IsAutomaticRejection, IsComplianceApproved, IsContractRecieved, ComplianceUserID, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNotes, IsTraderApproved, TraderUserId, TraderTimeStamp, TraderRejectionReasonID, TraderNotes, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PADealing
	WHERE	PADealingID = @PADealingID

	UPDATE	PADealing
	SET		RequestUserID = @RequestUserID, InstrumentMarketID = @InstrumentMarketID, PADealingAccountID = @PADealingAccountID, RequestQuantity = @RequestQuantity, RequestValue = @RequestValue, RequestTimeStamp = @RequestTimeStamp, RequestNotes = @RequestNotes, ActualQuantity = @ActualQuantity, IsAutomaticRejection = @IsAutomaticRejection, IsComplianceApproved = @IsComplianceApproved, IsContractRecieved = @IsContractRecieved, ComplianceUserID = @ComplianceUserID, ComplianceTimeStamp = @ComplianceTimeStamp, ComplianceRejectionReasonID = @ComplianceRejectionReasonID, ComplianceNotes = @ComplianceNotes, IsTraderApproved = @IsTraderApproved, TraderUserId = @TraderUserId, TraderTimeStamp = @TraderTimeStamp, TraderRejectionReasonID = @TraderRejectionReasonID, TraderNotes = @TraderNotes, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PADealingID = @PADealingID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealing
	WHERE	PADealingID = @PADealingID
	AND		@@ROWCOUNT > 0

GO
