from typing import Callable, TypeAlias
import time
from pathlib import Path

SortAlg: TypeAlias = Callable[[list[int]], list[int]]


def read_newline_list(content: str) -> list[int]:
    split_at_newline = content.strip().split("\n")
    converted_to_int = list(map(int, split_at_newline))

    return converted_to_int


def test(func: SortAlg) -> None:
    input = read_newline_list(Path("../input").read_text())
    validation = read_newline_list(Path("../validation").read_text())

    start_time = time.perf_counter()
    sorted_input = func(input)
    end_time = time.perf_counter()
    time_lapse = end_time - start_time

    if sorted_input == validation:
        print(f"Success! It took {time_lapse}")
    else:
        print("Failed!")
