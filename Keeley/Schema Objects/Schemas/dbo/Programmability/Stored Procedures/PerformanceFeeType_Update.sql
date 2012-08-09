USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[PerformanceFeeType_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[PerformanceFeeType_Update]
GO

CREATE PROCEDURE DBO.[PerformanceFeeType_Update]
		@PerformanceFeeTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO PerformanceFeeType_hst (
			PerformanceFeeTypeId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	PerformanceFeeTypeId, Name, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	PerformanceFeeType
	WHERE	PerformanceFeeTypeId = @PerformanceFeeTypeId

	UPDATE	PerformanceFeeType
	SET		Name = @Name, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	PerformanceFeeTypeId = @PerformanceFeeTypeId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	PerformanceFeeType
	WHERE	PerformanceFeeTypeId = @PerformanceFeeTypeId
	AND		@@ROWCOUNT > 0

GO
