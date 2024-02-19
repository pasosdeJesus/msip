import puppeteer from "puppeteer-core"
import {
  changeSelectElement,
  changeElementValue,
  preparar,
  prepararYAutenticarDeAmbiente,
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


(async () => {

  const tiempoini = performance.now();

  let timeout = 5000;
  let urlini, browser, page;
  [urlini, browser, page] = await prepararYAutenticarDeAmbiente(
    timeout, preparar
  );


  await browser.close();

  const tiempofin = performance.now();
  process.env.TIEMPO_EJECUCION=tiempofin - tiempoini;
  console.log(`Tiempo de ejecución: ${process.env.TIEMPO_EJECUCION} ms`);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
