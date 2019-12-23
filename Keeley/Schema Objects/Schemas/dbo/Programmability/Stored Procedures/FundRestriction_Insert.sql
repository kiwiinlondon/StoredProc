USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundRestriction_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundRestriction_Insert]
GO

CREATE PROCEDURE DBO.[FundRestriction_Insert]
		@Name varchar(200), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundRestriction
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	FundRestrictionId, StartDt, DataVersion
	FROM	FundRestriction
	WHERE	FundRestrictionId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
