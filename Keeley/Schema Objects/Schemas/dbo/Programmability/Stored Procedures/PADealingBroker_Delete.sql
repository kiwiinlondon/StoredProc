USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingBroker_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingBroker_Delete]
GO

CREATE PROCEDURE DBO.[PADealingBroker_Delete]
		@LegalEntityId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PADealingBroker_hst (
			LegalEntityId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PADealingBroker
	WHERE	LegalEntityId = @LegalEntityId

	DELETE	PADealingBroker
	WHERE	LegalEntityId = @LegalEntityId
	AND		DataVersion = @DataVersion
GO
