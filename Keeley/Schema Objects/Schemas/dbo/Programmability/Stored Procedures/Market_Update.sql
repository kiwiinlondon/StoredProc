USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Market_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Market_Update]
GO

CREATE PROCEDURE DBO.[Market_Update]
		@LegalEntityID int, 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@BBExchangeCode varchar(30), 
		@MicCode varchar(10), 
		@FixedIncomeMicCode varchar(20)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Market_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, BBExchangeCode, MicCode, FixedIncomeMicCode, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, BBExchangeCode, MicCode, FixedIncomeMicCode, @StartDt, @UpdateUserID
	FROM	Market
	WHERE	LegalEntityID = @LegalEntityID

	UPDATE	Market
	SET		UpdateUserID = @UpdateUserID, BBExchangeCode = @BBExchangeCode, MicCode = @MicCode, FixedIncomeMicCode = @FixedIncomeMicCode,  StartDt = @StartDt
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Market
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
