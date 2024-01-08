# MdEditor
## Getting Started

- Установите менеджер недостающих пакетов для macOS Homebrew с помощью команды в терминале 
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Скачайте и установите SwiftLint - утилиту для автоматической проверки Swift-кода
```
brew install swiftlint
```

- Установите tuist командной строкой в терминале 
```  
curl -Ls https://install.tuist.io | bash
```

- Сгенеририруйте фаил проекта
``` 
tuist generate
``` 
- Запустите файл MdEditor.xcodeproj 

- Для репозитория настроен CI/CD с помощью GitHub Actions

- SwiftGen встроен в tuist

## Требования

- Написано на Swift 5
- Поддерживается версия iOS 16.2
- Необходим Xcode 14.2
- SwiftLint
