USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerType_Update]
GO

CREATE PROCEDURE DBO.[IssuerType_Update]
		@IssuerTypeId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO IssuerType_hst (
			IssuerTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IssuerTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	IssuerType
	WHERE	IssuerTypeId = @IssuerTypeId

	UPDATE	IssuerType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	IssuerTypeId = @IssuerTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	IssuerType
	WHERE	IssuerTypeId = @IssuerTypeId
	AND		@@ROWCOUNT > 0

GO
