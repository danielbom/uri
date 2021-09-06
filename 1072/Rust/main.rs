// https://www.urionlinejudge.com.br/judge/en/problems/view/1008
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
    let n = read::<i32>()?;

    let mut count_in = 0;
    let mut count_out = 0;

    for _ in 0..n {
        let x = read::<i32>()?;
        if x < 10 || 20 < x {
            count_out += 1;
        } else {
            count_in += 1;
        }
    }

    println!("{} in", count_in);
    println!("{} out", count_out);

    Ok(())
}
