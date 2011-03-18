USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Account_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Account_Delete]
GO

CREATE PROCEDURE DBO.[Account_Delete]
		@AccountID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Account_hst (
			AccountID, Name, ExternalId, CustodianId, StartDt, UpdateUserID, DataVersion, FundId, EndDt, LastActionUserID)
	SELECT	AccountID, Name, ExternalId, CustodianId, StartDt, UpdateUserID, DataVersion, FundId, @EndDt, @UpdateUserID
	FROM	Account
	WHERE	AccountID = @AccountID

	DELETE	Account
	WHERE	AccountID = @AccountID
	AND		DataVersion = @DataVersion
GO
