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
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealing
			(RequestingUserID, InstrumentMarketID, IsBuy, Quantity, RequestTimeStamp, RequestNote, IsAutomaticRejection, IsComplianceApproved, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNote, IsTraderApproved, TraderTimeStamp, TraderRejectionReasonID, TraderNote, UpdateUserID, StartDt)
	VALUES
			(@RequestingUserID, @InstrumentMarketID, @IsBuy, @Quantity, @RequestTimeStamp, @RequestNote, @IsAutomaticRejection, @IsComplianceApproved, @ComplianceTimeStamp, @ComplianceRejectionReasonID, @ComplianceNote, @IsTraderApproved, @TraderTimeStamp, @TraderRejectionReasonID, @TraderNote, @UpdateUserID, @StartDt)

	SELECT	PADealingID, StartDt, DataVersion
	FROM	PADealing
	WHERE	PADealingID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
