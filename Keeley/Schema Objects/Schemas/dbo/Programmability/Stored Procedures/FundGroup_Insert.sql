USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[FundGroup_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[FundGroup_Insert]
GO

CREATE PROCEDURE DBO.[FundGroup_Insert]
		@Name varchar(70), 
		@UpdateUserID int, 
		@LongName varchar(70), 
		@Description varchar(200)
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into FundGroup
			(Name, UpdateUserID, LongName, Description, StartDt)
	VALUES
			(@Name, @UpdateUserID, @LongName, @Description, @StartDt)

	SELECT	FundGroupId, StartDt, DataVersion
	FROM	FundGroup
	WHERE	FundGroupId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
