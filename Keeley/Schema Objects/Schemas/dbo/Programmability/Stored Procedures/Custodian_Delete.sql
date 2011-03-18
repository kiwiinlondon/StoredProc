USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Custodian_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Custodian_Delete]
GO

CREATE PROCEDURE DBO.[Custodian_Delete]
		@LegalEntityID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Custodian_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Custodian
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	Custodian
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
