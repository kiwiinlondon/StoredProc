USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PADealingBroker_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PADealingBroker_Insert]
GO

CREATE PROCEDURE DBO.[PADealingBroker_Insert]
		@LegalEntityId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into PADealingBroker
			(LegalEntityId, UpdateUserID, StartDt)
	VALUES
			(@LegalEntityId, @UpdateUserID, @StartDt)

	SELECT	LegalEntityId, StartDt, DataVersion
	FROM	PADealingBroker
	WHERE	LegalEntityId = @LegalEntityId
	AND		@@ROWCOUNT > 0

GO
