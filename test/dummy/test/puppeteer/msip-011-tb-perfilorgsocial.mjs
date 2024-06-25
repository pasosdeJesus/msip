
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
        offsetY: 35,
        offsetX: 29.953125,
    });
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
        offsetY: 3,
        offsetX: 58.953125,
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Perfiles en organización social'
            ],
            [
                'li:nth-of-type(11) > a'
            ],
            [
                'xpath///*[@id="div_contenido"]/article/ul/li[11]/a'
            ],
            [
                'pierce/li:nth-of-type(11) > a'
            ],
            [
                'text/Perfiles en organización'
            ]
        ],
        offsetY: 11,
        offsetX: 151.5,
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/DIRECTIVO/A DE LA ORGANIZACIÓN'
            ],
            [
                'tr:nth-of-type(1) > td:nth-of-type(2)'
            ],
            [
                'xpath///*[@id="div_contenido"]/form/table/tbody/tr[1]/td[2]'
            ],
            [
                'pierce/tr:nth-of-type(1) > td:nth-of-type(2)'
            ],
            [
                'text/DIRECTIVO/A DE'
            ]
        ],
        offsetY: 35.5,
        offsetX: 111.5,
    });
    await runner.runStep({
        type: 'keyDown',
        target: 'main',
        key: ' '
    });
    await runner.runStep({
        type: 'keyUp',
        key: ' ',
        target: 'main'
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Nuevo'
            ],
            [
                'div:nth-of-type(2) a'
            ],
            [
                'xpath///*[@id="div_contenido"]/form/div[2]/div[2]/a'
            ],
            [
                'pierce/div:nth-of-type(2) a'
            ],
            [
                'text/Nuevo'
            ]
        ],
        offsetY: 31,
        offsetX: 42.5,
        assertedEvents: [
            {
                type: 'navigation',
                url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/perfilesorgsocial/nueva.%23%3CMsip::Perfilorgsocial::ActiveRecord_Relation:0x00000f6742101b80%3E',
                title: ''
            }
        ]
    });
    await runner.runStep({
        type: 'click',
        target: 'main',
        selectors: [
            [
                'aria/Nombre *'
            ],
            [
                '#perfilorgsocial_nombre'
            ],
            [
                'xpath///*[@id="perfilorgsocial_nombre"]'
            ],
            [
                'pierce/#perfilorgsocial_nombre'
            ]
        ],
        offsetY: 30,
        offsetX: 211,
    });
    await runner.runStep({
        type: 'change',
        value: 'perfx',
        selectors: [
            [
                'aria/Nombre *'
            ],
            [
                '#perfilorgsocial_nombre'
            ],
            [
                'xpath///*[@id="perfilorgsocial_nombre"]'
            ],
            [
                'pierce/#perfilorgsocial_nombre'
            ]
        ],
        target: 'main'
    });
    await runner.runStep({
        type: 'keyDown',
        target: 'main',
        key: 'Tab'
    });
    await runner.runStep({
        type: 'keyUp',
        key: 'Tab',
        target: 'main'
    });
    await runner.runStep({
        type: 'change',
        value: 'perfx',
        selectors: [
            [
                'aria/Observaciones'
            ],
            [
                '#perfilorgsocial_observaciones'
            ],
            [
                'xpath///*[@id="perfilorgsocial_observaciones"]'
            ],
            [
                'pierce/#perfilorgsocial_observaciones'
            ]
        ],
        target: 'main'
    });
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
                'xpath///*[@id="new_perfilorgsocial"]/div[6]/input'
            ],
            [
                'pierce/div.form-actions > input'
            ],
            [
                'text/Crear'
            ]
        ],
        offsetY: 15,
        offsetX: 24,
        assertedEvents: [
            {
                type: 'navigation',
                url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/perfilesorgsocial/101',
                title: ''
            }
        ]
    });

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
                'xpath///*[@id="div_contenido"]/div[5]/a[3]'
            ],
            [
                'pierce/a.btn-danger'
            ],
            [
                'text/Eliminar'
            ]
        ],
        offsetY: 28,
        offsetX: 63.25,
    });

  }
  await runner.runStep({
    type: 'waitForElement',
    assertedEvents: [
      {
        type: 'navigation',
        url: '',
        title: 'Msip::Estadosol eliminado.'
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

  const tiempofin = performance.now();
  console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
