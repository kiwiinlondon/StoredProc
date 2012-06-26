USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DisclosureRule_Insert]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DisclosureRule_Insert]
GO

CREATE PROCEDURE DBO.[DisclosureRule_Insert]
		@Name varchar(70), 
		@LongLimit numeric(27,8), 
		@LongStep numeric(27,8), 
		@ShortLimit numeric(27,8), 
		@ShortStep numeric(27,8), 
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT into DisclosureRule
			(Name, LongLimit, LongStep, ShortLimit, ShortStep, UpdateUserID, StartDt)
	VALUES
			(@Name, @LongLimit, @LongStep, @ShortLimit, @ShortStep, @UpdateUserID, @StartDt)

	SELECT	DisclosureRuleId, StartDt, DataVersion
	FROM	DisclosureRule
	WHERE	DisclosureRuleId = SCOPE_IDENTITY()
	AND		@@ROWCOUNT > 0

GO
