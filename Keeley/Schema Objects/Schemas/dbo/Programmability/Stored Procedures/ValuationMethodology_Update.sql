USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ValuationMethodology_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ValuationMethodology_Update]
GO

CREATE PROCEDURE DBO.[ValuationMethodology_Update]
		@ValuationMethodologyId int, 
		@Name varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO ValuationMethodology_hst (
			ValuationMethodologyId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ValuationMethodologyId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	ValuationMethodology
	WHERE	ValuationMethodologyId = @ValuationMethodologyId

	UPDATE	ValuationMethodology
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	ValuationMethodologyId = @ValuationMethodologyId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	ValuationMethodology
	WHERE	ValuationMethodologyId = @ValuationMethodologyId
	AND		@@ROWCOUNT > 0

GO
