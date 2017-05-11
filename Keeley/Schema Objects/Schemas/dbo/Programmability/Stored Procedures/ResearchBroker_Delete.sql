USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchBroker_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchBroker_Delete]
GO

CREATE PROCEDURE DBO.[ResearchBroker_Delete]
		@LegalEntityId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ResearchBroker_hst (
			LegalEntityId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ResearchBroker
	WHERE	LegalEntityId = @LegalEntityId

	DELETE	ResearchBroker
	WHERE	LegalEntityId = @LegalEntityId
	AND		DataVersion = @DataVersion
GO
