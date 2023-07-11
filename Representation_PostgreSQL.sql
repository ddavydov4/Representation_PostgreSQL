/*1.1 Создать представление, выводящее сводную информацию о городе, его
населении, а также минимальном, максимальном и суммарном весе грузов,
привезённом в этот город. Выбрать из представления всю информацию, не
содержащую городов, в названии которых присутствуют 2 буквы «л» на любых
местах.*/

CREATE VIEW Information
AS
SELECT t.city,
        c.population,
        MAX(t.weight) AS MAXweight,
        MIN (t.weight) AS MINweight,
        SUM (t.weight) AS SUMweight
        FROM city c
LEFT JOIN transportation t on t.city= c.cityname
GROUP BY t.city, c.population;
SELECT * FROM Information cw
WHERE LOWER (cw.city) not like '%л%л%'

/* Задание 1.2. Создать представление, выводящее подробную информацию о перевозках,
отправленных в Атланту (за исключением столбцов с кодом клиента и датой
транспортировки). Вставить новую строку в созданное представление с
помощью команды INSERT и зафиксировать результат операции. Пояснить, с чем
связан полученный результат. */

CREATE VIEW Deleviry_Atlanta
AS
SELECT transportationid, weight, carid, city,cost
From Transportation
WHERE city like 'Атланта'
INSERT INTO Deleviry_Atlanta (transportationid, weight, carid, city, cost)
VALUES (444, 333, 22, 'Атланта', '515');

ERROR: ОШИБКА:  значение NULL в столбце "clientid" отношения "transportation" нарушает ограничение NOT NULL
DETAIL:  Ошибочная строка содержит (444, null, 333.00, 22, Атланта, null, 515,00 ?).


SQL state: 23502

/* Если добавить указанную строку, то в таблицу transportation, которую использует представление Atlanta, добавится объект. 
В таблице transportation столбец clientid  - внешний ключ, он должен быть NOT NULL.
Ошбибка возникает из-за того, что представление не заполняет указанный столбец.*/

/*Задание 2.1 С помощью цикла вывести на экран ряд чисел от 1 до 10.*/

DO
$$
DECLARE number integer :=0;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        RAISE NOTICE '%', number;
    END LOOP;
END
$$

/*2.2. Дополнить код из задания 1, выводя на экран фразу «Число » в начале строки в
дополнение к самому числу.*/

DO
$$
DECLARE number integer :=0;
DECLARE result varchar;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        result = concat ('Число ', number);
        RAISE NOTICE  '%', result;
    END LOOP;
END
$$

/* Задание 2.3. Дополнить код из задания 2, добавив в конце строки фразу «: чётное» для
каждого из чётных чисел. Для нечётных чисел при этом текст добавлять не
нужно.*/

DO
$$
DECLARE number integer :=0;
DECLARE result varchar;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        IF number % 2 = 0
            THEN result = concat ('Число ', number, ': четное');
            ELSE result = concat ('Число ', number);
        END IF;
        RAISE NOTICE   '%', result;
    END LOOP;
END
$$

/*Задание 2.4. Дополнить код из задания 3, добавив в конец строки фразу «, делится на 5» для
каждого из чисел, делящихся на 5 без остатка (необходимо учесть, что на 5 могут
делиться и чётные, и нечётные числа).*/

DO
$$
DECLARE number integer :=0;
DECLARE result varchar;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        IF number % 2 = 0
            THEN result = concat ('Число ', number, ': четное');
            ELSE result = concat ('Число ', number);
        END IF;
        IF number % 5 = 0
            THEN result = concat (result, ', делится на 5');
        END IF;
        RAISE NOTICE  '%', result;
    END LOOP;
END
$$

/*Задание 2.5. Дополнить код из задания 4, добавив пропуск итерации цикла при появлении
числа 3.*/

DO
$$
DECLARE number integer :=0;
DECLARE result varchar;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        CONTINUE WHEN number = 3;
        IF number % 2 = 0
            THEN result = concat ('Число ', number, ': четное');
            ELSE result = concat ('Число ', number);
        END IF;
        IF number % 5 = 0
            THEN result = concat (result, ', делится на 5');
        END IF;
        RAISE NOTICE  '%', result;
    END LOOP;
END
$$

/* Задание 2.6. Дополнить код из задания 5, реализовав принудительный выход из цикла при
появлении числа 8.*/

DO
$$
DECLARE number integer :=0;
DECLARE result varchar;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        CONTINUE WHEN number = 3;
        EXIT WHEN number = 8;
        IF number % 2 = 0
            THEN result = concat ('Число ', number, ': четное');
            ELSE result = concat ('Число ', number);
        END IF;
        IF number % 5 = 0
            THEN result = concat (result, ', делится на 5');
        END IF;
        RAISE NOTICE  '%', result;
    END LOOP;
END
$$

/* Задание 2.7 (дополнительное задание) Изменить код задания 4 таким образом, чтобы
вместо IF…ELSE использовалась конструкция CASE.*/

DO
$$
DECLARE number integer :=0;
DECLARE result varchar;
BEGIN
    WHILE number <>10
    LOOP
        number = number +1;
        CASE
        WHEN number%2 = 0 and number%5 =0 
            THEN result := concat('Число ', number, ': четное, делится на 5');
        WHEN number%2 = 0  
            THEN result :=concat('Число ', number, ': четное');
        WHEN number%5 =0 
            THEN result :=concat('Число ', number, ', делится на 5');
        ELSE result :=concat('Число ', number);
        END CASE;
        RAISE NOTICE  '%', result;
    END LOOP;
END
$$

