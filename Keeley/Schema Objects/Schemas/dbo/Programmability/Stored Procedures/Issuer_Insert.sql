USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Issuer_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Issuer_Insert]
GO

CREATE PROCEDURE DBO.[Issuer_Insert]
		@LegalEntityID int, 
		@UpdateUserID int, 
		@FactsetId varchar(150), 
		@GicsLevel3IndustryID int, 
		@IssuerTypeId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Issuer
			(LegalEntityID, UpdateUserID, FactsetId, GicsLevel3IndustryID, IssuerTypeId, StartDt)
	VALUES
			(@LegalEntityID, @UpdateUserID, @FactsetId, @GicsLevel3IndustryID, @IssuerTypeId, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Issuer
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
