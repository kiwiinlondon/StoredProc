USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[SecurityGroupFunctionPoint_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[SecurityGroupFunctionPoint_Update]
GO

CREATE PROCEDURE DBO.[SecurityGroupFunctionPoint_Update]
		@SecurityGroupFunctionPointId int, 
		@SecurityGroupId int, 
		@FunctionPointId int, 
		@CreatePermission bit, 
		@ReadPermission bit, 
		@UpdatePermission bit, 
		@DeletePermission bit, 
		@UpdateUserID int, 
		@DataVersion rowversion
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO SecurityGroupFunctionPoint_hst (
			SecurityGroupFunctionPointId, SecurityGroupId, FunctionPointId, CreatePermission, ReadPermission, UpdatePermission, DeletePermission, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	SecurityGroupFunctionPointId, SecurityGroupId, FunctionPointId, CreatePermission, ReadPermission, UpdatePermission, DeletePermission, StartDt, UpdateUserID, DataVersion, @StartDt, @UpdateUserID
	FROM	SecurityGroupFunctionPoint
	WHERE	SecurityGroupFunctionPointId = @SecurityGroupFunctionPointId

	UPDATE	SecurityGroupFunctionPoint
	SET		SecurityGroupId = @SecurityGroupId, FunctionPointId = @FunctionPointId, CreatePermission = @CreatePermission, ReadPermission = @ReadPermission, UpdatePermission = @UpdatePermission, DeletePermission = @DeletePermission, UpdateUserID = @UpdateUserID,  StartDt = @StartDt
	WHERE	SecurityGroupFunctionPointId = @SecurityGroupFunctionPointId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	SecurityGroupFunctionPoint
	WHERE	SecurityGroupFunctionPointId = @SecurityGroupFunctionPointId
	AND		@@ROWCOUNT > 0

GO
