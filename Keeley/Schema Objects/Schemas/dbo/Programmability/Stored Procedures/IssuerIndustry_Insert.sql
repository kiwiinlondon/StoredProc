USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerIndustry_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerIndustry_Insert]
GO

CREATE PROCEDURE DBO.[IssuerIndustry_Insert]
		@IssuerID int, 
		@IndustryID int, 
		@IndustryClassificationID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IssuerIndustry
			(IssuerID, IndustryID, IndustryClassificationID, UpdateUserID, StartDt)
	VALUES
			(@IssuerID, @IndustryID, @IndustryClassificationID, @UpdateUserID, @StartDt)

	SELECT	IssuerIndustryID, StartDt, DataVersion
	FROM	IssuerIndustry
	WHERE	IssuerIndustryID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
