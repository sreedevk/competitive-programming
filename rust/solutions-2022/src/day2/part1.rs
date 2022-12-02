use std::fs;

#[derive(PartialEq, Eq, Hash, Clone, Copy)]
#[repr(u8)]
enum Shape {
    Rock = 1,
    Paper = 2,
    Scissors = 3,
}

fn str_to_shape(istr: &str) -> Shape {
    match istr {
        "A" | "X" => Shape::Rock,
        "B" | "Y" => Shape::Paper,
        "C" | "Z" => Shape::Scissors,
        _ => panic!("INVALID SHAPE"),
    }
}

pub fn solve() -> String {
    let data = fs::read_to_string("data/main/2022/day2.txt").unwrap();
    let score = data
        .trim()
        .split("\n")
        .map(|t| t.trim())
        .map(|shapes| shapes.split_once(" ").unwrap())
        .map(|(p0, p1)| (str_to_shape(p0), str_to_shape(p1)))
        .map(|shapes| score(shapes))
        .sum::<usize>();

    String::from(format!("{:?}", score))
}

fn x_beats(p0: Shape) -> Shape {
    match p0 {
        Shape::Rock => Shape::Scissors,
        Shape::Scissors => Shape::Paper,
        Shape::Paper => Shape::Rock
    }
}

fn score((p0, p1): (Shape, Shape)) -> usize {
    match p1 {
        _ if p1 == p0 => p1 as usize + 3,
        _ if x_beats(p0) == p1 => p1 as usize,
        _ => p1 as usize + 6
    }
}
