USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CorporateAction_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CorporateAction_Delete]
GO

CREATE PROCEDURE DBO.[CorporateAction_Delete]
		@CorporateActionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CorporateAction_hst (
			CorporateActionId, CorporateActionTypeId, Multiplier, InputDate, StartDt, UpdateUserID, DataVersion, InstrumentMarketId, AnnounceDate, ExDate, PayDate, RecordDate, EndDt, LastActionUserID)
	SELECT	CorporateActionId, CorporateActionTypeId, Multiplier, InputDate, StartDt, UpdateUserID, DataVersion, InstrumentMarketId, AnnounceDate, ExDate, PayDate, RecordDate, @EndDt, @UpdateUserID
	FROM	CorporateAction
	WHERE	CorporateActionId = @CorporateActionId

	DELETE	CorporateAction
	WHERE	CorporateActionId = @CorporateActionId
	AND		DataVersion = @DataVersion
GO
