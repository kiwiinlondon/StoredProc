USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Counterparty_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Counterparty_Insert]
GO

CREATE PROCEDURE DBO.[Counterparty_Insert]
		@LegalEntityID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Counterparty
			(LegalEntityID, UpdateUserID, StartDt)
	VALUES
			(@LegalEntityID, @UpdateUserID, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Counterparty
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
