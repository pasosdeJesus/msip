import * as fs from "fs";
import puppeteer from "puppeteer-core"
import {
  prepararYAutenticarDeAmbiente,
  changeSelectElement,
  changeElementValue,
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
