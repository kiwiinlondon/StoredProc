USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CurveTenor_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CurveTenor_Delete]
GO

CREATE PROCEDURE DBO.[CurveTenor_Delete]
		@CurveTenorId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO CurveTenor_hst (
			CurveTenorId, CurveId, ReferenceDate, TenorDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CurveTenorId, CurveId, ReferenceDate, TenorDate, Value, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	CurveTenor
	WHERE	CurveTenorId = @CurveTenorId

	DELETE	CurveTenor
	WHERE	CurveTenorId = @CurveTenorId
	AND		DataVersion = @DataVersion
GO
