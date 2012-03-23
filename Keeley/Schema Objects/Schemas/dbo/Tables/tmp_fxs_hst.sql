USE Keeley

create table DBO.tmp_fxs_hst(
	eventid int not null,
	paybookxrate numeric(35,16) not null,
	receivebookxrate numeric(35,16) not null,
	EndDt datetime,
	LastActionUserID int)