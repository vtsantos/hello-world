USE [ArcorAR]
GO
/****** Object:  StoredProcedure [dbo].[sp_baja_siradig_enc]    Script Date: 12/14/2017 7:30:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_baja_siradig_enc](
	@trabajador			CHAR(10),
	@periodo			SMALLINT)
AS
BEGIN
	DECLARE	@compania	CHAR(4),
		@indice_01		CHAR(10),
		@indice_02		CHAR(10),
		@indice_03		CHAR(10),
		@indice_04		CHAR(10),
		@indice_05		CHAR(10),
		@indice_06		CHAR(10),
		@indice_07		CHAR(10),
		@indice_08		CHAR(10),
		@indice_09		CHAR(10),
		@indice_10		CHAR(10),
		@indice_11		CHAR(10),
		@indice_12		CHAR(10),
		@indice_13		CHAR(10),
		@indice_14		CHAR(10),
		@indice_15		CHAR(10),
		@indice_16		CHAR(10),
		@indice_17		CHAR(10),
		@indice_18		CHAR(10),
		@indice_19		CHAR(10),
		@indice_20		CHAR(10),
		@indice_21		CHAR(10),
		@indice_22		CHAR(10),
		@indice_23		CHAR(10),
		@indice_24		CHAR(10),
		@indice_25		CHAR(10),
		@indice_26		CHAR(10),
		@indice_28		CHAR(10),
		@indice_29		CHAR(10),
		@indice_30		CHAR(10),
		@indice_31		CHAR(10),
		@indice_32		CHAR(10)

	SELECT	@compania = compania
	FROM	trabajadores_grales
	WHERE	sit_trabajador = 1
	AND	trabajador = @trabajador

	SELECT @indice_01 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 2, GETDATE()), '')
	SELECT @indice_02 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 4, GETDATE()), '')
	SELECT @indice_03 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 5, GETDATE()), '')
	SELECT @indice_04 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 6, GETDATE()), '')
	SELECT @indice_05 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 8, GETDATE()), '')
	SELECT @indice_06 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 11, GETDATE()), '')
	SELECT @indice_07 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 15, GETDATE()), '')

	SELECT @indice_08 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 2, GETDATE()), '')
	SELECT @indice_09 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 3, GETDATE()), '')
	SELECT @indice_10 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 4, GETDATE()), '')
	SELECT @indice_11 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 5, GETDATE()), '')
	SELECT @indice_12 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 6, GETDATE()), '')
	SELECT @indice_13 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 7, GETDATE()), '')
	SELECT @indice_14 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 8, GETDATE()), '')
	SELECT @indice_15 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 9, GETDATE()), '')
	SELECT @indice_16 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 10, GETDATE()), '')
	SELECT @indice_17 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 11, GETDATE()), '')
	SELECT @indice_18 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 12, GETDATE()), '')
	SELECT @indice_19 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 13, GETDATE()), '')
	SELECT @indice_20 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 14, GETDATE()), '')
	SELECT @indice_21 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 15, GETDATE()), '')
	SELECT @indice_22 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 16, GETDATE()), '')
	SELECT @indice_23 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 17, GETDATE()), '')
	SELECT @indice_24 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 18, GETDATE()), '')
	SELECT @indice_25 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 19, GETDATE()), '')
	SELECT @indice_26 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 20, GETDATE()), '')
	SELECT @indice_28 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 22, GETDATE()), '')
	SELECT @indice_29 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 23, GETDATE()), '')
	SELECT @indice_30 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 24, GETDATE()), '')
	SELECT @indice_31 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 25, GETDATE()), '')
	SELECT @indice_32 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 26, GETDATE()), '')

	DELETE	siradig_cargas_fam
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_ing_aportes
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_empleador_ent
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_deduc_per
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_deduc_det
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_deducciones
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_ret_pp_per
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_ret_pp_det
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_ret_per_pago
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_agente_ret
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_ajuste_det
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)	

	DELETE	siradig_ajuste
	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

	DELETE	siradig_enc
	WHERE	periodo = @periodo AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_01 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_02 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_03 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_04 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_05 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_06 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_07 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_08 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_09 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_10 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_11 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_12 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_13 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_14 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_15 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_16 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_17 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_18 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_19 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_20 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_21 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_22 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_23 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_24 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_25 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_26 AND trabajador = @trabajador
		
	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_28 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_29 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_30 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_31 AND trabajador = @trabajador

	DELETE	inf_soc_trabajador
	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_32 AND trabajador = @trabajador
END


--USE [ArcorAR]
--GO
--/****** Object:  StoredProcedure [dbo].[sp_baja_siradig_enc]    Script Date: 12/14/2017 8:42:52 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER OFF
--GO
--ALTER PROCEDURE [dbo].[sp_baja_siradig_enc](
--	@trabajador			CHAR(10),
--	@periodo			SMALLINT)
--AS
--BEGIN
--	DECLARE	@compania	CHAR(4),
--		@indice_01		CHAR(10),
--		@indice_02		CHAR(10),
--		@indice_03		CHAR(10),
--		@indice_04		CHAR(10),
--		@indice_05		CHAR(10),
--		@indice_06		CHAR(10),
--		@indice_07		CHAR(10),
--		@indice_08		CHAR(10),
--		@indice_09		CHAR(10),
--		@indice_10		CHAR(10),
--		@indice_11		CHAR(10),
--		@indice_12		CHAR(10),
--		@indice_13		CHAR(10),
--		@indice_14		CHAR(10),
--		@indice_15		CHAR(10),
--		@indice_16		CHAR(10),
--		@indice_17		CHAR(10),
--		@indice_18		CHAR(10),
--		@indice_19		CHAR(10),
--		@indice_20		CHAR(10),
--		@indice_21		CHAR(10),
--		@indice_22		CHAR(10),
--		@indice_23		CHAR(10),
--		@indice_24		CHAR(10),
--		@indice_25		CHAR(10),
--		@indice_26		CHAR(10)

--	SELECT	@compania = compania
--	FROM	trabajadores_grales
--	WHERE	sit_trabajador = 1
--	AND	trabajador = @trabajador

--	SELECT @indice_01 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 2, GETDATE()), '')
--	SELECT @indice_02 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 4, GETDATE()), '')
--	SELECT @indice_03 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 5, GETDATE()), '')
--	SELECT @indice_04 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 6, GETDATE()), '')
--	SELECT @indice_05 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 8, GETDATE()), '')
--	SELECT @indice_06 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 11, GETDATE()), '')
--	SELECT @indice_07 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'FPAR_FORMULARIO_649', 15, GETDATE()), '')

--	SELECT @indice_08 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 2, GETDATE()), '')
--	SELECT @indice_09 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 3, GETDATE()), '')
--	SELECT @indice_10 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 4, GETDATE()), '')
--	SELECT @indice_11 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 5, GETDATE()), '')
--	SELECT @indice_12 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 6, GETDATE()), '')
--	SELECT @indice_13 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 7, GETDATE()), '')
--	SELECT @indice_14 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 8, GETDATE()), '')
--	SELECT @indice_15 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 9, GETDATE()), '')
--	SELECT @indice_16 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 10, GETDATE()), '')
--	SELECT @indice_17 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 11, GETDATE()), '')
--	SELECT @indice_18 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 12, GETDATE()), '')
--	SELECT @indice_19 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 13, GETDATE()), '')
--	SELECT @indice_20 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 14, GETDATE()), '')
--	SELECT @indice_21 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 15, GETDATE()), '')
--	SELECT @indice_22 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 16, GETDATE()), '')
--	SELECT @indice_23 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 17, GETDATE()), '')
--	SELECT @indice_24 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 18, GETDATE()), '')
--	SELECT @indice_25 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 19, GETDATE()), '')
--	SELECT @indice_26 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 20, GETDATE()), '')

--	DELETE	siradig_cargas_fam
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_ing_aportes
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_empleador_ent
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_deduc_per
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_deduc_det
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_deducciones
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_ret_pp_per
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_ret_pp_det
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_ret_per_pago
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_agente_ret
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_ajuste_det
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)	

--	DELETE	siradig_ajuste
--	WHERE	id_siradig_enc IN (SELECT id_siradig_enc FROM siradig_enc WHERE periodo = @periodo AND trabajador = @trabajador)

--	DELETE	siradig_enc
--	WHERE	periodo = @periodo AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_01 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_02 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_03 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_04 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_05 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_06 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_07 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_08 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_09 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_10 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_11 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_12 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_13 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_14 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_15 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_16 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_17 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_18 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_19 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_20 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_21 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_22 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_23 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_24 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_25 AND trabajador = @trabajador

--	DELETE	inf_soc_trabajador
--	WHERE	dato_13 = @periodo AND indice_inf_soc = @indice_26 AND trabajador = @trabajador
--END
