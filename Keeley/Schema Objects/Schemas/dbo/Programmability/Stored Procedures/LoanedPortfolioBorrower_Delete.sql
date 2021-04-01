USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[LoanedPortfolioBorrower_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[LoanedPortfolioBorrower_Delete]
GO

CREATE PROCEDURE DBO.[LoanedPortfolioBorrower_Delete]
		@BorrowerId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO LoanedPortfolioBorrower_hst (
			BorrowerId, Name, PBIdentfier, StartDt, UpdateUserId, DataVersion, EndDt, LastActionUserID)
	SELECT	BorrowerId, Name, PBIdentfier, StartDt, UpdateUserId, DataVersion, @EndDt, @UpdateUserID
	FROM	LoanedPortfolioBorrower
	WHERE	BorrowerId = @BorrowerId

	DELETE	LoanedPortfolioBorrower
	WHERE	BorrowerId = @BorrowerId
	AND		DataVersion = @DataVersion
GO
