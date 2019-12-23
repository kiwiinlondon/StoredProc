USE Keeley

create table DBO.Research_hst(
	ResearchId int not null,
	Subject varchar(2000) not null,
	ContributorId int not null,
	CodeRedId uniqueidentifier,
	Document varbinary not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	CreatedDt datetime not null,
	GicsId int,
	CountryId int,
	AdditionalKeyWords varchar(400),
	ActionFlags int,
	IsActioned bit not null,
	IsCRGResearch bit,
	EndDt datetime,
	LastActionUserID int)