Category.create!([
  {id: 314, icon: "23", parent_id: "23", title: "Повреждение остановки общественного транспорта"},
  {id: 306, icon: "22", parent_id: "22", title: "Ненадлежащее состояние рекламной конструкции"},
  {id: 312, icon: "23", parent_id: "23", title: "Отсутствие остановочных указателей маршрутов"},
  {id: 303, icon: "21", parent_id: "21", title: "Требуется посадка деревьев, кустарников"},
  {id: 304, icon: "21", parent_id: "21", title: "Необходим снос сухих и аварийных деревьев"},
  {id: 313, icon: "23", parent_id: "23", title: "Отсутствие урны"},
  {id: 302, icon: "21", parent_id: "21", title: "Иное"},
  {id: 301, icon: "21", parent_id: "21", title: "Некачественное содержание инфраструктуры в парках / скверах"},
  {id: 307, icon: "22", parent_id: "22", title: "Иное"},
  {id: 310, icon: "23", parent_id: "23", title: "Грязь/мусор на остановках общественного транспорта"},
  {id: 311, icon: "23", parent_id: "23", title: "Несанкционированные надписи, изображения на остановках общественного транспорта"},
  {id: 289, icon: "20", parent_id: "20", title: "Поврежденные искусственные дорожные неровности"},
  {id: 291, icon: "20", parent_id: "20", title: "Просадка люка/Незакрытый люк"},
  {id: 294, icon: "20", parent_id: "20", title: "Неисправность/недоступность инфраструктуры для маломобильных граждан"},
  {id: 290, icon: "20", parent_id: "20", title: "Подтопление проезжей части"},
  {id: 293, icon: "20", parent_id: "20", title: "Ямы/выступы на проезжей части/тротуаре"},
  {id: 26, icon: "6", parent_id: "6", title: "Наличие выбоин и ям на проезжей части двора"},
  {id: 37, icon: "6", parent_id: "6", title: "Техническое состояние покрытий пешеходных дорожек, парковок"},
  {id: 283, icon: "20", parent_id: "20", title: "Некачественная укладка плитки на тротуаре"},
  {id: 281, icon: "20", parent_id: "20", title: "Неисправное освещение на проезжей части"},
  {id: 67, icon: "10", parent_id: "10", title: "Отсутствие освещения в подъезде"},
  {id: 371, icon: "6", parent_id: "6", title: "Отсутствие дворового освещения"},
  {id: 372, icon: "6", parent_id: "6", title: "Просадка люка/незакрытый люк"},
  {id: 23, icon: "23", parent_id: nil, title: "Инфраструктура города | Общественный транспорт, остановки общественного транспорта"},
  {id: 22, icon: "22", parent_id: nil, title: "Инфраструктура города | Рекламные и информационные конструкции"},
  {id: 21, icon: "21", parent_id: nil, title: "Инфраструктура города | Парки, скверы"},
  {id: 20, icon: "20", parent_id: nil, title: "Инфраструктура города | Дороги, тротуары"},
  {id: 14, icon: "14", parent_id: nil, title: "Многоквартирные дома | Санитарное состояние"},
  {id: 13, icon: "13", parent_id: nil, title: "Многоквартирные дома | Неисправность лифта"},
  {id: 12, icon: "12", parent_id: nil, title: "Многоквартирные дома | Текущий ремонт жилфонда за счет средств плательщиков"},
  {id: 11, icon: "11", parent_id: nil, title: "Многоквартирные дома | Общестроительные работы"},
  {id: 10, icon: "10", parent_id: nil, title: "Многоквартирные дома | Электроработы"},
  {id: 9, icon: "9", parent_id: nil, title: "Многоквартирные дома | Общие проблемы, неисправности, повреждения"},
  {id: 7, icon: "7", parent_id: nil, title: "Дворовые территории | Санитарное состояние"},
  {id: 54, icon: "9", parent_id: "9", title: "Протечка канализационных стоков на дворовую территорию, во вспомогательные помещения"},
  {id: 151, icon: "14", parent_id: "14", title: "Не убраны от мусора вспомогательные помещения"},
  {id: 66, icon: "10", parent_id: "10", title: "Иное"},
  {id: 48, icon: "7", parent_id: "7", title: "Иное"},
  {id: 292, icon: "20", parent_id: "20", title: "Отсутсвует или повреждена дорожная разметка"},
  {id: 6, icon: "6", parent_id: nil, title: "Дворовые территории | Благоустройство территории"},
  {id: 57, icon: "9", parent_id: "9", title: "Иные общие проблемы, неисправности, повреждения"},
  {id: 364, icon: "20", parent_id: "20", title: "Иные дорожные проблемы,тротуары"},
  {id: 325, icon: "6", parent_id: "6", title: "Иные проблемы благоустройства территорий"},
  {id: 154, icon: "14", parent_id: "14", title: "Не вымыты окна в подъезде"},
  {id: 99, icon: "11", parent_id: "11", title: "Повреждения лестничных ступеней"},
  {id: 299, icon: "21", parent_id: "21", title: "Неисправность освещения"},
  {id: 282, icon: "20", parent_id: "20", title: "Неисправный светофор"},
  {id: 156, icon: "14", parent_id: "14", title: "Иное"},
  {id: 369, icon: "11", parent_id: "11", title: "Иное"},
  {id: 296, icon: "20", parent_id: "20", title: "Благоустройство улиц"},
  {id: 36, icon: "6", parent_id: "6", title: "Содержание пешеходных лестниц"},
  {id: 33, icon: "6", parent_id: "6", title: "Техническое состояние контейнеров для сбора отходов"},
  {id: 285, icon: "20", parent_id: "20", title: "Неубранная проезжая часть/тротуар"},
  {id: 28, icon: "6", parent_id: "6", title: "Состояние площадок для выгула домашних животных"},
  {id: 63, icon: "10", parent_id: "10", title: "Отсутствие фасадного освещения"},
  {id: 140, icon: "13", parent_id: "13", title: "Отсутствует (недостаточное) освещение кабины лифта"},
  {id: 370, icon: "6", parent_id: "6", title: "Наличие просадки грунта вокруг технических колодцев"},
  {id: 29, icon: "6", parent_id: "6", title: "Содержание и техническое состояние оборудования детской площадки"},
  {id: 27, icon: "6", parent_id: "6", title: "Обрезка, посадка, и снос деревьев и кустарников"},
  {id: 94, icon: "11", parent_id: "11", title: "Течь кровли"},
  {id: 30, icon: "6", parent_id: "6", title: "Наличие и техническое состояние скамеек, урн, цветочниц, беседок и др."},
  {id: 25, icon: "6", parent_id: "6", title: "Брошенные автомобили"},
  {id: 40, icon: "7", parent_id: "7", title: "Не убрана дворовая территория"},
  {id: 367, icon: "23", parent_id: "23", title: "Иное"},
  {id: 61, icon: "10", parent_id: "10", title: "Не закреплена электропроводка на лестничной клетке"},
  {id: 118, icon: "12", parent_id: "12", title: "Иное"},
  {id: 315, icon: "23", parent_id: "23", title: "Повреждение остановочных указателей маршрутов"},
  {id: 280, icon: "20", parent_id: "20", title: "Брошенный автомобиль на проезжей части"},
  {id: 295, icon: "20", parent_id: "20", title: "Некачественное содержание подземных и надземных пешеходных переходов"},
  {id: 98, icon: "11", parent_id: "11", title: "Требуется ремонт отмостки"},
  {id: 64, icon: "10", parent_id: "10", title: "Постоянно горит свет в подъезде"},
  {id: 138, icon: "13", parent_id: "13", title: "Не работают кнопки управления лифтом"},
  {id: 104, icon: "11", parent_id: "11", title: "Наличие трещин на стене"},
  {id: 111, icon: "12", parent_id: "12", title: "Требуется восстановление штукатурки и облицовки стен, потолков"},
  {id: 100, icon: "11", parent_id: "11", title: "Повреждения входной двери в подъезд, подвал"},
  {id: 297, icon: "20", parent_id: "20", title: "Проблемы с гаражами / автостоянками / парковками"},
  {id: 101, icon: "11", parent_id: "11", title: "Течь стыков, промерзание стыков, промерзание стеновых панелей"},
  {id: 97, icon: "11", parent_id: "11", title: "Оборваны или не закреплены водосточные трубы"},
  {id: 112, icon: "12", parent_id: "12", title: "Выбоины, неровности , трещины стен и потолка"},
  {id: 45, icon: "7", parent_id: "7", title: "Не вывезен крупногабаритный мусор"},
  {id: 109, icon: "13", parent_id: "13", title: "Поврежден корпус кабины лифта"},
  {id: 152, icon: "14", parent_id: "14", title: "Загромождение вспомогательных помещений"},
  {id: 38, icon: "6", parent_id: "6", title: "Содержание песочниц и наличие в них песка"},
  {id: 142, icon: "13", parent_id: "13", title: "Лифт не работает"},
  {id: 47, icon: "7", parent_id: "7", title: "Не очищены урны"},
  {id: 44, icon: "7", parent_id: "7", title: "Наличие безнадзорных животных на территории"},
  {id: 52, icon: "9", parent_id: "9", title: "Несанкционированные объявления, надписи и рисунки на фасадах"},
  {id: 42, icon: "7", parent_id: "7", title: "Не убрана контейнерная площадка"},
  {id: 41, icon: "7", parent_id: "7", title: "Не вывезены контейнеры с твердыми коммунальными отходами"},
  {id: 286, icon: "20", parent_id: "20", title: "Повреждение уличной лестницы"},
  {id: 34, icon: "6", parent_id: "6", title: "Cостояние ограждения контейнерной площадки"},
  {id: 153, icon: "14", parent_id: "14", title: "Наличие грызунов или насекомых"},
  {id: 287, icon: "20", parent_id: "20", title: "Нечитаемые/поврежденные/неправильно установленные дорожные знаки"},
  {id: 62, icon: "10", parent_id: "10", title: "Открыт электрощиток"},
  {id: 137, icon: "13", parent_id: "13", title: "Иное"},
  {id: 324, icon: "6", parent_id: "6", title: "Требуется ремонт (установка) ограждения"},
  {id: 102, icon: "11", parent_id: "11", title: "Выветривание швов кирпичной кладки"},
  {id: 284, icon: "20", parent_id: "20", title: "Некачественное содержание велодорожек"},
  {id: 117, icon: "12", parent_id: "12", title: "Требуется окраска стен, потолков, трубопроводов"},
  {id: 55, icon: "9", parent_id: "9", title: "Протечка воды на дворовую территорию, во вспомогательные помещения"},
  {id: 46, icon: "7", parent_id: "7", title: "Не скошен газон"},
  {id: 103, icon: "11", parent_id: "11", title: "Отслоение облицовочной плитки на фасаде дома"}
])
