USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ResearchBroker_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ResearchBroker_Insert]
GO

CREATE PROCEDURE DBO.[ResearchBroker_Insert]
		@LegalEntityId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ResearchBroker
			(LegalEntityId, UpdateUserID, StartDt)
	VALUES
			(@LegalEntityId, @UpdateUserID, @StartDt)

	SELECT	LegalEntityId, StartDt, DataVersion
	FROM	ResearchBroker
	WHERE	LegalEntityId = @LegalEntityId
	AND		@@ROWCOUNT > 0

GO
