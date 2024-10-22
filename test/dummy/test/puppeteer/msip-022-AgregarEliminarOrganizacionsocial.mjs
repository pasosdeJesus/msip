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
				'aria/Organizaciones sociales'
			],
			[
				'#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(1) > a'
			],
			[
				'xpath///*[@id="navbarSupportedContent"]/ul[1]/li[1]/a'
			],
			[
				'pierce/#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(1) > a'
			],
			[
				'text/Organizaciones'
			]
		],
		offsetY: 20,
		offsetX: 109.078125,
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
				'text/Nueva'
			]
		],
		offsetY: 20,
		offsetX: 33.5,
		assertedEvents: [
			{
				type: 'navigation',
				url: 'http://rbd.nocheyniebla.org:4400/msip_2_2/orgsociales/nueva.%23%3CMsip::Orgsocial::ActiveRecord_Relation:0x00000fbbbdae7940%3E',
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
				'#orgsocial_grupoper_attributes_nombre'
			],
			[
				'xpath///*[@id="orgsocial_grupoper_attributes_nombre"]'
			],
			[
				'pierce/#orgsocial_grupoper_attributes_nombre'
			]
		],
		offsetY: 15,
		offsetX: 475,
	});
	await runner.runStep({
		type: 'change',
		value: 'Organizacion1',
		selectors: [
			[
				'aria/Nombre *'
			],
			[
				'#orgsocial_grupoper_attributes_nombre'
			],
			[
				'xpath///*[@id="orgsocial_grupoper_attributes_nombre"]'
			],
			[
				'pierce/#orgsocial_grupoper_attributes_nombre'
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
		value: 'An',
		selectors: [
			[
				'aria/Anotaciones'
			],
			[
				'#orgsocial_grupoper_attributes_anotaciones'
			],
			[
				'xpath///*[@id="orgsocial_grupoper_attributes_anotaciones"]'
			],
			[
				'pierce/#orgsocial_grupoper_attributes_anotaciones'
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
		value: 'Anota',
		selectors: [
			[
				'aria/Anotaciones'
			],
			[
				'#orgsocial_grupoper_attributes_anotaciones'
			],
			[
				'xpath///*[@id="orgsocial_grupoper_attributes_anotaciones"]'
			],
			[
				'pierce/#orgsocial_grupoper_attributes_anotaciones'
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
				'aria/GRUPO ARMADO'
			],
			[
				'#orgsocial_tipoorg_id-opt-2'
			],
			[
				'xpath///*[@id="orgsocial_tipoorg_id-opt-2"]'
			],
			[
				'pierce/#orgsocial_tipoorg_id-opt-2'
			]
		],
		offsetY: 9,
		offsetX: 298,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Web'
			],
			[
				'#orgsocial_web'
			],
			[
				'xpath///*[@id="orgsocial_web"]'
			],
			[
				'pierce/#orgsocial_web'
			]
		],
		offsetY: 10,
		offsetX: 241,
	});
	await runner.runStep({
		type: 'change',
		value: 'ejemplo.com',
		selectors: [
			[
				'aria/Web'
			],
			[
				'#orgsocial_web'
			],
			[
				'xpath///*[@id="orgsocial_web"]'
			],
			[
				'pierce/#orgsocial_web'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/País'
			],
			[
				'#orgsocial_pais_id-ts-control'
			],
			[
				'xpath///*[@id="orgsocial_pais_id-ts-control"]'
			],
			[
				'pierce/#orgsocial_pais_id-ts-control'
			]
		],
		offsetY: 10,
		offsetX: 156,
	});
	await runner.runStep({
		type: 'change',
		value: 'Co',
		selectors: [
			[
				'aria/País[role="combobox"]'
			],
			[
				'#orgsocial_pais_id-ts-control'
			],
			[
				'xpath///*[@id="orgsocial_pais_id-ts-control"]'
			],
			[
				'pierce/#orgsocial_pais_id-ts-control'
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
		value: 'Colo',
		selectors: [
			[
				'aria/País[role="combobox"]'
			],
			[
				'#orgsocial_pais_id-ts-control'
			],
			[
				'xpath///*[@id="orgsocial_pais_id-ts-control"]'
			],
			[
				'pierce/#orgsocial_pais_id-ts-control'
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
				'#orgsocial_pais_id-opt-48'
			],
			[
				'xpath///*[@id="orgsocial_pais_id-opt-48"]'
			],
			[
				'pierce/#orgsocial_pais_id-opt-48'
			]
		],
		offsetY: 9,
		offsetX: 132,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Dirección'
			],
			[
				'#orgsocial_direccion'
			],
			[
				'xpath///*[@id="orgsocial_direccion"]'
			],
			[
				'pierce/#orgsocial_direccion'
			]
		],
		offsetY: 12,
		offsetX: 123,
	});
	await runner.runStep({
		type: 'keyDown',
		target: 'main',
		key: 'Shift'
	});
	await runner.runStep({
		type: 'keyUp',
		key: 'Shift',
		target: 'main'
	});
	await runner.runStep({
		type: 'change',
		value: 'Carrera 4 # 3-31',
		selectors: [
			[
				'aria/Dirección'
			],
			[
				'#orgsocial_direccion'
			],
			[
				'xpath///*[@id="orgsocial_direccion"]'
			],
			[
				'pierce/#orgsocial_direccion'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Teléfono'
			],
			[
				'#orgsocial_telefono'
			],
			[
				'xpath///*[@id="orgsocial_telefono"]'
			],
			[
				'pierce/#orgsocial_telefono'
			]
		],
		offsetY: 11,
		offsetX: 114,
	});
	await runner.runStep({
		type: 'change',
		value: '324123',
		selectors: [
			[
				'aria/Teléfono'
			],
			[
				'#orgsocial_telefono'
			],
			[
				'xpath///*[@id="orgsocial_telefono"]'
			],
			[
				'pierce/#orgsocial_telefono'
			]
		],
		target: 'main'
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Fax'
			],
			[
				'#orgsocial_fax'
			],
			[
				'xpath///*[@id="orgsocial_fax"]'
			],
			[
				'pierce/#orgsocial_fax'
			]
		],
		offsetY: 29,
		offsetX: 92,
	});
	await runner.runStep({
		type: 'change',
		value: '123241',
		selectors: [
			[
				'aria/Fax'
			],
			[
				'#orgsocial_fax'
			],
			[
				'xpath///*[@id="orgsocial_fax"]'
			],
			[
				'pierce/#orgsocial_fax'
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
				'xpath///*[@id="new_orgsocial"]/div[12]/input'
			],
			[
				'pierce/div.form-actions > input'
			],
			[
				'text/Crear'
			]
		],
		offsetY: 22,
		offsetX: 15,
		assertedEvents: [
			{
				type: 'navigation',
				url: 'http://rbd.nocheyniebla.org:4400/msip_2_2/orgsociales/4',
				title: ''
			}
		]
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/Organizaciones sociales'
			],
			[
				'#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(1) > a'
			],
			[
				'xpath///*[@id="navbarSupportedContent"]/ul[1]/li[1]/a'
			],
			[
				'pierce/#navbarSupportedContent > ul:nth-of-type(1) > li:nth-of-type(1) > a'
			],
			[
				'text/Organizaciones'
			]
		],
		offsetY: 30,
		offsetX: 49.078125,
	});
	await runner.runStep({
		type: 'click',
		target: 'main',
		selectors: [
			[
				'aria/4[role="link"]'
			],
			[
				'tr:nth-of-type(2) > td:nth-of-type(1) > a'
			],
			[
				'xpath///*[@id="div_contenido"]/form/table/tbody/tr[2]/td[1]/a'
			],
			[
				'pierce/tr:nth-of-type(2) > td:nth-of-type(1) > a'
			]
		],
		offsetY: 10,
		offsetX: 5.5,
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
				'xpath///*[@id="div_contenido"]/div[4]/a[3]'
			],
			[
				'pierce/a.btn-danger'
			],
			[
				'text/Eliminar'
			]
		],
		offsetY: 14,
		offsetX: 43.75,
	});

	await terminar(runner)

	const tiempofin = performance.now();
	console.log(`Tiempo de ejecución: ${tiempofin - tiempoini} ms`);
})().catch(err => {
	console.error(err);
	process.exit(1);
});

