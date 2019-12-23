USE Keeley

create table DBO.EntityRankingSchemeOrder_hst(
	EntityRankingSchemeOrderId int not null,
	EntityRankingSchemeId int not null,
	EntityTypeId int not null,
	EntityRankingSchemeItemId int not null,
	Ordering int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	AlwaysStore bit not null,
	EndDt datetime,
	LastActionUserID int)