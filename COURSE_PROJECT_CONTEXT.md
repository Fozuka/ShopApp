# Контекст для написания курсовой работы по проекту TechStore

Этот файл нужен как справка для GPT или другого помощника, который будет писать текст курсовой работы по проекту. Здесь описано, каким приложение было изначально, что было доработано, какая архитектура используется, какие файлы важны и как раскрывать тему курсовой.

## 1. Исходное состояние проекта

Проект находится в папке:

```text
C:\Users\pc\AndroidStudioProjects\shop_app
```

Это Flutter-приложение интернет-магазина электроники. Изначально проект был сделан по лабораторным работам и имел учебную структуру:

- почти весь UI находился в одном файле `lib/main.dart`;
- каталог товаров загружался из локального JSON-файла `assets/data/products.json`;
- товары были статичными;
- корзина была ненастоящей: в ней вручную были захардкожены iPhone и AirPods;
- кнопки `Купить` фактически ничего не делали;
- оформление заказа принимало только данные формы и не было связано с корзиной;
- экран подтверждения заказа показывал только введенные пользователем данные;
- тест был стандартным counter-test из шаблона Flutter и ссылался на несуществующий `MyApp`;
- архитектура была лабораторной, а не курсовой.

В проекте уже были:

- главная страница магазина;
- каталог;
- корзина;
- профиль;
- форма оформления заказа;
- экран подтверждения заказа;
- раздел со статьями через WebView;
- локальные изображения товаров;
- нижняя навигация.

## 2. Требования курсового проекта

По заданию курсовая работа должна быть на тему:

```text
Исследование современных подходов и паттернов при разработке клиент-серверных мобильных приложений
```

Основные требования из задания:

- реализовать мобильное приложение с клиент-серверным взаимодействием;
- использовать архитектурный подход или паттерн;
- получить данные из внешнего API REST или GraphQL;
- отобразить данные в виде списка;
- сделать переход на экран деталей;
- обработать состояния загрузки, ошибки и пустого списка;
- реализовать простую навигацию;
- опционально добавить локальное состояние, фильтрацию или сортировку;
- выполнить исследовательский анализ выбранного подхода;
- подготовить PDF-отчет и исходный код.

Разрешено использовать Flutter, что и сделано в проекте.

## 3. Выбранная тема курсовой

Рекомендуемая формулировка темы:

```text
Исследование применения Clean Architecture и Riverpod при разработке клиент-серверного Flutter-приложения интернет-магазина электроники
```

Более короткий вариант:

```text
Разработка клиент-серверного Flutter-приложения интернет-магазина электроники с применением Clean Architecture и Riverpod
```

Исследовательский фокус:

- как разделение на слои `data / domain / presentation` влияет на поддержку и расширяемость проекта;
- как Riverpod помогает управлять асинхронными состояниями API и локальным состоянием корзины;
- какие преимущества дает архитектурный подход по сравнению с лабораторной структурой, где почти весь код был в `main.dart`.

Гипотеза для курсовой:

```text
Применение Clean Architecture совместно с Riverpod повышает модульность Flutter-приложения, упрощает обработку асинхронных состояний и делает проект более удобным для расширения по сравнению с монолитной лабораторной структурой.
```

## 4. Что было сделано в ходе доработки

### 4.1. Рефакторинг структуры проекта

Код был разнесен по папкам:

```text
lib/
  app/
  features/
    articles/
    cart/
    catalog/
    checkout/
    home/
    orders/
    profile/
  shared/
  main.dart
```

Файл `lib/main.dart` теперь является только точкой входа и содержит `ProviderScope`.

Приложение вынесено в:

```text
lib/app/electronics_shop_app.dart
```

Нижняя навигация вынесена в:

```text
lib/app/main_page.dart
```

Общие виджеты вынесены в:

```text
lib/shared/widgets/
```

### 4.2. Подключение Riverpod и HTTP

В `pubspec.yaml` добавлены зависимости:

```yaml
flutter_riverpod: ^2.6.1
http: ^1.2.2
```

После этого был выполнен:

