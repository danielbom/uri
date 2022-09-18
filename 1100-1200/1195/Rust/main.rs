use std::io;
use std::str::FromStr;
use std::io::{BufWriter, Write};

struct Node {
    value: i32,
    left_index: Option<usize>,
    right_index: Option<usize>,
}

impl Node {
    fn new(x: i32) -> Self {
        Self {
            value: x,
            left_index: None,
            right_index: None,
        }
    }
}

struct Tree {
    nodes: Vec<Node>,
}

impl Tree {
    fn with_capacity(capacity: usize) -> Self {
        Self {
            nodes: Vec::with_capacity(capacity),
        }
    }

    fn parent(&self, x: i32) -> Option<usize> {
        let mut index = 0;
        loop {
            if let Some(node) = self.nodes.get(index) {
                if x < node.value {
                    if let Some(new_index) = node.left_index {
                        index = new_index;
                    } else {
                        break;
                    }
                } else if node.value < x {
                    if let Some(new_index) = node.right_index {
                        index = new_index;
                    } else {
                        break;
                    }
                } else {
                    return None;
                }
            } else {
                return None;
            }
        }
        return Some(index);
    }

    fn add(&mut self, x: i32) {
        let n = self.nodes.len();
        if n == 0 {
            self.nodes.push(Node::new(x));
        } else {
            match self.parent(x) {
                Some(parent_index) => {
                    if let Some(parent) = self.nodes.get_mut(parent_index) {
                        if x < parent.value {
                            parent.left_index = Some(n);
                        } else {
                            parent.right_index = Some(n);
                        }
                    }
                    self.nodes.push(Node::new(x));
                }
                None => panic!("Invalid state"),
            }
        }
    }

    fn pre_order(&self) -> Vec<i32> {
        let mut vec = Vec::new();

        if self.nodes.len() > 0 {
            let mut stack: Vec<usize> = Vec::with_capacity(self.nodes.len());
            stack.push(0);

            while let Some(index) = stack.pop() {
                if let Some(node) = self.nodes.get(index) {
                    vec.push(node.value);

                    if let Some(i) = node.right_index {
                        stack.push(i);
                    }

                    if let Some(i) = node.left_index {
                        stack.push(i);
                    }
                }
            }
        }
        vec
    }

    fn in_order(&self) -> Vec<i32> {
        let mut vec = Vec::new();

        if self.nodes.len() > 0 {
            let mut stack: Vec<usize> = Vec::with_capacity(self.nodes.len());
            stack.push(0);

            while stack.len() > 0 {
                // Add lefts
                while let Some(i) = stack
                    .last()
                    .and_then(|&i| self.nodes.get(i))
                    .and_then(|node| node.left_index)
                {
                    stack.push(i);
                }

                // Check right
                while stack.len() > 0 {
                    if let Some(node) = stack.pop().and_then(|i| self.nodes.get(i)) {
                        vec.push(node.value);

                        if let Some(i) = node.right_index {
                            stack.push(i);
                            break;
                        }
                    }
                }
            }
        }
        vec
    }

    fn pos_order(&self) -> Vec<i32> {
        let mut vec = Vec::new();

        if self.nodes.len() > 0 {
            let mut stack: Vec<usize> = Vec::with_capacity(self.nodes.len());
            stack.push(0);

            while let Some(index) = stack.pop() {
                if let Some(node) = self.nodes.get(index) {
                    vec.push(node.value);

                    if let Some(i) = node.left_index {
                        stack.push(i);
                    }

                    if let Some(i) = node.right_index {
                        stack.push(i);
                    }
                }
            }
        }
        vec.reverse();
        vec
    }
}

fn write_vec(buf: &mut BufWriter<io::Stdout>, vec: &Vec<i32>) -> io::Result<()> {
    let mut i = 0;
    for x in vec {
        if i != 0 {
            write!(buf, " ")?;
        }
        write!(buf, "{}", x)?;
        i += 1;
    }
    writeln!(buf)?;
    Ok(())
}

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
    let mut buf = BufWriter::new(io::stdout());
    let cases: usize = read()?;

    for i in 1..=cases {
        let n: usize = read()?;

        let mut line = String::new();
        io::stdin().read_line(&mut line)?;
        let xs = line
            .trim_end()
            .split(" ")
            .map(|x| x.parse::<i32>().unwrap());

        let mut tree = Tree::with_capacity(n);
        for x in xs {
            tree.add(x);
        }

        writeln!(buf, "Case {}:", i)?;
        write!(buf, "Pre.: ")?;
        write_vec(&mut buf, &tree.pre_order())?;
        write!(buf, "In..: ")?;
        write_vec(&mut buf, &tree.in_order())?;
        write!(buf, "Post: ")?;
        write_vec(&mut buf, &tree.pos_order())?;

        writeln!(buf)?;
    }
    buf.flush()?;

    Ok(())
}
