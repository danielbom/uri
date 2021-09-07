// https://www.urionlinejudge.com.br/judge/en/problems/view/1168
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
    let digits_led = vec![6, 2, 5, 5, 4, 5, 6, 3, 7, 6];
    let n = read::<i32>()?;

    for _ in 0..n {
        let mut line = String::new();
        io::stdin().read_line(&mut line)?;
        let leds: i32 = line
            .trim_end()
            .chars()
            .map(|d| digits_led[d as usize - '0' as usize])
            .sum();
        println!("{:?} leds", leds);
    }

    Ok(())
}
