USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[Extract_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[Extract_Insert]
GO

CREATE PROCEDURE DBO.[Extract_Insert]
		@ExtractTypeId int, 
		@Name varchar(70), 
		@UpdateUserID int, 
		@ExtractOutputTypeID int, 
		@ExtractRunnerTypeID int, 
		@ExtractInputTypeID int, 
		@ExtractDeliveryTypeID int, 
		@SendIfEmpty bit
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into Extract
			(ExtractTypeId, Name, UpdateUserID, ExtractOutputTypeID, ExtractRunnerTypeID, ExtractInputTypeID, ExtractDeliveryTypeID, SendIfEmpty, StartDt)
	VALUES
			(@ExtractTypeId, @Name, @UpdateUserID, @ExtractOutputTypeID, @ExtractRunnerTypeID, @ExtractInputTypeID, @ExtractDeliveryTypeID, @SendIfEmpty, @StartDt)

	SELECT	ExtractID, StartDt, DataVersion
	FROM	Extract
	WHERE	ExtractID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
