// https://www.urionlinejudge.com.br/judge/en/problems/view/1075
use std::io;
use std::str::FromStr;

fn read<T: FromStr>() -> io::Result<T> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    if let Ok(x) = line.trim_end().parse::<T>() {
        Ok(x)
    } else {
        panic!("Invalid input")
    }
}

fn main() -> io::Result<()> {
    let x: usize = read()?;

    if x > 2 {
        for i in (2..10000).step_by(x) {
            println!("{}", i);
        }
    }

    Ok(())
}
