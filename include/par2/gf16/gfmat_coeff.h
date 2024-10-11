#ifndef GFMAT_COEFF_H
#define GFMAT_COEFF_H

#include <par2/osinfo/hedley.h>
#include <par2/osinfo/stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void gfmat_init();
void gfmat_free();
HEDLEY_CONST uint16_t gfmat_coeff_from_log(uint_fast16_t inputLog, uint_fast16_t recoveryBlock);
HEDLEY_CONST uint16_t gfmat_coeff(uint_fast16_t inputBlock, uint_fast16_t recoveryBlock);
HEDLEY_CONST uint16_t gfmat_input_log(uint_fast16_t inputBlock);
HEDLEY_CONST uint16_t gfmat_coeff_log(uint_fast16_t inputLog, uint_fast16_t recoveryBlock);
HEDLEY_CONST uint16_t gf16_exp(uint_fast16_t v);

#ifdef __cplusplus
}
#endif

#endif
