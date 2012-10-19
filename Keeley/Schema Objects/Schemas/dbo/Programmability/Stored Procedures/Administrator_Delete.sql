USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Administrator_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Administrator_Delete]
GO

CREATE PROCEDURE DBO.[Administrator_Delete]
		@LegalEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Administrator_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Administrator
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	Administrator
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
