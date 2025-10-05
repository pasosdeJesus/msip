import type { ColumnType } from "kysely";

export type Generated<T> = T extends ColumnType<infer S, infer I, infer U>
  ? ColumnType<S, I | undefined, U>
  : ColumnType<T, T | undefined, T>;

export type Int8 = ColumnType<string, bigint | number | string, bigint | number | string>;

export type Json = JsonValue;

export type JsonArray = JsonValue[];

export type JsonObject = {
  [K in string]?: JsonValue;
};

export type JsonPrimitive = boolean | number | string | null;

export type JsonValue = JsonArray | JsonObject | JsonPrimitive;

export type Timestamp = ColumnType<Date, Date | string, Date | string>;

export interface ArInternalMetadata {
  created_at: Timestamp;
  key: string;
  updated_at: Timestamp;
  value: string | null;
}

export interface DivipolaMsip {
  centropoblado: string | null;
  codcp: number | null;
  coddep: number | null;
  codmun: number | null;
  departamento: string | null;
  msip_idcp: number | null;
  municipio: string | null;
  tipocp: string | null;
}

export interface MsipAnexo {
  adjunto_content_type: string;
  adjunto_file_name: string;
  adjunto_file_size: number;
  adjunto_updated_at: Timestamp | null;
  created_at: Timestamp | null;
  descripcion: string;
  id: Generated<number>;
  updated_at: Timestamp | null;
}

export interface MsipBitacora {
  created_at: Timestamp;
  detalle: Json | null;
  fecha: Timestamp;
  id: Generated<Int8>;
  ip: string | null;
  modelo: string | null;
  modelo_id: number | null;
  operacion: string | null;
  params: string | null;
  updated_at: Timestamp;
  url: string | null;
  usuario_id: number | null;
}

export interface MsipCentropoblado {
  cplocal_cod: number | null;
  created_at: Timestamp | null;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  latitud: number | null;
  longitud: number | null;
  municipio_id: number;
  nombre: string;
  observaciones: string | null;
  svgcdalto: number | null;
  svgcdancho: number | null;
  svgcdx: number | null;
  svgcdy: number | null;
  svgrotx: number | null;
  svgroty: number | null;
  svgruta: string | null;
  tcentropoblado_id: Generated<string>;
  ultvigenciafin: Timestamp | null;
  ultvigenciaini: Timestamp | null;
  updated_at: Timestamp | null;
}

export interface MsipCentropobladoHistvigencia {
  centropoblado_id: number | null;
  cplocal_cod: number | null;
  id: Generated<Int8>;
  nombre: string | null;
  observaciones: string | null;
  tcentropoblado_id: string | null;
  vigenciafin: Timestamp;
  vigenciaini: Timestamp | null;
}

export interface MsipDepartamento {
  catiso: string | null;
  codiso: string | null;
  codreg: number | null;
  created_at: Timestamp | null;
  deplocal_cod: number | null;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  latitud: number | null;
  longitud: number | null;
  nombre: string;
  observaciones: string | null;
  pais_id: number;
  svgcdalto: number | null;
  svgcdancho: number | null;
  svgcdx: number | null;
  svgcdy: number | null;
  svgrotx: number | null;
  svgroty: number | null;
  svgruta: string | null;
  ultvigenciafin: Timestamp | null;
  ultvigenciaini: Timestamp | null;
  updated_at: Timestamp | null;
}

export interface MsipDepartamentoHistvigencia {
  catiso: number | null;
  codiso: number | null;
  codreg: number | null;
  departamento_id: number | null;
  deplocal_cod: number | null;
  id: Generated<Int8>;
  nombre: string | null;
  observaciones: string | null;
  vigenciafin: Timestamp;
  vigenciaini: Timestamp | null;
}

