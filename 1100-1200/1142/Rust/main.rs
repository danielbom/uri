// https://www.urionlinejudge.com.br/judge/en/problems/view/1142
use std::io;

fn read_i32() -> io::Result<i32> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    let x = line.trim_end().parse::<i32>().unwrap();
    Ok(x)
}

fn main() -> io::Result<()> {
    let n = read_i32()?;

    let mut x = 1;
    for _ in 0..n {
        println!("{} {} {} PUM", x, x + 1, x + 2);
        x += 4;
    }

    Ok(())
}
