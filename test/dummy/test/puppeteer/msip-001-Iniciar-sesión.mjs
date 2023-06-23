import * as fs from "fs";
import dotenv from "dotenv"
import puppeteer from "puppeteer-core"
import {
  autentica,
  changeSelectElement,
  changeElementValue,
  prepara,
  querySelectorsAll,
  querySelectorAll,
  scrollIntoViewIfNeeded,
  typeIntoElement,
  waitForConnected,
  waitForElement,
  waitForInViewport,
  waitForSelector,
  waitForSelectors,
  waitForFunction,
} from "@pasosdeJesus/pruebas_puppeteer";

dotenv.config({ path: "../../.env"})

export const rutaRelativa = typeof process != "undefined" &&
  typeof process.env.RUTA_RELATIVA != "undefined" ?
  process.env.RUTA_RELATIVA :
  '/msip';

export const usuarioAdminPrueba = typeof process != "undefined" &&
  typeof process.env.USUARIO_ADMIN_PRUEBA != "undefined" ?
  process.env.USUARIO_ADMIN_PRUEBA:
  'msip';

export const claveAdminPrueba = typeof process != "undefined" &&
  typeof process.env.CLAVE_ADMIN_PRUEBA != "undefined" ?
  process.env.CLAVE_ADMIN_PRUEBA:
  'msip';


(async () => {

  let timeout = 5000;
  let urlini, browser, page;
  [urlini, browser, page] = await prepararYAutenticarDeAmbiente();

  await browser.close();

})().catch(err => {
  console.error(err);
  process.exit(1);
});
