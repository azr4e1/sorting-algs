import utils as u


def quicksort(my_list: list[int]) -> list[int]:
    if not my_list:
        return []
    pivot = my_list[0]
    rest = my_list[1:]
    small_sorted = quicksort([x for x in rest if x <= pivot])
    big_sorted = quicksort([x for x in rest if x > pivot])

    return small_sorted + [pivot] + big_sorted


if __name__ == "__main__":
    test_dir = u.TEST_DIR
    test = u.Test(quicksort, test_dir)
    test.run()
