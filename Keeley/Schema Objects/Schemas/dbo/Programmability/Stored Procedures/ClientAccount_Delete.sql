USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientAccount_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientAccount_Delete]
GO

CREATE PROCEDURE DBO.[ClientAccount_Delete]
		@ClientAccountId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ClientAccount_hst (
			ClientAccountId, ClientId, AccountReference, AdministratorId, Name, CountryId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ClientAccountId, ClientId, AccountReference, AdministratorId, Name, CountryId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ClientAccount
	WHERE	ClientAccountId = @ClientAccountId

	DELETE	ClientAccount
	WHERE	ClientAccountId = @ClientAccountId
	AND		DataVersion = @DataVersion
GO
