USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Fund_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Fund_Delete]
GO

CREATE PROCEDURE DBO.[Fund_Delete]
		@LegalEntityID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Fund_hst (
			LegalEntityID, InstrumentMarketID, ParentFundID, CurrencyID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityID, InstrumentMarketID, ParentFundID, CurrencyID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
