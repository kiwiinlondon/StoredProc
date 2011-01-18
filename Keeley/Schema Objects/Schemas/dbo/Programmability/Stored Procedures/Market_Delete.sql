USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Market_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Market_Delete]
GO

CREATE PROCEDURE DBO.[Market_Delete]
		@LegalEntityID timestamp,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Market_hst (
			LegalEntityID, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	LegalEntityID, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Market
	WHERE	LegalEntityID = @LegalEntityID

	DELETE	Market
	WHERE	LegalEntityID = @LegalEntityID
	AND		DataVersion = @DataVersion
GO
