import {
  preparar,
  prepararYAutenticarDeAmbiente,
  terminar
} from "@pasosdeJesus/pruebas_puppeteer"

(async () => {

  const tiempoini = performance.now()

  let timeout = 15000
  let urlini, runner, browser, page
  [urlini, runner, browser, page] = await prepararYAutenticarDeAmbiente(timeout, preparar)

    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
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
        ],
        offsetY: 14,
        offsetX: 54.453125,
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
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
        ],
        offsetY: 5,
        offsetX: 55.453125,
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Centros poblados'
            ],
            [
                '#div_contenido li:nth-of-type(1) > a'
            ],
            [
                'xpath///*[@id="div_contenido"]/article/ul/li[1]/a'
            ],
            [
                'pierce/#div_contenido li:nth-of-type(1) > a'
            ],
            [
                'text/Centros poblados'
            ]
        ],
        offsetY: 10,
        offsetX: 111.5,
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'form > div:nth-of-type(1) a'
            ],
            [
                'xpath///*[@id="div_contenido"]/form/div[1]/div[1]/a'
            ],
            [
                'pierce/form > div:nth-of-type(1) a'
            ]
        ],
        offsetY: 8,
        offsetX: 31.5,
        assertedEvents: [
            {
                type: 'navigation',
                url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/centrospoblados/nueva.%23%3CMsip::Centropoblado::ActiveRecord_Relation:0x000008ae6f8f2e58%3E',
                title: ''
            }
        ]
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Nombre *'
            ],
            [
                '#centropoblado_nombre'
            ],
            [
                'xpath///*[@id="centropoblado_nombre"]'
            ],
            [
                'pierce/#centropoblado_nombre'
            ]
        ],
        offsetY: 23,
        offsetX: 204.5,
    })
    await runner.runStep({
        type: 'change',
        value: 'aaa',
        selectors: [
            [
                'aria/Nombre *'
            ],
            [
                '#centropoblado_nombre'
            ],
            [
                'xpath///*[@id="centropoblado_nombre"]'
            ],
            [
                'pierce/#centropoblado_nombre'
            ]
        ],
        target: 'main'
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Municipio *'
            ],
            [
                '#centropoblado_municipio_id-ts-control'
            ],
            [
                'xpath///*[@id="centropoblado_municipio_id-ts-control"]'
            ],
            [
                'pierce/#centropoblado_municipio_id-ts-control'
            ]
        ],
        offsetY: 9,
        offsetX: 101.5,
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Abejorral / Antioquia'
            ],
            [
                '#centropoblado_municipio_id-opt-1'
            ],
            [
                'xpath///*[@id="centropoblado_municipio_id-opt-1"]'
            ],
            [
                'pierce/#centropoblado_municipio_id-opt-1'
            ]
        ],
        offsetY: 22,
        offsetX: 114.5,
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Código dentro del municipio'
            ],
            [
                '#centropoblado_cplocal_cod'
            ],
            [
                'xpath///*[@id="centropoblado_cplocal_cod"]'
            ],
            [
                'pierce/#centropoblado_cplocal_cod'
            ]
        ],
        offsetY: 20,
        offsetX: 106.5,
    })
    await runner.runStep({
        type: 'change',
        value: '999',
        selectors: [
            [
                'aria/Código dentro del municipio'
            ],
            [
                '#centropoblado_cplocal_cod'
            ],
            [
                'xpath///*[@id="centropoblado_cplocal_cod"]'
            ],
            [
                'pierce/#centropoblado_cplocal_cod'
            ]
        ],
        target: 'main'
    })
    await runner.runStep({
        type: 'keyDown',
        target: 'main',
        key: 'Tab'
    })
    await runner.runStep({
        type: 'keyUp',
        key: 'Tab',
        target: 'main'
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'body'
            ],
            [
                'xpath//html/body'
            ],
            [
                'pierce/body'
            ]
        ],
        offsetY: 383,
        offsetX: 9,
    })
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Crear'
            ],
            [
                'div.form-actions > input'
            ],
            [
                'xpath///*[@id="new_centropoblado"]/div[11]/input'
            ],
            [
                'pierce/div.form-actions > input'
            ],
            [
                'text/Crear'
            ]
        ],
        offsetY: 16,
        offsetX: 21.5,
        assertedEvents: [
            {
                type: 'navigation',
                url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/centrospoblados/1000001',
                title: ''
            }
        ]
    })

   {
    const targetPage = page
    const promises = []; 
    promises.push(targetPage.waitForNavigation())

    targetPage.on('dialog', async dialog => {
      console.log(dialog.message())
      await dialog.accept(); //dismiss()
    })

    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Eliminar'
            ],
            [
                'a.btn-danger'
            ],
            [
                'xpath/*[@id="div_contenido"]/div[5]/a[3]'
            ],
            [
                'pierce/a.btn-danger'
            ],
            [
                'text/Eliminar'
            ]
        ],
        offsetY: 10,
        offsetX: 65.75,
    })
   }

    await runner.runStep({
        type: 'waitForElement',
        assertedEvents: [
            {
                type: 'navigation',
                url: '',
                title: 'Msip::Centropoblado eliminado.'
            }
        ],
        target: 'main',
        selectors: [
            'div.alert',
            'xpath/*[@id="div_contenido"]/div[2]',
            'pierce/div.alert'
        ]
    })

  await terminar(runner)

  const tiempofin = performance.now()
  console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`)
})().catch(err => {
  console.error(err)
  process.exit(1)
})
