use std::io;
use std::str::FromStr;
use std::io::{BufWriter, Write};

struct Node {
    value: i32,
    left: Option<Box<Node>>,
    right: Option<Box<Node>>,
}

impl Node {
    fn new(x: i32) -> Self {
        Self {
            value: x,
            left: None,
            right: None,
        }
    }

    fn boxed(x: i32) -> Box<Self> {
        Box::new(Node::new(x))
    }

    fn add(&mut self, x: i32) {
        if x > self.value {
            match self.right.as_mut() {
                Some(node) => node.add(x),
                None => {
                    self.right = Some(Node::boxed(x));
                }
            }
        } else if x < self.value {
            match self.left.as_mut() {
                Some(node) => node.add(x),
                None => {
                    self.left = Some(Node::boxed(x));
                }
            }
        }
    }
}

struct Tree {
    root: Option<Box<Node>>,
}

impl Tree {
    fn new() -> Self {
        Self { root: None }
    }

    fn add(&mut self, x: i32) {
        match self.root.as_mut() {
            Some(node) => node.add(x),
            None => self.root = Some(Node::boxed(x)),
        }
    }

    fn pre_order_rec(&self, some_node: &Option<Box<Node>>, mut vec: &mut Vec<i32>) {
        if let Some(node) = some_node {
            vec.push(node.value);
            self.pre_order_rec(&node.left, &mut vec);
            self.pre_order_rec(&node.right, &mut vec);
        }
    }

    fn pre_order(&self) -> Vec<i32> {
        let mut vec = Vec::new();
        self.pre_order_rec(&self.root, &mut vec);
        vec
    }
    
    fn pos_order_rec(&self, some_node: &Option<Box<Node>>, mut vec: &mut Vec<i32>) {
        if let Some(node) = some_node {
            self.pos_order_rec(&node.left, &mut vec);
            self.pos_order_rec(&node.right, &mut vec);
            vec.push(node.value);
        }
    }

    fn pos_order(&self) -> Vec<i32> {
        let mut vec = Vec::new();
        self.pos_order_rec(&self.root, &mut vec);
        vec
    }

    fn in_order_rec(&self, some_node: &Option<Box<Node>>, mut vec: &mut Vec<i32>) {
        if let Some(node) = some_node {
            self.in_order_rec(&node.left, &mut vec);
            vec.push(node.value);
            self.in_order_rec(&node.right, &mut vec);
        }
    }

    fn in_order(&self) -> Vec<i32> {
        let mut vec = Vec::new();
        self.in_order_rec(&self.root, &mut vec);
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
        let _: usize = read()?;

        let mut line = String::new();
        io::stdin().read_line(&mut line)?;
        let xs = line
            .trim_end()
            .split(" ")
            .map(|x| x.parse::<i32>().unwrap());

        let mut tree = Tree::new();
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
