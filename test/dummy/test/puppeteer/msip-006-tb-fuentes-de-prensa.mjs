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
  [urlini, browser, page] = await prepararYAutenticarDeAmbiente(timeout);

  {
    const targetPage = page;
    await scrollIntoViewIfNeeded([
      [
        'aria/Administrar'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Administrar'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 58.9375,
        y: 20,
      },
    });
  }
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await scrollIntoViewIfNeeded([
      [
        'aria/Tablas básicas'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Tablas básicas'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 40.9375,
        y: 15,
      },
    });
    await Promise.all(promises);
  }
  {
    const targetPage = page;
    await scrollIntoViewIfNeeded([
      [
        'aria/Fuentes de prensa'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Fuentes de prensa'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 96.5,
        y: 10,
      },
    });
  }
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await scrollIntoViewIfNeeded([
      [
        'aria/Nuevo'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Nuevo'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 36.5,
        y: 16,
      },
    });
    await Promise.all(promises);
  }
  {
    const targetPage = page;
    await scrollIntoViewIfNeeded([
      [
        'aria/Nombre *'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Nombre *'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 137.5,
        y: 10,
      },
    });
  }
  {
    const targetPage = page;
    await scrollIntoViewIfNeeded([
      [
        'aria/Nombre *'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Nombre *'
      ]
    ], targetPage, { timeout, visible: true });
    const inputType = await element.evaluate(el => el.type);
    if (inputType === 'select-one') {
      await changeSelectElement(element, 'aaa')
    } else if ([
      'textarea',
      'text',
      'url',
      'tel',
      'search',
      'password',
      'number',
      'email'
    ].includes(inputType)) {
      await typeIntoElement(element, 'aaa');
    } else {
      await changeElementValue(element, 'aaa');
    }
  }
  {
    const targetPage = page;
    await scrollIntoViewIfNeeded([
      [
        'aria/Observaciones'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Observaciones'
      ]
    ], targetPage, { timeout, visible: true });
    const inputType = await element.evaluate(el => el.type);
    if (inputType === 'select-one') {
      await changeSelectElement(element, 'obs')
    } else if ([
      'textarea',
      'text',
      'url',
      'tel',
      'search',
      'password',
      'number',
      'email'
    ].includes(inputType)) {
      await typeIntoElement(element, 'obs');
    } else {
      await changeElementValue(element, 'obs');
    }
  }
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await scrollIntoViewIfNeeded([
      [
        'aria/Crear'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Crear'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 32.5,
        y: 13.3125,
      },
    });
    await Promise.all(promises);
  }
  {
    const targetPage = page;
    targetPage.on('dialog', async dialog => {
      console.log(dialog.message());
      await dialog.accept(); //dismiss()
    })

    await scrollIntoViewIfNeeded([
      [
        'aria/Eliminar'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Eliminar'
      ]
    ], targetPage, { timeout, visible: true });
    await element.click({
      offset: {
        x: 32.5,
        y: 13.3125,
      },
    });
    //await Promise.all(promises);
  }

  {
    const targetPage = page;
    let frame = targetPage.mainFrame();
    await waitForElement({
      type: 'waitForElement',
      target: 'main',
      frame: [
      ],
      selectors: [
        [
          'text/Msip::Fuenteprensa eliminada.'
        ]
      ]
    }, frame, timeout);
  }


  await browser.close();


})().catch(err => {
  console.error(err);
  process.exit(1);
});



