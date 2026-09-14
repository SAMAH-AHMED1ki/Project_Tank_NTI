/**
 * @file level_private.h
 * @author Samah Ahmed (Process Sensing & Demand Logic)
 * @brief Private configurations and helper prototypes for the Level module.
 */
#include "STD_TYPES.h"
#ifndef LEVEL_PRIVATE_H
#define LEVEL_PRIVATE_H

/**
 * @brief Helper function to extract the median of three raw ADC readings
 *        to eliminate noise and spikes.
 * @param a First ADC reading
 * @param b Second ADC reading
 * @param c Third ADC reading
 * @return uint16 The median value
 */
static uint16 LVL_GetMedian(uint16 a, uint16 b, uint16 c);

#endif /* LEVEL_PRIVATE_H */