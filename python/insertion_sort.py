import utils as u


def insertion_sort(my_list: list[int]) -> list[int]:
    new_list = my_list.copy()
    for i in range(len(new_list)):
        j = i
        while j > 0 and new_list[j-1] > new_list[j]:
            # swap
            new_list[j-1], new_list[j] = new_list[j], new_list[j-1]
            j -= 1
        i += 1

    return new_list


if __name__ == "__main__":
    test_dir = u.TEST_DIR
    test = u.Test(insertion_sort, test_dir)
    test.run()
