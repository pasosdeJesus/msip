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
    offsetY: 33,
    offsetX: 54.953125,
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
    offsetY: 8,
    offsetX: 70.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Tipos de organización social'
      ],
      [
        'li:nth-of-type(16) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[16]/a'
      ],
      [
        'pierce/li:nth-of-type(16) > a'
      ],
      [
        'text/Tipos de organización'
      ]
    ],
    offsetY: 13,
    offsetX: 179.5,
  });
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
    offsetY: 347,
    offsetX: 79,
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
    offsetY: 13,
    offsetX: 19.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/tiposorg/nueva.%23%3CMsip::Tipoorg::ActiveRecord_Relation:0x00000f66f98e69c0%3E',
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
        '#tipoorg_nombre'
      ],
      [
        'xpath///*[@id="tipoorg_nombre"]'
      ],
      [
        'pierce/#tipoorg_nombre'
      ]
    ],
    offsetY: 26,
    offsetX: 239,
  });
  await runner.runStep({
    type: 'change',
    value: 'torgx',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#tipoorg_nombre'
      ],
      [
        'xpath///*[@id="tipoorg_nombre"]'
      ],
      [
        'pierce/#tipoorg_nombre'
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
    value: 'torgx',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#tipoorg_observaciones'
      ],
      [
        'xpath///*[@id="tipoorg_observaciones"]'
      ],
      [
        'pierce/#tipoorg_observaciones'
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
        'xpath///*[@id="new_tipoorg"]/div[6]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 31,
    offsetX: 36,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/tiposorg/101',
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
      offsetY: 21,
      offsetX: 74.25,
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
