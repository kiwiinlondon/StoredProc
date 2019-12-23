USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Curve_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Curve_Insert]
GO

CREATE PROCEDURE DBO.[Curve_Insert]
		@Name varchar(100), 
		@BloombergGlobalId varchar(100), 
		@Value numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Curve
			(Name, BloombergGlobalId, Value, UpdateUserID, StartDt)
	VALUES
			(@Name, @BloombergGlobalId, @Value, @UpdateUserID, @StartDt)

	SELECT	CurveId, StartDt, DataVersion
	FROM	Curve
	WHERE	CurveId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
