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


------ CREANDO LA CLASE ----------------------

select r.*, case when va_razonamiento_cuantitativo > 0 then 1 else 0 end clase_va_razonamiento_cuantitativo,
case when va_lectura_critica > 0 then 1 else 0 end clase_va_lectura_critica,
case when va_competencias_ciudadanas > 0 then 1 else 0 end clase_va_competencias_ciudadanas,
case when va_ingles > 0 then 1 else 0 end clase_va_ingles
from  proyecto.va_repositorio_v2 r join public.valor_agregado va on upper(r.estu_consecutivo) = va.estu_consecutivo
  
--- CREANDO VISTA------
create or replace view proyecto.view_clase_va
as select r.*, case when va_razonamiento_cuantitativo > 0 then 1 else 0 end clase_va_razonamiento_cuantitativo,
case when va_lectura_critica > 0 then 1 else 0 end clase_va_lectura_critica,
case when va_competencias_ciudadanas > 0 then 1 else 0 end clase_va_competencias_ciudadanas,
case when va_ingles > 0 then 1 else 0 end clase_va_ingles,
cast(anio_pro as int)-cast(anio_s11 as int) anio_preparacion
from  proyecto.va_repositorio_v3 r join public.valor_agregado va on upper(r.estu_consecutivo) = va.estu_consecutivo
  

select * from proyecto.view_clase_va

---------------------------
create or replace view proyecto.vista_repositorio as
select 
r.*,v.va_competencias_ciudadanas,v.va_lectura_critica,v.va_razonamiento_cuantitativo,v.va_ingles,
cast(v.anio_pro as int)-cast(v.anio_s11 as int) anio_preparacion
from proyecto.va_repositorio_v2  r join   valor_agregado v on upper(v.estu_consecutivo)=upper(r.estu_consecutivo)
  
--------------------------------------------

create table proyecto.va_repositorio_v3 as select * from proyecto.va_repositorio_v2;
select fami_nivel_sisben,count(*) from proyecto.va_repositorio_v3 group by fami_nivel_sisben;

update proyecto.va_repositorio_v3 set estu_limita_motriz='no_aplica' where estu_limita_motriz is null;
update proyecto.va_repositorio_v3 set estu_limita_motriz='no_aplica' where trim(estu_limita_motriz)='';



----------------------------------------------------------------

CREATE OR REPLACE FUNCTION proyecto.fn_limpiar()
  RETURNS void AS
$BODY$
declare

