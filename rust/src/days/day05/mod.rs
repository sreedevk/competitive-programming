use crate::template::Solution;
use anyhow::Result;

mod part1;
mod part2;

pub struct Day05;

const DATA: &str = include_str!("../../../data/day05.txt");

impl Solution for Day05 {
    fn solve_part1(&self) -> Result<String> {
        Ok(part1::solve(DATA))
    }

    fn solve_part2(&self) -> Result<String> {
        Ok(part2::solve(DATA))
    }
}
