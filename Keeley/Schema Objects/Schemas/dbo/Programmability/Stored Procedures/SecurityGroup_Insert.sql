USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[SecurityGroup_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[SecurityGroup_Insert]
GO

CREATE PROCEDURE DBO.[SecurityGroup_Insert]
		@Name varchar(100), 
		@ADName varchar(100), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into SecurityGroup
			(Name, ADName, UpdateUserID, StartDt)
	VALUES
			(@Name, @ADName, @UpdateUserID, @StartDt)

	SELECT	SecurityGroupId, StartDt, DataVersion
	FROM	SecurityGroup
	WHERE	SecurityGroupId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
