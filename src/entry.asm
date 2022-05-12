# os/src/entry.asm
    .section .text.entry #将第2行后的内容放入.text.entry，区别.text
    .globl _start #声明_start是全局符号
_start:
    la sp, boot_stack_top # load address，la为伪指令
    call rust_main #伪指令call调用Rust编写的内核入口点rust_main将控制权转交给Rust代码

    .section .bss.stack #将栈空间放置在一个名为.bss.stack的段中
    .globl boot_stack # RISC-V的栈高位向低位增长，此处表示栈底
boot_stack: 
    .space 4096 * 16 #预留64KB作为运行程序的栈空间
    .globl boot_stack_top # 栈顶，都设置为全局符号供其他目标文件使用
boot_stack_top: 