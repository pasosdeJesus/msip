import fs from "fs";
import puppeteer from "puppeteer-core"
//const puppeteer = require('puppeteer-core'); // v13.0.0 or later

(async () => {

  let browser = null;
  if (typeof process.env.CI == "string") {
      browser = await puppeteer.launch({
        defaultViewport: { width: 1240, height: 800},
        headless: true,
        args: [
          '--no-sandbox',
          '--disable-setuid-sandbox',
          '--disable-dev-shm-usage'
        ]
      });
    } else {
      if (fs.existsSync("/usr/local/bin/chrome")) {
        browser = await puppeteer.launch({
          executablePath: '/usr/local/bin/chrome',
          defaultViewport: { width: 1240, height: 800},
          headless: true
        });
      } else if (fs.existsSync("/usr/bin/chromium-browser")) {
        browser = await puppeteer.launch({
          executablePath: '/usr/bin/chromium-browser',
          defaultViewport: { width: 1240, height: 800},
          headless: false,
          devtools: true
        });
      } else {
        throw "No se encontró navegador";
      }
    }

    const page = await browser.newPage();
    const timeout = 10000;
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
        await targetPage.goto('http://127.0.0.1:33001/msip');
        await Promise.all(promises);
    }
    //// AUTENTICA

    {
        const targetPage = page;
        let frame = targetPage.mainFrame();
        await scrollIntoViewIfNeeded([
            [
                'aria/Iniciar Sesión'
            ]
        ], frame, timeout);
        const element = await waitForSelectors([
            [
                'aria/Iniciar Sesión'
            ]
        ], frame, { timeout, visible: true });
        await element.click({
          offset: {
            x: 52.25,
            y: 17,
          },
        });
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Usuario'
            ],
            [
                '#usuario_nusuario'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Usuario'
            ],
            [
                '#usuario_nusuario'
            ]
        ], targetPage, { timeout, visible: true });
        await element.click({
          offset: {
            x: 377,
            y: 3.609375,
          },
        });
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Usuario'
            ],
            [
                '#usuario_nusuario'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Usuario'
            ],
            [
                '#usuario_nusuario'
            ]
        ], targetPage, { timeout, visible: true });
        const inputType = await element.evaluate(el => el.type);
        if (inputType === 'select-one') {
          await changeSelectElement(element, 'msip')
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
          await typeIntoElement(element, 'msip');
        } else {
          await changeElementValue(element, 'msip');
        }
    }
    {
        const targetPage = page;
        await targetPage.keyboard.down('Tab');
    }
    {
        const targetPage = page;
        await targetPage.keyboard.up('Tab');
    }
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Clave'
            ],
            [
                '#usuario_password'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Clave'
            ],
            [
                '#usuario_password'
            ]
        ], targetPage, { timeout, visible: true });
        const inputType = await element.evaluate(el => el.type);
        if (inputType === 'select-one') {
          await changeSelectElement(element, 'msip')
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
          await typeIntoElement(element, 'msip');
        } else {
          await changeElementValue(element, 'msip');
        }
    }
    {
        const targetPage = page;
        const promises = [];
        promises.push(targetPage.waitForNavigation());
        await scrollIntoViewIfNeeded([
            [
                'aria/Iniciar Sesión[role="button"]'
            ],
            [
                '#new_usuario > div.form-actions > input'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Iniciar Sesión[role="button"]'
            ],
            [
                '#new_usuario > div.form-actions > input'
            ]
        ], targetPage, { timeout, visible: true });
        await element.click({
          offset: {
            x: 66,
            y: 11.609375,
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
                    'text/Sesión iniciada.'
                ]
            ]
        }, frame, timeout);
    }

    //////// Tras Autenticar
    {
        const targetPage = page;
        await scrollIntoViewIfNeeded([
            [
                'aria/Administrar'
            ],
            [
                '#navbarDropdownAdministrar'
            ],
            [
                'xpath///*[@id="navbarDropdownAdministrar"]'
            ],
            [
                'pierce/#navbarDropdownAdministrar'
            ],
            [
                'text/Administrar'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Administrar'
            ],
            [
                '#navbarDropdownAdministrar'
            ],
            [
                'xpath///*[@id="navbarDropdownAdministrar"]'
            ],
            [
                'pierce/#navbarDropdownAdministrar'
            ],
            [
                'text/Administrar'
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
            ],
            [
                'li:nth-of-type(4) > a'
            ],
            [
                'xpath///*[@id="navbarSupportedContent"]/ul[2]/li[2]/ul/li[4]/a'
            ],
            [
                'pierce/li:nth-of-type(4) > a'
            ],
            [
                'text/Tablas básicas'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Tablas básicas'
            ],
            [
                'li:nth-of-type(4) > a'
            ],
            [
                'xpath///*[@id="navbarSupportedContent"]/ul[2]/li[2]/ul/li[4]/a'
            ],
            [
                'pierce/li:nth-of-type(4) > a'
            ],
            [
                'text/Tablas básicas'
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
                'aria/Departamentos/Estados'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Departamentos/Estados'
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
            ],
            [
                'xpath///*[@id="div_contenido"]/form/div[1]/div[1]/a'
            ],
            [
                'pierce/form > div:nth-of-type(1) a'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'form > div:nth-of-type(1) a'
            ],
            [
                'xpath///*[@id="div_contenido"]/form/div[1]/div[1]/a'
            ],
            [
                'pierce/form > div:nth-of-type(1) a'
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
                'div.departamento_pais span'
            ],
            [
                'text/Seleccione una'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'div.departamento_pais span'
            ],
            [
                'text/Seleccione una'
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
            ],
            [
                'pierce/li.highlighted'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'li.highlighted'
            ],
            [
                'pierce/li.highlighted'
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
                'aria/Código dentro del país'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Código dentro del país'
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
                'aria/Código dentro del país'
            ]
        ], targetPage, timeout);
        const element = await waitForSelectors([
            [
                'aria/Código dentro del país'
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
              'text/Msip::Clase eliminado.'
            ]
          ]
        }, frame, timeout);
      }


    await browser.close();


    async function waitForSelectors(selectors, frame, options) {
      for (const selector of selectors) {
        try {
          return await waitForSelector(selector, frame, options);
        } catch (err) {
          console.error(err);
        }
      }
      throw new Error('Could not find element for selectors: ' + JSON.stringify(selectors));
    }

    async function scrollIntoViewIfNeeded(selectors, frame, timeout) {
      const element = await waitForSelectors(selectors, frame, { visible: false, timeout });
      if (!element) {
        throw new Error(
          'The element could not be found.'
        );
      }
      await waitForConnected(element, timeout);
      const isInViewport = await element.isIntersectingViewport({threshold: 0});
      if (isInViewport) {
        return;
      }
      await element.evaluate(element => {
        element.scrollIntoView({
          block: 'center',
          inline: 'center',
          behavior: 'auto',
        });
      });
      await waitForInViewport(element, timeout);
    }

    async function waitForConnected(element, timeout) {
      await waitForFunction(async () => {
        return await element.getProperty('isConnected');
      }, timeout);
    }

    async function waitForInViewport(element, timeout) {
      await waitForFunction(async () => {
        return await element.isIntersectingViewport({threshold: 0});
      }, timeout);
    }

    async function waitForSelector(selector, frame, options) {
      if (!Array.isArray(selector)) {
        selector = [selector];
      }
      if (!selector.length) {
        throw new Error('Empty selector provided to waitForSelector');
      }
      let element = null;
      for (let i = 0; i < selector.length; i++) {
        const part = selector[i];
        if (element) {
          element = await element.waitForSelector(part, options);
        } else {
          element = await frame.waitForSelector(part, options);
        }
        if (!element) {
          throw new Error('Could not find element: ' + selector.join('>>'));
        }
        if (i < selector.length - 1) {
          element = (await element.evaluateHandle(el => el.shadowRoot ? el.shadowRoot : el)).asElement();
        }
      }
      if (!element) {
        throw new Error('Could not find element: ' + selector.join('|'));
      }
      return element;
    }

    async function waitForElement(step, frame, timeout) {
      const {
        count = 1,
        operator = '>=',
        visible = true,
        properties,
        attributes,
      } = step;
      const compFn = {
        '==': (a, b) => a === b,
        '>=': (a, b) => a >= b,
        '<=': (a, b) => a <= b,
      }[operator];
      await waitForFunction(async () => {
        const elements = await querySelectorsAll(step.selectors, frame);
        let result = compFn(elements.length, count);
        const elementsHandle = await frame.evaluateHandle((...elements) => {
          return elements;
        }, ...elements);
        await Promise.all(elements.map((element) => element.dispose()));
        if (result && (properties || attributes)) {
          result = await elementsHandle.evaluate(
            (elements, properties, attributes) => {
              for (const element of elements) {
                if (attributes) {
                  for (const [name, value] of Object.entries(attributes)) {
                    if (element.getAttribute(name) !== value) {
                      return false;
                    }
                  }
                }
                if (properties) {
                  if (!isDeepMatch(properties, element)) {
                    return false;
                  }
                }
              }
              return true;

              function isDeepMatch(a, b) {
                if (a === b) {
                  return true;
                }
                if ((a && !b) || (!a && b)) {
                  return false;
                }
                if (!(a instanceof Object) || !(b instanceof Object)) {
                  return false;
                }
                for (const [key, value] of Object.entries(a)) {
                  if (!isDeepMatch(value, b[key])) {
                    return false;
                  }
                }
                return true;
              }
            },
            properties,
            attributes
          );
        }
        await elementsHandle.dispose();
        return result === visible;
      }, timeout);
    }

    async function querySelectorsAll(selectors, frame) {
      for (const selector of selectors) {
        const result = await querySelectorAll(selector, frame);
        if (result.length) {
          return result;
        }
      }
      return [];
    }

    async function querySelectorAll(selector, frame) {
      if (!Array.isArray(selector)) {
        selector = [selector];
      }
      if (!selector.length) {
        throw new Error('Empty selector provided to querySelectorAll');
      }
      let elements = [];
      for (let i = 0; i < selector.length; i++) {
        const part = selector[i];
        if (i === 0) {
          elements = await frame.$$(part);
        } else {
          const tmpElements = elements;
          elements = [];
          for (const el of tmpElements) {
            elements.push(...(await el.$$(part)));
          }
        }
        if (elements.length === 0) {
          return [];
        }
        if (i < selector.length - 1) {
          const tmpElements = [];
          for (const el of elements) {
            const newEl = (await el.evaluateHandle(el => el.shadowRoot ? el.shadowRoot : el)).asElement();
            if (newEl) {
              tmpElements.push(newEl);
            }
          }
          elements = tmpElements;
        }
      }
      return elements;
    }

    async function waitForFunction(fn, timeout) {
      let isActive = true;
      const timeoutId = setTimeout(() => {
        isActive = false;
      }, timeout);
      while (isActive) {
        const result = await fn();
        if (result) {
          clearTimeout(timeoutId);
          return;
        }
        await new Promise(resolve => setTimeout(resolve, 100));
      }
      throw new Error('Timed out');
    }

    async function changeSelectElement(element, value) {
      await element.select(value);
      await element.evaluateHandle((e) => {
        e.blur();
        e.focus();
      });
    }

    async function changeElementValue(element, value) {
      await element.focus();
      await element.evaluate((input, value) => {
        input.value = value;
        input.dispatchEvent(new Event('input', { bubbles: true }));
        input.dispatchEvent(new Event('change', { bubbles: true }));
      }, value);
    }

    async function typeIntoElement(element, value) {
      const textToType = await element.evaluate((input, newValue) => {
        if (
          newValue.length <= input.value.length ||
          !newValue.startsWith(input.value)
        ) {
          input.value = '';
          return newValue;
        }
        const originalValue = input.value;
        input.value = '';
        input.value = originalValue;
        return newValue.substring(originalValue.length);
      }, value);
      await element.type(textToType);
    }
})().catch(err => {
    console.error(err);
    process.exit(1);
});
