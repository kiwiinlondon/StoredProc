USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Administrator_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Administrator_Insert]
GO

CREATE PROCEDURE DBO.[Administrator_Insert]
		@LegalEntityID int, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Administrator
			(LegalEntityID, UpdateUserID, StartDt)
	VALUES
			(@LegalEntityID, @UpdateUserID, @StartDt)

	SELECT	LegalEntityID, StartDt, DataVersion
	FROM	Administrator
	WHERE	LegalEntityID = @LegalEntityID
	AND		@@ROWCOUNT > 0

GO
