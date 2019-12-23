USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CurveTenor_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CurveTenor_Update]
GO

CREATE PROCEDURE DBO.[CurveTenor_Update]
		@CurveTenorId int, 
		@CurveId int, 
		@ReferenceDate datetime, 
		@TenorDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO CurveTenor_hst (
			CurveTenorId, CurveId, ReferenceDate, TenorDate, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CurveTenorId, CurveId, ReferenceDate, TenorDate, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	CurveTenor
	WHERE	CurveTenorId = @CurveTenorId

	UPDATE	CurveTenor
	SET		CurveId = @CurveId, ReferenceDate = @ReferenceDate, TenorDate = @TenorDate, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	CurveTenorId = @CurveTenorId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	CurveTenor
	WHERE	CurveTenorId = @CurveTenorId
	AND		@@ROWCOUNT > 0

GO
