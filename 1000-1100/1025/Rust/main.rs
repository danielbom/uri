// https://www.urionlinejudge.com.br/judge/en/problems/view/1000
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
    let mut case = 1;
    loop {
        let mut line = String::new();
        io::stdin().read_line(&mut line)?;
        let mut iter = line.trim_end().split(" ");
        let marbles: i32 = iter.next().unwrap().parse().unwrap();
        let queries: i32 = iter.next().unwrap().parse().unwrap();

        if marbles == 0 && queries == 0 {
            break;
        }

        let vec = {
            let mut vec = Vec::with_capacity(marbles as usize);
            for _ in 0..marbles {
                let x: i32 = read()?;
                vec.push(x);
            }
            vec.sort();
            vec
        };

        println!("CASE# {}:", case);
        for _ in 0..queries {
            let x: i32 = read()?;
            if let Ok(mut i) = vec.binary_search(&x) {
                let mut last = i;
                while vec[i] == x && i > 0 {
                    last = i;
                    i -= 1;
                }
                if vec[i] != x {
                    i = last;
                }
                println!("{} found at {}", x, i + 1);
            } else {
                println!("{} not found", x);
            }
        }

        case += 1;
    }
    Ok(())
}
