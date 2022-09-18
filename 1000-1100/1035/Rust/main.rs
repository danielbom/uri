// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
use std::io;

fn main() -> io::Result<()> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    let xs: Vec<i32> = line
        .split(' ')
        .map(|val| val.trim_end().parse().unwrap())
        .collect();

    let a = xs[0];
    let b = xs[1];
    let c = xs[2];
    let d = xs[3];

    if b > c && d > a && c + d > a + b && c > 0 && d > 0 {
        println!("Valores aceitos");
    } else {
        println!("Valores nao aceitos");
    }

    Ok(())
}
