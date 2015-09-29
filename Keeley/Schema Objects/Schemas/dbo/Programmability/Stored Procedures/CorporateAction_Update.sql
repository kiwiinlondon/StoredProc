USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CorporateAction_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CorporateAction_Update]
GO

CREATE PROCEDURE DBO.[CorporateAction_Update]
		@CorporateActionId int, 
		@CorporateActionTypeId int, 
		@Multiplier numeric(27,8), 
		@InputDate datetime, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@InstrumentMarketId int, 
		@AnnounceDate datetime, 
		@ExDate datetime, 
		@PayDate datetime
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CorporateAction_hst (
			CorporateActionId, CorporateActionTypeId, Multiplier, InputDate, StartDt, UpdateUserID, DataVersion, InstrumentMarketId, AnnounceDate, ExDate, PayDate, EndDt, LastActionUserID)
	SELECT	CorporateActionId, CorporateActionTypeId, Multiplier, InputDate, StartDt, UpdateUserID, DataVersion, InstrumentMarketId, AnnounceDate, ExDate, PayDate, @StartDt, @UpdateUserID
	FROM	CorporateAction
	WHERE	CorporateActionId = @CorporateActionId

	UPDATE	CorporateAction
	SET		CorporateActionTypeId = @CorporateActionTypeId, Multiplier = @Multiplier, InputDate = @InputDate, UpdateUserID = @UpdateUserID, InstrumentMarketId = @InstrumentMarketId, AnnounceDate = @AnnounceDate, ExDate = @ExDate, PayDate = @PayDate,  StartDt = @StartDt
	WHERE	CorporateActionId = @CorporateActionId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CorporateAction
	WHERE	CorporateActionId = @CorporateActionId
	AND		@@ROWCOUNT > 0

GO
