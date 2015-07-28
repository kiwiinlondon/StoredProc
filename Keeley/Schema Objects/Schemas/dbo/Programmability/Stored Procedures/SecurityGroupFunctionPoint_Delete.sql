USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[SecurityGroupFunctionPoint_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[SecurityGroupFunctionPoint_Delete]
GO

CREATE PROCEDURE DBO.[SecurityGroupFunctionPoint_Delete]
		@SecurityGroupFunctionPointId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO SecurityGroupFunctionPoint_hst (
			SecurityGroupFunctionPointId, SecurityGroupId, FunctionPointId, CreatePermission, ReadPermission, UpdatePermission, DeletePermission, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	SecurityGroupFunctionPointId, SecurityGroupId, FunctionPointId, CreatePermission, ReadPermission, UpdatePermission, DeletePermission, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	SecurityGroupFunctionPoint
	WHERE	SecurityGroupFunctionPointId = @SecurityGroupFunctionPointId

	DELETE	SecurityGroupFunctionPoint
	WHERE	SecurityGroupFunctionPointId = @SecurityGroupFunctionPointId
	AND		DataVersion = @DataVersion
GO
