USE [ArcorAR]
GO
/****** Object:  StoredProcedure [dbo].[sp_transf_siradig_indinf]    Script Date: 12/14/2017 8:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_transf_siradig_indinf](
	@id_siradig_enc	BIGINT,
	@error			TINYINT OUTPUT)
AS
BEGIN
	SET DATEFORMAT dmy;

	DECLARE	@w_apo		CHAR(1),
		@compania		CHAR(4),
		@trabajador		CHAR(10),
		@val_inserta	TINYINT,

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
		@indice_32		CHAR(10),

		@dato_01		VARCHAR(40),
		@trabajador_persona	TINYINT,
		@persona_relacionada	CHAR(10),
		@dato_02		CHAR(15),
		@dato_03		CHAR(10),
		@dato_04		CHAR(10),
		@dato_05		CHAR(20),
		@dato_06		CHAR(20),
		@dato_07		VARCHAR(30),
		@dato_08		VARCHAR(30),
		@dato_09		VARCHAR(40),
		@dato_10		VARCHAR(50),
		@dato_11		INT,
		@dato_12		INT,
		@dato_13		INT,
		@dato_14		DECIMAL(15,6),
		@dato_15		DECIMAL(15,6),
		@dato_16		DECIMAL(15,6),
		@dato_17		DECIMAL(15,6),
		@dato_18		DECIMAL(15,6),
		@dato_19		DECIMAL(15,6),
		@dato_20		DECIMAL(15,6),
		@dato_21		SMALLDATETIME,
		@dato_22		SMALLDATETIME,
		@dato_23		SMALLDATETIME,
		@dato_24		SMALLDATETIME,
		@dato_25		SMALLDATETIME,
		
		@gan_brut		DECIMAL(17,6),
		@retrib_no_had	DECIMAL(17,6),
		@seg_soc		DECIMAL(17,6),
		@obra_soc		DECIMAL(17,6),
		@sind			DECIMAL(17,6),
		@ret_gan		DECIMAL(17,6),
		@ajuste			DECIMAL(17,6)

	DECLARE	@anio		SMALLINT,
		@mes		TINYINT,
		@fecha_ini	CHAR(8),
		@fecha_fin	CHAR(8)

	SET @error = 0

	SET @w_apo = ''''
	SET @trabajador_persona = NULL
	SET @persona_relacionada = NULL

	SELECT	@trabajador = trabajador,
		@mes = MONTH(fecha_presentacion),
		@anio = periodo
	FROM	siradig_enc
	WHERE	id_siradig_enc = @id_siradig_enc

	SELECT	@compania = compania
	FROM	trabajadores_grales
	WHERE	sit_trabajador = 1
	AND	trabajador = @trabajador

	IF ISNULL(LTRIM(RTRIM(@compania)), '') = ''
	BEGIN
		SET @error = 1
		RETURN
	END
 
  	SELECT @val_inserta = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 1, GETDATE()), '0')
	SET @val_inserta = ISNULL(@val_inserta, 0)

	IF @val_inserta = 0
	BEGIN
		SET @error = 1
		RETURN
	END

	SET @fecha_ini = CONVERT(CHAR(4), @anio) + RIGHT('0' + RTRIM(@mes), 2) + '01'
	SET @fecha_fin = CONVERT(CHAR(4), @anio) + '12' + '31'

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

	SELECT	@indice_01, @indice_02, @indice_03, @indice_04, @indice_05, @indice_06, @indice_07,
		@indice_08, @indice_09, @indice_10, @indice_11, @indice_12, @indice_13, @indice_14,
		@indice_15, @indice_16, @indice_17, @indice_18, @indice_19, @indice_20

	IF ISNULL(@indice_01, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE cr_indice_01 CURSOR FOR
		SELECT	see.denominacion, 'NO', cuit, gan_brut
		FROM	siradig_empleador_ent see, siradig_ing_aportes sia
		WHERE	see.id_siradig_empleador_ent = sia.id_siradig_empleador_ent
		AND	see.id_siradig_enc = sia.id_siradig_enc
		AND	see.id_siradig_enc = @id_siradig_enc
		AND	sia.gan_brut <> 0

		OPEN	cr_indice_01
		FETCH	cr_indice_01
		INTO	@dato_01, @dato_03, @dato_05, @dato_14

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_01, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_01
			INTO	@dato_01, @dato_03, @dato_05, @dato_14
		END

		CLOSE cr_indice_01
		DEALLOCATE cr_indice_01
	END

	IF ISNULL(@indice_02, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_02 CURSOR FOR
		SELECT	see.denominacion, 'NO', see.cuit, sia.obra_soc
		FROM	siradig_empleador_ent see, siradig_ing_aportes sia
		WHERE	see.id_siradig_empleador_ent = sia.id_siradig_empleador_ent
		AND	see.id_siradig_enc = sia.id_siradig_enc
		AND	see.id_siradig_enc = @id_siradig_enc
		AND	sia.obra_soc <> 0

		OPEN	cr_indice_02
		FETCH	cr_indice_02
		INTO	@dato_01, @dato_03, @dato_05, @dato_14

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_02, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_02
			INTO	@dato_01, @dato_03, @dato_05, @dato_14
		END

		CLOSE cr_indice_02
		DEALLOCATE cr_indice_02
	END

	IF ISNULL(@indice_03, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_03 CURSOR FOR
		SELECT	sd.denominacion, 'NO', SUBSTRING(sd.nro_doc, 1, 9), sd.monto_total, se.nro_presentacion, se.fecha_presentacion
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.tipo = 2
		AND	sd.tipo_doc = 80
		AND	sd.id_siradig_enc = @id_siradig_enc

		OPEN	cr_indice_03
		FETCH	cr_indice_03
		INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_16, @dato_24

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_03, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_03
			INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_16, @dato_24
		END

		CLOSE cr_indice_03
		DEALLOCATE cr_indice_03
	END

	IF ISNULL(@indice_04, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_04 CURSOR FOR
		SELECT	sd.denominacion, 'NO', SUBSTRING(sd.nro_doc, 1, 9), sd.monto_total, sdp.monto_mensual, se.nro_presentacion, se.fecha_presentacion
		FROM	siradig_deducciones sd, siradig_deduc_per sdp, siradig_enc se
		WHERE	sd.id_siradig_deducciones = sdp.id_siradig_deducciones
		AND	sd.id_siradig_enc = sdp.id_siradig_enc
		AND	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.tipo = 5
		AND	sd.tipo_doc = 80
		AND	sd.id_siradig_enc = @id_siradig_enc

		OPEN	cr_indice_04
		FETCH	cr_indice_04
		INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_04, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_04
			INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24
		END

		CLOSE cr_indice_04
		DEALLOCATE cr_indice_04
	END

	IF ISNULL(@indice_05, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_05 CURSOR FOR
		SELECT	sd.denominacion, 'NO', SUBSTRING(sd.nro_doc, 1, 9), sd.monto_total, sdp.monto_mensual, se.nro_presentacion, se.fecha_presentacion
		FROM	siradig_deducciones sd, siradig_deduc_per sdp, siradig_enc se
		WHERE	sd.id_siradig_deducciones = sdp.id_siradig_deducciones
		AND	sd.id_siradig_enc = sdp.id_siradig_enc
		AND	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.tipo = 3
		AND	sd.tipo_doc = 80
		AND	sd.id_siradig_enc = @id_siradig_enc

		OPEN	cr_indice_05
		FETCH	cr_indice_05
		INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_05, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_05
			INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24
		END

		CLOSE cr_indice_05
		DEALLOCATE cr_indice_05
	END

	IF ISNULL(@indice_07, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_07 CURSOR FOR
		SELECT	'NO', sd.monto_total, se.nro_presentacion, se.fecha_presentacion
		FROM	siradig_deducciones sd, siradig_deduc_per sdp, siradig_enc se
		WHERE	sd.id_siradig_deducciones = sdp.id_siradig_deducciones
		AND	sd.id_siradig_enc = sdp.id_siradig_enc
		AND	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.tipo = 99
		AND	sd.id_siradig_enc = @id_siradig_enc

		OPEN	cr_indice_07
		FETCH	cr_indice_07
		INTO	@dato_03, @dato_14, @dato_16, @dato_24

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_07, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_07
			INTO	@dato_03, @dato_14, @dato_16, @dato_24
		END

		CLOSE cr_indice_07
		DEALLOCATE cr_indice_07
	END

	IF ISNULL(@indice_08, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL
    
		DECLARE	cr_indice_08 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 1
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_08
		FETCH	cr_indice_08
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_08, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_08
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_08
		DEALLOCATE cr_indice_08
	END

	IF ISNULL(@indice_09, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_09 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 2
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_09
		FETCH	cr_indice_09
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_09, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_09
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_09
		DEALLOCATE cr_indice_09
	END

	IF ISNULL(@indice_10, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_10 CURSOR FOR
		SELECT	'NO', sd.denominacion,
			(SELECT MIN(sp.mes_desde) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc),
			(SELECT MAX(sp.mes_hasta) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc),
			@anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 5
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_10
		FETCH	cr_indice_10
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_10, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_10
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_10
		DEALLOCATE cr_indice_10
	END

	IF ISNULL(@indice_11, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_11 CURSOR FOR
		SELECT	'NO', sd.denominacion,
			(SELECT MIN(sp.mes_desde) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc) AS mes_desde,
			(SELECT MAX(sp.mes_hasta) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc) AS mes_desde,
			@anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 3
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_11
		FETCH	cr_indice_11
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_11, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_11
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_11
		DEALLOCATE cr_indice_11
	END

	IF ISNULL(@indice_12, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_12 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 4
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_12
		FETCH	cr_indice_12
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_12, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_12
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_12
		DEALLOCATE cr_indice_12
	END

	IF ISNULL(@indice_13, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_13 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 8
		AND	sd.tipo_doc IN (80, 86, 92)

		OPEN	cr_indice_13
		FETCH	cr_indice_13
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_13, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_13
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_13
		DEALLOCATE cr_indice_13
	END

	IF ISNULL(@indice_14, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_14 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_ret_per_pago sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 6
		AND	((sd.tipo_doc = 80)
		OR	(ISNULL(sd.tipo_doc, '') = ''))

		OPEN	cr_indice_14
		FETCH	cr_indice_14
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_14, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_14
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_14
		DEALLOCATE cr_indice_14
	END

	IF ISNULL(@indice_15, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_15 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_ret_per_pago sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo IN (12, 13, 14, 15, 16, 17, 18, 19,20)
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_15
		FETCH	cr_indice_15
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_15, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_15
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_15
		DEALLOCATE cr_indice_15
	END

	IF ISNULL(@indice_16, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_16 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 7
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_16
		FETCH	cr_indice_16
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_16, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_16
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_16
		DEALLOCATE cr_indice_16
	END

	IF ISNULL(@indice_17, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_17 CURSOR FOR
		SELECT	scf.parentesco, scf.nro_doc, scf.tipo_doc, '1',
			CASE WHEN scf.parentesco IN (31, 32, 36, 36, 38, 43, 46) THEN 'SI' ELSE 'NO' END,
			ISNULL(LTRIM(RTRIM(scf.nombre)) + ' ', '') + ISNULL(LTRIM(RTRIM(scf.apellido)), ''),
			scf.mes_desde, scf.mes_hasta, @anio, 0,
			scf.fecha_nacimiento, se.nro_presentacion, se.fecha_presentacion, se.provincia,
			se.cp, se.localidad, se.calle,
			CASE scf.vig_prox_periodo WHEN 'S' THEN 1 WHEN 'N' THEN 2 ELSE NULL END,
			scf.fecha_estado_civil, scf.fecha_fallecimiento
		FROM	siradig_cargas_fam scf, siradig_enc se
		WHERE	se.id_siradig_enc = scf.id_siradig_enc
		AND	scf.id_siradig_enc = @id_siradig_enc
		
		OPEN	cr_indice_17
		FETCH	cr_indice_17
		INTO	@dato_01, @dato_02, @dato_03, @dato_04, @dato_05, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14,
			@dato_23, @dato_16, @dato_24, @dato_17, @dato_06, @dato_07, @dato_08, @dato_15, @dato_21, @dato_22

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT	@dato_01 = clave
			FROM	siradig_fam_parentesco
			WHERE	LTRIM(RTRIM(siradig_parentesco)) = LTRIM(RTRIM(@dato_01))

			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_17, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_17
			INTO	@dato_01, @dato_02, @dato_03, @dato_04, @dato_05, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14,
				@dato_23, @dato_16, @dato_24, @dato_17, @dato_06, @dato_07, @dato_08, @dato_15, @dato_21, @dato_22
		END

		CLOSE cr_indice_17
		DEALLOCATE cr_indice_17
	END

	SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
		@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
		@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
		@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
		@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

	DECLARE	cr_indice_18 CURSOR FOR
	SELECT	see.denominacion,
		SUM(sia.gan_brut), SUM(sia.retrib_no_had), SUM(sia.seg_soc),
		SUM(sia.obra_soc), SUM(sia.sind), SUM(sia.ret_gan),
		SUM(sia.ajuste), 'NO', MIN(sia.mes), MAX(sia.mes), @anio,
		se.nro_presentacion, se.fecha_presentacion, se.provincia, see.cuit
	FROM	siradig_empleador_ent see, siradig_ing_aportes sia, siradig_enc se
	WHERE	see.id_siradig_empleador_ent = sia.id_siradig_empleador_ent
	AND	see.id_siradig_enc = sia.id_siradig_enc
	AND	see.id_siradig_enc = se.id_siradig_enc
	AND	see.id_siradig_enc = @id_siradig_enc
	GROUP BY see.denominacion, se.nro_presentacion, se.fecha_presentacion, se.provincia, see.cuit

	OPEN	cr_indice_18
	FETCH	cr_indice_18
	INTO	@dato_10, @gan_brut, @retrib_no_had, @seg_soc, @obra_soc, @sind, @ret_gan,
		@ajuste, @dato_03, @dato_11, @dato_12, @dato_13,
		@dato_16, @dato_24, @dato_17, @dato_02

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @dato_10 = REPLACE(@dato_10, '"', '')

		IF ISNULL(@indice_18, '') <> '' AND ISNUMERIC(@gan_brut) = 1
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_18, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @gan_brut, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END
		
		IF ISNULL(@indice_21, '') <> '' AND ISNUMERIC(@retrib_no_had) = 1
		BEGIN
			--EXEC sp_alta_inf_soc_trabajador
			--	@trabajador, @indice_21, NULL,
			--	@dato_01, @trabajador_persona, @persona_relacionada,
			--	@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
			--	@dato_11, @dato_12, @dato_13, @retrib_no_had, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
			--	@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_21, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @retrib_no_had, @ajuste, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END
		
		IF ISNULL(@indice_22, '') <> '' AND ISNUMERIC(@seg_soc) = 1
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_22, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @seg_soc, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END
		
		IF ISNULL(@indice_23, '') <> '' AND ISNUMERIC(@obra_soc) = 1
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_23, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @obra_soc, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END
		
		IF ISNULL(@indice_24, '') <> '' AND ISNUMERIC(@sind) = 1
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_24, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @sind, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END
		
		IF ISNULL(@indice_25, '') <> '' AND ISNUMERIC(@ret_gan) = 1
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_25, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @ret_gan, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END
		
		IF ISNULL(@indice_26, '') <> '' AND ISNUMERIC(@ajuste) = 1
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_26, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @ajuste, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
		END

		FETCH	cr_indice_18
		INTO	@dato_10, @gan_brut, @retrib_no_had, @seg_soc, @obra_soc, @sind, @ret_gan,
			@ajuste, @dato_03, @dato_11, @dato_12, @dato_13,
			@dato_16, @dato_24, @dato_17, @dato_02
	END

	CLOSE cr_indice_18
	DEALLOCATE cr_indice_18

	IF ISNULL(@indice_19, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_19 CURSOR FOR
		SELECT	'NO', sd.denominacion, sd.nro_doc, sd.monto_total, se.nro_presentacion, @fecha_ini, @fecha_fin, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 11
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_19
		FETCH	cr_indice_19
		INTO	@dato_03, @dato_01, @dato_05, @dato_14, @dato_16, @dato_21, @dato_22, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_19, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_19
			INTO	@dato_03, @dato_01, @dato_05, @dato_14, @dato_16, @dato_21, @dato_22, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_19
		DEALLOCATE cr_indice_19
	END

	IF ISNULL(@indice_20, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_20 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se, siradig_deduc_det sdd
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND sdd.id_siradig_enc = sd.id_siradig_enc 
		AND sd.id_siradig_deducciones = sdd.id_siradig_deducciones 
		AND	sd.tipo = 99
		AND	sd.tipo_doc = 80
		AND sdd.nombre = 'motivo'
		AND sdd.valor in (1,2)
		AND	sd.id_siradig_enc  = @id_siradig_enc

		OPEN	cr_indice_20
		FETCH	cr_indice_20
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_20, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_20
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_20
		DEALLOCATE cr_indice_20
	END

	IF ISNULL(@indice_28, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_28 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 22
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_28
		FETCH	cr_indice_28
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_28, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_28
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_28
		DEALLOCATE cr_indice_28
	END

	IF ISNULL(@indice_29, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_29 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND	sd.id_siradig_enc = @id_siradig_enc
		AND	sd.tipo = 9
		AND	sd.tipo_doc = 80

		OPEN	cr_indice_29
		FETCH	cr_indice_29
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_29, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_29
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_29
		DEALLOCATE cr_indice_29
	END

	--IF ISNULL(@indice_30, '') <> ''
	--BEGIN
	--	SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
	--		@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
	--		@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
	--		@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
	--		@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

	--	DECLARE	cr_indice_30 CURSOR FOR
	--	SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
	--	FROM	siradig_deducciones sd, siradig_enc se
	--	WHERE	sd.id_siradig_enc = se.id_siradig_enc
	--	AND	sd.id_siradig_enc = @id_siradig_enc
	--	AND	sd.tipo = 1000
	--	AND	sd.tipo_doc = 80

	--	OPEN	cr_indice_30
	--	FETCH	cr_indice_30
	--	INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

	--	WHILE @@FETCH_STATUS = 0
	--	BEGIN
	--		SELECT @dato_10 = REPLACE(@dato_10, '"', '')

	--		EXEC sp_alta_inf_soc_trabajador
	--			@trabajador, @indice_30, NULL,
	--			@dato_01, @trabajador_persona, @persona_relacionada,
	--			@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
	--			@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
	--			@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

	--		FETCH	cr_indice_30
	--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
	--	END

	--	CLOSE cr_indice_30
	--	DEALLOCATE cr_indice_30
	--END

	IF ISNULL(@indice_31, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_31 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se, siradig_deduc_det sdd
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND sdd.id_siradig_enc = sd.id_siradig_enc 
		AND sd.id_siradig_deducciones = sdd.id_siradig_deducciones 
		AND	sd.tipo = 99
		AND	sd.tipo_doc = 80
		AND sdd.nombre = 'motivo'
		AND sdd.valor = 9
		AND	sd.id_siradig_enc  = @id_siradig_enc

		OPEN	cr_indice_31
		FETCH	cr_indice_31
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_31, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_31
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_31
		DEALLOCATE cr_indice_31
	END

	IF ISNULL(@indice_32, '') <> ''
	BEGIN
		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

		DECLARE	cr_indice_32 CURSOR FOR
		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
		FROM	siradig_deducciones sd, siradig_enc se, siradig_deduc_det sdd
		WHERE	sd.id_siradig_enc = se.id_siradig_enc
		AND sdd.id_siradig_enc = sd.id_siradig_enc 
		AND sd.id_siradig_deducciones = sdd.id_siradig_deducciones 

		--AND	sd.tipo = 99
		--AND	sd.tipo_doc = 80
		--AND sdd.nombre = 'motivo'
		--AND sdd.valor = 9

		AND	sd.tipo = 7
		AND	sd.tipo_doc = 80
		AND	sd.id_siradig_enc  = @id_siradig_enc

		OPEN	cr_indice_32
		FETCH	cr_indice_32
		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

			EXEC sp_alta_inf_soc_trabajador
				@trabajador, @indice_32, NULL,
				@dato_01, @trabajador_persona, @persona_relacionada,
				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

			FETCH	cr_indice_32
			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
		END

		CLOSE cr_indice_32
		DEALLOCATE cr_indice_32
	END

END


--USE [ArcorAR]
--GO
--/****** Object:  StoredProcedure [dbo].[sp_transf_siradig_indinf]    Script Date: 12/14/2017 8:46:52 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER PROCEDURE [dbo].[sp_transf_siradig_indinf](
--	@id_siradig_enc	BIGINT,
--	@error			TINYINT OUTPUT)
--AS
--BEGIN
--	SET DATEFORMAT dmy;

--	DECLARE	@w_apo		CHAR(1),
--		@compania		CHAR(4),
--		@trabajador		CHAR(10),
--		@val_inserta	TINYINT,

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
--		@indice_26		CHAR(10),
--		@indice_28		CHAR(10),
--		@indice_29		CHAR(10),
--		@indice_30		CHAR(10),
--		@indice_31		CHAR(10),

--		@dato_01		VARCHAR(40),
--		@trabajador_persona	TINYINT,
--		@persona_relacionada	CHAR(10),
--		@dato_02		CHAR(15),
--		@dato_03		CHAR(10),
--		@dato_04		CHAR(10),
--		@dato_05		CHAR(20),
--		@dato_06		CHAR(20),
--		@dato_07		VARCHAR(30),
--		@dato_08		VARCHAR(30),
--		@dato_09		VARCHAR(40),
--		@dato_10		VARCHAR(50),
--		@dato_11		INT,
--		@dato_12		INT,
--		@dato_13		INT,
--		@dato_14		DECIMAL(15,6),
--		@dato_15		DECIMAL(15,6),
--		@dato_16		DECIMAL(15,6),
--		@dato_17		DECIMAL(15,6),
--		@dato_18		DECIMAL(15,6),
--		@dato_19		DECIMAL(15,6),
--		@dato_20		DECIMAL(15,6),
--		@dato_21		SMALLDATETIME,
--		@dato_22		SMALLDATETIME,
--		@dato_23		SMALLDATETIME,
--		@dato_24		SMALLDATETIME,
--		@dato_25		SMALLDATETIME,
		
--		@gan_brut		DECIMAL(17,6),
--		@retrib_no_had	DECIMAL(17,6),
--		@seg_soc		DECIMAL(17,6),
--		@obra_soc		DECIMAL(17,6),
--		@sind			DECIMAL(17,6),
--		@ret_gan		DECIMAL(17,6),
--		@ajuste			DECIMAL(17,6)

--	DECLARE	@anio		SMALLINT,
--		@mes		TINYINT,
--		@fecha_ini	CHAR(8),
--		@fecha_fin	CHAR(8)

--	SET @error = 0

--	SET @w_apo = ''''
--	SET @trabajador_persona = NULL
--	SET @persona_relacionada = NULL

--	SELECT	@trabajador = trabajador,
--		@mes = MONTH(fecha_presentacion),
--		@anio = periodo
--	FROM	siradig_enc
--	WHERE	id_siradig_enc = @id_siradig_enc

--	SELECT	@compania = compania
--	FROM	trabajadores_grales
--	WHERE	sit_trabajador = 1
--	AND	trabajador = @trabajador

--	IF ISNULL(LTRIM(RTRIM(@compania)), '') = ''
--	BEGIN
--		SET @error = 1
--		RETURN
--	END
 
--  	SELECT @val_inserta = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 1, GETDATE()), '0')
--	SET @val_inserta = ISNULL(@val_inserta, 0)

--	IF @val_inserta = 0
--	BEGIN
--		SET @error = 1
--		RETURN
--	END

--	SET @fecha_ini = CONVERT(CHAR(4), @anio) + RIGHT('0' + RTRIM(@mes), 2) + '01'
--	SET @fecha_fin = CONVERT(CHAR(4), @anio) + '12' + '31'

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
--	SELECT @indice_28 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 22, GETDATE()), '')
--	SELECT @indice_29 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 23, GETDATE()), '')
--	SELECT @indice_30 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 24, GETDATE()), '')
--	SELECT @indice_31 = ISNULL(dbo.fn_valor_parametros_compania('es-AR', @compania, 'SIRADIG_IND_INF', 25, GETDATE()), '')

--	SELECT	@indice_01, @indice_02, @indice_03, @indice_04, @indice_05, @indice_06, @indice_07,
--		@indice_08, @indice_09, @indice_10, @indice_11, @indice_12, @indice_13, @indice_14,
--		@indice_15, @indice_16, @indice_17, @indice_18, @indice_19, @indice_20

--	IF ISNULL(@indice_01, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE cr_indice_01 CURSOR FOR
--		SELECT	see.denominacion, 'NO', cuit, gan_brut
--		FROM	siradig_empleador_ent see, siradig_ing_aportes sia
--		WHERE	see.id_siradig_empleador_ent = sia.id_siradig_empleador_ent
--		AND	see.id_siradig_enc = sia.id_siradig_enc
--		AND	see.id_siradig_enc = @id_siradig_enc
--		AND	sia.gan_brut <> 0

--		OPEN	cr_indice_01
--		FETCH	cr_indice_01
--		INTO	@dato_01, @dato_03, @dato_05, @dato_14

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_01, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_01
--			INTO	@dato_01, @dato_03, @dato_05, @dato_14
--		END

--		CLOSE cr_indice_01
--		DEALLOCATE cr_indice_01
--	END

--	IF ISNULL(@indice_02, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_02 CURSOR FOR
--		SELECT	see.denominacion, 'NO', see.cuit, sia.obra_soc
--		FROM	siradig_empleador_ent see, siradig_ing_aportes sia
--		WHERE	see.id_siradig_empleador_ent = sia.id_siradig_empleador_ent
--		AND	see.id_siradig_enc = sia.id_siradig_enc
--		AND	see.id_siradig_enc = @id_siradig_enc
--		AND	sia.obra_soc <> 0

--		OPEN	cr_indice_02
--		FETCH	cr_indice_02
--		INTO	@dato_01, @dato_03, @dato_05, @dato_14

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_02, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_02
--			INTO	@dato_01, @dato_03, @dato_05, @dato_14
--		END

--		CLOSE cr_indice_02
--		DEALLOCATE cr_indice_02
--	END

--	IF ISNULL(@indice_03, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_03 CURSOR FOR
--		SELECT	sd.denominacion, 'NO', SUBSTRING(sd.nro_doc, 1, 9), sd.monto_total, se.nro_presentacion, se.fecha_presentacion
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.tipo = 2
--		AND	sd.tipo_doc = 80
--		AND	sd.id_siradig_enc = @id_siradig_enc

--		OPEN	cr_indice_03
--		FETCH	cr_indice_03
--		INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_16, @dato_24

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_03, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_03
--			INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_16, @dato_24
--		END

--		CLOSE cr_indice_03
--		DEALLOCATE cr_indice_03
--	END

--	IF ISNULL(@indice_04, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_04 CURSOR FOR
--		SELECT	sd.denominacion, 'NO', SUBSTRING(sd.nro_doc, 1, 9), sd.monto_total, sdp.monto_mensual, se.nro_presentacion, se.fecha_presentacion
--		FROM	siradig_deducciones sd, siradig_deduc_per sdp, siradig_enc se
--		WHERE	sd.id_siradig_deducciones = sdp.id_siradig_deducciones
--		AND	sd.id_siradig_enc = sdp.id_siradig_enc
--		AND	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.tipo = 5
--		AND	sd.tipo_doc = 80
--		AND	sd.id_siradig_enc = @id_siradig_enc

--		OPEN	cr_indice_04
--		FETCH	cr_indice_04
--		INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_04, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_04
--			INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24
--		END

--		CLOSE cr_indice_04
--		DEALLOCATE cr_indice_04
--	END

--	IF ISNULL(@indice_05, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_05 CURSOR FOR
--		SELECT	sd.denominacion, 'NO', SUBSTRING(sd.nro_doc, 1, 9), sd.monto_total, sdp.monto_mensual, se.nro_presentacion, se.fecha_presentacion
--		FROM	siradig_deducciones sd, siradig_deduc_per sdp, siradig_enc se
--		WHERE	sd.id_siradig_deducciones = sdp.id_siradig_deducciones
--		AND	sd.id_siradig_enc = sdp.id_siradig_enc
--		AND	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.tipo = 3
--		AND	sd.tipo_doc = 80
--		AND	sd.id_siradig_enc = @id_siradig_enc

--		OPEN	cr_indice_05
--		FETCH	cr_indice_05
--		INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_05, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_05
--			INTO	@dato_01, @dato_03, @dato_05, @dato_14, @dato_15, @dato_16, @dato_24
--		END

--		CLOSE cr_indice_05
--		DEALLOCATE cr_indice_05
--	END

--	IF ISNULL(@indice_07, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_07 CURSOR FOR
--		SELECT	'NO', sd.monto_total, se.nro_presentacion, se.fecha_presentacion
--		FROM	siradig_deducciones sd, siradig_deduc_per sdp, siradig_enc se
--		WHERE	sd.id_siradig_deducciones = sdp.id_siradig_deducciones
--		AND	sd.id_siradig_enc = sdp.id_siradig_enc
--		AND	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.tipo = 99
--		AND	sd.id_siradig_enc = @id_siradig_enc

--		OPEN	cr_indice_07
--		FETCH	cr_indice_07
--		INTO	@dato_03, @dato_14, @dato_16, @dato_24

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_07, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_07
--			INTO	@dato_03, @dato_14, @dato_16, @dato_24
--		END

--		CLOSE cr_indice_07
--		DEALLOCATE cr_indice_07
--	END

--	IF ISNULL(@indice_08, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL
    
--		DECLARE	cr_indice_08 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 1
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_08
--		FETCH	cr_indice_08
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_08, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_08
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_08
--		DEALLOCATE cr_indice_08
--	END

--	IF ISNULL(@indice_09, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_09 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 2
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_09
--		FETCH	cr_indice_09
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_09, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_09
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_09
--		DEALLOCATE cr_indice_09
--	END

--	IF ISNULL(@indice_10, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_10 CURSOR FOR
--		SELECT	'NO', sd.denominacion,
--			(SELECT MIN(sp.mes_desde) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc),
--			(SELECT MAX(sp.mes_hasta) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc),
--			@anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 5
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_10
--		FETCH	cr_indice_10
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_10, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_10
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_10
--		DEALLOCATE cr_indice_10
--	END

--	IF ISNULL(@indice_11, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_11 CURSOR FOR
--		SELECT	'NO', sd.denominacion,
--			(SELECT MIN(sp.mes_desde) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc) AS mes_desde,
--			(SELECT MAX(sp.mes_hasta) FROM siradig_deduc_per sp WHERE sp.id_siradig_deducciones = sd.id_siradig_deducciones AND sp.id_siradig_enc = sd.id_siradig_enc) AS mes_desde,
--			@anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 3
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_11
--		FETCH	cr_indice_11
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_11, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_11
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_11
--		DEALLOCATE cr_indice_11
--	END

--	IF ISNULL(@indice_12, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_12 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 4
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_12
--		FETCH	cr_indice_12
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_12, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_12
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_12
--		DEALLOCATE cr_indice_12
--	END

--	IF ISNULL(@indice_13, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_13 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 8
--		AND	sd.tipo_doc IN (80, 86, 92)

--		OPEN	cr_indice_13
--		FETCH	cr_indice_13
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_13, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_13
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_13
--		DEALLOCATE cr_indice_13
--	END

--	IF ISNULL(@indice_14, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_14 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_ret_per_pago sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 6
--		AND	((sd.tipo_doc = 80)
--		OR	(ISNULL(sd.tipo_doc, '') = ''))

--		OPEN	cr_indice_14
--		FETCH	cr_indice_14
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_14, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_14
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_14
--		DEALLOCATE cr_indice_14
--	END

--	IF ISNULL(@indice_15, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_15 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_ret_per_pago sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo IN (12, 13, 14, 15, 16, 17, 18, 19,20)
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_15
--		FETCH	cr_indice_15
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_15, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_15
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_15
--		DEALLOCATE cr_indice_15
--	END

--	IF ISNULL(@indice_16, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_16 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 7
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_16
--		FETCH	cr_indice_16
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_16, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_16
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_16
--		DEALLOCATE cr_indice_16
--	END

--	IF ISNULL(@indice_17, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_17 CURSOR FOR
--		SELECT	scf.parentesco, scf.nro_doc, scf.tipo_doc, '1',
--			CASE WHEN scf.parentesco IN (31, 32, 36, 36, 38, 43, 46) THEN 'SI' ELSE 'NO' END,
--			ISNULL(LTRIM(RTRIM(scf.nombre)) + ' ', '') + ISNULL(LTRIM(RTRIM(scf.apellido)), ''),
--			scf.mes_desde, scf.mes_hasta, @anio, 0,
--			scf.fecha_nacimiento, se.nro_presentacion, se.fecha_presentacion, se.provincia,
--			se.cp, se.localidad, se.calle,
--			CASE scf.vig_prox_periodo WHEN 'S' THEN 1 WHEN 'N' THEN 2 ELSE NULL END,
--			scf.fecha_estado_civil, scf.fecha_fallecimiento
--		FROM	siradig_cargas_fam scf, siradig_enc se
--		WHERE	se.id_siradig_enc = scf.id_siradig_enc
--		AND	scf.id_siradig_enc = @id_siradig_enc
		
--		OPEN	cr_indice_17
--		FETCH	cr_indice_17
--		INTO	@dato_01, @dato_02, @dato_03, @dato_04, @dato_05, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14,
--			@dato_23, @dato_16, @dato_24, @dato_17, @dato_06, @dato_07, @dato_08, @dato_15, @dato_21, @dato_22

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT	@dato_01 = clave
--			FROM	siradig_fam_parentesco
--			WHERE	LTRIM(RTRIM(siradig_parentesco)) = LTRIM(RTRIM(@dato_01))

--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_17, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_17
--			INTO	@dato_01, @dato_02, @dato_03, @dato_04, @dato_05, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14,
--				@dato_23, @dato_16, @dato_24, @dato_17, @dato_06, @dato_07, @dato_08, @dato_15, @dato_21, @dato_22
--		END

--		CLOSE cr_indice_17
--		DEALLOCATE cr_indice_17
--	END

--	SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--		@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--		@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--		@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--		@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--	DECLARE	cr_indice_18 CURSOR FOR
--	SELECT	see.denominacion,
--		SUM(sia.gan_brut), SUM(sia.retrib_no_had), SUM(sia.seg_soc),
--		SUM(sia.obra_soc), SUM(sia.sind), SUM(sia.ret_gan),
--		SUM(sia.ajuste), 'NO', MIN(sia.mes), MAX(sia.mes), @anio,
--		se.nro_presentacion, se.fecha_presentacion, se.provincia, see.cuit
--	FROM	siradig_empleador_ent see, siradig_ing_aportes sia, siradig_enc se
--	WHERE	see.id_siradig_empleador_ent = sia.id_siradig_empleador_ent
--	AND	see.id_siradig_enc = sia.id_siradig_enc
--	AND	see.id_siradig_enc = se.id_siradig_enc
--	AND	see.id_siradig_enc = @id_siradig_enc
--	GROUP BY see.denominacion, se.nro_presentacion, se.fecha_presentacion, se.provincia, see.cuit

--	OPEN	cr_indice_18
--	FETCH	cr_indice_18
--	INTO	@dato_10, @gan_brut, @retrib_no_had, @seg_soc, @obra_soc, @sind, @ret_gan,
--		@ajuste, @dato_03, @dato_11, @dato_12, @dato_13,
--		@dato_16, @dato_24, @dato_17, @dato_02

--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--		IF ISNULL(@indice_18, '') <> '' AND ISNUMERIC(@gan_brut) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_18, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @gan_brut, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END
		
--		IF ISNULL(@indice_21, '') <> '' AND ISNUMERIC(@retrib_no_had) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_21, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @retrib_no_had, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END
		
--		IF ISNULL(@indice_22, '') <> '' AND ISNUMERIC(@seg_soc) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_22, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @seg_soc, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END
		
--		IF ISNULL(@indice_23, '') <> '' AND ISNUMERIC(@obra_soc) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_23, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @obra_soc, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END
		
--		IF ISNULL(@indice_24, '') <> '' AND ISNUMERIC(@sind) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_24, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @sind, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END
		
--		IF ISNULL(@indice_25, '') <> '' AND ISNUMERIC(@ret_gan) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_25, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @ret_gan, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END
		
--		IF ISNULL(@indice_26, '') <> '' AND ISNUMERIC(@ajuste) = 1
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_26, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @ajuste, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25
--		END

--		FETCH	cr_indice_18
--		INTO	@dato_10, @gan_brut, @retrib_no_had, @seg_soc, @obra_soc, @sind, @ret_gan,
--			@ajuste, @dato_03, @dato_11, @dato_12, @dato_13,
--			@dato_16, @dato_24, @dato_17, @dato_02
--	END

--	CLOSE cr_indice_18
--	DEALLOCATE cr_indice_18

--	IF ISNULL(@indice_19, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_19 CURSOR FOR
--		SELECT	'NO', sd.denominacion, sd.nro_doc, sd.monto_total, se.nro_presentacion, @fecha_ini, @fecha_fin, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 11
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_19
--		FETCH	cr_indice_19
--		INTO	@dato_03, @dato_01, @dato_05, @dato_14, @dato_16, @dato_21, @dato_22, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_19, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_19
--			INTO	@dato_03, @dato_01, @dato_05, @dato_14, @dato_16, @dato_21, @dato_22, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_19
--		DEALLOCATE cr_indice_19
--	END

--	IF ISNULL(@indice_20, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_20 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se, siradig_deduc_det sdd
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND sdd.id_siradig_enc = sd.id_siradig_enc 
--		AND sd.id_siradig_deducciones = sdd.id_siradig_deducciones 
--		AND	sd.tipo = 99
--		AND	sd.tipo_doc = 80
--		AND sdd.nombre = 'motivo'
--		AND sdd.valor in (1,2)
--		AND	sd.id_siradig_enc  = @id_siradig_enc

--		OPEN	cr_indice_20
--		FETCH	cr_indice_20
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_20, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_20
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_20
--		DEALLOCATE cr_indice_20
--	END

--	IF ISNULL(@indice_28, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_28 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 22
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_28
--		FETCH	cr_indice_28
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_28, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_28
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_28
--		DEALLOCATE cr_indice_28
--	END

--	IF ISNULL(@indice_29, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_29 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND	sd.id_siradig_enc = @id_siradig_enc
--		AND	sd.tipo = 9
--		AND	sd.tipo_doc = 80

--		OPEN	cr_indice_29
--		FETCH	cr_indice_29
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_29, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_29
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_29
--		DEALLOCATE cr_indice_29
--	END

--	--IF ISNULL(@indice_30, '') <> ''
--	--BEGIN
--	--	SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--	--		@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--	--		@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--	--		@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--	--		@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--	--	DECLARE	cr_indice_30 CURSOR FOR
--	--	SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--	--	FROM	siradig_deducciones sd, siradig_enc se
--	--	WHERE	sd.id_siradig_enc = se.id_siradig_enc
--	--	AND	sd.id_siradig_enc = @id_siradig_enc
--	--	AND	sd.tipo = 1000
--	--	AND	sd.tipo_doc = 80

--	--	OPEN	cr_indice_30
--	--	FETCH	cr_indice_30
--	--	INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--	--	WHILE @@FETCH_STATUS = 0
--	--	BEGIN
--	--		SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--	--		EXEC sp_alta_inf_soc_trabajador
--	--			@trabajador, @indice_30, NULL,
--	--			@dato_01, @trabajador_persona, @persona_relacionada,
--	--			@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--	--			@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--	--			@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--	--		FETCH	cr_indice_30
--	--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--	--	END

--	--	CLOSE cr_indice_30
--	--	DEALLOCATE cr_indice_30
--	--END

--	IF ISNULL(@indice_31, '') <> ''
--	BEGIN
--		SELECT	@dato_01 = NULL, @dato_02 = NULL, @dato_03 = NULL, @dato_04 = NULL, @dato_05 = NULL,
--			@dato_06 = NULL, @dato_07 = NULL, @dato_08 = NULL, @dato_09 = NULL, @dato_10 = NULL,
--			@dato_11 = NULL, @dato_12 = NULL, @dato_13 = NULL, @dato_14 = NULL, @dato_15 = NULL,
--			@dato_16 = NULL, @dato_17 = NULL, @dato_18 = NULL, @dato_19 = NULL, @dato_20 = NULL,
--			@dato_21 = NULL, @dato_22 = NULL, @dato_23 = NULL, @dato_24 = NULL, @dato_25 = NULL

--		DECLARE	cr_indice_31 CURSOR FOR
--		SELECT	'NO', sd.denominacion, @mes, @mes, @anio, sd.monto_total, se.nro_presentacion, se.fecha_presentacion, se.provincia, sd.nro_doc
--		FROM	siradig_deducciones sd, siradig_enc se, siradig_deduc_det sdd
--		WHERE	sd.id_siradig_enc = se.id_siradig_enc
--		AND sdd.id_siradig_enc = sd.id_siradig_enc 
--		AND sd.id_siradig_deducciones = sdd.id_siradig_deducciones 
--		AND	sd.tipo = 99
--		AND	sd.tipo_doc = 80
--		AND sdd.nombre = 'motivo'
--		AND sdd.valor = 9
--		AND	sd.id_siradig_enc  = @id_siradig_enc

--		OPEN	cr_indice_31
--		FETCH	cr_indice_31
--		INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02

--		WHILE @@FETCH_STATUS = 0
--		BEGIN
--			SELECT @dato_10 = REPLACE(@dato_10, '"', '')

--			EXEC sp_alta_inf_soc_trabajador
--				@trabajador, @indice_31, NULL,
--				@dato_01, @trabajador_persona, @persona_relacionada,
--				@dato_02, @dato_03, @dato_04, @dato_05, @dato_06, @dato_07, @dato_08, @dato_09, @dato_10,
--				@dato_11, @dato_12, @dato_13, @dato_14, @dato_15, @dato_16, @dato_17, @dato_18, @dato_19,
--				@dato_20, @dato_21, @dato_22, @dato_23, @dato_24, @dato_25

--			FETCH	cr_indice_31
--			INTO	@dato_03, @dato_10, @dato_11, @dato_12, @dato_13, @dato_14, @dato_16, @dato_24, @dato_17, @dato_02
--		END

--		CLOSE cr_indice_31
--		DEALLOCATE cr_indice_31
--	END

--END
