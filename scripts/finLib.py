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
# @fDefaultPont: the date when default happens, in the unit of year with 0 as now 
# @fMaturity: maturity of bound
# @couponDate: derived from fCouponInterval if couponDate param is not specifically provided
# @return: current value of the bond 
def BondValue(fBondYield, fCouponRate, fCouponInterval, fMaturity, fDefaultPoint=None, fFaceValue=100, couponDate=None):
    logger = logging.getLogger(__name__)
    if couponDate == None:
        couponDate = np.arange(fCouponInterval, fMaturity+fCouponInterval, fCouponInterval)
    discountRate = np.exp(-fBondYield*couponDate)
    logger.debug('discountRate=%s', discountRate)

    fCoupon = fCouponInterval * fCouponRate * fFaceValue
    ucashFlowSize = couponDate.size
    cashFlow = np.ones(ucashFlowSize)*fCoupon
    cashFlow[ucashFlowSize - 1] += fFaceValue
    logger.debug('cashFlow=%s', cashFlow)
    if fDefaultPoint != None:
        for i in range(0, couponDate.shape[0]):
            if couponDate[i]>=fDefaultPoint:
                cashFlow[i] = 0 # nullify defaulted return
    logger.debug('nullified cashFlow=%s', cashFlow)

    discountedCashFlow = discountRate * cashFlow
    logger.debug('discountedCashFlow=%s', discountedCashFlow)

    logger.info('%.2f=BondValue(fBondYield=%.2f, fCouponRate=%.2f, fCouponInterval=%.2f, fMaturity=%.2f, fDefaultPoint=%s, fFaceValue=%.2f, couponDate=%s)', np.sum(discountedCashFlow), fBondYield, fCouponRate, fCouponInterval, fMaturity, fDefaultPoint, fFaceValue, couponDate)

    return np.sum(discountedCashFlow)

def main():
    setup_logging(logging.DEBUG)
    fRecoveryValue = 100*0.4
    fRiskFreeRate = 0.05

    #bondYield  = np.array([0.065, 0.068, 0.0695])
    fBondYield  = fRiskFreeRate
    fCouponRate = 0.08
    fCouponInterval = 0.5
    fMaturity   = 1
    defaultPoint = np.array([0.25, 0.75])
    fdefaulReturn = np.zeros(defaultPoint.size)
    for i in range(0, defaultPoint.size):
        """current value of the recovery on default date + 
           current value of all the risk free return before default -
           current value of all the risk free return
        """
        fdefaulReturn[i] = \
            fRecoveryValue*np.exp(-fRiskFreeRate*defaultPoint[i])  + \
            BondValue(fRiskFreeRate, fCouponRate, fCouponInterval, fMaturity, defaultPoint[i]) - \
            BondValue(fRiskFreeRate, fCouponRate, fCouponInterval, fMaturity)
    logging.info('fdefaulReturn=%s', fdefaulReturn)

if __name__ == "__main__":
    main()

