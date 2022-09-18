// https://www.urionlinejudge.com.br/judge/en/problems/view/1023
use std::cmp::Ordering;
use std::collections::HashMap;
use std::io;
use std::str::FromStr;

struct Property {
    residents: i32,
    consumption: i32,
    per_resident: i32,
}

impl Property {
    fn new(residents: i32, consumption: i32) -> Self {
        Self {
            residents: residents,
            consumption: consumption,
            per_resident: consumption / residents,
        }
    }

    fn compare(&self, other: &Property) -> Ordering {
        return self.per_resident.partial_cmp(&other.per_resident).unwrap();
    }
}

fn read<T: FromStr>() -> io::Result<T> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    if let Ok(x) = line.trim_end().parse() {
        Ok(x)
    } else {
        panic!("Invalid input");
    }
}

fn read_pair<T: FromStr, U: FromStr>() -> io::Result<(T, U)> {
    let mut line = String::new();
    io::stdin().read_line(&mut line)?;
    let mut iter = line.split(" ");
    let x = iter.next().unwrap().parse();
    let y = iter.next().unwrap().trim_end().parse();
    if let (Ok(x), Ok(y)) = (x, y) {
        Ok((x, y))
    } else {
        panic!("Invalid pair")
    }
}

fn main() -> io::Result<()> {
    let mut city_count = 1;
    loop {
        let n: i32 = read()?;

        if n == 0 {
            break;
        }

        if city_count != 1 {
            println!();
        }

        let mut consumption_sum = 0;
        let mut population = 0;
        let mut map: HashMap<i32, Property> = HashMap::new();

        for _ in 0..n {
            let (residents, consumption) = read_pair()?;
            let property = Property::new(residents, consumption);
            if let Some(p) = map.get_mut(&property.per_resident) {
                p.residents += residents;
            } else {
                map.insert(property.per_resident, property);
            }
            population += residents;
            consumption_sum += consumption;
        }

        let mut vec = Vec::with_capacity(n as usize);
        for (_, p) in &map {
            vec.push(p);
        }
        vec.sort_unstable_by(|p1, p2| p1.compare(p2));

        println!("Cidade# {}:", city_count);
        for (i, p) in vec.iter().enumerate() {
            if i != 0 {
                print!(" ");
            }
            print!("{}-{}", p.residents, p.per_resident);
        }
        println!();

        let consumption_avg =
            ((consumption_sum as f32 / population as f32) * 100.0).floor() / 100.0;
        println!("Consumo medio: {:.2} m3.", consumption_avg);
        city_count += 1;
    }
    Ok(())
}
