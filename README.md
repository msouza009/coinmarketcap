# CoinMarketCap Flutter App

Aplicativo Flutter simples para consultar informa\u00e7\u00f5es de criptomoedas utilizando a API da CoinMarketCap.

## Vis\u00e3o geral

Este projeto demonstra o consumo de uma API REST em Flutter, exibindo cota\u00e7\u00f5es de diversas moedas.
Ele usa o pacote **provider** para gerenciamento de estado e **http** para realizar as requisi\u00e7\u00f5es.

## Depend\u00eancias

- Flutter 3.8 ou superior
- Dart SDK 3.8 ou superior
- Pacotes: `http`, `provider`, `intl`

## Como executar

1. Instale as depend\u00eancias:
   ```sh
   flutter pub get
   ```
2. Altere a chave de API no arquivo `lib/data/coin_datasource.dart` para a sua chave pessoal da CoinMarketCap.
3. Rode o aplicativo:
   ```sh
   flutter run
   ```

## Estrutura do projeto

```
lib/
  data/           // camada de acesso \u00e0 API
  model/          // modelos de dados
  repository/     // l\u00f3gica de negoc\u00edos
  view/           // telas (UI)
  viewmodel/      // gest\u00e3o de estado
```

O ponto de entrada principal est\u00e1 em `lib/main.dart`.

## Testes

Para rodar os testes (quando houver), execute:
```sh
flutter test
```

## Licen\u00e7a

Este projeto \u00e9 de uso livre para fins de estudo. Verifique eventuais
restri\u00e7\u00f5es antes de distribui-lo.
