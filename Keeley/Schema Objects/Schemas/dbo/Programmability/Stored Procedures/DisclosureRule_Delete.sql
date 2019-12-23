USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DisclosureRule_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DisclosureRule_Delete]
GO

CREATE PROCEDURE DBO.[DisclosureRule_Delete]
		@DisclosureRuleId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO DisclosureRule_hst (
			DisclosureRuleId, Name, LongLimit, LongStep, ShortLimit, ShortStep, StartDt, UpdateUserID, DataVersion, CountryId, EndDt, LastActionUserID)
	SELECT	DisclosureRuleId, Name, LongLimit, LongStep, ShortLimit, ShortStep, StartDt, UpdateUserID, DataVersion, CountryId, @EndDt, @UpdateUserID
	FROM	DisclosureRule
	WHERE	DisclosureRuleId = @DisclosureRuleId

	DELETE	DisclosureRule
	WHERE	DisclosureRuleId = @DisclosureRuleId
	AND		DataVersion = @DataVersion
GO
