USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CorporateAction_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CorporateAction_Insert]
GO

CREATE PROCEDURE DBO.[CorporateAction_Insert]
		@CorporateActionTypeId int, 
		@Multiplier numeric(27,8), 
		@InputDate datetime, 
		@UpdateUserID int, 
		@InstrumentMarketId int, 
		@AnnounceDate datetime, 
		@ExDate datetime, 
		@PayDate datetime, 
		@RecordDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CorporateAction
			(CorporateActionTypeId, Multiplier, InputDate, UpdateUserID, InstrumentMarketId, AnnounceDate, ExDate, PayDate, RecordDate, StartDt)
	VALUES
			(@CorporateActionTypeId, @Multiplier, @InputDate, @UpdateUserID, @InstrumentMarketId, @AnnounceDate, @ExDate, @PayDate, @RecordDate, @StartDt)

	SELECT	CorporateActionId, StartDt, DataVersion
	FROM	CorporateAction
	WHERE	CorporateActionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
