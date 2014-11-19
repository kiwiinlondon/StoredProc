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
		@TraderID int, 
		@TraderTimeStamp datetime, 
		@TraderRejectionReasonID int, 
		@TraderNotes varchar(150), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealing
			(RequestUserID, InstrumentMarketID, PADealingAccountID, RequestQuantity, RequestValue, RequestTimeStamp, RequestNotes, ActualQuantity, IsAutomaticRejection, IsComplianceApproved, IsContractRecieved, ComplianceUserID, ComplianceTimeStamp, ComplianceRejectionReasonID, ComplianceNotes, IsTraderApproved, TraderID, TraderTimeStamp, TraderRejectionReasonID, TraderNotes, UpdateUserID, StartDt)
	VALUES
			(@RequestUserID, @InstrumentMarketID, @PADealingAccountID, @RequestQuantity, @RequestValue, @RequestTimeStamp, @RequestNotes, @ActualQuantity, @IsAutomaticRejection, @IsComplianceApproved, @IsContractRecieved, @ComplianceUserID, @ComplianceTimeStamp, @ComplianceRejectionReasonID, @ComplianceNotes, @IsTraderApproved, @TraderID, @TraderTimeStamp, @TraderRejectionReasonID, @TraderNotes, @UpdateUserID, @StartDt)

	SELECT	PADealingID, StartDt, DataVersion
	FROM	PADealing
	WHERE	PADealingID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
