import dotenv from "dotenv";
import puppeteer from "puppeteer";


export async function preparar(timeout = 5000, rutainicial = '/msip') {
  let maq = "http://127.0.0.1:33001";
  if (typeof process.env.IPDES != "undefined" && 
    typeof process.env.PUERTODES != "undefined") {
    maq = "http://" + process.env.IPDES + ":" + process.env.PUERTODES;
  }
  //console.log("maq=", maq);
  let sincabeza = 'new';
  if (typeof process.env.CONCABEZA != "undefined") {
    sincabeza = false;
  }
  //console.log("sincabeza=", sincabeza);
  let browser = null;
  if (typeof process.env.CI == "string") {
    let ep = puppeteerc.executablePath;
    browser = await puppeteer.launch({
      executablePath: ep,
      defaultViewport: { width: 1240, height: 800},
      headless: sincabeza,
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage'
      ]
    });
  } else {
    console.log("En adJ se debe usar puppeteer-core");
    exit(1);
  }

  const page = await browser.newPage();
  page.setDefaultTimeout(timeout);
  {
    const targetPage = page;
    await targetPage.setViewport({
      width: 1292,
      height: 636
    })
  }
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await targetPage.goto(maq + rutainicial);
    await Promise.all(promises);
  }

  return [maq, browser, page];
}
