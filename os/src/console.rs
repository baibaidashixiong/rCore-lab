use crate::sbi::console_putchar;
use core::fmt::{self,Write};

struct Stdout;

impl Write for Stdout {
    fn write_str(&mut self,s:&str)->fmt::Result{
        for c in s.chars(){
            console_putchar(c as usize);
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments){
    Stdout.write_fmt(args).unwrap();
}

#[macro_export] 
//表示下面的宏定义对其他包也是可见的
macro_rules! print {
    ($fmt: literal $(,$($arg:tt)+)?) => {
        $crate::console::print(format_args!($fmt $(,$($arg)+)?));
    }//在宏定义中使用$crate，可以在被导出时，让编译器根据上下文推断包名，避免依赖问题。
}

#[macro_export]
macro_rules! println{
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?));
    }
}

