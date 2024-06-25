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
    offsetY: 27,
    offsetX: 21.953125,
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
    offsetY: 7,
    offsetX: 82.953125,
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
        'aria/Veredas'
      ],
      [
        'li:nth-of-type(21) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[21]/a'
      ],
      [
        'pierce/li:nth-of-type(21) > a'
      ],
      [
        'text/Veredas'
      ]
    ],
    offsetY: 8,
    offsetX: 47.5,
  });
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
    offsetY: 24,
    offsetX: 46.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/veredas/nueva.%23%3CMsip::Vereda::ActiveRecord_Relation:0x00000f66515ee068%3E',
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
        '#vereda_nombre'
      ],
      [
        'xpath///*[@id="vereda_nombre"]'
      ],
      [
        'pierce/#vereda_nombre'
      ]
    ],
    offsetY: 35,
    offsetX: 196.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'verx',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#vereda_nombre'
      ],
      [
        'xpath///*[@id="vereda_nombre"]'
      ],
      [
        'pierce/#vereda_nombre'
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
        'aria/Ábrego / Norte de Santander'
      ],
      [
        '#vereda_municipio_id-opt-1'
      ],
      [
        'xpath///*[@id="vereda_municipio_id-opt-1"]'
      ],
      [
        'pierce/#vereda_municipio_id-opt-1'
      ]
    ],
    offsetY: 7,
    offsetX: 177.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Código dentro del municipio'
      ],
      [
        '#vereda_verlocal_id'
      ],
      [
        'xpath///*[@id="vereda_verlocal_id"]'
      ],
      [
        'pierce/#vereda_verlocal_id'
      ]
    ],
    offsetY: 18,
    offsetX: 106.5,
  });
  await runner.runStep({
    type: 'change',
    value: '10000',
    selectors: [
      [
        'aria/Código dentro del municipio'
      ],
      [
        '#vereda_verlocal_id'
      ],
      [
        'xpath///*[@id="vereda_verlocal_id"]'
      ],
      [
        'pierce/#vereda_verlocal_id'
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
    value: '1',
    selectors: [
      [
        'aria/Latitud'
      ],
      [
        '#vereda_latitud'
      ],
      [
        'xpath///*[@id="vereda_latitud"]'
      ],
      [
        'pierce/#vereda_latitud'
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
    value: '1',
    selectors: [
      [
        'aria/Longitud'
      ],
      [
        '#vereda_longitud'
      ],
      [
        'xpath///*[@id="vereda_longitud"]'
      ],
      [
        'pierce/#vereda_longitud'
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
    value: 'verx',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#vereda_observaciones'
      ],
      [
        'xpath///*[@id="vereda_observaciones"]'
      ],
      [
        'pierce/#vereda_observaciones'
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
        'xpath///*[@id="new_vereda"]/div[10]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 15,
    offsetX: 44.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/veredas/1000001',
        title: ''
      }
    ]
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
        'aria/[role="contentinfo"]',
        'aria/[role="paragraph"]'
      ],
      [
        'p'
      ],
      [
        'xpath//html/body/footer/p'
      ],
      [
        'pierce/p'
      ]
    ],
    offsetY: 0,
    offsetX: 343,
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
      offsetY: 27,
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

  await terminar(runner)

  const tiempofin = performance.now();
  console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
  console.error(err);
  process.exit(1);
});
