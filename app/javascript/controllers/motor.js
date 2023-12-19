
export default class MsipMotor {
  /* 
   * Aunque este no es un controlador lo dejamos dentro del directorio
   * controllers para aprovechar lo avanzado para compartir controladores
   * Stimulus de motores.
   */
  static MESES = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];

  static partirFechaLocalizada(fechaLocalizada, formato) {
    let anio = 1900;
    let dia = 15;
    let mes = 6;
    if (formato == 'dd/M/yyyy' || formato == 'dd-M-yyyy') {
      anio = +fechaLocalizada.slice(7,11)
      dia = +fechaLocalizada.slice(0,2)
      let nmes = fechaLocalizada.slice(3,6)
      if (typeof nmes != 'undefined' && 
        MESES.includes(nmes.toLowerCase())) {
        mes = MESES.indexOf(nmes.toLowerCase()) + 1;
      } else {
        mes = 6;
      }
    } else {
      if (typeof fechaLocalizada == 'string') {
        anio = +fechaLocalizada.slice(0,4);
        mes = +fechaLocalizada.slice(5,7);
        dia = +fechaLocalizada.slice(8,10);
      } else {
        anio = 1900;
        mes = 1;
        dia = 1;
      }
    }
    return [anio, mes, dia]
  }
}
