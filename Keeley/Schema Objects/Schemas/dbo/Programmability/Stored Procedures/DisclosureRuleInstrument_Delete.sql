USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[DisclosureRuleInstrument_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[DisclosureRuleInstrument_Delete]
GO

CREATE PROCEDURE DBO.[DisclosureRuleInstrument_Delete]
		@DisclosureRuleInstrumentId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO DisclosureRuleInstrument_hst (
			DisclosureRuleInstrumentId, DisclosureRuleId, Exclude, CountryId, InstrumentMarketId, InstrumentClassId, StartDt, UpdateUserID, DataVersion, EndDt, LastActionUserID)
	SELECT	DisclosureRuleInstrumentId, DisclosureRuleId, Exclude, CountryId, InstrumentMarketId, InstrumentClassId, StartDt, UpdateUserID, DataVersion, @EndDt, @UpdateUserID
	FROM	DisclosureRuleInstrument
	WHERE	DisclosureRuleInstrumentId = @DisclosureRuleInstrumentId

	DELETE	DisclosureRuleInstrument
	WHERE	DisclosureRuleInstrumentId = @DisclosureRuleInstrumentId
	AND		DataVersion = @DataVersion
GO
