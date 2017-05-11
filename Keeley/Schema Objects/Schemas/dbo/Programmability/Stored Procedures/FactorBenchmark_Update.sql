USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorBenchmark_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorBenchmark_Update]
GO

CREATE PROCEDURE DBO.[FactorBenchmark_Update]
		@FactorBenchmarkId int, 
		@BenchmarkName varchar(250), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO FactorBenchmark_hst (
			FactorBenchmarkId, BenchmarkName, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	FactorBenchmarkId, BenchmarkName, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	FactorBenchmark
	WHERE	FactorBenchmarkId = @FactorBenchmarkId

	UPDATE	FactorBenchmark
	SET		BenchmarkName = @BenchmarkName, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	FactorBenchmarkId = @FactorBenchmarkId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	FactorBenchmark
	WHERE	FactorBenchmarkId = @FactorBenchmarkId
	AND		@@ROWCOUNT > 0

GO
