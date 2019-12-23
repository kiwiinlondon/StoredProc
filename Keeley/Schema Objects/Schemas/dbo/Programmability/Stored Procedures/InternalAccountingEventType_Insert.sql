USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[InternalAccountingEventType_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[InternalAccountingEventType_Insert]
GO

CREATE PROCEDURE DBO.[InternalAccountingEventType_Insert]
		@Name varchar(70), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into InternalAccountingEventType
			(Name, UpdateUserID, StartDt)
	VALUES
			(@Name, @UpdateUserID, @StartDt)

	SELECT	InternalAccountingEventTypeID, StartDt, DataVersion
	FROM	InternalAccountingEventType
	WHERE	InternalAccountingEventTypeID = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
