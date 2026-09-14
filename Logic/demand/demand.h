/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Application Pump Demand Logic - Header
 */

#ifndef DEMAND_H_
#define DEMAND_H_

#include "STD_TYPES.h"

/* تهيئة منطق الطلب */
STD_ReturnType DEM_Init(void);

/* تحديث حالة الطلب بناءً على الحساسات ومفاتيح التعويم */
STD_ReturnType DEM_Update(void);

/* هل هناك طلب لتشغيل المضخة أم لا؟ (1 = مطلوب تشغيل، 0 = متوقف) */
uint8 DEM_GetPumpDemand(void);

#endif /* DEMAND_H_ */