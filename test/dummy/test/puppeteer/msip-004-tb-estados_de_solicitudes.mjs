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
    offsetY: 30,
    offsetX: 44.953125,
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
    offsetY: 15,
    offsetX: 92.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Estados de solicitudes'
      ],
      [
        '#div_contenido li:nth-of-type(3) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[3]/a'
      ],
      [
        'pierce/#div_contenido li:nth-of-type(3) > a'
      ],
      [
        'text/Estados de solicitudes'
      ]
    ],
    offsetY: 9,
    offsetX: 131.5,
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
    offsetY: 19,
    offsetX: 31.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/estadossol/nueva.%23%3CMsip::Estadosol::ActiveRecord_Relation:0x00000892865a4300%3E',
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
        '#estadosol_nombre'
      ],
      [
        'xpath///*[@id="estadosol_nombre"]'
      ],
      [
        'pierce/#estadosol_nombre'
      ]
    ],
    offsetY: 14,
    offsetX: 138.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'x',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#estadosol_nombre'
      ],
      [
        'xpath///*[@id="estadosol_nombre"]'
      ],
      [
        'pierce/#estadosol_nombre'
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
    value: 'x',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#estadosol_observaciones'
      ],
      [
        'xpath///*[@id="estadosol_observaciones"]'
      ],
      [
        'pierce/#estadosol_observaciones'
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
        'xpath///*[@id="new_estadosol"]/div[6]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 22,
    offsetX: 41.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/estadossol/101',
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
      offsetY: 26,
      offsetX: 64.75,
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

  await runner.runStep({
    type: 'keyDown',
    target: 'main',
    key: 'Alt'
  });


  await terminar(runner)

  const tiempofin = performance.now();
  console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
