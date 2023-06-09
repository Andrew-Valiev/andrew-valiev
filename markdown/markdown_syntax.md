# ![Markdown](https://img.shields.io/badge/-Markdown-190004?style=for-the-badge&logo=Markdown&logoColor=136bel)

## Cинтаксис Markdown

---

> Выделение текста

* *Курсивный текст* или _курсивный текст_.  
* **Полужирный текст** или __полужирный текст__.  
* **Полужирный _наклонный_ текст_**  
* ***Текст жирным курсивом***  
* ___Текст жирным курсивом___  
* ~~Зачёркнутый текст~~  
* <u>Подчёркнутый текст</u>

---

>**Заголовки**

# Заголовок первого уровня

## Заголовок второго уровня ##

### Заголовок третьего уровня

---

#### Заголовок четвёртого уровня #

##### Заголовок пятого уровня ############

###### Заголовок шестого уровня

* При использовании двух или более заголовков GitHub автоматически создает оглавление, к которому можно получить доступ, щелкнув  в заголовке файла. В оглавлении приводится каждый заголовок. Щелкнув по нему, можно перейти к соответствующему разделу.

---

>**Списки**

* Привет
* Как дела
  * после таба получаем вложенный список
* Первый пункт
* Второй пункт
* Третий пункт
- Первый пункт
- Второй пункт
- Третий пункт
+ Первый пункт
+ Второй пункт
+ Третий пункт

1. Пункт
   1. Подпункт
      1. Подподпункт

- Пункт
	- Подпункт
		- Подподпункт


1. Пункт
	- Подпункт
		* Подподпункт

+ Пункт
	1. Подпункт

- Пункт
  - [x] Отмеченный подпункт
  - [ ] Неотмеченный подпункт
    1. Подподпункт

1. Первый пункт
   > Цитата внутри первого пункта
1. Второй пункт

    Параграф внутри второго пункта
1. Третий пункт

---
>**Нумерация**

1. Да
1. Да-да
    1. Да-да-да-да
    1. Да-да-да-да-да
1. Да-да-да

---

>**Ссылки**

* ![Альт-текст](ссылка на картинку)
* [Текст ссылки](https://htmlacademy.ru)
* <https://skillbox.ru/media/code/>
* [Skillbox Media](https://skillbox.ru/media/ "Всплывающая подсказка") с подсказкой

---

>**Цитаты**

Это обычный текст, а
> Цитируем вот так, и сразу видно, что это цитата

> для разделение строк нужно оставить пустую строку

>Если же строки находятся рядом, то они автоматически склеиваются в одну.

> # Заголовок

> Первый параграф
>
> Второй параграф
>
> > Вложенная цитата
> > > Цитата третьего уровня
>
> Продолжение основной цитаты

---

>**Для переноса строки внутри одного параграфа** **есть три метода:**

1. поставить в конце строки два или больше пробела   ;
1. поставить в конце строки обратную косую черту \ \;
1. использовать HTML-тег <br>
   * Перенос с помощью пробелов  
   * Перенос с помощью обратного слеша\
   * Перенос с помощью тега <br> Последняя строка

---

>Разделители  

*** 
--- 
___
*	*  **

---

>Чекбоксы

- [x] Отмеченный пункт
- [ ] Неотмеченный пункт
- [x] #739
- [ ] https://github.com/octo-org/octo-repo/issues/740
- [ ] Add delight to the experience when all tasks are complete :tada:

---

Картинки

![Изображение](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/1920px-Markdown-mark.svg.png "Логотип Markdown")

![Изображение][1]

[1]: https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/1920px-Markdown-mark.svg.png "Логотип Markdown"

---

>Вставка кода (code)

В Markdown есть несколько способов выделить исходный код:

* Если надо **отобразить фрагмент кода** внутри строки с каким-то текстом, нужно с двух сторон выделить этот код одним или несколькими обратными апострофами (`; их ещё называют бэктиками).
* Чтобы выделить фрагмент из нескольких строк, нужно с двух сторон выделить его тремя обратными апострофами. 
* Также перед фрагментом кода можно поставить табуляцию или четыре пробела, при этом предыдущая строка должна быть пустой.

Функция `print (x)` выводит содержимое переменной ```x```.

```text
#include <stdio.h>
int main() {
   printf("Hello, World!");
   return 0;
}
```

    let x = 12;
	let y = 6;
	console.log(x + y);

* Если обрамлять код тремя обратными апострофами, то после первой тройки можно указать язык программирования — тогда Markdown правильно подсветит элементы кода.

```python
if x > 0:
	print (x)
else:
	print ('Hello, World!')
```

```c
#include <stdio.h>
int main() {
   printf("Hello, World!");
   return 0;
}
```

```javascript
let x = 12;
let y = 6;
console.log(x + y);
```

---

>**Таблицы**

* Столбцы разделяются вертикальными линиями |, а строка с шапкой отделяется от остальных дефисами -, которых можно ставить сколько угодно.

|Столбец 1|Столбец 2|Столбец 3|
|-|--------|---|
|Длинная запись в первом столбце|Запись в столбце 2|Запись в столбце 3|
|Кртк зпс| |Слева нет записи|

* Чтобы выровнять весь столбец по правому краю, в строке с дефисами сразу после дефисов можно поставить двоеточие :. Чтобы выровнять содержимое по центру, надо поставить двоеточия с обеих сторон.

|Столбец 1|Столбец 2|Столбец 3|
|:-|:-:|-:|
|Равнение по левому краю|Равнение по центру|Равнение по правому краю|
|Запись|Запись|Запись|

---

>**Экранирование**

* Для этого перед ними ставится обратная косая черта \\. 
* Вот список символов, которые нужно экранировать: \`*_{}[]<>()#+-.! |

>**Оповещения**

> [!NOTE]
> Information the user should notice even if skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]
> Essential information required for user success.

> [!CAUTION]
> Negative potential consequences of an action.

> [!WARNING]
> Dangerous certain consequences of an action.

