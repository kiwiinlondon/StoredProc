USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Curve_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Curve_Delete]
GO

CREATE PROCEDURE DBO.[Curve_Delete]
		@CurveId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Curve_hst (
			CurveId, Name, BloombergGlobalId, Value, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	CurveId, Name, BloombergGlobalId, Value, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	Curve
	WHERE	CurveId = @CurveId

	DELETE	Curve
	WHERE	CurveId = @CurveId
	AND		DataVersion = @DataVersion
GO
