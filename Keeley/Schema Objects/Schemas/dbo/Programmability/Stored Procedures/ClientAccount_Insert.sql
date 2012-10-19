USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientAccount_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientAccount_Insert]
GO

CREATE PROCEDURE DBO.[ClientAccount_Insert]
		@ClientId int, 
		@AccountReference varchar(20), 
		@AdministratorId int, 
		@Name varchar(100), 
		@CountryId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientAccount
			(ClientId, AccountReference, AdministratorId, Name, CountryId, UpdateUserID, StartDt)
	VALUES
			(@ClientId, @AccountReference, @AdministratorId, @Name, @CountryId, @UpdateUserID, @StartDt)

	SELECT	ClientAccountId, StartDt, DataVersion
	FROM	ClientAccount
	WHERE	ClientAccountId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
