USE Keeley

create table DBO.portfoliomessageq_hst(
	MessageId int not null,
	PortfolioMessageTypeId int not null,
	Message varchar(-1),
	StartDt datetime not null,
	FundId int not null,
	InitiatingEntityId int not null,
	InitiatingEntityTypeId int not null,
	EndDt datetime,
	LastActionUserID int)