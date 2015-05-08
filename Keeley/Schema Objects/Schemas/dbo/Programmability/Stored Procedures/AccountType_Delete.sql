USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AccountType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AccountType_Delete]
GO

CREATE PROCEDURE DBO.[AccountType_Delete]
		@AccountTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO AccountType_hst (
			AccountTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	AccountTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	AccountType
	WHERE	AccountTypeId = @AccountTypeId

	DELETE	AccountType
	WHERE	AccountTypeId = @AccountTypeId
	AND		DataVersion = @DataVersion
GO
