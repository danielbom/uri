// https://www.urionlinejudge.com.br/judge/en/problems/view/1234
use std::io::{self, BufRead, BufReader};

fn main() {
    let result = BufReader::new(io::stdin())
        .lines()
        .map(|line| line.expect("Expect a line"))
        .map(|line| {
            let mut count = 0;
            let mut result: Vec<String> = Vec::new();

            for ch in line.chars() {
                if ch.is_alphabetic() {
                    result.push(if count % 2 == 0 {
                        ch.to_uppercase().to_string()
                    } else {
                        ch.to_lowercase().to_string()
                    });
                    count += 1;
                } else {
                    result.push(ch.to_string());
                }
            }

            result.join("")
        })
        .collect::<Vec<String>>()
        .join("\n");

    print!("{}", result);
}
