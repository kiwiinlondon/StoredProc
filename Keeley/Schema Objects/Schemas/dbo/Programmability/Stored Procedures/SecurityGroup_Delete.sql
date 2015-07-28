USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[SecurityGroup_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[SecurityGroup_Delete]
GO

CREATE PROCEDURE DBO.[SecurityGroup_Delete]
		@SecurityGroupId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO SecurityGroup_hst (
			SecurityGroupId, Name, ADName, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	SecurityGroupId, Name, ADName, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	SecurityGroup
	WHERE	SecurityGroupId = @SecurityGroupId

	DELETE	SecurityGroup
	WHERE	SecurityGroupId = @SecurityGroupId
	AND		DataVersion = @DataVersion
GO
