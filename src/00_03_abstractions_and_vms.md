# Абстракции и виртуальные машины

Писать программы в виде непосредственно команд для процессора весьма и весьма накладно, потому что
кроме арифметики и логики нужно заниматься вводом и выводом, а как именно это делать --- зависит
буквально от всего, начиная от модели монитора и заканчивая тем, в какой именно порт воткнута клавиатура.

И здесь на помощь приходит идея абстрагирования. Поясним её на кулинарном примере.
Когда в рецепте написано "вскипятить воду", совершенно безразлично, каким именно способом 
это будет происходить. Один вскипятит воду в чайнике, другой в кастрюльке,
третий в микроволновке, четвёртый на костре, пятый скомандует помощникам и т. п.
Это некая абстракция, которая специфицирует результат, но не способ его достижения.

И именно такие абстракции очень нужны программистам. Например: "выведи строку" (неважно, на какой экран, может, 
вообще на принтере напечатать) или "прочитай файл по такому-то пути" (на диске, на флешке, по сети и т. п.),
и нужен некий _уровень абстракции_ (abstraction level), который возьмёт на себя все конкретные шаги по достижению какого-либо результата.

Для этого существует операционная система (ОС). Вместо того чтобы обращаться к видеокарте и монитору, программист просит ОС "напечатать на экране",
вместо обращения к жёсткому диску --- "прочитай мне файл с таким-то именем", и так далее. Такие обращения к ОС называются 
_системными вызовами_ (system call). Кроме того, операционная система позволяет писать программу, не задумываясь о том, 
что вместе с ней одновременно могут работать какие-то другие программы, и множество всего прочего.

Но программисты редко работают напрямую с системными вызовами. Дело в том, что даже разные версии одной ОС могут иметь 
несколько различающиеся соглашения по этому поводу, а уж у разных ОС (например, Windows и Linux) системные вызовы
совсем разные. Поэтому здесь нужен ещё один уровень абстракции, который обычно предоставляется 
средствами языка программирования, и он скрывает от программиста все тонкости взаимодействия с операционной системой.

Так, команда "напечатай строку на экране" в зависимости от ОС превращается в разные системные вызовы,
а в зависимости от железа ОС делает разные вещи, но обо всём этом программисту обычно думать не нужно.

Но чтобы что-нибудь вычислить, операционная система не нужна, и в этом случае язык программирования 
помогает абстрагироваться от конкретных арифметических команд конкретного процессора.

## Виртуальные машины

Идея абстрагирования имеет и другие интересные применения. Например, если очень хочется запустить какую-нибудь
программу, написанную для отсутствующей аппаратной системы (например, Sega), то достаточно написать эмулятор, который будет
исполнять команды точно так же, создав таким образом _виртуальную машину_ (приставка --- тоже машина).

Но кто сказал, что виртуальная машина должна обязательно соответствовать какой-то существующей системе? 
Можно ведь придумать свой удобный набор команд ("байт-код"), а затем реализовать его эмуляторы для всех нужных систем.

Именно так работает Java: программы на ней распространяются в виде кода для специальной 
виртуальной машины (Java Virtual Machine, JVM), а для каждой целевой системы существуют реализации JVM.
Более того, есть несколько альтернативных реализаций JVM. А ещё на базе JVM можно писать программы не только на 
Java, но и на других языках.

Поскольку к этому моменту уже ничего не понятно, нарисуем древо абстракций:

```mermaid
flowchart TD
    subgraph Lang[Языки программирования]
        Java
        Groovy
        Kotlin    
    end
    Lang <-->|Байт-код| JVM
    subgraph JVM[Виртуальные машины Java]
        Or[Oracle JVM]
        OpenJDK    
    end
    JVM <-->|Системные вызовы| OS
    subgraph OS[Операционные системы]
        Windows
        Linux
        macOS
    end
    OS <-->|Машинный код| Proc
    JVM <-->|Машинный код| Proc
    subgraph Proc[Процессоры]
        Intel
        AMD
        ARM[Apple Silicon]
    end
```

Как это понимать?

Программу, написанную на любом из этих языков, может выполнить любая виртуальная машина Java. Она, в свою очередь,
может работать на разных операционных системах, которые могут работать на разном оборудовании. И благодаря тому,
что на каждом уровне правила строго определены, большую часть времени программисту вообще не нужно думать, 
как это работает на самом деле.

## Глубже и выше

Древо можно наращивать в обоих направлениях. Если речь идёт о программировании хоть сколько-нибудь сложной системы,
то программисты сами наращивают абстракции. Например, брать деньги за какую-нибудь услугу можно разными способами,
но с точки зрения процесса купли-продажи способ неважен, поэтому этот процесс прячется за абстракцией "платежа".

Более изощрённый пример: существует, например, Jython --- реализация языка Python, написанная на Java. 
А на Python написан эмулятор [эзотерического](https://ru.wikipedia.org/wiki/%D0%AD%D0%B7%D0%BE%D1%82%D0%B5%D1%80%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B8%D0%B9_%D1%8F%D0%B7%D1%8B%D0%BA_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F)
языка программирования [Befunge](https://ru.wikipedia.org/wiki/Befunge).
Но это уже из области ненормального программирования.

С другой стороны, можно запускать программы не на реальной, а на виртуальной машине. Но всё обстоит даже интереснее:
многие "реальные" современные процессоры содержат внутри специальную программу ([микрокод](https://ru.wikipedia.org/wiki/Микрокод)),
которая на самом деле исполняет "в железе" все команды.

Ну и в самом железе есть ещё пара уровней абстракции, которые скрывают от разработчиков логических схем процессора реальные 
физические явления. И всё это как-то работает!