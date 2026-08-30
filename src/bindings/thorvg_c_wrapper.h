#ifndef THORVG_C_WRAPPER_H
#define THORVG_C_WRAPPER_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

int thorvg_wrapper_init(void);
void thorvg_wrapper_finish(void);

#ifdef __cplusplus
}
#endif

#endif // THORVG_C_WRAPPER_H
