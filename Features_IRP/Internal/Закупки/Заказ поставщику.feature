﻿#language: ru

@tree

Функционал: заказ поставщику

Как Менеджер по закупкам я хочу
зафиксировать заказанный поставщику товар
чтобы проанализировать разницу между тем что было заказано и что было фактически доставлено

Контекст:
	Дано Я открыл новый сеанс TestClient или подключил уже существующий

Сценарий: _0401 подготовительный сценарий (заказ поставщику)
	Когда экспорт основных данных


Сценарий: _0402 проверка заполнения цены из соглашения
	* Заполнение документа заказ поставщику
		Дано Я открываю навигационную ссылку "e1cib/list/Document.PurchaseOrder"
		И я нажимаю на кнопку с именем 'FormCreate'
		И я нажимаю кнопку выбора у поля с именем "Partner"
		И в таблице "List" я перехожу к строке:
			| 'Наименование'               |
			| 'Поставщик 1 (1 соглашение)' |
		И в таблице "List" я выбираю текущую строку
		И в таблице "ItemList" я активизирую поле с именем "ItemListLineNumber"
		И в таблице "ItemList" я нажимаю на кнопку с именем 'ItemListAdd'
		И в таблице "ItemList" я активизирую поле с именем "ItemListItem"
		И в таблице "ItemList" я нажимаю кнопку выбора у реквизита с именем "ItemListItem"
		И в таблице "List" я перехожу к строке:
			| 'Код' | 'Наименование'            | 'Ссылка'                  |
			| '2'   | 'Товар без характеристик' | 'Товар без характеристик' |
		И в таблице "List" я активизирую поле с именем "Description"
		И в таблице "List" я выбираю текущую строку
		И в таблице "ItemList" я завершаю редактирование строки
	* Проверка заполнения цены из соглашения
		Тогда таблица "ItemList" содержит строки:
			| 'N' | 'Номенклатура'            | 'Характеристика'          | 'Количество' | 'Ед. изм.' | 'Вид цены'          | 'Цена'   |
			| '1' | 'Товар без характеристик' | 'Товар без характеристик' | '1,000'      | 'шт'       | 'Цена поставщика 1' | '150,00' |
	* Изменения вида цен и проверка его перезаполнения при перевыборе соглашения
		И в таблице "ItemList" я выбираю текущую строку
		И в таблице "ItemList" я нажимаю кнопку выбора у реквизита с именем "ItemListPriceType"
		И в таблице "List" я перехожу к строке:
			| 'Валюта' | 'Код' | 'Наименование'      | 'Ссылка'            |
			| 'USD'    | '4'   | 'Цена поставщика 2' | 'Цена поставщика 2' |
		И в таблице "List" я выбираю текущую строку
		Тогда таблица "ItemList" содержит строки:
			| 'N' | 'Номенклатура'            | 'Характеристика'          | 'Количество' | 'Ед. изм.' | 'Вид цены'          | 'Цена' |
			| '1' | 'Товар без характеристик' | 'Товар без характеристик' | '1,000'      | 'шт'       | 'Цена поставщика 2' | ''     |
		И я нажимаю кнопку выбора у поля с именем "Agreement"
		И в таблице "List" я перехожу к строке:
		| 'Наименование'               |
		| 'Соглашение с поставщиком 1' |	
		И в таблице "List" я выбираю текущую строку
		Тогда открылось окно 'Табличная часть товаров будет обновлена'
		И я нажимаю на кнопку с именем 'FormOK'
		Тогда таблица "ItemList" содержит строки:
			| 'N' | 'Номенклатура'            | 'Характеристика'          | 'Количество' | 'Ед. изм.' | 'Вид цены'          | 'Цена'   |
			| '1' | 'Товар без характеристик' | 'Товар без характеристик' | '1,000'      | 'шт'       | 'Цена поставщика 1' | '150,00' |				
		И я закрываю все окна клиентского приложения