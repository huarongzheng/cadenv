#!/usr/bin/env /usr/bin/python
import os
import json
import yaml
import logging
import logging.config

import numpy as np
import getopt, sys
import re
import collections
import random
import matplotlib.pyplot as plt


def setup_logging(
    default_level=logging.INFO,
    default_path='logging.yaml',
    env_key='LOG_CFG'
):
    #Setup logging configuration
    path = default_path
    value = os.getenv(env_key, None)
    if value:
        path = value
    if os.path.exists(path):
        with open(path, 'rt') as f:
            config = yaml.safe_load(f.read())
        logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=default_level)
 
##
# current value of a bond with specified face value (default to $100), given the following parameters
# @fBondYield: yield rate for discounting cash flow within bond maturity
# @fCouponRate: anual coupon rate
# @fCouponInterval: coupon paying date, semianual-0.5 anual-1 etc
# @fMaturity: maturity of bound
# @couponDate: derived from fCouponInterval if couponDate param is not specifically provided
# @return: current value of the bond 
def BondValue(fBondYield, fCouponRate, fCouponInterval, fMaturity, uFaceValue=100, couponDate = None):
    logger = logging.getLogger(__name__)
    if couponDate == None:
        couponDate = np.arange(fCouponInterval, fMaturity+fCouponInterval, fCouponInterval)
    logger.info('couponDate=%s', couponDate)
    discountRate = np.exp(-fBondYield*couponDate)
    logger.debug('discountRate=%s', discountRate)

    fCoupon = fCouponInterval * fCouponRate * uFaceValue
    ucashFlowSize = couponDate.size
    cashFlow = np.ones(ucashFlowSize)*fCoupon
    cashFlow[ucashFlowSize - 1] += uFaceValue
    logger.debug('cashFlow=%s', cashFlow)

    discountedCashFlow = discountRate * cashFlow
    logger.debug('discountedCashFlow=%s', discountedCashFlow)

    logger.debug('boundValue=%s', np.sum(discountedCashFlow))
    return np.sum(discountedCashFlow)

def main():
    setup_logging(logging.DEBUG)

    #bondYield  = np.array([0.065, 0.068, 0.0695])
    fBondYield  = 0.05
    fCouponRate = 0.08
    fCouponInterval = 0.5
    fMaturity   = 1
    BondValue(fBondYield, fCouponRate, fCouponInterval, fMaturity)

if __name__ == "__main__":
    main()

