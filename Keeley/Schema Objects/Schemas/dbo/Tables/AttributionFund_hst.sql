﻿USE Keeley

create table DBO.AttributionFund_hst(
	AttributionFundId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	AdjustmentFactor numeric(27,8) not null,
	AdjustedNav numeric(27,8) not null,
	AdjustedOpeningNav numeric(27,8) not null,
	KeeleyAdjustmentFactor numeric(27,8) not null,
	KeeleyAdjustedNav numeric(27,8) not null,
	KeeleyAdjustedOpeningNav numeric(27,8) not null,
	AdministratorAdjustmentFactor numeric(27,8),
	AdministratorAdjustedNav numeric(27,8),
	AdministratorOpeningAdjustedNav numeric(27,8),
	AdministratorSourced bit not null,
	AdministratorPrevious datetime,
	FactsetSourced bit not null,
	FactsetPrevious datetime,
	KeeleyUnadjustedNav numeric(27,8) not null,
	KeeleyTodayCapitalChange numeric(27,8) not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	PercentageOfFund numeric(27,8) not null,
	ValuationAdjustmentFactor numeric(27,8),
	ValuationAdjustedNav numeric(27,8),
	ValuationOpeningAdjustedNav numeric(27,8),
	ValuationUnadjustedNav numeric(27,8),
	EndDt datetime,
	LastActionUserID int)