from typing import Callable, TypeAlias
import time
from pathlib import Path

SortAlg: TypeAlias = Callable[[list[int]], list[int]]

TEST_DIR = "~/Desktop/Projects/sorting-algs/tests"


class Test:
    def __init__(self, func: SortAlg, test_dir: str | Path) -> None:
        self.func = func
        self.test_dir = Path(test_dir).expanduser()
        self._source_input()

    def _source_input(self) -> None:
        inputs = [input for input in self.test_dir.iterdir()
                  if str(input).endswith("_input")]
        validations = [validation for validation in self.test_dir.iterdir()
                       if str(validation).endswith("_validation")]

        if len(inputs) != len(validations):
            raise ValueError("Validations and tests are not the same numbers")

        self.inputs = sorted(inputs)
        self.validations = sorted(validations)

    def run(self) -> None:
        for input_file, validation_file in zip(self.inputs, self.validations):
            input = self.read_newline_list(input_file.read_text())
            validation = self.read_newline_list(validation_file.read_text())
            self._run_single_test(input, validation)

    def _run_single_test(self, input, validation) -> None:
        start_time = time.perf_counter()
        sorted_input = self.func(input)
        end_time = time.perf_counter()
        time_lapse = end_time - start_time

        if sorted_input == validation:
            length = len(input)
            print(f"Success! It took {time_lapse}s to sort {length} elements.")
        else:
            print("Failed!")

    @staticmethod
    def read_newline_list(content: str) -> list[int]:
        split_at_newline = content.strip().split("\n")
        converted_to_int = list(map(int, split_at_newline))

        return converted_to_int
