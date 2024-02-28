# TFC Patchouli RUS

Ресурспак с переводом руководства TerraFirmaCraft от [NaoCraftLab](https://github.com/NaoCraftLab).



## Сборка

### TerraFirmaCraft 2

![tfc2-categories.png](publication%2Fgalery%2Ftfc2-categories.png)

Сборка ресурспака для TFC2 основана на ресурсах данного репозитория.

#### Команда сборки для MacOS/Linux

```bash
./build.sh "1.12.2" "1"
```

где "1.12.2" - версия Minecraft, а "1" - номер сборки ресурспака.

Результат в виде zip-архива будет находиться в папке [build](./build).

### TerraFirmaCraft 3

![tfc3-categories.png](publication%2Fgalery%2Ftfc3-categories.png)

Сборка ресурспака для TFC3 основана на ресурсах [официального перевода от NaoCraftLab](https://github.com/NaoCraftLab/TerraFirmaCraft).

#### Пререквизиты

- Python 3.10
- Клон репозитория [официального перевода от NaoCraftLab](https://github.com/NaoCraftLab/TerraFirmaCraft)

#### Команда сборки для MacOS/Linux

```bash
./build.sh "1.20.1" "1" "/nao_craft_lab_tfc_path"
```

где "1.20.1" - версия Minecraft, "1" - номер сборки ресурспака, а "/nao_craft_lab_tfc_path" - путь к папке репозитория [официального перевода от NaoCraftLab](https://github.com/NaoCraftLab/TerraFirmaCraft)
