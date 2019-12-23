USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[CurveTenor_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[CurveTenor_Insert]
GO

CREATE PROCEDURE DBO.[CurveTenor_Insert]
		@CurveId int, 
		@ReferenceDate datetime, 
		@TenorDate datetime, 
		@Value numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into CurveTenor
			(CurveId, ReferenceDate, TenorDate, Value, UpdateUserID, StartDt)
	VALUES
			(@CurveId, @ReferenceDate, @TenorDate, @Value, @UpdateUserID, @StartDt)

	SELECT	CurveTenorId, StartDt, DataVersion
	FROM	CurveTenor
	WHERE	CurveTenorId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
