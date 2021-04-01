USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolioBorrower_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolioBorrower_Update]
GO

CREATE PROCEDURE DBO.[LoanedPortfolioBorrower_Update]
		@BorrowerId int, 
		@Name varchar(100), 
		@PBIdentfier varchar(20), 
		@UpdateUserId int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO LoanedPortfolioBorrower_hst (
			BorrowerId, Name, PBIdentfier, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	BorrowerId, Name, PBIdentfier, StartDt, UpdateUserId, DataVersion, @StartDt, @UpdateUserID
	FROM	LoanedPortfolioBorrower
	WHERE	BorrowerId = @BorrowerId

	UPDATE	LoanedPortfolioBorrower
	SET		Name = @Name, PBIdentfier = @PBIdentfier, UpdateUserId = @UpdateUserId,  StartDt = @StartDt
	WHERE	BorrowerId = @BorrowerId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	LoanedPortfolioBorrower
	WHERE	BorrowerId = @BorrowerId
	AND		@@ROWCOUNT > 0

GO
