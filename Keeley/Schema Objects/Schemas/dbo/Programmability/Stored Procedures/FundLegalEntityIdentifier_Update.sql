USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundLegalEntityIdentifier_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundLegalEntityIdentifier_Update]
GO

CREATE PROCEDURE DBO.[FundLegalEntityIdentifier_Update]
		@FundLegalEntityIdentifierId int, 
		@FundId int, 
		@LegalEntityId int, 
		@Identifier varchar(50), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@IdentifierTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FundLegalEntityIdentifier_hst (
			FundLegalEntityIdentifierId, FundId, LegalEntityId, Identifier, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, EndDt, LastActionUserID)
	SELECT	FundLegalEntityIdentifierId, FundId, LegalEntityId, Identifier, StartDt, UpdateUserID, DataVersion, IdentifierTypeId, @StartDt, @UpdateUserID
	FROM	FundLegalEntityIdentifier
	WHERE	FundLegalEntityIdentifierId = @FundLegalEntityIdentifierId

	UPDATE	FundLegalEntityIdentifier
	SET		FundId = @FundId, LegalEntityId = @LegalEntityId, Identifier = @Identifier, UpdateUserID = @UpdateUserID, IdentifierTypeId = @IdentifierTypeId,  StartDt = @StartDt
	WHERE	FundLegalEntityIdentifierId = @FundLegalEntityIdentifierId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FundLegalEntityIdentifier
	WHERE	FundLegalEntityIdentifierId = @FundLegalEntityIdentifierId
	AND		@@ROWCOUNT > 0

GO
