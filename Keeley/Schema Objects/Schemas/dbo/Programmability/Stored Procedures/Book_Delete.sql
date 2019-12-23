USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Book_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Book_Delete]
GO

CREATE PROCEDURE DBO.[Book_Delete]
		@BookID int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO Book_hst (
			BookID, FMOrgId, Name, FundID, StartDt, UpdateUserID, DataVersion, ManagerId, EZEIdentifier, IsPrimary, IsActive, NavIsNotUsable, SignOffManagerId, EndDt, LastActionUserID)
	SELECT	BookID, FMOrgId, Name, FundID, StartDt, UpdateUserID, DataVersion, ManagerId, EZEIdentifier, IsPrimary, IsActive, NavIsNotUsable, SignOffManagerId, @EndDt, @UpdateUserID
	FROM	Book
	WHERE	BookID = @BookID

	DELETE	Book
	WHERE	BookID = @BookID
	AND		DataVersion = @DataVersion
GO
