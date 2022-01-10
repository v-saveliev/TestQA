﻿#language: ru

@tree

Функционал: изменение количества в строке для услуги в ТЧ документа Заказ

Как Менеджер по продажам я хочу
изменить документ Заказ
чтобы корректно отразить заказ клиента

Контекст:
Дано Я открыл новый сеанс TestClient или подключил уже существующий

Сценарий: создание документа поступления товаров
* Открытие формы создания документа
	И я закрываю все окна клиентского приложения
	И В командном интерфейсе я выбираю 'Продажи' 'Заказы'
	Тогда открылось окно 'Заказы товаров'
	И я нажимаю на кнопку с именем 'ФормаСоздать'
	Тогда открылось окно 'Заказ (создание)'
* Заполнение шапки документа
	И из выпадающего списка с именем "ВидЦен" я выбираю точное значение 'Оптовая'
	И из выпадающего списка с именем "Организация" я выбираю точное значение 'ООО "Все для дома"'
	И из выпадающего списка с именем "Покупатель" я выбираю точное значение 'Мосхлеб ОАО'
	И из выпадающего списка с именем "Склад" я выбираю точное значение 'Средний'
	И из выпадающего списка с именем "Валюта" я выбираю точное значение 'Рубли'
* Заполнение табличной части
	И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
	И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю точное значение 'Доставка'
	И я перехожу к следующему реквизиту
	И в таблице "Товары" я завершаю редактирование строки	
	И я нажимаю на кнопку "Записать"
* Проверка заполнения табличной части до изменений
	Тогда таблица "Товары" содержит строки:
		| 'Товар'     | 'Цена'     | 'Количество' | 'Сумма'  |
		| 'Доставка'  | '200,00'   | '1'          | '200,00' |
* Номер
	И я запоминаю значение поля "Номер" как "$Номер$"	
* Проведение документа
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна "Заказ (создание)" в течение 20 секунд
* Проверка создания документа
	И таблица "Список" содержит строки:
		| 'Номер' |
		| '$Номер$'   |
* Открытие созданно документа
	Когда открылось окно 'Заказы товаров'
	И в таблице "Список" я перехожу к строке:
		| 'Номер'     |
		| '$Номер$' | 	
	И в таблице "Список" я выбираю текущую строку	
* Изменение количества услуги в табличной части
	И в таблице "Товары" я перехожу к строке:
		| 'Сумма'  | 'Товар'     | 'Цена'   |
		| '200,00' | 'Доставка'  | '200,00' |
	И в таблице "Товары" я выбираю текущую строку
	И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '2'
	И в таблице "Товары" я завершаю редактирование строки
	И я нажимаю на кнопку с именем 'ФормаПровести'
* Проверка изменения количества услуги в табличной части
	Тогда таблица "Товары" содержит строки:
		| 'Товар'    | 'Цена'   | 'Количество' | 'Сумма'  |
		| 'Доставка' | '200,00' | '2'          | '200,00' |

		
