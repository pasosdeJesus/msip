import puppeteer from "puppeteer-core";
import { getDocument, queries } from "pptr-testing-library";


describe("Iniciar Sesión", () => {
  let browser;
  let page;

  const verificarValor = async (selector, valorEsperado) => {
    // Nos ha ocurrido esporádicamente que al usar
    // pelem presenta el error 
    // Execution context was destroyed, most likely because of a navigation.
    // ¿Tal vez por eso se prefiera selector?
    let pelem = await page.waitForSelector(selector);
    const valor = await pelem.$eval("xpath/self::node()", e => e.value);
    expect(valor).toBe(valorEsperado);
  }

  const verificarContieneTexto = async (selector, textoEsperado) => {
    let pelem = await page.waitForSelector(selector);
    const texto = await pelem.$eval("xpath/self::node()", c => c.innerText);
    expect(texto).toContain(textoEsperado);
  }


  beforeAll(async () => {
    browser = await puppeteer.launch({
          executablePath: '/usr/local/bin/chrome',
          defaultViewport: { width: 1240, height: 800},
          headless: true
        });

    page = await browser.newPage();
  });

  it("Contiene titulo msip", async () => {
    await page.goto("http://127.0.0.1:3000/msip/");
    verificarContieneTexto(".navbar-brand", 'msip');
  });

  it("Iniciar sesión", async () => {
    await page.goto("http://127.0.0.1:3000/msip/");
    const doc = await getDocument(page);

    const iniciar = await queries.getByRole(doc, 'link', 
      {name: 'Iniciar Sesión'})
    await iniciar.click()
    await page.screenshot({path: '/tmp/m.png'})

    //const usuario = await queries.getByRole(doc, 'textbox', 
    //  {name: 'Usuario' });
    const usuario = await page.waitForSelector("#usuario_nusuario");
    await usuario.type('msip');
    //await verificarValor(usuario, 'msip')
    //const clave = await queries.getByRole(doc, 'textbox', 
    //  {name: 'Clave' });
    const clave = await page.waitForSelector("#usuario_password");
    // Por extraño motivo no se logró agarrar campo para clave con
    // queries.getByRole
    await clave.type('msip');
    //await verificarValor(clave, 'msip')

    const enviar = await queries.getByRole(doc, 'button', 
      {name: 'Iniciar Sesión' });
    await enviar.click();

    await verificarContieneTexto(".alert", 'Sesión iniciada.')

  });


  afterAll(() => browser.close());
  // Pueden ocurrir al final falla ProtocolError: Protocol error (Runtime.callFunctionOn): Target closed.
  // si se olvida el await en alguna de las funciones async
});
