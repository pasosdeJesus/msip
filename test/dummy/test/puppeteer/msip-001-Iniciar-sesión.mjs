import puppeteer from "puppeteer-core"
import {
  changeSelectElement,
  changeElementValue,
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

  let timeout = 5000;
  let urlini, browser, page;
  [urlini, browser, page] = await prepararYAutenticarDeAmbiente();


  await browser.close();
})().catch(err => {
  console.error(err);
  process.exit(1);
});
