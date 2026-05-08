-- Отключаем проверку внешних ключей (опционально, но лучше удалять в правильном порядке)
-- Начинаем транзакцию
BEGIN TRANSACTION;

-- Очистка таблиц в порядке зависимости (от дочерних к родительским)
DELETE FROM [dbo].[ProductMaterial];
DELETE FROM [dbo].[ProductSale];
DELETE FROM [dbo].[ProductCostHistory];
DELETE FROM [dbo].[Shop];
DELETE FROM [dbo].[AgentPriorityHistory];
DELETE FROM [dbo].[Agent];
DELETE FROM [dbo].[AgentType];
DELETE FROM [dbo].[Product];
DELETE FROM [dbo].[ProductType];
DELETE FROM [dbo].[MaterialSupplier];
DELETE FROM [dbo].[MaterialCountHistory];
DELETE FROM [dbo].[Material];
DELETE FROM [dbo].[MaterialType];
DELETE FROM [dbo].[Supplier];

-- Сброс идентификаторов
DBCC CHECKIDENT ('[AgentType]', RESEED, 0);
DBCC CHECKIDENT ('[Agent]', RESEED, 0);
DBCC CHECKIDENT ('[ProductType]', RESEED, 0);
DBCC CHECKIDENT ('[Product]', RESEED, 0);

-- Создание таблицы пользователей (если нет)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'User')
BEGIN
    CREATE TABLE [dbo].[User](
        [Login] [nvarchar](50) NOT NULL PRIMARY KEY,
        [Password] [nvarchar](50) NOT NULL,
        [Role] [nvarchar](50) NOT NULL,
        [FirstName] [nvarchar](50) NULL,
        [MiddleName] [nvarchar](50) NULL,
        [LastName] [nvarchar](50) NULL
    );
END

DELETE FROM [dbo].[User];

-- Заполнение пользователей
INSERT INTO [dbo].[User] ([Login], [Password], [Role], [FirstName], [MiddleName], [LastName]) VALUES 
('admin', 'admin', 'Администратор', 'Иван', 'Иванович', 'Иванов'),
('manager', 'manager', 'Менеджер', 'Петр', 'Петрович', 'Петров'),
('user', 'user', 'Агент', 'Алексей', 'Алексеевич', 'Алексеев');

-- Заполнение типов агентов
INSERT INTO [dbo].[AgentType] ([Title]) VALUES 
('МКК'), ('ОАО'), ('ООО'), ('ЗАО'), ('МФО'), ('ПАО');

