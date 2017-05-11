USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FactorBenchmark_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FactorBenchmark_Insert]
GO

CREATE PROCEDURE DBO.[FactorBenchmark_Insert]
		@BenchmarkName varchar(250), 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FactorBenchmark
			(BenchmarkName, UpdateUserId, StartDt)
	VALUES
			(@BenchmarkName, @UpdateUserId, @StartDt)

	SELECT	FactorBenchmarkId, StartDt, DataVersion
	FROM	FactorBenchmark
	WHERE	FactorBenchmarkId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
