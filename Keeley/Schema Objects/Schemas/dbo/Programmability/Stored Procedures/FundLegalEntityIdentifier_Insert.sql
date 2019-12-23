USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundLegalEntityIdentifier_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundLegalEntityIdentifier_Insert]
GO

CREATE PROCEDURE DBO.[FundLegalEntityIdentifier_Insert]
		@FundId int, 
		@LegalEntityId int, 
		@Identifier varchar(50), 
		@UpdateUserID int, 
		@IdentifierTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundLegalEntityIdentifier
			(FundId, LegalEntityId, Identifier, UpdateUserID, IdentifierTypeId, StartDt)
	VALUES
			(@FundId, @LegalEntityId, @Identifier, @UpdateUserID, @IdentifierTypeId, @StartDt)

	SELECT	FundLegalEntityIdentifierId, StartDt, DataVersion
	FROM	FundLegalEntityIdentifier
	WHERE	FundLegalEntityIdentifierId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
