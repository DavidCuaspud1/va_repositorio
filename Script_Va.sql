create table va_maximos_pro as   
 	select substring(promax.periodo,0,5) anio, max(promax.punt_razonamiento_cuantitativo)max_punt_razonamiento_cuantitativo,
 	max(promax.punt_lectura_critica) max_punt_lectura_critica_pro, max(promax.punt_competencias_ciudadanas) max_punt_competencias_ciudadanas,
 	max(promax.punt_ingles) max_punt_ingles_pro
 	from proyecto.va_saber_pro promax 
		 where promax.departamento_programa = 'NARIÑO'::text 
  AND promax.nombre_institucion ~~* 'UNIVERSIDAD DE NARIÑO-PASTO'::text 
  group by  substring(promax.periodo,0,5)
  
 create table va_maximos_11 as   
 	select substring(s11.periodo,0,5) anio, max(s11.punt_matematicas)max_punt_matematicas,
 	max(s11.punt_lectura_critica) max_punt_lectura_critica_s11, max(s11.punt_sociales) max_punt_sociales,
 	max(s11.punt_ingles) max_punt_ingles_s11 
 	from proyecto.va_saber_11 s11 
 	join proyecto.va_cruces c ON s11.estu_consecutivo = c.estu_consecutivo_11
 	join proyecto.va_saber_pro promax on promax.estu_consecutivo = c.estu_consecutivo_pro
		 where promax.departamento_programa = 'NARIÑO'::text 
  AND promax.nombre_institucion ~~* 'UNIVERSIDAD DE NARIÑO-PASTO'::text 
  --and cast(substring(s11.periodo,0,5) as int)<cast(substring(promax.periodo,0,5) as int)
  group by  substring(s11.periodo,0,5)
  
  
  create table valor_agregado as
select 
    pro.estu_consecutivo,
    --pro.punt_razonamiento_cuantitativo,--,pro.punt_lectura_critica,pro.punt_competencias_ciudadanas,pro.punt_ingles,
	--s11.punt_matematicas,--,s11.punt_lectura_critica,s11.punt_sociales,s11.punt_ingles,pro.periodo p_ecaes,s11.periodo p_s11,
	substring(pro.periodo,0,5) anio_pro,substring(s11.periodo,0,5) anio_s11,--mpro.max_punt_razonamiento_cuantitativo,m11.max_punt_matematicas,
	 --pro.punt_razonamiento_cuantitativo/mpro.max_punt_razonamiento_cuantitativo rend_razonamiento_cuantitativo_pro,
	 --s11.punt_matematicas/m11.max_punt_matematicas rend_punt_matematicas_s11,
	 (pro.punt_razonamiento_cuantitativo/mpro.max_punt_razonamiento_cuantitativo)-(s11.punt_matematicas/m11.max_punt_matematicas) va_razonamiento_cuantitativo,
	 (pro.punt_lectura_critica/mpro.max_punt_lectura_critica_pro)-(s11.punt_lectura_critica/m11.max_punt_lectura_critica_s11) va_lectura_critica,
	 (pro.punt_competencias_ciudadanas/mpro.max_punt_competencias_ciudadanas)-(s11.punt_sociales/m11.max_punt_sociales) va_competencias_ciudadanas,
     (pro.punt_ingles/mpro.max_punt_ingles_pro)-(s11.punt_ingles/m11.max_punt_ingles_s11) va_ingles
 FROM proyecto.va_saber_pro pro
 JOIN proyecto.va_cruces c ON pro.estu_consecutivo = c.estu_consecutivo_pro 
 JOIN proyecto.va_saber_11 s11 ON s11.estu_consecutivo = c.estu_consecutivo_11
 join va_maximos_pro mpro on substring(pro.periodo,0,5)=mpro.anio
  join va_maximos_11 m11 on substring(s11.periodo,0,5)=m11.anio
  WHERE pro.departamento_programa = 'NARIÑO'::text 
  AND pro.nombre_institucion ~~* 'UNIVERSIDAD DE NARIÑO-PASTO'::text 
  
  
  
  --------------------------------------------
  select * from proyecto.va_repositorio_inicial;

  select count(*) from archivos.ftp_sbpro_gen_20121 where inst_nombre_institucion='UNIVERSIDAD DE NARIÑO-PASTO';
  select count(*) from archivos.ftp_sbpro_gen_20122 where inst_nombre_institucion='UNIVERSIDAD DE NARIÑO-PASTO';
  select count(*) from archivos.ftp_sbpro_gen_20131 where inst_nombre_institucion='UNIVERSIDAD DE NARIÑO-PASTO';
  select count(*) from archivos.ftp_sbpro_gen_2018 where inst_nombre_institucion='UNIVERSIDAD DE NARIÑO-PASTO';
  
 
 
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20121 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20122 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20131 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20132 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20141 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20142 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20151 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_20152 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_2016 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_2017 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
 select inst_nombre_institucion,count(*) from archivos.ftp_sbpro_gen_2018 where inst_nombre_institucion ilike'%NARIÑO%' group by inst_nombre_institucion;
  
  
  
  
  
  
  