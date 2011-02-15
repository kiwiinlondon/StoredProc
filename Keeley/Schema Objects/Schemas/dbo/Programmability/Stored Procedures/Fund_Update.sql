USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Fund_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Fund_Update]
GO

CREATE PROCEDURE DBO.[Fund_Update]
		@LegalEntityID int, 
		@CurrencyID int, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Fund_hst (
			LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityID, CurrencyID, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Fund
	SET		CurrencyID = @CurrencyID, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
