USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[AttributionSource_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[AttributionSource_Insert]
GO

CREATE PROCEDURE DBO.[AttributionSource_Insert]
		@Name varchar(50), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into AttributionSource
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	AttributionSourceId, StartDt, DataVersion
	FROM	AttributionSource
	WHERE	AttributionSourceId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
