USE Keeley

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[TestBradPosition_Update]')
AND OBJECTPROPERTY(id, N'IsProcedure') = 1)

DROP PROCEDURE DBO.[TestBradPosition_Update]
GO

CREATE PROCEDURE DBO.[TestBradPosition_Update]
		@PositionId int, 
		@C1 varchar(200), 
		@C2 varchar(70), 
		@C3 varchar(70), 
		@C4 varchar(150), 
		@C5 varchar(150), 
		@C6 int, 
		@C7 int, 
		@C8 varchar(70), 
		@C9 varchar(100), 
		@C10 varchar(70), 
		@C11 varchar(100), 
		@C12 varchar(100), 
		@C13 varchar(100), 
		@C14 varchar(100), 
		@C15 varchar(100), 
		@C16 varchar(100), 
		@C17 varchar(100), 
		@C18 varchar(100), 
		@C19 varchar(100), 
		@C20 varchar(100), 
		@C21 varchar(200), 
		@C22 varchar(70), 
		@C23 varchar(150), 
		@C24 varchar(100), 
		@C25 varchar(200), 
		@C26 varchar(70), 
		@C27 varchar(100), 
		@C28 varchar(100), 
		@C29 varchar(100), 
		@C30 varchar(100), 
		@C31 varchar(100), 
		@C32 bit, 
		@C33 bit, 
		@C34 numeric(15,0), 
		@C35 bit, 
		@C36 varchar(100), 
		@C37 int, 
		@C38 varchar(200), 
		@C39 int, 
		@C40 int, 
		@C41 int, 
		@C42 int, 
		@C43 int, 
		@C44 varchar(200), 
		@C45 int, 
		@C46 int, 
		@C47 int, 
		@C48 int, 
		@C49 int, 
		@C50 int, 
		@C51 int, 
		@C52 int, 
		@C53 int, 
		@C54 int, 
		@C55 int, 
		@C56 int, 
		@C57 int, 
		@C58 int, 
		@C59 int, 
		@C60 int, 
		@C61 int, 
		@C62 int, 
		@C63 int, 
		@C64 int, 
		@C65 int, 
		@C66 varchar(100), 
		@C67 int, 
		@C68 int, 
		@C69 int, 
		@C70 varchar(100), 
		@C71 int, 
		@C72 datetime, 
		@C73 datetime, 
		@C74 datetime, 
		@C75 datetime, 
		@C76 bit, 
		@C77 int, 
		@C78 bit, 
		@C79 int, 
		@C80 int, 
		@C81 varchar(100), 
		@C82 int, 
		@C83 int, 
		@C84 varchar(100), 
		@C85 int, 
		@C86 varchar(100), 
		@C87 varchar(100), 
		@C88 datetime, 
		@C89 bit, 
		@C90 varchar(100), 
		@C91 int, 
		@UltimateUnderlyingInstrumentMarketId int, 
		@InstrumentMarketId int
AS
	SET NOCOUNT ON

	DECLARE @StartDt DateTime
	Set @StartDt = GetDate()

	INSERT INTO TestBradPosition_hst (
			PositionId, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, UltimateUnderlyingInstrumentMarketId, InstrumentMarketId, EndDt, LastActionUserID)
	SELECT	PositionId, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, C66, C67, C68, C69, C70, C71, C72, C73, C74, C75, C76, C77, C78, C79, C80, C81, C82, C83, C84, C85, C86, C87, C88, C89, C90, C91, UltimateUnderlyingInstrumentMarketId, InstrumentMarketId, @StartDt, @UpdateUserID
	FROM	TestBradPosition
	WHERE	 = @

	UPDATE	TestBradPosition
	SET		PositionId = @PositionId, C1 = @C1, C2 = @C2, C3 = @C3, C4 = @C4, C5 = @C5, C6 = @C6, C7 = @C7, C8 = @C8, C9 = @C9, C10 = @C10, C11 = @C11, C12 = @C12, C13 = @C13, C14 = @C14, C15 = @C15, C16 = @C16, C17 = @C17, C18 = @C18, C19 = @C19, C20 = @C20, C21 = @C21, C22 = @C22, C23 = @C23, C24 = @C24, C25 = @C25, C26 = @C26, C27 = @C27, C28 = @C28, C29 = @C29, C30 = @C30, C31 = @C31, C32 = @C32, C33 = @C33, C34 = @C34, C35 = @C35, C36 = @C36, C37 = @C37, C38 = @C38, C39 = @C39, C40 = @C40, C41 = @C41, C42 = @C42, C43 = @C43, C44 = @C44, C45 = @C45, C46 = @C46, C47 = @C47, C48 = @C48, C49 = @C49, C50 = @C50, C51 = @C51, C52 = @C52, C53 = @C53, C54 = @C54, C55 = @C55, C56 = @C56, C57 = @C57, C58 = @C58, C59 = @C59, C60 = @C60, C61 = @C61, C62 = @C62, C63 = @C63, C64 = @C64, C65 = @C65, C66 = @C66, C67 = @C67, C68 = @C68, C69 = @C69, C70 = @C70, C71 = @C71, C72 = @C72, C73 = @C73, C74 = @C74, C75 = @C75, C76 = @C76, C77 = @C77, C78 = @C78, C79 = @C79, C80 = @C80, C81 = @C81, C82 = @C82, C83 = @C83, C84 = @C84, C85 = @C85, C86 = @C86, C87 = @C87, C88 = @C88, C89 = @C89, C90 = @C90, C91 = @C91, UltimateUnderlyingInstrumentMarketId = @UltimateUnderlyingInstrumentMarketId, InstrumentMarketId = @InstrumentMarketId,  StartDt = @StartDt
	WHERE	 = @
	AND		DataVersion = @DataVersion

	SELECT	StartDt, DataVersion
	FROM	TestBradPosition
	WHERE	 = @
	AND		@@ROWCOUNT > 0

GO
