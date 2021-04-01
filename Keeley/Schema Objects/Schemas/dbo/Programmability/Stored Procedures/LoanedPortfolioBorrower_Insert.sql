USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolioBorrower_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolioBorrower_Insert]
GO

CREATE PROCEDURE DBO.[LoanedPortfolioBorrower_Insert]
		@Name varchar(100), 
		@PBIdentfier varchar(20), 
		@UpdateUserId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into LoanedPortfolioBorrower
			(Name, PBIdentfier, UpdateUserId, StartDt)
	VALUES
			(@Name, @PBIdentfier, @UpdateUserId, @StartDt)

	SELECT	BorrowerId, StartDt, DataVersion
	FROM	LoanedPortfolioBorrower
	WHERE	BorrowerId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
