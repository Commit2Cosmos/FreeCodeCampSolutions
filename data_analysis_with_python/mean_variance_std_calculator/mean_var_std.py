import numpy as np
from typing import List


def iterate_over_axis(input_lst: List[int], fn) -> np.array:
    return [fn(input_lst, axis=i).tolist() for i in [0, 1, None]]


def calculate(input_lst: List[int]) -> dict:

    if len(input_lst) < 9:
        raise ValueError("List must contain nine numbers.")
    
    input_lst = np.array(input_lst).reshape(3, 3)

    res = {}
    
    #* mean
    res["mean"] = iterate_over_axis(input_lst, np.mean)

    #* variance
    res["variance"] = iterate_over_axis(input_lst, np.var)

    #* standard deviation
    res["standard deviation"] = iterate_over_axis(input_lst, np.std)

    #* max
    res["max"] = iterate_over_axis(input_lst, np.max)
    
    #* min
    res["min"] = iterate_over_axis(input_lst, np.min)

    #* sum
    res["sum"] = iterate_over_axis(input_lst, np.sum)

    return res