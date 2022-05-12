OUTPUT_ARCH(riscv) /* 设置目标平台为riscv */
ENTRY(_start) /* 整个程序的入口点为全局符号 _start */
BASE_ADDRESS = 0x80200000;/* 初始化代码存放地址 */

SECTIONS
{
    . = BASE_ADDRESS;/* .表示当前地址 */
    skernel = .;

    stext = .;
    .text : {
        *(.text.entry)/* 将所有输入文件袋.text.entry section合并成一个.text section */
        *(.text .text.*)
    }

    . = ALIGN(4K);
    etext = .;
    srodata = .;
    .rodata : {/* read only data */
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);
    erodata = .;
    sdata = .;
    .data : {
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);
    edata = . ;
    .bss : {/* block starting symbol存放未初始化全局变量的一块区域 */
        *(.bss.stack)
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }
    ebss = .;

    . = ALIGN(4K);
    ebss = .;
    ekernel = .;

    /DISCARD/ : {
        *(.eh_frame)
    }
}