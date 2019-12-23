USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[RollConvention_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[RollConvention_Delete]
GO

CREATE PROCEDURE DBO.[RollConvention_Delete]
		@RollConventionId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO RollConvention_hst (
			RollConventionId, Name, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	RollConventionId, Name, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	RollConvention
	WHERE	RollConventionId = @RollConventionId

	DELETE	RollConvention
	WHERE	RollConventionId = @RollConventionId
	AND		DataVersion = @DataVersion
GO
