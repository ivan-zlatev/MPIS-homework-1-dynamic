Това е код за асинхронен брояч с изменение броя на цифрите.

При повече от една цифра, се генерират няколко четирибитови съкратени броячи, като CARRY сигнала на едната цифра, който индицира препълване, се подава като CLOCK сигнал на следващата цифра.

Портовете CLOCK на първият съкратен брояч и порта CARRY на последният съкратен брояч са изведени като портове на dynamic_counter.

Използвани са следните източници на информация:

http://vhdlguru.blogspot.com/2010/03/usage-of-components-and-port-mapping.html
http://vhdlguru.blogspot.com/2010/09/how-to-use-generate-keyword-for.html
http://www.cse.wustl.edu/~jbf/cse362.d/cse362.vhdl.Generate.pdf
https://github.com/vtchoumatchenko/mpis

