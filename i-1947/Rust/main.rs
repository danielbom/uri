use std::collections::HashMap;
use std::io;

fn read_ints() -> io::Result<Vec<i32>> {
    let mut line = String::new();

    io::stdin().read_line(&mut line)?;
    let xs = line
        .trim_end()
        .split(" ")
        .map(|x| x.parse::<i32>().unwrap())
        .collect();
    Ok(xs)
}

fn make_matrix(size: usize) -> Vec<Vec<i32>> {
    let mut m: Vec<Vec<i32>> = Vec::with_capacity(size);
    for _ in 0..size {
        m.push(vec![0; size]);
    }
    return m;
}

fn main() -> io::Result<()> {
    let first_line = read_ints()?;
    let (n, m, t) = (first_line[0], first_line[1], first_line[2]);

    let mut street_graph = HashMap::<i32, HashMap<i32, i32>>::new();

    for _ in 0..m {
        let street_line = read_ints()?;

        let a = street_line[0] - 1;
        let b = street_line[1] - 1;
        let c = street_line[2];

        if let Some(m) = street_graph.get_mut(&a) {
            m.insert(b, c);
        } else {
            let mut m = HashMap::new();
            m.insert(b, c);
            street_graph.insert(a, m);
        }

        if let Some(m) = street_graph.get_mut(&b) {
            m.insert(a, c);
        } else {
            let mut m = HashMap::new();
            m.insert(a, c);
            street_graph.insert(b, m);
        }
    }

    // Floyd Wharshall
    let mut distances = make_matrix(n as usize);

    for i in 0..n {
        for j in 0..n {
            let c = street_graph
                .get(&i)
                .map_or(0, |m| m.get(&j).map_or(0, |x| *x));
            distances[i as usize][j as usize] = if c == 0 && i != j { 101 } else { c };
        }
    }

    for k in 0..n {
        for i in 0..n {
            for j in 0..n {
                let d1 = distances[i as usize][k as usize];
                let d2 = distances[k as usize][j as usize];
                let (distance_sum, overflow) = d1.overflowing_add(d2);
                if !overflow && distances[i as usize][j as usize] > distance_sum {
                    distances[i as usize][j as usize] = distance_sum;
                }
            }
        }
    }

    let mut turists = HashMap::<i32, Vec<i32>>::new();

    for _ in 0..t {
        let turist_line = read_ints()?;
        let o = turist_line[0] - 1;
        let d = turist_line[1] - 1;

        if let Some(xs) = turists.get_mut(&o) {
            xs.push(d);
        } else {
            turists.insert(o, vec![d]);
        }
    }

    let mut current_position = 0;
    let mut total_distance = 0;

    while !turists.is_empty() {
        let mut to_remove = Vec::<i32>::new();
        if let Some(xs) = turists.get_mut(&current_position) {
            if let Some(d) = xs.pop() {
                total_distance += distances[current_position as usize][d as usize];
                current_position = d;

                if xs.len() == 1 {
                    to_remove.push(current_position);
                }
            }
        } else {
            let mut min_turist: Option<i32> = None;
            let mut min_distance = i32::MAX;
            for (&o, xs) in &turists {
                if xs.is_empty() {
                    to_remove.push(o);
                } else {
                    let d = distances[current_position as usize][o as usize];
                    if d < min_distance {
                        min_distance = d;
                        min_turist = Some(o);
                    }
                }
            }

            if let Some(v) = min_turist {
                total_distance += min_distance;
                current_position = v;
            }
        }
        for o in to_remove {
            turists.remove(&o);
        }
    }

    total_distance += distances[current_position as usize][0];

    println!("{}", total_distance);

    Ok(())
}
