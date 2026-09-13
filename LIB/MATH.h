#ifndef MATH_H
#define MATH_H

#include "STD_TYPES.h"
#define SET_BIT(REG, BIT) ((REG) |= (1u << (BIT)))
#define CLR_BIT(REG, BIT) ((REG) &= ~(1u << (BIT)))
#define TOG_BIT(REG, BIT) ((REG) ^= (1u << (BIT)))
#define GET_BIT(REG, BIT) (((REG) >> (BIT)) & 1u)

#endif // MATH_H