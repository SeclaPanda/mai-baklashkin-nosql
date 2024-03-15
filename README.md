# Распределенные приложения МАИ 2023 
## Проект A2 - Бронирование комнат (Air BnB)
### Используемые технологии
- python 3.11 в качестве основного языка программирования
- fastapi для rest-api приложения
- mongodb как основное хранилище данных
- elasticsearch для полнотекстового поиска и бронирования
- redis для блокировки комнаты на время бронирования
- docker для виртуализации
- docker compose для оркестрации и запуска кластера
### Сценарии использования
- получить всех пользователей
- создать нового пользователя
- получить пользователя по id
- получить список всех комнат
- создать новую комнату
- найти свободные на заданные даты комнаты
- получить список всех бронирований
- забронировать комнату
- получить бронирование по id
### Конфигурация rest-api приложения
Переменные окружения по умолчанию передаются в контейнер app с помощью docker-compose.yml
|Переменная|Назначение|
|--------|-----------------------------------|
|MONGO_URI|строка подключения к mongodb|
|DB_NAME|используемая база данных mongodb|
|ELASTICSEARCH_URI|строка подключения к elasticsearch|
|REDIS_URI|строка подключения к redis|
|USER_PARSER_PATH|путь к Users.xml|
|USER_DATA_PATH|путь к Users.сsv|
|ROOM_DATA_PATH|путь к tomslee_airbnb_auckland_0534_2016-08-19.csv|
### Запуск кластера в docker
Запуск:
```
docker compose up -d
```
Состав кластера:
- mongodb - режим кластера, mongo01:27017, mongo02:27018, mongo03:27019 + один инициализирующий mongoinit
- elasticsearch - режим кластера, es01:9201, es02:9202, es03:9203 + kibana:5601
- redis - redis:6379
- приложение на python - app:8000
### Поведение под нагрузкой

| Состояние          | Работа (чтение/запись) | Отчёт | Дополнительные комментарии|
|---|---|---|---|
| 3 контейнера Mongo | да/да | Весь функционал приложения работает | Штатный режим работы кластера.
| 2 контейнера Mongo | да/да | Весь функционал приложения работает | Остановлен PRIMARY-контейнер mongo01.
| 1 контейнер  Mongo |нет/нет| Функционал приложения не работает   | Остановлены два контейнера Mongo
| 3 контейнера ES | да/да | Функционал бронирования работает исправно| Штатный режим работы кластера.
| 2 контейнера ES | да/да | Функционал бронирования работает исправно| Остановлен PRIMARY-контейнер es03.
| 1 контейнер  ES |нет/нет| Функционал бронирования недоступен       | Остановлены два контейнера Elastic