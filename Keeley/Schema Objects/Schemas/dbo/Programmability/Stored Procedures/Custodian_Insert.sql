USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Custodian_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Custodian_Insert]
GO

CREATE PROCEDURE DBO.[Custodian_Insert]
		@LegalEntityID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Custodian
			(LegalEntityID, UpdateUserID, StartDt)
	VALUES
			(@LegalEntityID, @UpdateUserID, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Custodian
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
