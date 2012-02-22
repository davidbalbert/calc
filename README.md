calc
====

A simple calculator made with lex and yacc. Trying to make it feature compatable with [jisoncalc](http://github.com/davidbalbert/jisoncalc). Supports floating point math.

##Using

```
$ make
$ echo '5 + 5' | ./calc
10
$ ./calc
>> foo = 2 * 3
=> 6
>> bar = foo ^ 2
=> 36
>> baz = foo + bar
=> 42
>> 3 + 4.3
=> 7.3
```

##License

calc is licensed under the terms of the [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html).

calc contains `khash.h` which is licensed under the terms of the MIT license. More info can be found here: http://attractivechaos.awardspace.com/khash.h.html
