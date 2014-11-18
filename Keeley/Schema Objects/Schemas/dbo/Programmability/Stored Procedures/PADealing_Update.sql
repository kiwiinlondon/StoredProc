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
		@RequestingUserID int, 
		@InstrumentMarketID int, 
		@IsBuy bit, 
		@Quantity numeric(27,8), 
		@RequestTimeStamp datetime, 
		@RequestNote varchar(150), 
		@IsAutomaticRejection bit, 
		@IsComplianceApproved bit, 
		@ComplianceTimeStamp datetime, 
		@ComplianceRejectionReasonID int, 
		@ComplianceNote varchar(150), 
		@IsTraderApproved bit, 
		@TraderTimeStamp datetime, 
		@TraderRejectionReasonID int, 
		@TraderNote varchar(150), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PADealing_hst (
			PADealingID, RequestingUserID, InstrumentMarketID, IsBuy, Quantity, RequestTimeStamp, RequestNote, IsAutomaticRejection, IsComplianceApproved, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNote, IsTraderApproved, TraderTimeStamp, TraderRejectionReasonID, TraderNote, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PADealingID, RequestingUserID, InstrumentMarketID, IsBuy, Quantity, RequestTimeStamp, RequestNote, IsAutomaticRejection, IsComplianceApproved, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNote, IsTraderApproved, TraderTimeStamp, TraderRejectionReasonID, TraderNote, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PADealing
	WHERE	PADealingID = @PADealingID

	UPDATE	PADealing
	SET		RequestingUserID = @RequestingUserID, InstrumentMarketID = @InstrumentMarketID, IsBuy = @IsBuy, Quantity = @Quantity, RequestTimeStamp = @RequestTimeStamp, RequestNote = @RequestNote, IsAutomaticRejection = @IsAutomaticRejection, IsComplianceApproved = @IsComplianceApproved, ComplianceTimeStamp = @ComplianceTimeStamp, ComplianceRejectionReasonID = @ComplianceRejectionReasonID, ComplianceNote = @ComplianceNote, IsTraderApproved = @IsTraderApproved, TraderTimeStamp = @TraderTimeStamp, TraderRejectionReasonID = @TraderRejectionReasonID, TraderNote = @TraderNote, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PADealingID = @PADealingID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PADealing
	WHERE	PADealingID = @PADealingID
	AND		@@ROWCOUNT > 0

GO
