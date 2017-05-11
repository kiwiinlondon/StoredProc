USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchBroker_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchBroker_Update]
GO

CREATE PROCEDURE DBO.[ResearchBroker_Update]
		@LegalEntityId int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ResearchBroker_hst (
			LegalEntityId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityId, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ResearchBroker
	WHERE	LegalEntityId = @LegalEntityId

	UPDATE	ResearchBroker
	SET		UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	LegalEntityId = @LegalEntityId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ResearchBroker
	WHERE	LegalEntityId = @LegalEntityId
	AND		@@ROWCOUNT > 0

GO
