﻿USE Keeley

create table DBO.OfficialNetAssetValue_hst(
	OfficialNetAssetValueId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	Value numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	InSpecieTransfer numeric(27,8),
	UnitsInIssue numeric(27,8),
	GrossAssetValue numeric(27,8),
	TodayManagementFee numeric(27,8),
	ValueIsForReferenceDate bit not null,
	OpeningGAV numeric(27,8),
	PercentageOfFund numeric(27,8),
	TodayOfficialManagementFee numeric(27,8),
	TodayOfficialPerformanceFee numeric(27,8),
	TotalOfficialPerformanceFee numeric(27,8),
	TodayOfficialPNL numeric(27,8),
	TodayOfficialShareClassHedgingPNL numeric(27,8),
	NetAssetValueFundCurrency numeric(27,8),
	GrossAssetValueFundCurrency numeric(27,8),
	TodayOfficialManagementFeeFundCurrency numeric(27,8),
	TodayOfficialPerformanceFeeFundCurrency numeric(27,8),
	TotalOfficialPerformanceFeeFundCurrency numeric(27,8),
	TodayOfficialPNLFundCurrency numeric(27,8),
	TodayOfficialShareClassHedgingPNLFundCurrency numeric(27,8),
	Subscriptions numeric(27,8),
	Redemptions numeric(27,8),
	SubscriptionsFundCurrency numeric(27,8),
	RedemptionsFundCurrency numeric(27,8),
	OpeningGAVFundCurrency numeric(27,8),
	OpeningNAVFundCurrency numeric(27,8),
	OpeningNAV numeric(27,8),
	EndDt datetime,
	LastActionUserID int)