```powershell
C:\flutter\bin\flutter.bat pub get
```

Riverpod используется для:

- асинхронной загрузки товаров из API;
- хранения состояния корзины;
- подсчета количества товаров;
- подсчета итоговой суммы заказа.

HTTP используется для REST-запросов к DummyJSON.

### 4.3. Переход с локального JSON на внешний API

Изначально товары загружались из:

```text
assets/data/products.json
```

Теперь каталог работает через внешний REST API:

```text
https://dummyjson.com
```

Чтобы приложение оставалось именно магазином электроники, общий endpoint `/products` не используется. Вместо него загружаются только категории:

```text
smartphones
laptops
tablets
mobile-accessories
```

API-запросы выполняются в:

```text
lib/features/catalog/data/datasources/product_remote_data_source.dart
```

Категории загружаются через endpoint:

```text
/products/category/{category}
```

Например:

```text
https://dummyjson.com/products/category/smartphones
```

### 4.4. Архитектура каталога

Каталог построен по слоям, близким к Clean Architecture:

```text
lib/features/catalog/
  data/
    datasources/
      product_remote_data_source.dart
    models/
      product_dto.dart
    repositories/
      product_repository_impl.dart
  domain/
    entities/
      product.dart
    repositories/
      product_repository.dart
    usecases/
      get_products_use_case.dart
      get_product_by_id_use_case.dart
  presentation/
    providers/
      catalog_providers.dart
    screens/
      catalog_page.dart
      product_details_page.dart
```

Назначение слоев:

- `domain` содержит бизнес-сущность `Product`, абстракцию `ProductRepository` и use cases;
- `data` содержит DTO, сетевой источник данных и реализацию репозитория;
- `presentation` содержит Riverpod providers и UI-экраны.

Ключевые файлы:

```text
lib/features/catalog/domain/entities/product.dart
```

Сущность товара. Содержит:

- `id`;
- `title`;
- `description`;
- `price`;
- `imageUrl`;
- `category`;
- `rating`;
- `stock`;
- `formattedPrice`.

```text
lib/features/catalog/domain/repositories/product_repository.dart
```

Абстракция репозитория:

- `getProducts()`;
- `getProductById(int id)`.

```text
lib/features/catalog/domain/usecases/get_products_use_case.dart
```

Use case для получения списка товаров. Он инкапсулирует пользовательский сценарий загрузки каталога и обращается к `ProductRepository`.

```text
lib/features/catalog/domain/usecases/get_product_by_id_use_case.dart
```

Use case для получения товара по идентификатору. Он используется экраном деталей товара через provider.

```text
lib/features/catalog/data/models/product_dto.dart
```

DTO для преобразования JSON из API в доменную сущность.

```text
lib/features/catalog/data/datasources/product_remote_data_source.dart
```

Сетевой источник данных. Выполняет HTTP-запросы к DummyJSON.

```text
lib/features/catalog/data/repositories/product_repository_impl.dart
```

Реализация репозитория. Получает DTO из data source и преобразует их в `Product`.

```text
lib/features/catalog/presentation/providers/catalog_providers.dart
```

Riverpod providers:

- `httpClientProvider`;
- `productRemoteDataSourceProvider`;
- `productRepositoryProvider`;
- `getProductsUseCaseProvider`;
- `getProductByIdUseCaseProvider`;
- `productsProvider`;
- `productDetailsProvider`.

Важно: после усиления архитектуры `productsProvider` и `productDetailsProvider` больше не вызывают repository напрямую. Они используют use cases:

```dart
ref.watch(getProductsUseCaseProvider)()
ref.watch(getProductByIdUseCaseProvider)(id)
```

Это делает реализацию ближе к Clean Architecture: presentation-слой зависит от пользовательских сценариев, а не напрямую от репозитория.

```text
lib/features/catalog/presentation/screens/catalog_page.dart
```

Экран каталога. Показывает:

- loading;
- error;
- empty;
- список товаров.

Также умеет принимать фильтр категории:

- `category`;
- `categoryTitle`.

Если фильтр передан, экран показывает только товары выбранной категории.

