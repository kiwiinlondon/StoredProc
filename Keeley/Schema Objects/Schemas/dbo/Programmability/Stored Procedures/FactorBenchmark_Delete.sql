USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorBenchmark_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorBenchmark_Delete]
GO

CREATE PROCEDURE DBO.[FactorBenchmark_Delete]
		@FactorBenchmarkId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO FactorBenchmark_hst (
			FactorBenchmarkId, BenchmarkName, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorBenchmarkId, BenchmarkName, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	FactorBenchmark
	WHERE	FactorBenchmarkId = @FactorBenchmarkId

	DELETE	FactorBenchmark
	WHERE	FactorBenchmarkId = @FactorBenchmarkId
	AND		DataVersion = @DataVersion
GO
