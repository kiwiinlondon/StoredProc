USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PerformanceFeeType_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PerformanceFeeType_Delete]
GO

CREATE PROCEDURE DBO.[PerformanceFeeType_Delete]
		@PerformanceFeeTypeId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO PerformanceFeeType_hst (
			PerformanceFeeTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PerformanceFeeTypeId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	PerformanceFeeType
	WHERE	PerformanceFeeTypeId = @PerformanceFeeTypeId

	DELETE	PerformanceFeeType
	WHERE	PerformanceFeeTypeId = @PerformanceFeeTypeId
	AND		DataVersion = @DataVersion
GO
