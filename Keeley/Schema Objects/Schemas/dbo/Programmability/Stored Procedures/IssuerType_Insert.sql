USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[IssuerType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[IssuerType_Insert]
GO

CREATE PROCEDURE DBO.[IssuerType_Insert]
		@Name varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into IssuerType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	IssuerTypeId, StartDt, DataVersion
	FROM	IssuerType
	WHERE	IssuerTypeId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
