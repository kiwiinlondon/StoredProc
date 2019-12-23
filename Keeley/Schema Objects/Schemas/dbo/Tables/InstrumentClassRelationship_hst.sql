USE Keeley

create table DBO.InstrumentClassRelationship_hst(
	InstrumentClassRelationshipID int not null,
	InstrumentClassID int not null,
	ParentInstrumentClassID int not null,
	InstrumentClassHierarchyId int not null,
	StartDt datetime not null,
	UpdateUserID int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)