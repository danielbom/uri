// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
use std::io;
use std::str::FromStr;

fn read<T: FromStr>() -> io::Result<T> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    if let Ok(x) = line.trim_end().parse::<T>() {
        Ok(x)
    } else {
        panic!("Input malformed")
    }
}

fn main() -> io::Result<()> {
    let x = read::<i32>()?;
    let y = read::<i32>()?;
    let (first, end) = if x > y { (y, x) } else { (x, y) };

    let start = if first.abs() % 2 == 0 {
        first + 1
    } else {
        first + 2
    };

    let sum: i32 = (start..end).step_by(2).sum();
    println!("{}", sum);

    Ok(())
}
