USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundFeederType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundFeederType_Insert]
GO

CREATE PROCEDURE DBO.[FundFeederType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundFeederType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundFeederTypeId, StartDt, DataVersion
	FROM	FundFeederType
	WHERE	FundFeederTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
