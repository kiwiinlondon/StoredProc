USE Keeley

create table DBO.FinancingControl_hst(
	FinancingControlId int not null,
	FundId int not null,
	ReferenceDate datetime not null,
	Loaded bit not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	CustodianId int not null,
	FinancingTypeId int not null,
	IsPrimary bit not null,
	EndDt datetime,
	LastActionUserID int)