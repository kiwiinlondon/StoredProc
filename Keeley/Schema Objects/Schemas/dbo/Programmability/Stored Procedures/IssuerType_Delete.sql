USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerType_Delete]
GO

CREATE PROCEDURE DBO.[IssuerType_Delete]
		@IssuerTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO IssuerType_hst (
			IssuerTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	IssuerTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	IssuerType
	WHERE	IssuerTypeId = @IssuerTypeId

	DELETE	IssuerType
	WHERE	IssuerTypeId = @IssuerTypeId
	AND		DataVersion = @DataVersion
GO
