USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ValuationMethodology_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ValuationMethodology_Delete]
GO

CREATE PROCEDURE DBO.[ValuationMethodology_Delete]
		@ValuationMethodologyId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO ValuationMethodology_hst (
			ValuationMethodologyId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	ValuationMethodologyId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	ValuationMethodology
	WHERE	ValuationMethodologyId = @ValuationMethodologyId

	DELETE	ValuationMethodology
	WHERE	ValuationMethodologyId = @ValuationMethodologyId
	AND		DataVersion = @DataVersion
GO