-- Заполнение агентов (все записи из CSV)
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МонтажОрионУрал', ID, 'pzaitev@blokin.org', '(35222) 67-39-26', '\agents\agent_96.png', '027573, Тамбовская область, город Коломна, ул. Ленина, 20', 50, 'Давыдоваа Нина Евгеньевна', '1692286718', '181380912' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МетизСтрой', ID, 'kristina.pakomov@burova.ru', '8-800-172-62-56', '\agents\agent_94.png', '254238, Нижегородская область, город Павловский Посад, проезд Балканская, 23', 374, 'Ева Борисовна Беспалова', '4024742936', '295608432' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'РадиоСевер', ID, 'maiy.belov@rogov.ru', '(495) 368-86-51', '\agents\agent_123.png', '491360, Московская область, город Одинцовво, въезд Ленина, 19', 431, 'Карпов Иосиф Максимович', '5889206249', '372789083' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания КазАлмаз', ID, 'irina.gusina@vlasova.ru', '8-800-533-24-75', '\agents\agent_80.png', '848810, Кемеровская область, город Лотошино, пер. Ломоносова, 90', 396, 'Марк Фёдорович Муравьёва', '3084797352', '123190924' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания СервисРадиоГор', ID, 'nika.nekrasova@kovalev.ru', '8-800-676-32-86', '\agents\agent_40.png', '547196, Ульяновская область, город Серебряные Пруды, въезд Балканская, 81', 169, 'Попов Вадим Александрович', '8880473721', '729975116' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ВодТверьХозМашина', ID, 'tkrylov@baranova.net', '+7 (922) 849-91-96', '\agents\agent_56.png', '145030, Сахалинская область, город Шатура, въезд Гоголя, 79', 8, 'Александра Дмитриевна Ждановаа', '4174253174', '522227145' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Тех', ID, 'vasilisa99@belyev.ru', '+7 (922) 427-13-31', '\agents\agent_61.png', '731935, Калининградская область, город Павловский Посад, наб. Гагарина, 59', 278, 'Аким Романович Логинова', '9282924869', '587356429' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТверьМетизУралСнос', ID, 'rlazareva@novikov.ru', '(35222) 57-92-75', '\agents\agent_109.png', '880551, Ленинградская область, город Красногорск, ул. Гоголя, 61', 165, 'Зоя Андреевна Соболева', '1076095397', '947828491' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МясРеч', ID, 'bkozlov@volkov.ru', '8-800-453-63-45', '\agents\agent_58.png', '903648, Калужская область, город Воскресенск, пр. Будапештсткая, 91', 355, 'Белоусоваа Ирина Максимовна', '9254261217', '656363498' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Флот', ID, 'gerasim.makarov@kornilov.ru', '8-800-144-25-38', '\agents\agent_87.png', '505562, Тюменская область, город Наро-Фоминск, пр. Косиора, 11', 473, 'Василий Андреевич Ковалёв', '1112170258', '382584255' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'CибПивОмскСнаб', ID, 'evorontova@potapova.ru', '+7 (922) 153-95-22', '\agents\agent_46.png', '816260, Ивановская область, город Москва, ул. Гагарина, 31', 477, 'Людмила Александровна Сафонова', '5676173945', '256512286' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЦементАсбоцемент', ID, 'polykov.veronika@artemeva.ru', '(495) 184-87-92', 'отсутствует', '619540, Курская область, город Раменское, пл. Балканская, 12', 426, 'Воронова Мария Александровна', '4345774724', '352469905' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТелеГлавВекторСбыт', ID, 'nsitnikov@kovaleva.ru', '(35222) 56-15-37', '\agents\agent_31.png', '062489, Челябинская область, город Пушкино, въезд Бухарестская, 07', 185, 'Екатерина Фёдоровна Ковалёва', '9504787157', '419758597' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Инфо', ID, 'arsenii.mikailova@prokorov.com', '8-800-793-59-97', '\agents\agent_89.png', '100469, Рязанская область, город Ногинск, шоссе Гагарина, 57', 304, 'Баранова Виктор Романович', '6549468639', '718386757' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЭлектроРемОрионЛизинг', ID, 'anfisa.fedotova@tvetkov.ru', '(495) 519-97-41', '\agents\agent_68.png', '594365, Ярославская область, город Павловский Посад, бульвар Космонавтов, 64', 198, 'Тарасова Дан Львович', '1340072597', '500478249' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания ТелекомХмельГаражПром', ID, 'qkolesnikova@kalinina.ru', '(812) 983-91-73', '\agents\agent_71.png', '126668, Ростовская область, город Зарайск, наб. Гагарина, 69', 457, 'Костина Татьяна Борисовна', '1614623826', '824882264' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания Алмаз', ID, 'akalinina@zaitev.ru', '+7 (922) 688-74-22', '\agents\agent_121.png', '016215, Воронежская область, город Зарайск, ул. Косиора, 48', 259, 'Фоминаа Лариса Романовна', '6698862694', '662876919' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МясТрансМоторЛизинг', ID, 'vlad.sokolov@andreev.org', '+7 (922) 676-34-94', '\agents\agent_62.png', '765320, Ивановская область, город Шатура, спуск Гоголя, 88', 268, 'Тамара Дмитриевна Семёноваа', '6148685143', '196332656' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Монтаж', ID, 'zakar.sazonova@gavrilov.ru', '(495) 867-76-15', 'не указано', '066594, Магаданская область, город Шаховская, спуск Сталина, 59', 300, 'Блохина Сергей Максимович', '6142194281', '154457435' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ВостокГлав', ID, 'gordei95@kirillov.ru', '(812) 949-29-26', '\agents\agent_63.png', '217022, Ростовская область, город Озёры, ул. Домодедовская, 19', 107, 'Инга Фёдоровна Дмитриева', '3580946305', '405017349' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Газ', ID, 'ulyna.antonov@noskov.ru', '(35222) 22-45-58', '\agents\agent_76.png', '252821, Тамбовская область, город Пушкино, ул. Чехова, 40', 170, 'Терентьев Илларион Максимович', '8876413796', '955381891' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЭлектроТранс', ID, 'boleslav.zukova@nikiforova.com', '(812) 342-24-31', '\agents\agent_91.png', '434616, Калининградская область, город Павловский Посад, пл. Ладыгина, 83', 129, 'Сава Александрович Титова', '6019144874', '450629885' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Электро', ID, 'likacev.makar@antonov.ru', '8-800-714-36-41', '\agents\agent_93.png', '966815, Новгородская область, город Одинцово, пр. Космонавтов, 19', 366, 'Шарапова Елена Дмитриевна', '7896029866', '786038848' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Гор', ID, 'maiy12@koklov.net', '(495) 973-48-55', '\agents\agent_52.png', '376483, Калужская область, город Сергиев Посад, ул. Славы, 09', 175, 'Нонна Львовна Одинцоваа', '7088187045', '440309946' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания Гараж', ID, 'asiryeva@andreeva.com', '+7 (922) 848-38-54', '\agents\agent_66.png', '395101, Белгородская область, город Балашиха, бульвар 1905 года, 00', 413, 'Владлена Фёдоровна Ларионоваа', '6190244524', '399106161' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ОрионГлав', ID, 'sermakova@sarova.net', '+7 (922) 684-13-74', '\agents\agent_106.png', '729639, Магаданская область, город Талдом, въезд Будапештсткая, 98', 482, 'Тимофеева Григорий Андреевич', '9032455179', '763045792' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ГлавITФлотПроф', ID, 'savva.rybov@kolobov.ru', '(812) 146-66-46', '\agents\agent_64.png', '447811, Мурманская область, город Егорьевск, ул. Ленина, 24', 62, 'Зыкова Стефан Максимович', '2561361494', '525678825' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТверьМонтажОмск', ID, 'dteterina@selezneva.ru', '8-800-363-43-86', '\agents\agent_128.png', '761751, Амурская область, город Балашиха, шоссе Гоголя, 02', 272, 'Матвей Романович Большакова', '2421347164', '157370604' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'РемСантехОмскБанк', ID, 'anisimov.mark@vorobev.ru', '(812) 182-44-77', '\agents\agent_57.png', '289468, Омская область, город Видное, пер. Балканская, 33', 442, 'Фокина Искра Максимовна', '6823050572', '176488617' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЭлектроМоторТрансСнос', ID, 'inessa.voronov@sidorova.ru', '(35222) 43-62-19', 'отсутствует', '913777, Самарская область, город Красногорск, ул. Бухарестская, 49', 151, 'Людмила Евгеньевна Новиковаа', '6608362851', '799760512' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТверьХозМорСбыт', ID, 'marina58@koroleva.com', '(495) 416-75-67', '\agents\agent_117.png', '252101, Ростовская область, город Дорохово, пер. Ленина, 85', 207, 'Аким Львович Субботина', '6681338084', '460530907' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания ТомскХоз', ID, 'nelli11@gureva.ru', '+7 (922) 849-13-37', '\agents\agent_115.png', '861543, Томская область, город Истра, бульвар Славы, 42', 464, 'Лазарева Аркадий Сергеевич', '8430391035', '961540858' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания МясДизайнДизайн', ID, 'gleb.gulyev@belyeva.com', '(812) 535-17-25', '\agents\agent_53.png', '557264, Брянская область, город Серпухов, въезд Гоголя, 34', 491, 'Клементина Сергеевна Стрелкова', '8004989990', '908629456' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания ЖелДорТверьМонтаж', ID, 'burova.zlata@zueva.ru', '(495) 521-61-75', '\agents\agent_85.png', '152424, Рязанская область, город Сергиев Посад, ул. 1905 года, 27', 2, 'Нестор Максимович Гуляев', '3325722996', '665766347' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МетизТехАвтоПроф', ID, 'anastasiy.gromov@samsonova.com', '(495) 581-42-46', '\agents\agent_33.png', '713016, Брянская область, город Подольск, пл. Домодедовская, 93', 321, 'Егор Фёдорович Третьякова', '2988890076', '215491048' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Гараж', ID, 'antonin51@korolev.com', '(35222) 54-72-59', '\agents\agent_90.png', '585758, Самарская область, город Красногорск, бульвар Балканская, 13', 107, 'Панфилов Константин Максимович', '2638464552', '746822723' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ГазДизайнЖелДор', ID, 'elizaveta.komarov@rybakov.net', '(495) 797-97-33', '\agents\agent_49.png', '695230, Курская область, город Красногорск, пр. Гоголя, 64', 236, 'Лев Иванович Третьяков', '2396029740', '458924890' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'РемГаражЛифт', ID, 'novikova.gleb@sestakov.ru', '8-800-772-27-53', '\agents\agent_65.png', '048715, Ивановская область, город Люберцы, проезд Космонавтов, 89', 374, 'Филатов Владимир Максимович', '1656477206', '988968838' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'СантехБашкир', ID, 'nikodim81@kiseleva.com', '+7 (922) 155-87-39', '\agents\agent_99.png', '180288, Тверская область, город Одинцово, ул. Бухарестская, 37', 369, 'Виктор Иванович Молчанов', '4159215346', '639267493' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЮпитерЛенГараж-М', ID, 'larkipova@gorbunov.ru', '(495) 327-58-25', '\agents\agent_48.png', '339507, Московская область, город Видное, ул. Космонавтов, 11', 470, 'Васильева Валерия Борисовна', '2038393690', '259672761' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ОрионСофтВодСнос', ID, 'isukanov@sobolev.com', '(35222) 59-75-11', '\agents\agent_97.png', '577227, Калужская область, город Павловский Посад, наб. Чехова, 35', 361, 'Мухина Ян Фёдорович', '1522348613', '977738715' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'КазХоз', ID, 'istrelkova@fomin.ru', '+7 (922) 728-85-62', 'нет', '384162, Астраханская область, город Одинцово, бульвар Гагарина, 57', 213, 'Степанова Роман Иванович', '6503377671', '232279972' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'БухВжух', ID, 'valentina.bolsakova@aksenova.ru', '(495) 367-21-41', 'отсутствует', '481744, Амурская область, город Щёлково, пл. Сталина, 48', 327, 'Тарасов Болеслав Александрович', '2320989197', '359282667' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ХозЮпитер', ID, 'jisakova@nazarova.com', '+7 (922) 332-48-96', '\agents\agent_114.png', '038182, Курганская область, город Москва, спуск Космонавтов, 16', 375, 'Максимоваа Вера Фёдоровна', '6667635058', '380592865' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ВостокКазРыб', ID, 'flukin@misin.org', '(495) 987-31-63', '\agents\agent_112.png', '059565, Оренбургская область, город Истра, шоссе Домодедовская, 27', 361, 'Самсонов Родион Романович', '7411284960', '176779733' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЦементКрепТех-М', ID, 'yna.evdokimov@gordeeva.ru', '(812) 838-79-58', '\agents\agent_82.png', '263764, Свердловская область, город Раменское, пер. Косиора, 28', 189, 'Сергеев Владлен Александрович', '5359981084', '680416300' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Строй', ID, 'soloveva.adam@andreev.ru', '(812) 447-45-59', 'отсутствует', '763019, Омская область, город Шатура, пл. Сталина, 56', 12, 'Кудрявцев Адриан Андреевич', '6678884759', '279288618' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'БашкирЮпитерТомск', ID, 'dyckov.veniamin@kotova.ru', '(812) 189-59-57', '\agents\agent_59.png', '035268, Сахалинская область, город Волоколамск, проезд Ладыгина, 51', 139, 'Фадеева Раиса Александровна', '1606315697', '217799345' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'КазМеталКазань', ID, 'mmoiseev@teterin.ru', '(495) 685-34-29', '\agents\agent_130.png', '532703, Пензенская область, город Чехов, наб. Чехова, 81', 252, 'Валерий Владимирович Хохлова', '4598939812', '303467543' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Газ', ID, 'alina56@zdanov.com', '(35222) 75-96-85', '\agents\agent_120.png', '310403, Кировская область, город Солнечногорск, пл. Балканская, 76', 445, 'Давид Андреевич Фадеев', '2262431140', '247369527' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Монтаж', ID, 'afanasev.anastasiy@muravev.ru', '(35222) 92-45-98', '\agents\agent_75.png', '036381, Брянская область, город Кашира, бульвар Гагарина, 76', 124, 'Силин Даниил Иванович', '6206428565', '118570048' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'СервисХмельМонтаж', ID, 'galina31@melnikov.ru', '+7 (922) 344-73-38', '\agents\agent_92.png', '928260, Нижегородская область, город Балашиха, пл. Косиора, 44', 124, 'Анжелика Дмитриевна Горбунова', '3459886235', '356196105' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ВодГараж', ID, 'pmaslov@fomiceva.com', '+7 (922) 363-86-67', '\agents\agent_67.png', '988899, Саратовская область, город Раменское, пр. Славы, 40', 250, 'Лаврентий Фёдорович Логинова', '5575072431', '684290320' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'CибГаз', ID, 'inna.sarova@panfilov.ru', '(495) 945-37-25', '\agents\agent_103.png', '365674, Архангельская область, город Серебряные Пруды, пр. Ленина, 29', 488, 'Вячеслав Романович Третьякова', '6483417250', '455013058' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'БашкирФлотМотор-H', ID, 'morozova.nika@kazakova.ru', '(495) 793-84-82', '\agents\agent_36.png', '008081, Тюменская область, город Ногинск, въезд Гагарина, 94', 416, 'Марат Алексеевич Фролов', '1657476072', '934931159' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МетелСервисМор', ID, 'xdanilov@titov.ru', '(35222) 91-28-62', 'нет', '293265, Иркутская область, город Клин, пр. Славы, 12', 475, 'Коновалова Кирилл Львович', '6922817841', '580142825' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Рем', ID, 'zanna25@nikiforova.com', '(495) 987-88-53', '\agents\agent_79.png', '707812, Иркутская область, город Шаховская, ул. Гагарина, 17', 329, 'Шароваа Елизавета Львовна', '3203830728', '456254820' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'СантехСеверЛенМашина', ID, 'pgorbacev@vasilev.net', '(812) 918-88-43', '\agents\agent_74.png', '606990, Новосибирская область, город Павловский Посад, въезд Домодедовская, 38', 201, 'Павел Максимович Рожков', '3506691089', '830713603' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Цемент', ID, 'panova.klementina@bobrov.ru', '8-800-517-78-47', '\agents\agent_54.png', '084315, Амурская область, город Шаховская, наб. Чехова, 62', 340, 'Анфиса Фёдоровна Буроваа', '9662118663', '650216214' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Вод', ID, 'savva86@zaiteva.ru', '(495) 142-19-84', '\agents\agent_129.png', '964386, Оренбургская область, город Чехов, пл. Косиора, 80', 359, 'Зоя Романовна Селезнёва', '1296063939', '447430051' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Орион', ID, 'aleksei63@kiselev.ru', '8-800-621-61-93', '\agents\agent_77.png', '951035, Ивановская область, город Ступино, шоссе Космонавтов, 73', 166, 'Мартынов Михаил Борисович', '2670166502', '716874456' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'СтройГорНефть', ID, 'lysy.kolesnikova@molcanova.com', '(812) 385-21-37', '\agents\agent_37.png', '444539, Ульяновская область, город Лотошино, спуск Будапештсткая, 95', 161, 'Тарасова Макар Максимович', '5916775587', '398299418' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания Хмель', ID, 'ermakov.mark@isakova.ru', '(812) 421-77-82', 'отсутствует', '889757, Новосибирская область, город Раменское, бульвар 1905 года, 93', 2, 'Владимир Борисович Суворова', '9004087602', '297273898' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания ВодАлмазIT', ID, 'zakar37@nikolaeva.ru', '(35222) 52-76-16', '\agents\agent_111.png', '302100, Нижегородская область, город Мытищи, пер. 1905 года, 63', 31, 'Гуляев Егор Евгеньевич', '2345297765', '908449277' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'БашкирРечТомск', ID, 'aleksandra77@karpov.com', '8-800-254-71-85', '\agents\agent_100.png', '136886, Амурская область, город Видное, въезд Космонавтов, 39', 84, 'Назарова Вера Андреевна', '7027724917', '823811460' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'СофтРосБух', ID, 'ivanova.antonin@rodionov.ru', '+7 (922) 445-69-17', '\agents\agent_124.png', '747695, Амурская область, город Сергиев Посад, въезд Бухарестская, 46', 69, 'Белова Полина Владимировна', '8321561226', '807803984' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТелекомЮпитер', ID, 'kulikov.adrian@zuravlev.org', '(812) 895-67-23', '\agents\agent_81.png', '959793, Курская область, город Егорьевск, бульвар Ленина, 72', 302, 'Калинина Татьяна Ивановна', '9383182378', '944520594' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'УралСтройХмель', ID, 'aleksandr95@kolobova.ru', '(35222) 39-23-65', '\agents\agent_113.png', '462632, Костромская область, город Шаховская, шоссе Сталина, 92', 372, 'Август Борисович Красильникова', '8773558039', '402502867' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'АсбоцементТехАвто', ID, 'matveev.yliy@kiseleva.ru', '+7 (922) 977-68-84', '\agents\agent_110.png', '304975, Пензенская область, город Солнечногорск, шоссе Балканская, 76', 247, 'Сидорова Любовь Ивановна', '7626076463', '579234124' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания ФинансСервис', ID, 'robert.serbakov@safonova.ru', '(812) 878-42-71', '\agents\agent_38.png', '841700, Брянская область, город Серпухов, спуск Домодедовская, 35', 395, 'Клавдия Сергеевна Виноградова', '7491491391', '673621812' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Софт', ID, 'jterentev@ersov.com', '(35222) 12-82-65', '\agents\agent_122.png', '453714, Смоленская область, город Одинцово, спуск Косиора, 84', 292, 'Петухова Прохор Фёдорович', '3889910123', '952047511' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТелекомГор', ID, 'gorskov.larisa@kalinin.com', '(35222) 78-93-21', '\agents\agent_98.png', '210024, Белгородская область, город Сергиев Посад, наб. Ломоносова, 43', 255, 'Ксения Андреевна Михайлова', '3748947224', '766431901' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'РемСтрем', ID, 'rafail96@sukin.ru', '(35222) 55-28-24', '\agents\agent_116.png', '373761, Псковская область, город Наро-Фоминск, наб. Гагарина, 03', 88, 'Альбина Александровна Романова', '9006569852', '152177100' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Лифт', ID, 'zinaida01@bespalova.ru', '(812) 484-92-38', '\agents\agent_101.png', '479565, Курганская область, город Клин, пл. Ленина, 54', 92, 'Вера Евгеньевна Денисоваа', '6169713039', '848972934' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания МоторТелекомЦемент-М', ID, 'larisa44@silin.org', '(812) 857-95-57', '\agents\agent_118.png', '021293, Амурская область, город Наро-Фоминск, шоссе Славы, 40', 237, 'Иван Евгеньевич Белоусова', '7326832482', '440199498' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЮпитерТяжОрионЭкспедиция', ID, 'gblokin@orlov.net', '(35222) 95-63-65', '\agents\agent_44.png', '960726, Томская область, город Орехово-Зуево, въезд 1905 года, 51', 446, 'Валерий Евгеньевич Виноградов', '6843174002', '935556458' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Транс', ID, 'artem.fadeev@polykov.com', '8-800-954-23-89', '\agents\agent_127.png', '508299, Кемеровская область, город Кашира, пер. Гагарина, 42', 38, 'Евсеева Болеслав Сергеевич', '9604275878', '951258069' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'РемВод', ID, 'komarov.elizaveta@agafonova.ru', '+7 (922) 353-31-72', '\agents\agent_126.png', '449723, Смоленская область, город Наро-Фоминск, пер. Ломоносова, 94', 1, 'Медведеваа Ярослава Фёдоровна', '3986603105', '811373078' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'АсбоцементЛифтРеч-H', ID, 'vladlena58@seliverstova.ru', '(495) 245-57-16', '\agents\agent_105.png', '599158, Ростовская область, город Озёры, ул. Космонавтов, 05', 407, 'Кондратьева Таисия Андреевна', '6567878928', '560960507' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'РосАвтоМонтаж', ID, 'lapin.inessa@isaeva.com', '(495) 445-97-76', '\agents\agent_55.png', '331914, Курская область, город Ногинск, спуск Ладыгина, 66', 10, 'Диана Алексеевна Исаковаа', '4735043946', '263682488' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания СервисТелеМотор', ID, 'veronika.egorov@bespalova.com', '+7 (922) 461-25-29', '\agents\agent_102.png', '625988, Вологодская область, город Озёры, пр. Гоголя, 18', 81, 'Фролова Эдуард Борисович', '3248454160', '138472695' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ФинансТелеТверь', ID, 'medvedev.klim@afanasev.com', '(812) 115-56-93', '\agents\agent_45.png', '687171, Томская область, город Лотошино, пл. Славы, 59', 100, 'Зайцеваа Дарья Сергеевна', '2646091050', '971874277' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ВодГор', ID, 'tvetkova.robert@sorokin.com', '(35222) 73-72-16', '\agents\agent_125.png', '265653, Калужская область, город Ступино, шоссе Гоголя, 89', 72, 'Фаина Фёдоровна Филиппова', '4463113470', '899603778' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТяжРадиоУралПроф', ID, 'liliy62@grisina.ru', '+7 (922) 885-66-15', '\agents\agent_88.png', '521087, Орловская область, город Егорьевск, шоссе Ладыгина, 14', 278, 'София Алексеевна Мухина', '5688533246', '401535045' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ГаражЛофт', ID, 'lydmila.belyeva@karpov.ru', '(495) 427-55-66', '\agents\agent_108.png', '294596, Мурманская область, город Шаховская, пр. Домодедовская, 88', 335, 'Клавдия Фёдоровна Кудряшова', '2816939574', '754741128' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ITСтройАлмаз', ID, 'fokin.eduard@samoilov.com', '8-800-185-78-91', '\agents\agent_83.png', '361730, Костромская область, город Волоколамск, шоссе Славы, 36', 159, 'Алексеева Валериан Андреевич', '7689065648', '456612755' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Асбоцемент', ID, 'antonin19@panfilov.ru', '8-800-211-16-23', '\agents\agent_34.png', '030119, Курганская область, город Дмитров, пер. Славы, 47', 273, 'Никитинаа Антонина Андреевна', '1261407459', '745921890' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ТекстильУралАвтоОпт', ID, 'hkononova@pavlova.ru', '(35222) 98-76-54', 'не указано', '028936, Магаданская область, город Видное, ул. Гагарина, 54', 176, 'Алина Сергеевна Дьячковаа', '3930950057', '678529397' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Компания КрепЦемент', ID, 'rusakov.efim@nikiforov.ru', '(812) 963-77-87', '\agents\agent_50.png', '423477, Мурманская область, город Кашира, бульвар Домодедовская, 61', 426, 'Екатерина Львовна Суворова', '3025099903', '606083992' FROM [dbo].[AgentType] WHERE [Title] = 'ООО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'КазаньТекстиль', ID, 'osimonova@andreeva.com', '(35222) 86-74-21', '\agents\agent_47.png', '231891, Челябинская область, город Шатура, бульвар Ладыгина, 40', 156, 'Александров Бронислав Максимович', '4584384019', '149680499' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'КазЮпитерТомск', ID, 'tgavrilov@frolov.ru', '+7 (922) 772-33-58', '\agents\agent_60.png', '393450, Тульская область, город Кашира, пр. 1905 года, 47', 244, 'Рафаил Андреевич Копылов', '9201745524', '510248846' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Бух', ID, 'belova.vikentii@konstantinova.net', '+7 (922) 375-49-21', '\agents\agent_78.png', '409600, Новгородская область, город Ногинск, пл. Гагарина, 68', 82, 'Татьяна Сергеевна Королёваа', '1953785418', '122905583' FROM [dbo].[AgentType] WHERE [Title] = 'МФО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Радио', ID, 'rtretykova@kozlov.ru', '8-800-897-32-78', '\agents\agent_43.png', '798718, Ленинградская область, город Пушкино, бульвар Балканская, 37', 221, 'Эмма Андреевна Колесникова', '9077613654', '657690787' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Креп', ID, 'savina.dominika@belousova.com', '(495) 217-46-29', '\agents\agent_39.png', '336489, Калининградская область, город Можайск, наб. Славы, 35', 371, 'Назар Алексеевич Григорьева', '4880732317', '258673591' FROM [dbo].[AgentType] WHERE [Title] = 'ЗАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'Мобайл', ID, 'dsiryev@dementeva.com', '8-800-618-73-37', '\agents\agent_107.png', '606703, Амурская область, город Чехов, пл. Будапештсткая, 91', 464, 'Екатерина Сергеевна Бобылёва', '7803888520', '885703265' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'CибБашкирТекстиль', ID, 'vzimina@zdanova.com', '(495) 285-78-38', '\agents\agent_69.png', '429540, Мурманская область, город Воскресенск, пл. Славы, 36', 218, 'Григорий Владимирович Елисеева', '7392007090', '576103661' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'МеталТекстильЛифтТрест', ID, 'muravev.trofim@sazonov.net', '(812) 753-96-76', '\agents\agent_86.png', '786287, Свердловская область, город Волоколамск, пер. Будапештсткая, 72', 425, 'Одинцов Назар Борисович', '2971553297', '821859486' FROM [dbo].[AgentType] WHERE [Title] = 'МКК';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ОрионТомскТех', ID, 'faina.tikonova@veselov.com', '+7 (922) 542-89-15', '\agents\agent_119.png', '738763, Курская область, город Егорьевск, спуск Чехова, 66', 73, 'Георгий Александрович Лукин', '9351493429', '583041591' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'ЖелДорДизайнМетизТраст', ID, 'lnikitina@kulikova.com', '(812) 123-63-47', 'не указано', '170549, Сахалинская область, город Видное, проезд Космонавтов, 89', 290, 'Игорь Львович Агафонова', '7669116841', '906390137' FROM [dbo].[AgentType] WHERE [Title] = 'ПАО';
INSERT INTO [dbo].[Agent] ([Title], [AgentTypeID], [Email], [Phone], [Logo], [Address], [Priority], [DirectorName], [INN], [KPP])
SELECT 'БухМясМоторПром', ID, 'varvara49@savin.ru', '(35222) 83-23-59', '\agents\agent_95.png', '677498, Костромская область, город Зарайск, спуск Славы, 59', 158, 'Нина Дмитриевна Черноваа', '7377410338', '592041317' FROM [dbo].[AgentType] WHERE [Title] = 'ОАО';

