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

	page.on('dialog', async dialog => {
		console.log(dialog.message())
		await dialog.accept(); 
	})

	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Personas'
			],
			[
				'#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(2) > a'
			],
			[
				'xpath///*[@id="navbarSupportedContent"]/ul[1]/li[2]/a'
			],
			[
				'pierce/#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(2) > a'
			],
			[
				'text/Personas'
			]
		],
		offsetY: 25,
		offsetX: 28.96875,
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
		offsetY: 6,
		offsetX: 56,
		assertedEvents: [
			{
				type: 'navigation',
				url: 'http://rbd.nocheyniebla.org:4400/msip_2_2/personas/nueva.%23%3CMsip::Persona::ActiveRecord_Relation:0x000004f2619e8998%3E',
				title: ''
			}
		]
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Nombres *'
			],
			[
				'#persona_nombres'
			],
			[
				'xpath///*[@id="persona_nombres"]'
			],
			[
				'pierce/#persona_nombres'
			]
		],
		offsetY: 26,
		offsetX: 127,
	});
	await runner.runStep({
		type: 'change',
		value: 'AL',
		selectors: [
			[
				'aria/Nombres *'
			],
			[
				'#persona_nombres'
			],
			[
				'xpath///*[@id="persona_nombres"]'
			],
			[
				'pierce/#persona_nombres'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'keyUp',
		key: 'l',
		target: 'main'
	});
	await runner.runStep({
		type: 'change',
		value: 'Alejandro',
		selectors: [
			[
				'aria/Nombres *'
			],
			[
				'#persona_nombres'
			],
			[
				'xpath///*[@id="persona_nombres"]'
			],
			[
				'pierce/#persona_nombres'
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
		value: 'C',
		selectors: [
			[
				'aria/Apellidos *'
			],
			[
				'#persona_apellidos'
			],
			[
				'xpath///*[@id="persona_apellidos"]'
			],
			[
				'pierce/#persona_apellidos'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'keyUp',
		key: 'c',
		target: 'main'
	});
	await runner.runStep({
		type: 'change',
		value: 'Cruz',
		selectors: [
			[
				'aria/Apellidos *'
			],
			[
				'#persona_apellidos'
			],
			[
				'xpath///*[@id="persona_apellidos"]'
			],
			[
				'pierce/#persona_apellidos'
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
		value: '1900',
		selectors: [
			[
				'aria/Año nacimiento'
			],
			[
				'#persona_anionac'
			],
			[
				'xpath///*[@id="persona_anionac"]'
			],
			[
				'pierce/#persona_anionac'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'keyDown',
		target: 'main',
		key: '9'
	});
	await runner.runStep({
		type: 'keyUp',
		key: '9',
		target: 'main'
	});
	await runner.runStep({
		type: 'change',
		value: '1994',
		selectors: [
			[
				'aria/Año nacimiento'
			],
			[
				'#persona_anionac'
			],
			[
				'xpath///*[@id="persona_anionac"]'
			],
			[
				'pierce/#persona_anionac'
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
		value: '4',
		selectors: [
			[
				'aria/Mes nacimiento'
			],
			[
				'#persona_mesnac'
			],
			[
				'xpath///*[@id="persona_mesnac"]'
			],
			[
				'pierce/#persona_mesnac'
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
		value: '16',
		selectors: [
			[
				'aria/Día nacimiento'
			],
			[
				'#persona_dianac'
			],
			[
				'xpath///*[@id="persona_dianac"]'
			],
			[
				'pierce/#persona_dianac'
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
		value: 'M',
		selectors: [
			[
				'aria/Sexo *'
			],
			[
				'#persona_sexo'
			],
			[
				'xpath///*[@id="persona_sexo"]'
			],
			[
				'pierce/#persona_sexo'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'div.ts-control > div'
			],
			[
				'xpath///*[@id="new_persona"]/div[9]/div/div[1]/div'
			],
			[
				'pierce/div.ts-control > div'
			]
		],
		offsetY: 4,
		offsetX: 82,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/ACHAGUA'
			],
			[
				'#persona_etnia_id-opt-1'
			],
			[
				'xpath///*[@id="persona_etnia_id-opt-1"]'
			],
			[
				'pierce/#persona_etnia_id-opt-1'
			]
		],
		offsetY: 19,
		offsetX: 79,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/País nacimiento'
			],
			[
				'#persona_pais_id-ts-control'
			],
			[
				'xpath///*[@id="persona_pais_id-ts-control"]'
			],
			[
				'pierce/#persona_pais_id-ts-control'
			]
		],
		offsetY: 13,
		offsetX: 68,
	});
	await runner.runStep({
		type: 'change',
		value: 'COlo',
		selectors: [
			[
				'aria/País nacimiento[role="combobox"]'
			],
			[
				'#persona_pais_id-ts-control'
			],
			[
				'xpath///*[@id="persona_pais_id-ts-control"]'
			],
			[
				'pierce/#persona_pais_id-ts-control'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Colombia'
			],
			[
				'#persona_pais_id-opt-48'
			],
			[
				'xpath///*[@id="persona_pais_id-opt-48"]'
			],
			[
				'pierce/#persona_pais_id-opt-48'
			]
		],
		offsetY: 4,
		offsetX: 73,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Cauca'
			],
			[
				'#persona_departamento_id-opt-12'
			],
			[
				'xpath///*[@id="persona_departamento_id-opt-12"]'
			],
			[
				'pierce/#persona_departamento_id-opt-12'
			]
		],
		offsetY: 14,
		offsetX: 105,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Caloto'
			],
			[
				'#persona_municipio_id-opt-8'
			],
			[
				'xpath///*[@id="persona_municipio_id-opt-8"]'
			],
			[
				'pierce/#persona_municipio_id-opt-8'
			]
		],
		offsetY: 9,
		offsetX: 100,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Bodega Arriba'
			],
			[
				'#persona_centropoblado_id-opt-2'
			],
			[
				'xpath///*[@id="persona_centropoblado_id-opt-2"]'
			],
			[
				'pierce/#persona_centropoblado_id-opt-2'
			]
		],
		offsetY: 25,
		offsetX: 104,
	});
	await runner.runStep({
		type: 'keyDown',
		target: 'main',
		key: 'Shift'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Nacional de'
			],
			[
				'#persona_nacionalde-ts-control'
			],
			[
				'xpath///*[@id="persona_nacionalde-ts-control"]'
			],
			[
				'pierce/#persona_nacionalde-ts-control'
			]
		],
		offsetY: 9,
		offsetX: 99,
	});
	await runner.runStep({
		type: 'change',
		value: 'C',
		selectors: [
			[
				'aria/Nacional de[role="combobox"]'
			],
			[
				'#persona_nacionalde-ts-control'
			],
			[
				'xpath///*[@id="persona_nacionalde-ts-control"]'
			],
			[
				'pierce/#persona_nacionalde-ts-control'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'keyUp',
		key: 'Shift',
		target: 'main'
	});
	await runner.runStep({
		type: 'change',
		value: 'Colo',
		selectors: [
			[
				'aria/Nacional de[role="combobox"]'
			],
			[
				'#persona_nacionalde-ts-control'
			],
			[
				'xpath///*[@id="persona_nacionalde-ts-control"]'
			],
			[
				'pierce/#persona_nacionalde-ts-control'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Colombia'
			],
			[
				'#persona_nacionalde-opt-48'
			],
			[
				'xpath///*[@id="persona_nacionalde-opt-48"]'
			],
			[
				'pierce/#persona_nacionalde-opt-48'
			]
		],
		offsetY: 21,
		offsetX: 117,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Tipo de documento'
			],
			[
				'#persona_tdocumento_id-ts-control'
			],
			[
				'xpath///*[@id="persona_tdocumento_id-ts-control"]'
			],
			[
				'pierce/#persona_tdocumento_id-ts-control'
			]
		],
		offsetY: 14,
		offsetX: 105,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/CÉDULA DE CIUDADANÍA'
			],
			[
				'#persona_tdocumento_id-opt-1'
			],
			[
				'xpath///*[@id="persona_tdocumento_id-opt-1"]'
			],
			[
				'pierce/#persona_tdocumento_id-opt-1'
			]
		],
		offsetY: 8,
		offsetX: 117,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Número de documento'
			],
			[
				'#persona_numerodocumento'
			],
			[
				'xpath///*[@id="persona_numerodocumento"]'
			],
			[
				'pierce/#persona_numerodocumento'
			]
		],
		offsetY: 32,
		offsetX: 127,
	});
	await runner.runStep({
		type: 'change',
		value: '10617587878',
		selectors: [
			[
				'aria/Número de documento'
			],
			[
				'#persona_numerodocumento'
			],
			[
				'xpath///*[@id="persona_numerodocumento"]'
			],
			[
				'pierce/#persona_numerodocumento'
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
				"input[type='submit']"
			],
			[
				'xpath///*[@id="new_persona"]/div[18]/input[2]'
			],
			[
				"pierce/input[type='submit']"
			],
			[
				'text/Crear'
			]
		],
		offsetY: 18,
		offsetX: 29,
		assertedEvents: [
			{
				type: 'navigation',
				url: 'http://rbd.nocheyniebla.org:4400/msip_2_2/personas/115',
				title: 'msip 2.2.0.beta7'
			}
		]
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Personas'
			],
			[
				'#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(2) > a'
			],
			[
				'xpath///*[@id="navbarSupportedContent"]/ul[1]/li[2]/a'
			],
			[
				'pierce/#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(2) > a'
			],
			[
				'text/Personas'
			]
		],
		offsetY: 20,
		offsetX: 60.96875,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'#filtro_busnombres'
			],
			[
				'xpath///*[@id="filtro_busnombres"]'
			],
			[
				'pierce/#filtro_busnombres'
			]
		],
		offsetY: 25,
		offsetX: 29,
	});
	await runner.runStep({
		type: 'change',
		value: 'A',
		selectors: [
			[
				'#filtro_busnombres'
			],
			[
				'xpath///*[@id="filtro_busnombres"]'
			],
			[
				'pierce/#filtro_busnombres'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'keyUp',
		key: 'a',
		target: 'main'
	});
	await runner.runStep({
		type: 'change',
		value: 'Alejandro',
		selectors: [
			[
				'#filtro_busnombres'
			],
			[
				'xpath///*[@id="filtro_busnombres"]'
			],
			[
				'pierce/#filtro_busnombres'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Filtrar[role="button"]'
			],
			[
				'td:nth-of-type(17) > input'
			],
			[
				'xpath///*[@id="div_contenido"]/form/table/thead/tr[2]/td[17]/input'
			],
			[
				'pierce/td:nth-of-type(17) > input'
			],
			[
				'text/Filtrar'
			]
		],
		offsetY: 15,
		offsetX: 46.484375,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/115[role="link"]'
			],
			[
				'tr:nth-of-type(2) > td:nth-of-type(1) > a'
			],
			[
				'xpath///*[@id="div_contenido"]/form/table/tbody/tr[2]/td[1]/a'
			],
			[
				'pierce/tr:nth-of-type(2) > td:nth-of-type(1) > a'
			],
			[
				'text/115'
			]
		],
		offsetY: 13,
		offsetX: 13.5,
	});
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
		offsetY: 31,
		offsetX: 32.25,
	});

	await terminar(runner)

	const tiempofin = performance.now();
	console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
	console.error(err);
	process.exit(1);
});