```text
lib/features/catalog/presentation/screens/product_details_page.dart
```

Экран деталей товара. Показывает:

- изображение;
- название;
- цену;
- категорию;
- рейтинг;
- остаток на складе;
- описание;
- кнопку добавления в корзину.

### 4.5. Главная страница и категории

Главная страница:

```text
lib/features/home/screens/home_page.dart
```

На главной отображается магазин `TechStore` и категории:

- смартфоны;
- ноутбуки;
- планшеты;
- аксессуары.

Карточки категорий открывают каталог с фильтром:

- `Смартфоны` -> `smartphones`;
- `Ноутбуки` -> `laptops`;
- `Планшеты` -> `tablets`;
- `Аксессуары` -> `mobile-accessories`.

Общий каталог через нижнюю навигацию показывает все категории электроники.

Карточка категории:

```text
lib/shared/widgets/category_card.dart
```

Она получила `onTap`, чтобы категории стали кликабельными.

### 4.6. Корзина

Корзина была полностью переделана. Изначально она была статичной, теперь это реальное локальное состояние приложения на Riverpod.

Структура:

```text
lib/features/cart/
  domain/
    entities/
      cart_item.dart
  presentation/
    providers/
      cart_provider.dart
    screens/
      cart_page.dart
```

Ключевые файлы:

```text
lib/features/cart/domain/entities/cart_item.dart
```

Сущность элемента корзины:

- `product`;
- `quantity`;
- `totalPrice`;
- `copyWith`.

```text
lib/features/cart/presentation/providers/cart_provider.dart
```

Riverpod Notifier для корзины.

Содержит:

- `cartProvider`;
- `cartTotalProvider`;
- `cartItemsCountProvider`;
- `CartNotifier`.

Методы:

- `addProduct(Product product)`;
- `decreaseQuantity(int productId)`;
- `removeProduct(int productId)`;
- `clear()`.

Поведение:

- если товар добавляется впервые, он появляется в корзине с количеством 1;
- если товар уже есть, увеличивается `quantity`;
- при уменьшении количества до нуля товар удаляется;
- итоговая сумма считается автоматически;
- количество товаров считается автоматически.

```text
lib/features/cart/presentation/screens/cart_page.dart
```

Экран корзины. Показывает:

- пустое состояние;
- список товаров;
- количество;
- кнопки `+` и `-`;
- удаление товара;
- итоговую сумму;
- кнопку оформления заказа.

### 4.7. Оформление заказа

Checkout был связан с реальной корзиной.

Ключевые файлы:

```text
lib/features/checkout/models/checkout_data.dart
```

Модель данных заказа. Содержит:

- `name`;
- `phone`;
- `address`;
- `comment`;
- `items`;
- `total`.

```text
lib/features/checkout/screens/checkout_form_page.dart
```

Форма оформления заказа.

Теперь она:

- читает корзину из Riverpod;
- показывает количество товаров и итоговую сумму;
- не дает оформить заказ с пустой корзиной;
- валидирует имя;
- валидирует телефон;
- валидирует адрес;
- передает список товаров и сумму на экран подтверждения.

```text
lib/features/checkout/screens/checkout_confirm_page.dart
```

Экран подтверждения заказа.

Теперь он показывает:

- данные получателя;
- комментарий;
- состав заказа;
- количество каждого товара;
- сумму по позициям;
- общую сумму.

При нажатии `Подтвердить заказ`:

- корзина очищается;
- приложение возвращается на главный экран;
- показывается сообщение `Заказ оформлен`.

### 4.8. Раздел статей

Раздел статей остался из лабораторной работы.

Файлы:

```text
lib/features/articles/models/article_site.dart
lib/features/articles/screens/article_sites_page.dart
lib/features/articles/screens/web_view_page.dart
```

Он показывает список сайтов со статьями об электронике и открывает их через WebView.

Этот раздел можно упомянуть как дополнительный информационный модуль приложения, но не делать на нем основной акцент в курсовой.

### 4.9. Профиль и заказы

Профиль:

