USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundLegalEntityIdentifier_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundLegalEntityIdentifier_Delete]
GO

CREATE PROCEDURE DBO.[FundLegalEntityIdentifier_Delete]
		@FundLegalEntityIdentifierId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FundLegalEntityIdentifier_hst (
			FundLegalEntityIdentifierId, FundId, LegalEntityId, Identifier, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, EndDt, LastActionUserID)
	SELECT	FundLegalEntityIdentifierId, FundId, LegalEntityId, Identifier, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, @EndDt, @UpdateUserID
	FROM	FundLegalEntityIdentifier
	WHERE	FundLegalEntityIdentifierId = @FundLegalEntityIdentifierId

	DELETE	FundLegalEntityIdentifier
	WHERE	FundLegalEntityIdentifierId = @FundLegalEntityIdentifierId
	AND		DataVersion = @DataVersion
GO
