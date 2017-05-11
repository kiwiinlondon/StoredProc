USE Keeley

create table DBO.FactorBenchmark_hst(
	FactorBenchmarkId int not null,
	BenchmarkName varchar(250) not null,
	StartDt datetime not null,
	UpdateUserId int not null,
	DataVersion binary(8) not null,
	EndDt datetime,
	LastActionUserID int)