USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ClientTradeType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ClientTradeType_Insert]
GO

CREATE PROCEDURE DBO.[ClientTradeType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ClientTradeType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ClientTradeTypeId, StartDt, DataVersion
	FROM	ClientTradeType
	WHERE	ClientTradeTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
