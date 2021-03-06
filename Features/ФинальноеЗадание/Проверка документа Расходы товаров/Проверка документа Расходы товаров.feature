#language: ru

@tree

Функционал: проверка документа Продажи товара

Как оператор я хочу
зафиксировать сведения о продаже товаров клиенту в базе
чтобы отразить бизнес операцию в учетной системе для дальнейшего анализа

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: основные проверки документа Продажи товара
	* Открытие формы документа
		И я закрываю все окна клиентского приложения		
		И В командном интерфейсе я выбираю 'Продажи' 'Продажи'
		Тогда открылось окно 'Продажи товара'
		И я нажимаю на кнопку с именем 'ФормаСоздать'		
	* Проверка отображения элемента формы Валюта	
		И элемент формы с именем "Валюта" отсутствует на форме	
		И из выпадающего списка с именем "Организация" я выбираю по строке 'ООО "1000 мелочей"'		
		И элемент формы с именем "Валюта" отсутствует на форме
		И из выпадающего списка с именем "Организация" я выбираю по строке 'ООО "Товары"'
		И элемент формы с именем "Валюта" присутствует на форме
	* Автоматическое заполнение вида цен
		И из выпадающего списка с именем "Покупатель" я выбираю по строке 'ЭлектроБыт ЗАО'
		Тогда элемент формы с именем "ВидЦен" стал равен 'Розничная'
	* Заполнение прочих полей шапки		
		И из выпадающего списка с именем "Склад" я выбираю по строке 'Малый'
		И из выпадающего списка с именем "Валюта" я выбираю по строке 'Рубли'		
	* Заполнение табличной части
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'	
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'Sony К3456P'		
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '500,00'
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '3,00'
		И в таблице "Товары" я завершаю редактирование строки
		Тогда таблица "Товары" стала равной:
			| 'N' | 'Товар'       | 'Цена'   | 'Количество' | 'Сумма'    |
			| '1' | 'Sony К3456P' | '500,00' | '3,00'       | '1 500,00' |			
	* Запись документа
		И я нажимаю на кнопку с именем 'ФормаЗаписать'
		И я запоминаю значение поля с именем "Номер" как "НомерДокумента" глобально

Сценарий: проверка движения документа Продажи товара
	* Интерактивное проведение документа
		И я закрываю все окна клиентского приложения
		Дано Я открываю навигационную ссылку "e1cib/list/Документ.РасходТовара"			
		И в таблице "Список" я перехожу к строке:
			| 'Номер'              |
			| '$$НомерДокумента$$' |
		И в таблице "Список" я выбираю текущую строку
		И я нажимаю на кнопку с именем 'ФормаПровести'								
	* Регистр взаиморасчетов с контрагентами
		И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр взаиморасчетов с контрагентами'
		Тогда таблица "Список" стала равной:
			| 'Период' | 'Регистратор' | 'Номер строки' | 'Контрагент'     | 'Сумма'    | 'Валюта' |
			| '*'      | '*'           | '1'            | 'ЭлектроБыт ЗАО' | '1 500,00' | 'Рубли'  |
	* Регистр продаж
		И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр продаж'
		Тогда таблица "Список" стала равной:
			| 'Период' | 'Регистратор' | 'Номер строки' | 'Покупатель'     | 'Сумма'    | 'Товар'       | 'Количество' |
			| '*'      | '*'           | '1'            | 'ЭлектроБыт ЗАО' | '1 500,00' | 'Sony К3456P' | '3,00'       |
	* Регистр товарных запасов
		И В текущем окне я нажимаю кнопку командного интерфейса 'Регистр товарных запасов'
		Тогда таблица "Список" стала равной:
			| 'Период' | 'Регистратор' | 'Номер строки' | 'Склад' | 'Товар'       | 'Количество' |
			| '*'      | '*'           | '1'            | 'Малый' | 'Sony К3456P' | '3,00'       |

Сценарий: проверка печатных форм документа Продажи товара
	* Открытие формы документа
		И я закрываю все окна клиентского приложения
		Дано Я открываю навигационную ссылку "e1cib/list/Документ.РасходТовара"			
		И в таблице "Список" я перехожу к строке:
			| 'Номер'              |
			| '$$НомерДокумента$$' |
		И в таблице "Список" я выбираю текущую строку
	* Расходная накладная
		И я выполняю код встроенного языка на сервере	
			|'Документы.РасходТовара.НайтиПоНомеру("$$НомерДокумента$$").ПолучитьОбъект().Записать(РежимЗаписиДокумента.ОтменаПроведения);'|
		Если в текущем окне есть сообщения пользователю Тогда
			И я нажимаю на кнопку с именем 'ФормаПровести'
			И я нажимаю на кнопку с именем 'ФормаДокументРасходТовараПечатьРасходнойНакладной'
			Дано Табличный документ "SpreadsheetDocument" равен макету "РасходнаяНакладная" по шаблону
			И я закрываю текущее окно
	* Доставка
		И я нажимаю на кнопку с именем 'ФормаОформитьДоставку'
		Дано Табличный документ "ТабличныйДокумент" равен макету "ЗаявкаНаДоставку" по шаблону