export interface MsipEstadosol {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipEtiqueta {
  created_at: Timestamp | null;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp | null;
}

export interface MsipEtiquetaMunicipio {
  etiqueta_id: Int8;
  municipio_id: Int8;
}

export interface MsipEtiquetaPersona {
  created_at: Timestamp;
  etiqueta_id: number;
  fecha: Timestamp;
  id: Generated<Int8>;
  observaciones: string | null;
  persona_id: number;
  updated_at: Timestamp;
  usuario_id: number;
}

export interface MsipEtnia {
  created_at: Timestamp;
  descripcion: string | null;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipFuenteprensa {
  created_at: Timestamp;
  fechacreacion: Timestamp | null;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  nombre: string | null;
  observaciones: string | null;
  updated_at: Timestamp | null;
}

export interface MsipGrupo {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipGrupoper {
  anotaciones: string | null;
  id: Generated<Int8>;
  nombre: string;
}

export interface MsipGrupoUsuario {
  grupo_id: number;
  usuario_id: number;
}

export interface MsipMundepSinorden {
  idlocal: number | null;
  nombre: string | null;
}

export interface MsipMunicipio {
  codreg: number | null;
  created_at: Timestamp | null;
  departamento_id: number;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  latitud: number | null;
  longitud: number | null;
  munlocal_cod: number | null;
  nombre: string;
  observaciones: string | null;
  svgcdalto: number | null;
  svgcdancho: number | null;
  svgcdx: number | null;
  svgcdy: number | null;
  svgrotx: number | null;
  svgroty: number | null;
  svgruta: string | null;
  tipomun: string | null;
  ultvigenciafin: Timestamp | null;
  ultvigenciaini: Timestamp | null;
  updated_at: Timestamp | null;
}

export interface MsipMunicipioHistvigencia {
  codreg: number | null;
  id: Generated<Int8>;
  municipio_id: number | null;
  munlocal_cod: number | null;
  nombre: string | null;
  observaciones: string | null;
  vigenciafin: Timestamp;
  vigenciaini: Timestamp | null;
}

export interface MsipOficina {
  created_at: Timestamp | null;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp | null;
}

export interface MsipOrgsocial {
  created_at: Timestamp;
  direccion: string | null;
  fax: string | null;
  fechadeshabilitacion: Timestamp | null;
  grupoper_id: number;
  id: Generated<Int8>;
  pais_id: number | null;
  telefono: string | null;
  tipoorg_id: Generated<number>;
  updated_at: Timestamp;
  web: string | null;
}

export interface MsipOrgsocialPersona {
  cargo: string | null;
  correo: string | null;
  created_at: Timestamp;
  id: Generated<Int8>;
  orgsocial_id: number;
  perfilorgsocial_id: number | null;
  persona_id: number;
  updated_at: Timestamp;
}

export interface MsipOrgsocialSectororgsocial {
  orgsocial_id: number | null;
  sectororgsocial_id: number | null;
}

export interface MsipPais {
  alfa2: string | null;
  alfa3: string | null;
  codiso: number | null;
  created_at: Timestamp | null;
  div1: string | null;
  div2: string | null;
  div3: string | null;
  fechacreacion: Timestamp | null;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  latitud: number | null;
  longitud: number | null;
  nombre: string | null;
  nombreiso_espanol: string | null;
  nombreiso_frances: string | null;
  nombreiso_ingles: string | null;
  observaciones: string | null;
  svgcdalto: number | null;
  svgcdancho: number | null;
  svgcdx: number | null;
  svgcdy: number | null;
  svgrotx: number | null;
  svgroty: number | null;
  svgruta: string | null;
  ultvigenciafin: Timestamp | null;
  ultvigenciaini: Timestamp | null;
  updated_at: Timestamp | null;
}

export interface MsipPaisHistvigencia {
  alfa2: string | null;
  alfa3: string | null;
  codcambio: string | null;
  codiso: number | null;
  id: Generated<Int8>;
  pais_id: number | null;
  vigenciafin: Timestamp;
  vigenciaini: Timestamp | null;
}

export interface MsipPerfilorgsocial {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipPersona {
  anionac: number | null;
  apellidos: string;
  centropoblado_id: number | null;
  created_at: Timestamp | null;
  departamento_id: number | null;
  dianac: number | null;
  etnia_id: Generated<number>;
  id: Generated<number>;
  mesnac: number | null;
  municipio_id: number | null;
  nacionalde: number | null;
  nombres: string;
  numerodocumento: string | null;
  pais_id: number | null;
  sexo: string;
  tdocumento_id: number | null;
  updated_at: Timestamp | null;
}

export interface MsipPersonaTrelacion {
  created_at: Timestamp | null;
  id: Generated<number>;
  observaciones: string | null;
  persona1: number;
  persona2: number;
  trelacion_id: Generated<string>;
  updated_at: Timestamp | null;
}

export interface MsipSectororgsocial {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipSolicitud {
  created_at: Timestamp;
  estadosol_id: number | null;
  fecha: Timestamp;
  id: Generated<Int8>;
  solicitud: string | null;
  updated_at: Timestamp;
  usuario_id: number;
}

export interface MsipSolicitudUsuarionotificar {
  solicitud_id: number | null;
  usuarionotificar_id: number | null;
}

export interface MsipTcentropoblado {
  created_at: Timestamp | null;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: string;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp | null;
}

export interface MsipTdocumento {
  ayuda: string | null;
  created_at: Timestamp | null;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  formatoregex: string | null;
  id: Generated<number>;
  nombre: string;
  observaciones: string | null;
  sigla: string;
  updated_at: Timestamp | null;
}

export interface MsipTema {
  alerta_exito_fondo: string | null;
  alerta_exito_fuente: string | null;
  alerta_problema_fondo: string | null;
  alerta_problema_fuente: string | null;
  btn_accion_fondo_fin: string | null;
  btn_accion_fondo_ini: string | null;
  btn_accion_fuente: string | null;
  btn_peligro_fondo_fin: string | null;
  btn_peligro_fondo_ini: string | null;
  btn_peligro_fuente: string | null;
  btn_primario_fondo_fin: string | null;
  btn_primario_fondo_ini: string | null;
  btn_primario_fuente: string | null;
  color_flota_subitem_fondo: string | null;
  color_flota_subitem_fuente: string | null;
  color_fuente: string | null;
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  fondo: string | null;
  fondo_lista: string | null;
  id: Generated<Int8>;
  nav_fin: string | null;
  nav_fuente: string | null;
  nav_ini: string | null;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipTipoorg {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipTrelacion {
  created_at: Timestamp | null;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: string;
  inverso: string | null;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp | null;
}

export interface MsipTrivalente {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
}

export interface MsipTsitio {
  created_at: Timestamp | null;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp | null;
}

export interface MsipUbicacion {
  centropoblado_id: number | null;
  created_at: Timestamp | null;
  departamento_id: number | null;
  id: Generated<number>;
  latitud: number | null;
  longitud: number | null;
  lugar: string | null;
  municipio_id: number | null;
  pais_id: number | null;
  sitio: string | null;
  tsitio_id: Generated<number>;
  updated_at: Timestamp | null;
}

export interface MsipUbicacionpre {
  centropoblado_id: number | null;
  created_at: Timestamp;
  departamento_id: number | null;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  latitud: number | null;
  longitud: number | null;
  lugar: string | null;
  municipio_id: number | null;
  nombre: string;
  nombre_sin_pais: string | null;
  observaciones: string | null;
  pais_id: number;
  sitio: string | null;
  tsitio_id: number | null;
  updated_at: Timestamp;
  vereda_id: number | null;
}

export interface MsipVereda {
  created_at: Timestamp;
  fechacreacion: Timestamp;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<Int8>;
  latitud: number | null;
  longitud: number | null;
  municipio_id: number | null;
  nombre: string;
  observaciones: string | null;
  updated_at: Timestamp;
  verlocal_cod: number | null;
}

export interface SchemaMigrations {
  version: string;
}

export interface Usuario {
  created_at: Timestamp | null;
  current_sign_in_at: Timestamp | null;
  current_sign_in_ip: string | null;
  descripcion: string | null;
  email: Generated<string>;
  encrypted_password: Generated<string>;
  failed_attempts: number | null;
  fechacreacion: Generated<Timestamp>;
  fechadeshabilitacion: Timestamp | null;
  id: Generated<number>;
  idioma: Generated<string>;
  last_sign_in_at: Timestamp | null;
  last_sign_in_ip: string | null;
  locked_at: Timestamp | null;
  nombre: string | null;
  nusuario: string;
  password: Generated<string>;
  remember_created_at: Timestamp | null;
  reset_password_sent_at: Timestamp | null;
  reset_password_token: string | null;
  rol: Generated<number | null>;
  sign_in_count: Generated<number>;
  tema_id: number | null;
  unlock_token: string | null;
  updated_at: Timestamp | null;
}

export interface DB {
  ar_internal_metadata: ArInternalMetadata;
  divipola_msip: DivipolaMsip;
  msip_anexo: MsipAnexo;
  msip_bitacora: MsipBitacora;
  msip_centropoblado: MsipCentropoblado;
  msip_centropoblado_histvigencia: MsipCentropobladoHistvigencia;
  msip_departamento: MsipDepartamento;
  msip_departamento_histvigencia: MsipDepartamentoHistvigencia;
  msip_estadosol: MsipEstadosol;
  msip_etiqueta: MsipEtiqueta;
  msip_etiqueta_municipio: MsipEtiquetaMunicipio;
  msip_etiqueta_persona: MsipEtiquetaPersona;
  msip_etnia: MsipEtnia;
  msip_fuenteprensa: MsipFuenteprensa;
  msip_grupo: MsipGrupo;
  msip_grupo_usuario: MsipGrupoUsuario;
  msip_grupoper: MsipGrupoper;
  msip_mundep_sinorden: MsipMundepSinorden;
  msip_municipio: MsipMunicipio;
  msip_municipio_histvigencia: MsipMunicipioHistvigencia;
  msip_oficina: MsipOficina;
  msip_orgsocial: MsipOrgsocial;
  msip_orgsocial_persona: MsipOrgsocialPersona;
  msip_orgsocial_sectororgsocial: MsipOrgsocialSectororgsocial;
  msip_pais: MsipPais;
  msip_pais_histvigencia: MsipPaisHistvigencia;
  msip_perfilorgsocial: MsipPerfilorgsocial;
  msip_persona: MsipPersona;
  msip_persona_trelacion: MsipPersonaTrelacion;
  msip_sectororgsocial: MsipSectororgsocial;
  msip_solicitud: MsipSolicitud;
  msip_solicitud_usuarionotificar: MsipSolicitudUsuarionotificar;
  msip_tcentropoblado: MsipTcentropoblado;
  msip_tdocumento: MsipTdocumento;
  msip_tema: MsipTema;
  msip_tipoorg: MsipTipoorg;
  msip_trelacion: MsipTrelacion;
  msip_trivalente: MsipTrivalente;
  msip_tsitio: MsipTsitio;
  msip_ubicacion: MsipUbicacion;
  msip_ubicacionpre: MsipUbicacionpre;
  msip_vereda: MsipVereda;
  schema_migrations: SchemaMigrations;
  usuario: Usuario;
}
