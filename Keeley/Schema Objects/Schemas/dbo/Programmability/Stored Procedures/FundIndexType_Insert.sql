USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundIndexType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundIndexType_Insert]
GO

CREATE PROCEDURE DBO.[FundIndexType_Insert]
		@Name varchar(150), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundIndexType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundIndexTypeId, StartDt, DataVersion
	FROM	FundIndexType
	WHERE	FundIndexTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
