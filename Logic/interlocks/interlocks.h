/*
 * Author: Samah Ahmed Mahmoud Ahmed
 * Module: Application Interlocks & Safety Layer - Header
 */

#ifndef INTERLOCKS_H_
#define INTERLOCKS_H_

#include "STD_TYPES.h"

/* تهيئة نظام الحماية والإنذارات */
STD_ReturnType INT_Init(void);

/* تحديث وفحص شروط الحماية بصفة دورية */
STD_ReturnType INT_Update(void);

/* التحقق هل هناك حالة طوارئ أو فصل (Trip) حالياً؟ */
uint8 INT_IsSystemTripped(void);

#endif /* INTERLOCKS_H_ */