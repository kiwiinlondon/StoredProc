USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Client_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Client_Delete]
GO

CREATE PROCEDURE DBO.[Client_Delete]
		@ClientId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Client_hst (
			ClientId, ExternalReference, ClientSubTypeId, Name, StartDt, UpdateUserID, DataVersion, Unconfirmed, SalesPersonId, EndDt, LastActionUserID)
	SELECT	ClientId, ExternalReference, ClientSubTypeId, Name, StartDt, UpdateUserID, DataVersion, Unconfirmed, SalesPersonId, @EndDt, @UpdateUserID
	FROM	Client
	WHERE	ClientId = @ClientId

	DELETE	Client
	WHERE	ClientId = @ClientId
	AND		DataVersion = @DataVersion
GO
