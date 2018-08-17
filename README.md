# ARM_Reverse_Engineer
ARM平台逆向工程学习笔记

## 基于领英上Kevin M. Thomas的ARM Reverse Engineering 教程
学习和掌握ＡＲＭ汇编基础，ＡＲＭ指令体系，以及通过动态调用手段，理解高级语言转化为汇编和机器码的过程，这些都是逆向工程所必须的基础。

## 将每篇文档整理成文放到此库中，以及相应的示例代码，以便随时查阅



## GDB调试技巧
使用gdb-peda插件，可以实时显示出当前寄存器状态，栈等信息，如下图所示：
```
Breakpoint 1, 0x000106fa in main ()
[ Legend: Modified register | Code | Heap | Stack | String ]
────────────────────────────────────────────────────────────────────────────────────────────────────[ registers ]────
$r0   : 0x0000103c
$r1   : 0x0000006e
$r2   : 0xfffef5dc  →  0xfffef753  →  "LC_PAPER=en"
$r3   : 0x0000006e
$r4   : 0xfffef498  →  0x83e1f9a1
$r5   : 0x00000000
$r6   : 0x00000000
$r7   : 0xfffef470  →  0x00000000
$r8   : 0x00000000
$r9   : 0x00000000
$r10  : 0xf77f0000  →  0x00027f44  →  0x00000000
$r11  : 0x00000000
$r12  : 0xfffef500  →  0x00000027 ("'"?)
$sp   : 0xfffef470  →  0x00000000
$lr   : 0xf759c8ab  →  <__libc_start_main+159> bl 0xf75ac1f8 <__GI_exit>
$pc   : 0x000106fa  →  0x0002f2c0  →  0x00000000
$cpsr : [THUMB fast interrupt overflow CARRY zero negative]
────────────────────────────────────────────────────────────────────────────────────────────────────────[ stack ]────
0xfffef470│+0x00: 0x00000000     ← $r7, $sp
0xfffef474│+0x04: 0x6e000000
0xfffef478│+0x08: 0x00000000
0xfffef47c│+0x0c: 0xf759c8ab  →  <__libc_start_main+159> bl 0xf75ac1f8 <__GI_exit>
0xfffef480│+0x10: 0xf766e000  →  0x000e7f20
0xfffef484│+0x14: 0xfffef5d4  →  0xfffef71c  →  "/home/pi/workspace/ARM_Reverse_Engineer/Part20/exa[...]"
0xfffef488│+0x18: 0x00000001
0xfffef48c│+0x1c: 0x000106e9  →  <main+1> push {r7,  lr}
───────────────────────────────────────────────────────────────────────────────────────────────[ code:arm:thumb ]────
      0x106f3 <main+11>        ldrb   r3,  [r7,  #7]
      0x106f5 <main+13>        mov    r1,  r3
      0x106f7 <main+15>        movw   r0,  #4156        ; 0x103c
 →    0x106fb <main+19>        movt   r0,  #2
      0x106ff <main+23>        blx    0x105cc <_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_c@plt>
      0x10703 <main+27>        mov    r3,  r0
      0x10705 <main+29>        movw   r1,  #1448        ; 0x5a8
      0x10709 <main+33>        movt   r1,  #1
      0x1070d <main+37>        mov    r0,  r3
──────────────────────────────────────────────────────────────────────────────────────────────────────[ threads ]────
[#0] Id 1, Name: "example", stopped, reason: BREAKPOINT
────────────────────────────────────────────────────────────────────────────────────────────────────────[ trace ]────
[#0] 0x106fa → Name: main()
[#1] 0xf759c8aa → Name: __libc_start_main(main=0x106e9 <main>, argc=0x1, argv=0xfffef5d4, init=<optimized out>, fini=0x107b5 <__libc_csu_fini>, rtld_fini=0xf77d3c2d <_dl_fini>, stack_end=0xfffef5d4)
[#2] 0x10628 → Name: _start()
─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
Python Exception <class 'UnicodeEncodeError'> 'ascii' codec can't encode character '\u27a4' in position 12: ordinal not in range(128):

```

注：实际各种信息使用不同颜色显示，十分给力，缺点就是显示的反汇编内容有些少，有时看不全整个函数，这时就需要手工执行disas命令来查看某函数的反汇编结果了。

## 锻炼从C语言到汇编的转换思维能力
使用gdb-peda插件，利用单步调试的功能，根据当前的汇编语句来预测执行结果，然后再单步执行加以确认，慢慢这种思维就能达到一定高度，遇到汇编再也不会没自信了。
