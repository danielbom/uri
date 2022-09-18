// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
use std::io;

fn read_f64() -> io::Result<f64> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    let x = line.trim_end().parse::<f64>().unwrap();
    Ok(x)
}

fn main() -> io::Result<()> {
    let grade_a = read_f64()?;
    let grade_b = read_f64()?;
    let grade_c = read_f64()?;
    let average = (grade_a * 2.0 + grade_b * 3.0 + grade_c * 5.0) / 10.0;
    println!("MEDIA = {:.1}", average);
    Ok(())
}
