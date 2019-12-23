USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Curve_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Curve_Update]
GO

CREATE PROCEDURE DBO.[Curve_Update]
		@CurveId int, 
		@Name varchar(100), 
		@BloombergGlobalId varchar(100), 
		@Value numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO Curve_hst (
			CurveId, Name, BloombergGlobalId, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CurveId, Name, BloombergGlobalId, Value, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	Curve
	WHERE	CurveId = @CurveId

	UPDATE	Curve
	SET		Name = @Name, BloombergGlobalId = @BloombergGlobalId, Value = @Value, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	CurveId = @CurveId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	Curve
	WHERE	CurveId = @CurveId
	AND		@@ROWCOUNT > 0

GO
