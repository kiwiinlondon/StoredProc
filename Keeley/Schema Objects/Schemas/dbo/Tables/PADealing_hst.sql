﻿USE Keeley

create table DBO.PADealing_hst(
	PADealingID int not null,
	RequestUserID int not null,
	InstrumentMarketID int not null,
	PADealingAccountID int not null,
	RequestQuantity numeric(27,8),
	RequestValue numeric(27,8),
	RequestTimeStamp datetime not null,
	RequestNotes varchar(150),
	ActualQuantity numeric(27,8),
	IsAutomaticRejection bit,
	IsComplianceApproved bit,
	IsContractRecieved bit,
	ComplianceUserID int,
	ComplianceTimeStamp datetime,
	ComplianceRejectionReasonID int,
	ComplianceNotes varchar(150),
	IsTraderApproved bit,
	TraderUserId int,
	TraderTimeStamp datetime,
	TraderRejectionReasonID int,
	TraderNotes varchar(150),
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)