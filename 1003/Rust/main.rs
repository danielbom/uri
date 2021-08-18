// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
use std::io;

fn read_i32() -> io::Result<i32> {
  let mut line = String::new();
  io::stdin().read_line(&mut line)?;
  let x = line.trim_end().parse::<i32>().unwrap();
  Ok(x)
}

fn main() -> io::Result<()> {
  let x = read_i32()?;
  let y = read_i32()?;
  let sum = x + y;
  println!("SOMA = {}", sum);
  Ok(())
}
