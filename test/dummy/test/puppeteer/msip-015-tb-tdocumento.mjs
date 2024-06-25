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
    offsetY: 17,
    offsetX: 28.953125,
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
    offsetY: 13,
    offsetX: 68.953125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Tipos de documentos de identidad'
      ],
      [
        'li:nth-of-type(15) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[15]/a'
      ],
      [
        'pierce/li:nth-of-type(15) > a'
      ],
      [
        'text/Tipos de documentos'
      ]
    ],
    offsetY: 12,
    offsetX: 218.5,
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
    offsetY: 12,
    offsetX: 51.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/tdocumentos/nueva.%23%3CMsip::Tdocumento::ActiveRecord_Relation:0x00000f66db9b51f8%3E',
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
        '#tdocumento_nombre'
      ],
      [
        'xpath///*[@id="tdocumento_nombre"]'
      ],
      [
        'pierce/#tdocumento_nombre'
      ]
    ],
    offsetY: 27,
    offsetX: 144.5,
  });
  await runner.runStep({
    type: 'change',
    value: 'tdx',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#tdocumento_nombre'
      ],
      [
        'xpath///*[@id="tdocumento_nombre"]'
      ],
      [
        'pierce/#tdocumento_nombre'
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
    value: 'tdx',
    selectors: [
      [
        'aria/Sigla *'
      ],
      [
        '#tdocumento_sigla'
      ],
      [
        'xpath///*[@id="tdocumento_sigla"]'
      ],
      [
        'pierce/#tdocumento_sigla'
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
    value: '.*',
    selectors: [
      [
        'aria/Formato (exp. reg)'
      ],
      [
        '#tdocumento_formatoregex'
      ],
      [
        'xpath///*[@id="tdocumento_formatoregex"]'
      ],
      [
        'pierce/#tdocumento_formatoregex'
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
    type: 'keyDown',
    target: 'main',
    key: 'Control'
  });
  await runner.runStep({
    type: 'keyUp',
    key: 'Control',
    target: 'main'
  });
  await runner.runStep({
    type: 'change',
    value: 'tdx',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#tdocumento_observaciones'
      ],
      [
        'xpath///*[@id="tdocumento_observaciones"]'
      ],
      [
        'pierce/#tdocumento_observaciones'
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
    value: 'tdx',
    selectors: [
      [
        'aria/Ayuda'
      ],
      [
        '#tdocumento_ayuda'
      ],
      [
        'xpath///*[@id="tdocumento_ayuda"]'
      ],
      [
        'pierce/#tdocumento_ayuda'
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
        'body'
      ],
      [
        'xpath//html/body'
      ],
      [
        'pierce/body'
      ]
    ],
    offsetY: 464,
    offsetX: 63,
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
        'aria/Crear'
      ],
      [
        'div.form-actions > input'
      ],
      [
        'xpath///*[@id="new_tdocumento"]/div[9]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 20,
    offsetX: 39.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/tdocumentos/101',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'dl'
      ],
      [
        'xpath///*[@id="div_contenido"]/dl'
      ],
      [
        'pierce/dl'
      ]
    ],
    offsetY: 110,
    offsetX: 206.5,
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
      offsetY: 8,
      offsetX: 48.75,
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