```text
lib/features/profile/screens/profile_page.dart
```

Пока содержит статичные данные пользователя.

Заказы:

```text
lib/features/orders/screens/orders_page.dart
```

Экран заказов существует, но не подключен к нижней навигации и не является центральной частью курсовой.

Основной акцент лучше делать на:

- каталоге;
- REST API;
- Riverpod;
- корзине;
- checkout;
- архитектуре.

## 5. Общие виджеты

Общие виджеты находятся в:

```text
lib/shared/widgets/
```

Файлы:

```text
category_card.dart
order_card.dart
product_card.dart
shop_screen.dart
```

Назначение:

- `ShopScreen` - общий экран с `AppBar`, `SafeArea` и прокруткой;
- `ProductCard` - карточка товара, поддерживает asset-изображения и network-изображения;
- `CategoryCard` - карточка категории с обработчиком нажатия;
- `OrderCard` - карточка заказа, осталась для экрана заказов.

## 6. Тесты

Тесты находятся в:

```text
test/
```

Файлы:

```text
test/widget_test.dart
test/cart_provider_test.dart
```

`widget_test.dart`:

- smoke-test запуска приложения;
- проверяет, что главная страница открывается.

`cart_provider_test.dart`:

- unit-тест бизнес-логики корзины;
- проверяет, что два одинаковых товара объединяются в одну позицию;
- проверяет количество;
- проверяет итоговую сумму.

Команды проверки:

```powershell
C:\flutter\bin\dart.bat format lib test
C:\flutter\bin\flutter.bat analyze
C:\flutter\bin\flutter.bat test
```

Последний результат проверок:

```text
No issues found
All tests passed
```

Обычная команда `flutter` в PowerShell не работает, потому что Flutter не добавлен в PATH. Поэтому используется полный путь:

```powershell
C:\flutter\bin\flutter.bat
```

## 7. Как проект соответствует заданию

Требование: получение данных из внешнего API.

Реализация:

```text
ProductRemoteDataSource -> DummyJSON REST API
```

Требование: отображение данных в виде списка.

Реализация:

```text
CatalogPage
```

Требование: переход на экран деталей.

Реализация:

```text
ProductDetailsPage
```

Требование: loading/error/empty/success.

Реализация:

```text
productsProvider + AsyncValue.when(...)
```

В `CatalogPage` есть:

- `_CatalogLoadingView`;
- `_CatalogErrorView`;
- `_CatalogEmptyView`;
- список товаров при успешной загрузке.

Требование: простая навигация.

Реализация:

- нижняя навигация в `MainPage`;
- переход из каталога в детали товара;
- переход из корзины к оформлению заказа;
- переход из формы к подтверждению заказа;
- переход с главной в отфильтрованный каталог.

Требование: архитектурно организованный проект.

Реализация:

- feature-based структура;
- разделение каталога на `data / domain / presentation`;
- Riverpod providers;
- отдельные shared widgets.

Опциональное требование: фильтрация.

Реализация:

- категории на главном экране открывают отфильтрованный каталог.

Опциональное требование: локальное состояние.

Реализация:

- корзина на Riverpod.

## 8. Как раскрывать тему в отчете

### Введение

Во введении нужно написать:

- мобильные приложения часто работают с удаленными данными;
- при росте приложения монолитная структура усложняет поддержку;
- поэтому актуально исследовать архитектурные подходы;
- в работе рассматривается Flutter-приложение интернет-магазина электроники;
- применяются Clean Architecture и Riverpod;
- приложение получает товары из REST API и управляет локальным состоянием корзины.

Цель:

```text
Исследовать применение Clean Architecture и Riverpod при разработке клиент-серверного мобильного приложения на Flutter.
```

Задачи:

- изучить принципы Clean Architecture;
- изучить управление состоянием с Riverpod;
- разработать клиент-серверное приложение интернет-магазина;
- реализовать загрузку товаров из REST API;
- реализовать состояния загрузки, ошибки, пустого списка и успешной загрузки;
- реализовать каталог, детали товара, корзину и оформление заказа;
- оценить преимущества и ограничения выбранного подхода.

