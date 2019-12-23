USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DisclosureRule_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DisclosureRule_Update]
GO

CREATE PROCEDURE DBO.[DisclosureRule_Update]
		@DisclosureRuleId int, 
		@Name varchar(70), 
		@LongLimit numeric(27,8), 
		@LongStep numeric(27,8), 
		@ShortLimit numeric(27,8), 
		@ShortStep numeric(27,8), 
		@UpdateUserID int, 
		@DataVersion rowversion, 
		@CountryId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO DisclosureRule_hst (
			DisclosureRuleId, Name, LongLimit, LongStep, ShortLimit, ShortStep, StartDt, UpdateUserID, DataVersion, CountryId, EndDt, LastActionUserID)
	SELECT	DisclosureRuleId, Name, LongLimit, LongStep, ShortLimit, ShortStep, StartDt, UpdateUserID, DataVersion, CountryId, @StartDt, @UpdateUserID
	FROM	DisclosureRule
	WHERE	DisclosureRuleId = @DisclosureRuleId

	UPDATE	DisclosureRule
	SET		Name = @Name, LongLimit = @LongLimit, LongStep = @LongStep, ShortLimit = @ShortLimit, ShortStep = @ShortStep, UpdateUserID = @UpdateUserID, CountryId = @CountryId,  StartDt = @StartDt
	WHERE	DisclosureRuleId = @DisclosureRuleId
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	DisclosureRule
	WHERE	DisclosureRuleId = @DisclosureRuleId
	AND		@@ROWCOUNT > 0

GO
