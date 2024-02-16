import fs from "fs";
import dotenv from "dotenv";
import puppeteer from "puppeteer-core";
import puppeteerd from "puppeteer";


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
    if (fs.existsSync("/usr/local/bin/chrome")) {
      console.log("Corriendo en OpenBSD")
      browser = await puppeteer.launch({
        executablePath: '/usr/local/bin/chrome',
        defaultViewport: { width: 1240, height: 800},
        headless: sincabeza 
      });
    } else if (fs.existsSync("/usr/bin/chromium-browser")) {
      browser = await puppeteer.launch({
        executablePath: '/usr/bin/chromium-browser',
        defaultViewport: { width: 1240, height: 800},
        headless: sincabeza,
        devtools: true
      });
    } else if (fs.existsSync("/bin/chromium-browser")) {
      browser = await puppeteer.launch({
        executablePath: '/bin/chromium-browser',
        defaultViewport: { width: 1240, height: 800},
        headless: sincabeza,
        devtools: true
      });
    } else {
      throw "No se encontró navegador";
    }
  }
  //console.log("browser=", browser);

  const page = await browser.newPage();
  page.setDefaultTimeout(timeout);
  {
    const targetPage = page;
    await targetPage.setViewport({
      width: 1292,
      height: 636
    })
  }
  //console.log("page=", page);
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await targetPage.goto(maq + rutainicial);
    await Promise.all(promises);
  }

  return [maq, browser, page];
}


export async function autenticar(page, timeout, usuario, clave) {
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
      await changeSelectElement(element, usuario)
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
      await typeIntoElement(element, usuario);
    } else {
      await changeElementValue(element, usuario);
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
      await changeSelectElement(element, clave)
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
      await typeIntoElement(element, clave);
    } else {
      await changeElementValue(element, clave);
    }
  }
  {
    const targetPage = page;
    const promises = [];
    promises.push(targetPage.waitForNavigation());
    await scrollIntoViewIfNeeded([
      [
        'aria/Iniciar Sesión[role="button"]'
      ]
    ], targetPage, timeout);
    const element = await waitForSelectors([
      [
        'aria/Iniciar Sesión[role="button"]'
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
}

export async function waitForSelectors(selectors, frame, options) {
  for (const selector of selectors) {
    try {
      return await waitForSelector(selector, frame, options);
    } catch (err) {
      console.error(err);
    }
  }
  throw new Error('Could not find element for selectors: ' + JSON.stringify(selectors));
}

export async function scrollIntoViewIfNeeded(selectors, frame, timeout) {
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

export async function waitForConnected(element, timeout) {
  await waitForFunction(async () => {
    return await element.getProperty('isConnected');
  }, timeout);
}

export async function waitForInViewport(element, timeout) {
  await waitForFunction(async () => {
    return await element.isIntersectingViewport({threshold: 0});
  }, timeout);
}

export async function waitForSelector(selector, frame, options) {
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

export async function waitForElement(step, frame, timeout) {
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

export async function querySelectorsAll(selectors, frame) {
  for (const selector of selectors) {
    const result = await querySelectorAll(selector, frame);
    if (result.length) {
      return result;
    }
  }
  return [];
}

export async function querySelectorAll(selector, frame) {
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

export async function waitForFunction(fn, timeout) {
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

export async function changeSelectElement(element, value) {
  await element.select(value);
  await element.evaluateHandle((e) => {
    e.blur();
    e.focus();
  });
}

export async function changeElementValue(element, value) {
  await element.focus();
  await element.evaluate((input, value) => {
    input.value = value;
    input.dispatchEvent(new Event('input', { bubbles: true }));
    input.dispatchEvent(new Event('change', { bubbles: true }));
  }, value);
}

export async function typeIntoElement(element, value) {
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


export async function prepararYAutenticarDeAmbiente(timeout = 5000, 
  rutaAmbiente = '../../.env') {
  dotenv.config({ path: rutaAmbiente });

  const rutaRelativa = typeof process != "undefined" &&
    typeof process.env.RUTA_RELATIVA != "undefined" ?
    process.env.RUTA_RELATIVA : '/msip';

  const usuarioAdminPrueba = typeof process != "undefined" &&
    typeof process.env.USUARIO_ADMIN_PRUEBA != "undefined" ?
    process.env.USUARIO_ADMIN_PRUEBA : 'msip';

  const claveAdminPrueba = typeof process != "undefined" &&
    typeof process.env.CLAVE_ADMIN_PRUEBA != "undefined" ?
    process.env.CLAVE_ADMIN_PRUEBA : 'msip';

  let urlini, browser, page;
  [urlini, browser, page] = await preparar(timeout, rutaRelativa);

  await autenticar(page, timeout, usuarioAdminPrueba, claveAdminPrueba);

  return [urlini, browser, page];
}

