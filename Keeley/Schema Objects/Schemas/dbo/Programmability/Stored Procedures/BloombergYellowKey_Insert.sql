USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[BloombergYellowKey_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[BloombergYellowKey_Insert]
GO

CREATE PROCEDURE DBO.[BloombergYellowKey_Insert]
		@Name varchar(200), 
		@UpdateUserID int, 
		@Code varchar(10)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into BloombergYellowKey
			(Name, UpdateUserID, Code, StartDt)
	VALUES
			(@Name, @UpdateUserID, @Code, @StartDt)

	SELECT	BloombergYellowKeyId, StartDt, DataVersion
	FROM	BloombergYellowKey
	WHERE	BloombergYellowKeyId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
