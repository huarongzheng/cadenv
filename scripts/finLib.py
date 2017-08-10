#!/usr/bin/env /usr/bin/python
import numpy as np
import getopt, sys
import re
import collections
import random
import matplotlib.pyplot as plt
 
##
# current value of a bond with specified face value (default to $100), given the following parameters
# @fBondYield: yield rate for discounting cash flow within bond maturity
# @fCouponRate: anual coupon rate
# @fCouponInterval: coupon paying date, semianual-0.5 anual-1 etc
# @fMaturity: maturity of bound
# @couponDate: derived from fCouponInterval if couponDate param is not specifically provided
# @return: current value of the bond 
def BondValue(fBondYield, fCouponRate, fCouponInterval, fMaturity, uFaceValue=100, couponDate = None):
    if couponDate == None:
        couponDate = np.arange(fCouponInterval, fMaturity+fCouponInterval, fCouponInterval)
    print 'couponDate=', couponDate
    discountRate = np.exp(-fBondYield*couponDate)
    print 'discountRate=', discountRate

    fCoupon = fCouponInterval * fCouponRate * uFaceValue
    ucashFlowSize = couponDate.size
    cashFlow = np.ones(ucashFlowSize)*fCoupon
    cashFlow[ucashFlowSize - 1] += uFaceValue
    print 'cashFlow=', cashFlow

    discountedCashFlow = discountRate * cashFlow
    print 'discountedCashFlow=', discountedCashFlow

    print 'boundValue=', np.sum(discountedCashFlow)
    return np.sum(discountedCashFlow)

def main():
    #bondYield  = np.array([0.065, 0.068, 0.0695])
    fBondYield  = 0.0695
    fCouponRate = 0.08
    fCouponInterval = 0.5
    fMaturity   = 3
    BondValue(fBondYield, fCouponRate, fCouponInterval, fMaturity)

if __name__ == "__main__":
    main()

