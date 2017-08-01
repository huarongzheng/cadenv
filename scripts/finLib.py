#!/usr/bin/env /usr/bin/python
import numpy as np
import getopt, sys
import re
import collections
import random
import matplotlib.pyplot as plt
 
##
# current value of a bond with specified face value (default to $100), given the following parameters
# @bondYield: yield rate for each coupon paying day
# @coupon: for each coupon paying day
# @return: current value of the bond 
def BondValue(bondYield, couponDate, coupon, uFaceValue=100, uCouponRate = None):
    print 'bondYield=', bondYield

def main():
    bondYield = np.array([0.065, 0.065, 0.068, 0.068, 0.0695, 0.0695])
    BondValue(bondYield, 0, 0)

if __name__ == "__main__":
    main()

