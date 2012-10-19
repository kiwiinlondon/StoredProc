USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Client_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Client_Insert]
GO

CREATE PROCEDURE DBO.[Client_Insert]
		@ExternalReference varchar(20), 
		@ClientSubTypeId int, 
		@Name varchar(100), 
		@CountryId int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Client
			(ExternalReference, ClientSubTypeId, Name, CountryId, UpdateUserID, StartDt)
	VALUES
			(@ExternalReference, @ClientSubTypeId, @Name, @CountryId, @UpdateUserID, @StartDt)

	SELECT	ClientId, StartDt, DataVersion
	FROM	Client
	WHERE	ClientId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