### Теоретическая часть

Описать:

- Flutter как фреймворк для кроссплатформенной мобильной разработки;
- REST API как способ клиент-серверного взаимодействия;
- Clean Architecture;
- слои `data / domain / presentation`;
- DTO;
- repository pattern;
- use case pattern;
- Riverpod;
- отличие серверного состояния от локального состояния.

Важно:

Clean Architecture и Riverpod не являются конкурентами. Clean Architecture отвечает за организацию кода и зависимости между слоями, а Riverpod отвечает за управление состоянием и внедрение зависимостей.

В проекте слой `domain` включает не только сущности и абстракции репозиториев, но и use cases. Use cases описывают конкретные сценарии приложения: получение списка товаров и получение товара по идентификатору. Это позволяет presentation-слою обращаться к бизнес-сценариям, а не к репозиторию напрямую.

### Практическая часть

Описать приложение:

- название: `TechStore`;
- тип: интернет-магазин электроники;
- товары загружаются с DummyJSON;
- используются только категории электроники;
- пользователь может открыть общий каталог;
- пользователь может открыть категорию с главного экрана;
- пользователь может открыть детали товара;
- пользователь может добавить товар в корзину;
- пользователь может изменить количество товаров;
- пользователь может оформить заказ;
- после подтверждения корзина очищается.

Описать структуру проекта и основные файлы.

### Аналитическая часть

Сравнить исходный лабораторный подход и текущий архитектурный подход.

Исходный подход:

- все в одном файле;
- трудно расширять;
- UI смешан с логикой;
- данные локальные;
- корзина статичная;
- тесты не соответствовали проекту.

Новый подход:

- код разделен по features;
- каталог разделен на `data / domain / presentation`;
- API отделен от UI;
- UI работает с providers;
- providers каталога используют use cases;
- корзина реализована как локальное состояние;
- легче добавлять новые источники данных;
- легче тестировать бизнес-логику.

Преимущества:

- модульность;
- читаемость;
- расширяемость;
- явная обработка состояний;
- удобное внедрение зависимостей;
- возможность тестирования provider-логики.

Недостатки:

- больше файлов;
- выше начальная сложность;
- для маленького приложения архитектура может казаться избыточной;
- нужно понимать Riverpod и принципы разделения слоев.

Вывод:

Для учебного клиент-серверного приложения Clean Architecture + Riverpod является удачным решением, потому что показывает современный подход к Flutter-разработке, позволяет отделить API от UI и демонстрирует управление как асинхронным состоянием, так и локальным состоянием корзины.

## 9. Что не нужно раздувать в курсовой

Не нужно делать основной акцент на:

- реальной оплате;
- авторизации;
- Firebase;
- собственном backend;
- сложной админ-панели;
- красивых анимациях;
- полноценной истории заказов.

Задание требует архитектуру, API, состояния и анализ. Поэтому главный акцент должен быть на архитектурной переработке лабораторной работы в клиент-серверное приложение.

## 10. Возможные формулировки для отчета

Про исходную проблему:

```text
Изначальная версия приложения имела лабораторную структуру: основная часть интерфейса находилась в одном файле, данные каталога загружались из локального JSON, а корзина была статичной. Такая организация подходит для демонстрации отдельных виджетов, но плохо масштабируется при добавлении клиент-серверного взаимодействия и состояния приложения.
```

Про архитектуру:

```text
Для повышения модульности проект был разделен на функциональные модули. Каталог товаров реализован с использованием подхода, близкого к Clean Architecture: слой data отвечает за получение и преобразование данных, слой domain содержит бизнес-сущности, абстракции репозиториев и use cases, а слой presentation отвечает за UI и состояние.
```

Про use cases:

```text
Для более корректного соответствия Clean Architecture в доменный слой были добавлены use cases: GetProductsUseCase и GetProductByIdUseCase. Они инкапсулируют основные пользовательские сценарии каталога, а presentation-слой обращается к ним через Riverpod providers.
```

Про Riverpod:

