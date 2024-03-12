# MarkdownParserPackage

Пакет содержит набор классов для работы со markdown текстом

## Lexer

Класс `Lexer` предоставляет методы для лексический анализа текста и вычисления токенов

- `func tokenize(_ input: String) -> [Token]` -- анализ текста;

## Parser

Класс `Parser` предоставляет методы для синтаксического анализа, преобразует токены в структурированный формат используя дерево разбора

- `func parse(tokens: [Token]) -> Document` -- анализ токенов;

## MarkdownParserManager

Класс `MarkdownParserManager` предоставляет методы для анализа, используя `Lexer` и `Parser`

- `init(lexer: ILexer, parser: IParser)` -- инициализация менеджера с лексером и парсером
- `func analyse(_ input: String) -> Document` -- анализ текста;

##  Примеры использования

```
let document = MarkdownParserManager().analyse(text)
```

```
let tokens = Lexer().tokenize(text)
let document = Parser().parse(tokens: tokens)
```
