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
    let employee_number = read::<i32>()?;
    let worked_hours = read::<i32>()?;
    let amount_per_hour = read::<f32>()?;

    println!("NUMBER = {}", employee_number);
    println!("SALARY = U$ {:.2}", (worked_hours as f32 * amount_per_hour));
    Ok(())
}
