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


  let timeout = 15000;
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
                'aria/Centros poblados'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Centros poblados'
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
                'form > div:nth-of-type(1) a'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'form > div:nth-of-type(1) a'
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
                'div.clase_municipio span'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'div.clase_municipio span'
            ]
        ], targetPage, { timeout, visible: true });
        await element.click({
          offset: {
            x: 100.5,
            y: 11.65625,
          },
        });
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'li.highlighted'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'li.highlighted'
            ]
        ], targetPage, { timeout, visible: true });
        await element.click({
          offset: {
            x: 75.5,
            y: 14.65625,
          },
        });
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Código dentro del municipio'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Código dentro del municipio'
            ]
        ], targetPage, { timeout, visible: true });
        await element.click({
          offset: {
            x: 76.5,
            y: 32.65625,
          },
        });
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Código dentro del municipio'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Código dentro del municipio'
            ]
        ], targetPage, { timeout, visible: true });
        const inputType = await element.evaluate(el => el.type);
        if (inputType === 'select-one') {
          await changeSelectElement(element, '999')
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
          await typeIntoElement(element, '999');
        } else {
          await changeElementValue(element, '999');
        }
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Latitud'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Latitud'
            ]
        ], targetPage, { timeout, visible: true });
        const inputType = await element.evaluate(el => el.type);
        if (inputType === 'select-one') {
          await changeSelectElement(element, '1')
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
          await typeIntoElement(element, '1');
        } else {
          await changeElementValue(element, '1');
        }
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Longitud'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Longitud'
            ]
        ], targetPage, { timeout, visible: true });
        const inputType = await element.evaluate(el => el.type);
        if (inputType === 'select-one') {
          await changeSelectElement(element, '2')
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
          await typeIntoElement(element, '2');
        } else {
          await changeElementValue(element, '2');
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
        const promises = []; 
        promises.push(targetPage.waitForNavigation());

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
        await Promise.all(promises);
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
              'text/Msip::Clase eliminado.'
            ]
          ]
        }, frame, timeout);
      }


    await browser.close();

})().catch(err => {
    console.error(err);
    process.exit(1);
});
