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
    offsetY: 20,
    offsetX: 45.453125,
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
    offsetY: 21,
    offsetX: 128.453125,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/[role="article"]',
        'aria/[role="list"]'
      ],
      [
        '#div_contenido ul'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul'
      ],
      [
        'pierce/#div_contenido ul'
      ]
    ],
    offsetY: 227,
    offsetX: 22.5,
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Países'
      ],
      [
        'li:nth-of-type(10) > a'
      ],
      [
        'xpath///*[@id="div_contenido"]/article/ul/li[10]/a'
      ],
      [
        'pierce/li:nth-of-type(10) > a'
      ],
      [
        'text/Países'
      ]
    ],
    offsetY: 9,
    offsetX: 2.5,
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
    offsetY: 21,
    offsetX: 60.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/paises/nueva.%23%3CMsip::Pais::ActiveRecord_Relation:0x00000f6634332d00%3E',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'aria/Id *'
      ],
      [
        '#pais_id'
      ],
      [
        'xpath///*[@id="pais_id"]'
      ],
      [
        'pierce/#pais_id'
      ]
    ],
    offsetY: 14,
    offsetX: 129.5,
  });
  await runner.runStep({
    type: 'change',
    value: '10000',
    selectors: [
      [
        'aria/Id *'
      ],
      [
        '#pais_id'
      ],
      [
        'xpath///*[@id="pais_id"]'
      ],
      [
        'pierce/#pais_id'
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
    value: 'paix',
    selectors: [
      [
        'aria/Nombre *'
      ],
      [
        '#pais_nombre'
      ],
      [
        'xpath///*[@id="pais_nombre"]'
      ],
      [
        'pierce/#pais_nombre'
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
    value: 'paix',
    selectors: [
      [
        'aria/Nombre ISO en español *'
      ],
      [
        '#pais_nombreiso_espanol'
      ],
      [
        'xpath///*[@id="pais_nombreiso_espanol"]'
      ],
      [
        'pierce/#pais_nombreiso_espanol'
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
    type: 'change',
    value: 'px',
    selectors: [
      [
        'aria/Código ISO de 2 letras'
      ],
      [
        '#pais_alfa2'
      ],
      [
        'xpath///*[@id="pais_alfa2"]'
      ],
      [
        'pierce/#pais_alfa2'
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
    value: 'pax',
    selectors: [
      [
        'aria/Código ISO de 3 letras'
      ],
      [
        '#pais_alfa3'
      ],
      [
        'xpath///*[@id="pais_alfa3"]'
      ],
      [
        'pierce/#pais_alfa3'
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
    value: '10000',
    selectors: [
      [
        'aria/Código ISO numérico'
      ],
      [
        '#pais_codiso'
      ],
      [
        'xpath///*[@id="pais_codiso"]'
      ],
      [
        'pierce/#pais_codiso'
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
    value: 'paix',
    selectors: [
      [
        'aria/Nombre ISO en inglés'
      ],
      [
        '#pais_nombreiso_ingles'
      ],
      [
        'xpath///*[@id="pais_nombreiso_ingles"]'
      ],
      [
        'pierce/#pais_nombreiso_ingles'
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
    value: 'paix',
    selectors: [
      [
        'aria/Nombre ISO en francés'
      ],
      [
        '#pais_nombreiso_frances'
      ],
      [
        'xpath///*[@id="pais_nombreiso_frances"]'
      ],
      [
        'pierce/#pais_nombreiso_frances'
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
    value: 'd',
    selectors: [
      [
        'aria/Primera división política (e.g Departamento o Estado)'
      ],
      [
        '#pais_div1'
      ],
      [
        'xpath///*[@id="pais_div1"]'
      ],
      [
        'pierce/#pais_div1'
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
    value: 'm',
    selectors: [
      [
        'aria/Segunda división política (e.g Municipio o Condado)'
      ],
      [
        '#pais_div2'
      ],
      [
        'xpath///*[@id="pais_div2"]'
      ],
      [
        'pierce/#pais_div2'
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
    value: 'c',
    selectors: [
      [
        'aria/Tercer división política (e.g Centro poblado)'
      ],
      [
        '#pais_div3'
      ],
      [
        'xpath///*[@id="pais_div3"]'
      ],
      [
        'pierce/#pais_div3'
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
    value: 'obs',
    selectors: [
      [
        'aria/Observaciones'
      ],
      [
        '#pais_observaciones'
      ],
      [
        'xpath///*[@id="pais_observaciones"]'
      ],
      [
        'pierce/#pais_observaciones'
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
        'xpath///*[@id="new_pais"]/div[20]/input'
      ],
      [
        'pierce/div.form-actions > input'
      ],
      [
        'text/Crear'
      ]
    ],
    offsetY: 15,
    offsetX: 18.5,
    assertedEvents: [
      {
        type: 'navigation',
        url: 'http://nuevo.nocheyniebla.org:4300/msip_2_2/admin/paises/10000',
        title: ''
      }
    ]
  });
  await runner.runStep({
    type: 'click',
    target: 'main',
    selectors: [
      [
        'dd:nth-of-type(4)'
      ],
      [
        'xpath///*[@id="div_contenido"]/dl/dd[4]'
      ],
      [
        'pierce/dd:nth-of-type(4)'
      ],
      [
        'text/px'
      ]
    ],
    offsetY: 7,
    offsetX: 93.5,
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
      offsetY: 13,
      offsetX: 56.75,
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
