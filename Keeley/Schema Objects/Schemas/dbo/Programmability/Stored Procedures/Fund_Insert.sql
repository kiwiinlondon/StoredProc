USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Fund_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Fund_Insert]

GO
CREATE PROCEDURE DBO.[Fund_Insert]
		@LegalEntityID int, 
		@InstrumentMarketID int, 
		@ParentFundID int, 
		@CurrencyID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Fund
			(LegalEntityID, InstrumentMarketID, ParentFundID, CurrencyID, UpdateUserID, StartDt)
	VALUES
			(@LegalEntityID, @InstrumentMarketID, @ParentFundID, @CurrencyID, @UpdateUserID, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Fund
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