```text
Riverpod используется как инструмент управления состоянием и внедрения зависимостей. С его помощью реализована асинхронная загрузка товаров из API, обработка состояний loading, error, empty и data, а также локальное состояние корзины.
```

Про API:

```text
В качестве внешнего источника данных используется DummyJSON. Для сохранения предметной целостности приложения загружаются только категории, связанные с электроникой: smartphones, laptops, tablets и mobile-accessories.
```

Про результат:

```text
В результате лабораторное приложение было преобразовано в клиент-серверный мобильный проект с архитектурным разделением, внешним API, экраном деталей товара, фильтрацией по категориям, корзиной и оформлением заказа.
```

## 11. Текущее состояние проекта

На текущий момент реализовано:

- архитектурная структура проекта;
- слой domain/usecases для каталога;
- внешний REST API;
- каталог электроники;
- фильтрация по категориям с главной страницы;
- экран деталей товара;
- обработка loading/error/empty/success;
- корзина на Riverpod;
- изменение количества товаров;
- удаление товаров из корзины;
- оформление заказа;
- подтверждение заказа;
- очистка корзины после подтверждения;
- smoke-test приложения;
- unit-тест корзины.

Проект уже подходит как практическая часть курсовой. Для сдачи останется подготовить отчет PDF и, при необходимости, README с инструкцией запуска.

## 12. Последнее архитектурное усиление: domain/usecases

После основной доработки проекта была выполнена дополнительная архитектурная правка, чтобы каталог точнее соответствовал Clean Architecture.

До этой правки:

- в каталоге уже были слои `data / domain / presentation`;
- был `ProductRepository`;
- были Riverpod providers;
- но `productsProvider` и `productDetailsProvider` обращались к repository напрямую.

Что было сделано:

- добавлена папка `lib/features/catalog/domain/usecases/`;
- создан `GetProductsUseCase`;
- создан `GetProductByIdUseCase`;
- в `catalog_providers.dart` добавлены providers для use cases;
- `productsProvider` переведен на `GetProductsUseCase`;
- `productDetailsProvider` переведен на `GetProductByIdUseCase`;
- UI не менялся;
- data-слой не менялся;
- presentation-слой был изменен только в файле providers;
- новые библиотеки не добавлялись;
- функциональность приложения осталась прежней.

Новые файлы:

```text
lib/features/catalog/domain/usecases/get_products_use_case.dart
lib/features/catalog/domain/usecases/get_product_by_id_use_case.dart
```

Измененный файл:

```text
lib/features/catalog/presentation/providers/catalog_providers.dart
```

Итоговая структура каталога после усиления:

```text
lib/features/catalog/
  data/
    datasources/
      product_remote_data_source.dart
    models/
      product_dto.dart
    repositories/
      product_repository_impl.dart
  domain/
    entities/
      product.dart
    repositories/
      product_repository.dart
    usecases/
      get_product_by_id_use_case.dart
      get_products_use_case.dart
  presentation/
    providers/
      catalog_providers.dart
    screens/
      catalog_page.dart
      product_details_page.dart
```

Как объяснять это в курсовой:

```text
На завершающем этапе архитектура каталога была усилена за счет добавления слоя use cases в domain. Это позволило убрать прямое обращение presentation-слоя к repository при выполнении пользовательских сценариев. Теперь Riverpod providers используют GetProductsUseCase и GetProductByIdUseCase, а сами use cases обращаются к абстракции ProductRepository. Такое разделение лучше соответствует Clean Architecture, так как сценарии приложения представлены отдельными объектами доменного слоя.
```

Почему это важно:

- use cases явно описывают действия пользователя или приложения;
- presentation-слой меньше знает о деталях получения данных;
- repository остается абстракцией источника данных;
- data-слой по-прежнему можно заменить без изменения UI;
- проект проще описывать как Clean Architecture в отчете.

Проверки после этой доработки:

```powershell
C:\flutter\bin\dart.bat format lib test
C:\flutter\bin\flutter.bat analyze
C:\flutter\bin\flutter.bat test
```

Результат:

```text
No issues found
All tests passed
```
