USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[SecurityGroup_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[SecurityGroup_Update]
GO

CREATE PROCEDURE DBO.[SecurityGroup_Update]
		@SecurityGroupId int, 
		@Name varchar(100), 
		@ADName varchar(100), 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO SecurityGroup_hst (
			SecurityGroupId, Name, ADName, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	SecurityGroupId, Name, ADName, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	SecurityGroup
	WHERE	SecurityGroupId = @SecurityGroupId

	UPDATE	SecurityGroup
	SET		Name = @Name, ADName = @ADName, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	SecurityGroupId = @SecurityGroupId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	SecurityGroup
	WHERE	SecurityGroupId = @SecurityGroupId
	AND		@@ROWCOUNT > 0

GO
