USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[ListingStatus_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[ListingStatus_Insert]
GO

CREATE PROCEDURE DBO.[ListingStatus_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into ListingStatus
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	ListingStatusId, StartDt, DataVersion
	FROM	ListingStatus
	WHERE	ListingStatusId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
