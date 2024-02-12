# FileManagerPackage

Пакет содержит набор классов для работы с файлами на устройстве

##Файловый загрузчик

Класс `FileExplorer` предоставляет функции для работы с файлами:

- `func scan(sources: [FileSourceType])` -- поиск источников фалов;
- `func scan(url: URL) ` -- поиск файлов по URL;
- `func getFile(url: URL) -> File?` -- получение файла;
- ` func createFile(with name: String, data: Data, url: URL)` -- создание файла;
- `func createFolder(with name: String, url: URL)` -- создание папки;
- `func loadFileBody(url: URL) throws -> String ` -- загрузка текста файла;

##Файл

Класс `File` предоставляет информацию о файле:
