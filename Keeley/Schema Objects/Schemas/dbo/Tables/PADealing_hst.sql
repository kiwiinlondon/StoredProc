USE Keeley

create table DBO.PADealing_hst(
	PADealingID int not null,
	RequestingUserID int not null,
	InstrumentMarketID int not null,
	IsBuy bit not null,
	Quantity numeric(27,8) not null,
	RequestTimeStamp datetime not null,
	RequestNote varchar(150),
	IsAutomaticRejection bit,
	IsComplianceApproved bit,
	ComplianceTimeStamp datetime,
	ComplianceRejectionReasonID int,
	ComplianceNote varchar(150),
	IsTraderApproved bit,
	TraderTimeStamp datetime,
	TraderRejectionReasonID int,
	TraderNote varchar(150),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)