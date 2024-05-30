import {
  preparar,
  prepararYAutenticarDeAmbiente,
  terminar
} from "@pasosdeJesus/pruebas_puppeteer"


(async () => {

  const tiempoini = performance.now()

  let timeout = 5000
  let urlini, runner, browser, page
  [urlini, runner, browser, page] = await prepararYAutenticarDeAmbiente(timeout, preparar)

  await terminar(runner)

  const tiempofin = performance.now()
  process.env.TIEMPO_EJECUCION=tiempofin - tiempoini
  console.log(`Tiempo de ejecución: ${process.env.TIEMPO_EJECUCION} ms`)
})().catch(err => {
  console.error(err)
  process.exit(1)
})
