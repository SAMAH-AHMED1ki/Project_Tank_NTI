/**
 * @file level_interface.h
 * @author Samah Ahmed (Process Sensing & Demand Logic)
 * @brief Public interface for the Tank Level sensing module.
 */

#ifndef LEVEL_INTERFACE_H
#define LEVEL_INTERFACE_H

#include "STD_TYPES.h"
/* Channel mapping based on project specifications */
#define LVL_ROOF_CHANNEL 0      /* ADC0: Roof tank level sensor */
#define LVL_RESERVOIR_CHANNEL 1 /* ADC1: Ground reservoir level sensor */

/**
 * @brief Initialize the level sensing module.
 * @return STD_ReturnType E_OK if successful, E_NOK otherwise.
 */
STD_ReturnType LVL_Init(void);

/**
 * @brief Update and calculate the percentage for a specific channel using Median filtering.
 * @param Copy_u8Channel The ADC channel to read from (0 or 1).
 * @param Copy_pu8Percentage Pointer to store the calculated percentage (0 - 100%).
 * @return STD_ReturnType E_OK if successful, E_NOK otherwise.
 */
STD_ReturnType LVL_Update(uint8 Copy_u8Channel, uint8 *Copy_pu8Percentage);

/**
 * @brief Get the current roof tank level percentage.
 * @param Copy_pu8Percentage Pointer to store the percentage value.
 * @return STD_ReturnType E_OK if successful, E_NOK otherwise.
 */
STD_ReturnType LVL_GetPercent(uint8 *Copy_pu8Percentage);

/**
 * @brief Get the rate of change of the level (%/min).
 * @param Copy_pi8Rate Pointer to store the signed rate of change.
 * @return STD_ReturnType E_OK if successful, E_NOK otherwise.
 */
STD_ReturnType LVL_GetRate(sint8 *Copy_pi8Rate);

#endif /* LEVEL_INTERFACE_H */