-- Заполнение типов продукции
INSERT INTO [dbo].[ProductType] ([Title], [DefectedPercent]) VALUES 
('Для маленьких деток', 0), ('Для больших деток', 0), ('Взрослый', 0), ('Цифровой', 0), ('Упругий', 0);

-- Заполнение продукции (все записи из TXT)
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 1289', ID, '82925345', 4, 10, 1919.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский желтый 6678', ID, '80007300', 2, 1, 1768 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский 6888', ID, '13875235', 4, 12, 1972 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для мальчиков 3929', ID, '2158097', 1, 9, 255 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский 2071', ID, '3157982', 3, 6, 275 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 5096', ID, '67975083', 4, 9, 1465 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для мальчиков 5389', ID, '70873532', 3, 2, 1739 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский розовый 5376', ID, '74291677', 4, 6, 1889.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для мальчиков 3307', ID, '30269726', 4, 10, 1533 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для кошечек 2604', ID, '11890154', 2, 7, 842 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Шар 6366', ID, '25514523', 4, 4, 1932 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский желтый 6051', ID, '88211092', 4, 12, 727 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для девочек 2311', ID, '25262035', 4, 1, 1308 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 4387', ID, '89607276', 3, 8, 912.00 FROM [dbo].[ProductType] WHERE [Title] = 'Упругий';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгун 3016', ID, '74919447', 1, 12, 615 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 3240', ID, '88098604', 3, 8, 882.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский розовый 1657', ID, '86558177', 4, 3, 662.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 6591', ID, '79704172', 5, 7, 592.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для девочек 1895', ID, '54983244', 4, 4, 1586 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для кошечек 3741', ID, '43987093', 5, 4, 1668.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 3839', ID, '26655484', 5, 2, 1921 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 4969', ID, '10614909', 5, 12, 913 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 5754', ID, '79018408', 2, 8, 633.00 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 4485', ID, '33440129', 2, 12, 1995 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для девочек 1656', ID, '22217580', 5, 6, 1494 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для мальчиков 4791', ID, '45540528', 3, 11, 1260 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для девочек 6849', ID, '10084400', 1, 11, 933 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский желтый 1371', ID, '85514178', 3, 7, 252 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для девочек 3389', ID, '26434211', 3, 10, 597.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский розовый 5197', ID, '89612317', 1, 3, 1948 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 3500', ID, '79994924', 2, 9, 1142.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгун 6882', ID, '12732041', 1, 6, 809 FROM [dbo].[ProductType] WHERE [Title] = 'Упругий';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для кошечек 4740', ID, '80698285', 1, 6, 1973.00 FROM [dbo].[ProductType] WHERE [Title] = 'Упругий';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Шар 2243', ID, '42536654', 3, 12, 1247.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 1740', ID, '43330133', 5, 3, 1749.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 5400', ID, '68237918', 4, 5, 1570.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для девочек 1560', ID, '47378395', 5, 6, 235 FROM [dbo].[ProductType] WHERE [Title] = 'Для маленьких деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Шар 4124', ID, '39025230', 5, 8, 1160 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский желтый 2582', ID, '32125209', 3, 11, 1730 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский 6029', ID, '69184347', 3, 7, 419 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгун 2299', ID, '34750945', 2, 2, 1688 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский красный 1972', ID, '59509797', 1, 7, 794.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский 5117', ID, '80875656', 3, 12, 338 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский розовый 5501', ID, '25409940', 2, 7, 652.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский розовый 6346', ID, '30282346', 1, 10, 1024.00 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгун 6412', ID, '28152672', 2, 9, 523 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский 1916', ID, '73345857', 5, 8, 832.00 FROM [dbo].[ProductType] WHERE [Title] = 'Взрослый';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 4529', ID, '81713527', 3, 6, 1923.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик для собачек 4381', ID, '27301447', 2, 5, 1234 FROM [dbo].[ProductType] WHERE [Title] = 'Цифровой';
INSERT INTO [dbo].[Product] ([Title], [ProductTypeID], [ArticleNumber], [ProductionPersonCount], [ProductionWorkshopNumber], [MinCostForAgent])
SELECT 'Попрыгунчик детский розовый 2694', ID, '13340356', 4, 6, 1691.00 FROM [dbo].[ProductType] WHERE [Title] = 'Для больших деток';

COMMIT TRANSACTION;
