USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Account_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Account_Insert]
GO

CREATE PROCEDURE DBO.[Account_Insert]
		@Name varchar(100), 
		@ExternalId varchar(30), 
		@CustodianId int, 
		@UpdateUserID int, 
		@FundId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Account
			(Name, ExternalId, CustodianId, UpdateUserID, FundId, StartDt)
	VALUES
			(@Name, @ExternalId, @CustodianId, @UpdateUserID, @FundId, @StartDt)

	SELECT	AccountID, StartDt, DataVersion
	FROM	Account
	WHERE	AccountID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
