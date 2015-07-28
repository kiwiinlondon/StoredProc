USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[SecurityGroupFunctionPoint_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[SecurityGroupFunctionPoint_Insert]
GO

CREATE PROCEDURE DBO.[SecurityGroupFunctionPoint_Insert]
		@SecurityGroupId int, 
		@FunctionPointId int, 
		@CreatePermission bit, 
		@ReadPermission bit, 
		@UpdatePermission bit, 
		@DeletePermission bit, 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into SecurityGroupFunctionPoint
			(SecurityGroupId, FunctionPointId, CreatePermission, ReadPermission, UpdatePermission, DeletePermission, UpdateUserID, StartDt)
	VALUES
			(@SecurityGroupId, @FunctionPointId, @CreatePermission, @ReadPermission, @UpdatePermission, @DeletePermission, @UpdateUserID, @StartDt)

	SELECT	SecurityGroupFunctionPointId, StartDt, DataVersion
	FROM	SecurityGroupFunctionPoint
	WHERE	SecurityGroupFunctionPointId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
