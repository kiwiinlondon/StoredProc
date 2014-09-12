USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Client_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Client_Update]
GO

CREATE PROCEDURE DBO.[Client_Update]
		@ClientId int, 
		@ExternalReference varchar(150), 
		@ClientSubTypeId int, 
		@Name varchar(150), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@Unconfirmed bit, 
		@SalesPersonId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Client_hst (
			ClientId, ExternalReference, ClientSubTypeId, Name, StartDt, UpdateUserID, DataVersion, Unconfirmed, SalesPersonId, EndDt, LastActionUserID)
	SELECT	ClientId, ExternalReference, ClientSubTypeId, Name, StartDt, UpdateUserID, DataVersion, Unconfirmed, SalesPersonId, @StartDt, @UpdateUserID
	FROM	Client
	WHERE	ClientId = @ClientId

	UPDATE	Client
	SET		ExternalReference = @ExternalReference, ClientSubTypeId = @ClientSubTypeId, Name = @Name, UpdateUserID = @UpdateUserID, Unconfirmed = @Unconfirmed, SalesPersonId = @SalesPersonId,  StartDt = @StartDt
	WHERE	ClientId = @ClientId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Client
	WHERE	ClientId = @ClientId
	AND		@@ROWCOUNT > 0

GO
