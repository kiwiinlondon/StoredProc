USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[HistoricEzeCommissionRate_Delete]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[HistoricEzeCommissionRate_Delete]
GO

CREATE PROCEDURE DBO.[HistoricEzeCommissionRate_Delete]
		@HistoricEzeCommissionRateId int,
		@DataVersion RowVersion,
		@UpdateUserID int
AS
	SET NOCOUNT ON

	DECLARE @EndDt DateTime
	Set @EndDt = GetDate()

	INSERT INTO HistoricEzeCommissionRate_hst (
			HistoricEzeCommissionRateId, EzeBrokerCode, Execution01Jan15, Research01Jan15, Execution01Feb16, Research01Feb16, Execution19Jul17, Research19Jul17, Execution05Sep17, Research05Sep17, Execution20Oct17, Research20Oct17, IsResearchUSTrade, IsResearchAllCFDTrade, IsResearchUSHKCNCFDTrade, IsResearchUSHKCNCFDTrade2016, IsResearchAllCFDTrade2016, EndDt, LastActionUserID)
	SELECT	HistoricEzeCommissionRateId, EzeBrokerCode, Execution01Jan15, Research01Jan15, Execution01Feb16, Research01Feb16, Execution19Jul17, Research19Jul17, Execution05Sep17, Research05Sep17, Execution20Oct17, Research20Oct17, IsResearchUSTrade, IsResearchAllCFDTrade, IsResearchUSHKCNCFDTrade, IsResearchUSHKCNCFDTrade2016, IsResearchAllCFDTrade2016, @EndDt, @UpdateUserID
	FROM	HistoricEzeCommissionRate
	WHERE	HistoricEzeCommissionRateId = @HistoricEzeCommissionRateId

	DELETE	HistoricEzeCommissionRate
	WHERE	HistoricEzeCommissionRateId = @HistoricEzeCommissionRateId
	AND		DataVersion = @DataVersion
GO