BEGIN
 	-- ACTUALIZANDO NULL A NO_APLICA
	--estu_genero
	update proyecto.va_repositorio_v3 set estu_genero='no_aplica' where trim(estu_genero)='';
	--estu_estadocivil
    update proyecto.va_repositorio_v3 set estu_estadocivil='no_aplica' where trim(estu_estadocivil)=''; 
   --estu_etnia
    update proyecto.va_repositorio_v3 set estu_etnia='no_aplica' where trim(estu_etnia)='';
   --estu_valormatriculauniversidad
    update proyecto.va_repositorio_v3 set estu_valormatriculauniversidad='no_aplica' where trim(estu_valormatriculauniversidad)='';
   --estu_pagomatriculabeca
    update proyecto.va_repositorio_v3 set estu_pagomatriculabeca='no_aplica' where trim(estu_pagomatriculabeca)='';
   --estu_pagomatriculacredito
    update proyecto.va_repositorio_v3 set estu_pagomatriculacredito='no_aplica' where trim(estu_pagomatriculacredito)='';
   --estu_pagomatriculapadres
    update proyecto.va_repositorio_v3 set estu_pagomatriculapadres='no_aplica' where trim(estu_pagomatriculapadres)=''; 
   --estu_pagomatriculapropio
    update proyecto.va_repositorio_v3 set estu_pagomatriculapropio='no_aplica' where trim(estu_pagomatriculapropio)='';
   --estu_tomo_cursopreparacion
	update proyecto.va_repositorio_v3 set estu_tomo_cursopreparacion='no_aplica' where trim(estu_tomo_cursopreparacion)='';
   --estu_simulacrotipoicfes
    update proyecto.va_repositorio_v3 set estu_simulacrotipoicfes='no_aplica' where trim(estu_simulacrotipoicfes)='';
   --estu_actividadrefuerzoareas
    update proyecto.va_repositorio_v3 set estu_actividadrefuerzoareas='no_aplica' where trim(estu_actividadrefuerzoareas)='';
   --estu_actividadrefuerzogeneric
    update proyecto.va_repositorio_v3 set estu_actividadrefuerzogeneric='no_aplica' where trim(estu_actividadrefuerzogeneric)='';
   --estu_semestrecursa
   	update proyecto.va_repositorio_v3 set estu_semestrecursa='no_aplica' where trim(estu_semestrecursa)='';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='2' where trim(estu_semestrecursa)='02';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='3' where trim(estu_semestrecursa)='03';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='4' where trim(estu_semestrecursa)='04';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='5' where trim(estu_semestrecursa)='05';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='6' where trim(estu_semestrecursa)='06';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='7' where trim(estu_semestrecursa)='07';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='8' where trim(estu_semestrecursa)='08';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='9' where trim(estu_semestrecursa)='09';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='12' where trim(estu_semestrecursa)='12_o_mas';
    update proyecto.va_repositorio_v3 set estu_semestrecursa='-99' where trim(estu_semestrecursa)='no_aplica';
   --fami_hogaractual
    update proyecto.va_repositorio_v3 set fami_hogaractual='no_aplica' where trim(fami_hogaractual)='';
   --fami_cabezafamilia
    update proyecto.va_repositorio_v3 set fami_cabezafamilia='no_aplica' where trim(fami_cabezafamilia)='';
   --estu_horassemanatrabaja
    update proyecto.va_repositorio_v3 set estu_horassemanatrabaja='no_aplica' where trim(estu_horassemanatrabaja)='';
   --fami_numpersonasacargo
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='no_aplica' where trim(fami_numpersonasacargo)='';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='1' where trim(fami_numpersonasacargo)='una';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='2' where trim(fami_numpersonasacargo)='dos';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='3' where trim(fami_numpersonasacargo)='tres';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='4' where trim(fami_numpersonasacargo)='cuatro';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='5' where trim(fami_numpersonasacargo)='cinco';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='6' where trim(fami_numpersonasacargo)='seis';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='7' where trim(fami_numpersonasacargo)='siete';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='8' where trim(fami_numpersonasacargo)='ocho';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='9' where trim(fami_numpersonasacargo)='nueve';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='10' where trim(fami_numpersonasacargo)='diez';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='12' where trim(fami_numpersonasacargo)='12_o_mas';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='-99' where trim(fami_numpersonasacargo)='no_aplica';
    update proyecto.va_repositorio_v3 set fami_numpersonasacargo='0' where trim(fami_numpersonasacargo)='ninguna';
   --fami_educacionpadre
    update proyecto.va_repositorio_v3 set fami_educacionpadre='no_aplica' where trim(fami_educacionpadre)='';
   --fami_educacionmadre
    update proyecto.va_repositorio_v3 set fami_educacionmadre='no_aplica' where trim(fami_educacionmadre)='';
   --fami_ocupacionpadre
    update proyecto.va_repositorio_v3 set fami_ocupacionpadre='no_aplica' where trim(fami_ocupacionpadre)='';
   --fami_ocupacionmadre
    update proyecto.va_repositorio_v3 set fami_ocupacionmadre='no_aplica' where trim(fami_ocupacionmadre)='';
   --fami_estratovivienda
    update proyecto.va_repositorio_v3 set fami_estratovivienda='no_aplica' where trim(fami_estratovivienda)='';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='0' where trim(fami_estratovivienda)='estrato_0';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='1' where trim(fami_estratovivienda)='estrato_1';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='2' where trim(fami_estratovivienda)='estrato_2';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='3' where trim(fami_estratovivienda)='estrato_3';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='4' where trim(fami_estratovivienda)='estrato_4';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='5' where trim(fami_estratovivienda)='estrato_5';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='6' where trim(fami_estratovivienda)='estrato_6';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='0' where trim(fami_estratovivienda)='vive_en_una_zona_rural_donde_no_hay_estratificacion_socioeconomica';
    update proyecto.va_repositorio_v3 set fami_estratovivienda='-99' where fami_estratovivienda in('sin_estrato','no_aplica');
   --fami_personashogar
    update proyecto.va_repositorio_v3 set fami_personashogar='no_aplica' where trim(fami_personashogar)='';
    update proyecto.va_repositorio_v3 set fami_personashogar='1' where trim(fami_personashogar)='una';
    update proyecto.va_repositorio_v3 set fami_personashogar='2' where trim(fami_personashogar)='dos';
    update proyecto.va_repositorio_v3 set fami_personashogar='3' where trim(fami_personashogar)='tres';
    update proyecto.va_repositorio_v3 set fami_personashogar='4' where trim(fami_personashogar)='cuatro';
    update proyecto.va_repositorio_v3 set fami_personashogar='5' where trim(fami_personashogar)='cinco';
    update proyecto.va_repositorio_v3 set fami_personashogar='6' where trim(fami_personashogar)='seis';
    update proyecto.va_repositorio_v3 set fami_personashogar='7' where trim(fami_personashogar)='siete';
    update proyecto.va_repositorio_v3 set fami_personashogar='8' where trim(fami_personashogar)='ocho';
    update proyecto.va_repositorio_v3 set fami_personashogar='9' where trim(fami_personashogar)='nueve';
    update proyecto.va_repositorio_v3 set fami_personashogar='10' where trim(fami_personashogar)='diez';
    update proyecto.va_repositorio_v3 set fami_personashogar='11' where trim(fami_personashogar)='once';
    update proyecto.va_repositorio_v3 set fami_personashogar='12' where trim(fami_personashogar)='12_o_mas';
    update proyecto.va_repositorio_v3 set fami_personashogar='12' where trim(fami_personashogar)='doce_o_mas';
    update proyecto.va_repositorio_v3 set fami_personashogar='0' where trim(fami_personashogar)='ninguna';
    update proyecto.va_repositorio_v3 set fami_personashogar='-99' where trim(fami_personashogar)='no_aplica';
   --fami_cuartoshogar
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='no_aplica' where trim(fami_cuartoshogar)='';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='1' where trim(fami_cuartoshogar)='una';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='1' where trim(fami_cuartoshogar)='uno';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='2' where trim(fami_cuartoshogar)='dos';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='3' where trim(fami_cuartoshogar)='tres';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='4' where trim(fami_cuartoshogar)='cuatro';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='5' where trim(fami_cuartoshogar)='cinco';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='6' where trim(fami_cuartoshogar)='seis';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='7' where trim(fami_cuartoshogar)='siete';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='8' where trim(fami_cuartoshogar)='ocho';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='9' where trim(fami_cuartoshogar)='nueve';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='10' where trim(fami_cuartoshogar)='diez_o_mas';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='10' where trim(fami_cuartoshogar)='10_o_mas';
    update proyecto.va_repositorio_v3 set fami_cuartoshogar='-99' where trim(fami_cuartoshogar)='no_aplica';
   --fami_pisos_hogar
    update proyecto.va_repositorio_v3 set fami_pisos_hogar='no_aplica' where trim(fami_pisos_hogar)='';
   --fami_tieneinternet
    update proyecto.va_repositorio_v3 set fami_tieneinternet='no_aplica' where trim(fami_tieneinternet)='';
   --fami_tiene_serviciotv
    update proyecto.va_repositorio_v3 set fami_tiene_serviciotv='no_aplica' where trim(fami_tiene_serviciotv)='';
   --fami_tienecomputador
    update proyecto.va_repositorio_v3 set fami_tienecomputador='no_aplica' where trim(fami_tienecomputador)='';
   --fami_tienelavadora
    update proyecto.va_repositorio_v3 set fami_tienelavadora='no_aplica' where trim(fami_tienelavadora)='';
   --fami_tiene_microondas
    update proyecto.va_repositorio_v3 set fami_tiene_microondas='no_aplica' where trim(fami_tiene_microondas)='';
   --fami_tiene_horno
    update proyecto.va_repositorio_v3 set fami_tiene_horno='no_aplica' where trim(fami_tiene_horno)='';
   --fami_tieneautomovil
    update proyecto.va_repositorio_v3 set fami_tieneautomovil='no_aplica' where trim(fami_tieneautomovil)='';
   --fami_tiene_dvd
    update proyecto.va_repositorio_v3 set fami_tiene_dvd='no_aplica' where trim(fami_tiene_dvd)='';
   --fami_tiene_nevera
    update proyecto.va_repositorio_v3 set fami_tiene_nevera='no_aplica' where trim(fami_tiene_nevera)='';
   --fami_tiene_celular
    update proyecto.va_repositorio_v3 set fami_tiene_celular='no_aplica' where trim(fami_tiene_celular)='';
   --fami_telefono
    update proyecto.va_repositorio_v3 set fami_telefono='no_aplica' where trim(fami_telefono)='';
   --fami_tienehornomicroogas
    update proyecto.va_repositorio_v3 set fami_tienehornomicroogas='no_aplica' where trim(fami_tienehornomicroogas)='';
   --fami_tienemotocicleta
    update proyecto.va_repositorio_v3 set fami_tienemotocicleta='no_aplica' where trim(fami_tienemotocicleta)='';
   --fami_tieneconsolavideojuegos
    update proyecto.va_repositorio_v3 set fami_tieneconsolavideojuegos='no_aplica' where trim(fami_tieneconsolavideojuegos)='';
   --fami_ingreso_fmiliar_mensual
    update proyecto.va_repositorio_v3 set fami_ingreso_fmiliar_mensual='no_aplica' where trim(fami_ingreso_fmiliar_mensual)='';
   --estu_trabaja_actualmente
    update proyecto.va_repositorio_v3 set estu_trabaja_actualmente='no_aplica' where trim(estu_trabaja_actualmente)='';
   --estu_tiporemuneracion
    update proyecto.va_repositorio_v3 set estu_tiporemuneracion='no_aplica' where trim(estu_tiporemuneracion)='';
   --estu_nse_individual
    update proyecto.va_repositorio_v3 set estu_nse_individual='no_aplica' where trim(estu_nse_individual)='';
   
   
   --VARIABLES ORDINALES 
   --fami_nivel_sisben 
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='no_aplica' where trim(fami_nivel_sisben)='';
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='-99' where trim(fami_nivel_sisben)='no_aplica';
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='1' where trim(fami_nivel_sisben)='nivel_1';
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='2' where trim(fami_nivel_sisben)='nivel_2';
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='3' where trim(fami_nivel_sisben)='nivel_3';
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='0' where trim(fami_nivel_sisben)='no_esta_clasificada_por_el_sisben';
    update proyecto.va_repositorio_v3 set fami_nivel_sisben='4' where trim(fami_nivel_sisben)='esta_clasificada_en_otro_nivel_del_sisben';
   -- estu_porcentajecreditosaprob
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='no_aplica' where trim(estu_porcentajecreditosaprob)='';
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='-99' where trim(estu_porcentajecreditosaprob)='no_aplica';
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='0' where trim(estu_porcentajecreditosaprob)='no_sigue_el_sistema_de_creditos';
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='75' where trim(estu_porcentajecreditosaprob)='menos_del_75_por_centaje';
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='76' where trim(estu_porcentajecreditosaprob)='entre_el_76_por_centaje_y_el_80_por_centaje';
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='81' where trim(estu_porcentajecreditosaprob)='entre_el_81_por_centaje_y_el_90_por_centaje';
    update proyecto.va_repositorio_v3 set estu_porcentajecreditosaprob='90' where trim(estu_porcentajecreditosaprob)='mas_del_90_por_centaje';
   --estu_cursodocentesies	
	update proyecto.va_repositorio_v3 set estu_cursodocentesies='no_aplica' where trim(estu_cursodocentesies)='';
    update proyecto.va_repositorio_v3 set estu_cursodocentesies='-99' where trim(estu_cursodocentesies)='no_aplica';
    update proyecto.va_repositorio_v3 set estu_cursodocentesies='0' where trim(estu_cursodocentesies)='no_tomo_curso';
    update proyecto.va_repositorio_v3 set estu_cursodocentesies='19' where trim(estu_cursodocentesies)='menos_de_20_horas';
    update proyecto.va_repositorio_v3 set estu_cursodocentesies='20' where trim(estu_cursodocentesies)='entre_20_y_30_horas';
    update proyecto.va_repositorio_v3 set estu_cursodocentesies='30' where trim(estu_cursodocentesies)='mas_de_30_horas';
   --estu_cursoiesapoyoexterno
	update proyecto.va_repositorio_v3 set estu_cursoiesapoyoexterno='no_aplica' where trim(estu_cursoiesapoyoexterno)='';
    update proyecto.va_repositorio_v3 set estu_cursoiesapoyoexterno='-99' where trim(estu_cursoiesapoyoexterno)='no_aplica';
    update proyecto.va_repositorio_v3 set estu_cursoiesapoyoexterno='0' where trim(estu_cursoiesapoyoexterno)='no_tomo_curso';
    update proyecto.va_repositorio_v3 set estu_cursoiesapoyoexterno='19' where trim(estu_cursoiesapoyoexterno)='menos_de_20_horas';
    update proyecto.va_repositorio_v3 set estu_cursoiesapoyoexterno='20' where trim(estu_cursoiesapoyoexterno)='entre_20_y_30_horas';
    update proyecto.va_repositorio_v3 set estu_cursoiesapoyoexterno='30' where trim(estu_cursoiesapoyoexterno)='mas_de_30_horas';
   --estu_cursoiesexterna
	update proyecto.va_repositorio_v3 set estu_cursoiesexterna='no_aplica' where trim(estu_cursoiesexterna)='';
    update proyecto.va_repositorio_v3 set estu_cursoiesexterna='-99' where trim(estu_cursoiesexterna)='no_aplica';
    update proyecto.va_repositorio_v3 set estu_cursoiesexterna='0' where trim(estu_cursoiesexterna)='no_tomo_curso';
    update proyecto.va_repositorio_v3 set estu_cursoiesexterna='19' where trim(estu_cursoiesexterna)='menos_de_20_horas';
    update proyecto.va_repositorio_v3 set estu_cursoiesexterna='20' where trim(estu_cursoiesexterna)='entre_20_y_30_horas';
    update proyecto.va_repositorio_v3 set estu_cursoiesexterna='30' where trim(estu_cursoiesexterna)='mas_de_30_horas';
    --fami_numlibros
    update proyecto.va_repositorio_v3 set fami_numlibros='no_aplica' where trim(fami_numlibros)='';
    update proyecto.va_repositorio_v3 set fami_numlibros='-99' where trim(fami_numlibros)='no_aplica';
    update proyecto.va_repositorio_v3 set fami_numlibros='10' where trim(fami_numlibros)='0_a_10_libros';
    update proyecto.va_repositorio_v3 set fami_numlibros='11' where trim(fami_numlibros)='11_a_25_libros';
    update proyecto.va_repositorio_v3 set fami_numlibros='26' where trim(fami_numlibros)='26_a_100_libros';
    update proyecto.va_repositorio_v3 set fami_numlibros='100' where trim(fami_numlibros)='mas_de_100_libros';
   --estu_dedicacioninternet
    update proyecto.va_repositorio_v3 set estu_dedicacioninternet='no_aplica' where trim(estu_dedicacioninternet)='';
    update proyecto.va_repositorio_v3 set estu_dedicacioninternet='-99' where trim(estu_dedicacioninternet)='no_aplica';
    update proyecto.va_repositorio_v3 set estu_dedicacioninternet='1' where trim(estu_dedicacioninternet)='menos_de_una_hora';
    update proyecto.va_repositorio_v3 set estu_dedicacioninternet='3' where trim(estu_dedicacioninternet)='entre_1_y_3_horas';
    update proyecto.va_repositorio_v3 set estu_dedicacioninternet='4' where trim(estu_dedicacioninternet)='mas_de_4_horas';
   --fami_cuantoscompartebano
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='no_aplica' where trim(fami_cuantoscompartebano)='';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='-99' where trim(fami_cuantoscompartebano)='no_aplica';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='1' where trim(fami_cuantoscompartebano)='1';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='2' where trim(fami_cuantoscompartebano)='2';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='3' where trim(fami_cuantoscompartebano)='3_o_4';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='5' where trim(fami_cuantoscompartebano)='5_o_6';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='6' where trim(fami_cuantoscompartebano)='mas_de_6';
    update proyecto.va_repositorio_v3 set fami_cuantoscompartebano='0' where trim(fami_cuantoscompartebano)='ninguna';
   --estu_dedicacionlecturadiaria
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='no_aplica' where trim(estu_dedicacionlecturadiaria)='';
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='-99' where trim(estu_dedicacionlecturadiaria)='no_aplica';
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='30' where trim(estu_dedicacionlecturadiaria)='30_minutos_o_menos';
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='0' where trim(estu_dedicacionlecturadiaria)='no_leo_por_entretenimiento';
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='60' where trim(estu_dedicacionlecturadiaria)='entre_30_y_60_minutos';
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='2' where trim(estu_dedicacionlecturadiaria)='mas_de_2_horas';
    update proyecto.va_repositorio_v3 set estu_dedicacionlecturadiaria='1' where trim(estu_dedicacionlecturadiaria)='entre_1_y_2_horas';
   
return;
end
$BODY$
	language plpgsql volatile
	cost 100;

select proyecto.fn_limpiar()
	
	
select estu_dedicacionlecturadiaria,count(*) from proyecto.va_repositorio_v3 group by estu_dedicacionlecturadiaria;
	
	
	
	

  