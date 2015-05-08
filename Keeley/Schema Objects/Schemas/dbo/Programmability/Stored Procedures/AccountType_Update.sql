USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AccountType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AccountType_Update]
GO

CREATE PROCEDURE DBO.[AccountType_Update]
		@AccountTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO AccountType_hst (
			AccountTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AccountTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	AccountType
	WHERE	AccountTypeId = @AccountTypeId

	UPDATE	AccountType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	AccountTypeId = @AccountTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	AccountType
	WHERE	AccountTypeId = @AccountTypeId
	AND		@@ROWCOUNT > 0

GO
