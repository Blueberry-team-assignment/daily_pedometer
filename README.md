# Daily Pedomete

## 1. 프로젝트 명: 
Daily Pedometer (데일리 만보기)

<br>

## 2. 프로젝트 빌드 정보:

|제목|버전|비고|
|:---|:---|:---|
|Flutter|3.24.3|2024.12.08. 기준 최신 버전|
|Dart|3.5.3||
|Java|17|Correto-17|
|Gradle|8.0||
|AndroidStudio|Ladybug 2024.2.1 Patch 3|debug build success|
|XCode|16.1|debug build success|
|CocoaPods|1.15.2||

## 3. Clean Architecture 호출 흐름 구조
```
- XX_Repository <- XX_RepositoryImpl (구현체)
- XX_RepositoryImpl <- XX_Service (서비스 의존성)
- XX_UseCase <- XX_Repository (비즈니스 로직)
- XX_UseCaseProvider <- XX_UseCase (Provider로 관리)
- Screens <- XX_UseCaseProvider (UI에서 Provider 사용)
```