USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Market_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Market_Insert]
GO

CREATE PROCEDURE DBO.[Market_Insert]
		@LegalEntityID int, 
		@UpdateUserID int, 
		@BBExchangeCode varchar(30)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Market
			(LegalEntityID, UpdateUserID, BBExchangeCode, StartDt)
	VALUES
			(@LegalEntityID, @UpdateUserID, @BBExchangeCode, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Market
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
