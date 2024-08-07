// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1100 -mattr=-real-true16,+wavefrontsize32 -show-encoding %s | FileCheck --check-prefix=GFX11 %s
// RUN: llvm-mc -triple=amdgcn -mcpu=gfx1100 -mattr=-real-true16,+wavefrontsize64 -show-encoding %s | FileCheck --check-prefix=GFX11 %s

v_floor_f16 v5, v1
// GFX11: encoding: [0x01,0xb7,0x0a,0x7e]

v_floor_f16 v5, v127
// GFX11: encoding: [0x7f,0xb7,0x0a,0x7e]

v_floor_f16 v5, s1
// GFX11: encoding: [0x01,0xb6,0x0a,0x7e]

v_floor_f16 v5, s105
// GFX11: encoding: [0x69,0xb6,0x0a,0x7e]

v_floor_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xb6,0x0a,0x7e]

v_floor_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xb6,0x0a,0x7e]

v_floor_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xb6,0x0a,0x7e]

v_floor_f16 v5, m0
// GFX11: encoding: [0x7d,0xb6,0x0a,0x7e]

v_floor_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xb6,0x0a,0x7e]

v_floor_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xb6,0x0a,0x7e]

v_floor_f16 v5, null
// GFX11: encoding: [0x7c,0xb6,0x0a,0x7e]

v_floor_f16 v5, -1
// GFX11: encoding: [0xc1,0xb6,0x0a,0x7e]

v_floor_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xb6,0x0a,0x7e]

v_floor_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xb6,0x0a,0x7e]

v_floor_f16 v127, 0xfe0b
// GFX11: encoding: [0xff,0xb6,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_floor_f32 v5, v1
// GFX11: encoding: [0x01,0x49,0x0a,0x7e]

v_ceil_f16 v5, v1
// GFX11: encoding: [0x01,0xb9,0x0a,0x7e]

v_ceil_f16 v5, v127
// GFX11: encoding: [0x7f,0xb9,0x0a,0x7e]

v_ceil_f16 v5, s1
// GFX11: encoding: [0x01,0xb8,0x0a,0x7e]

v_ceil_f16 v5, s105
// GFX11: encoding: [0x69,0xb8,0x0a,0x7e]

v_ceil_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xb8,0x0a,0x7e]

v_ceil_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xb8,0x0a,0x7e]

v_ceil_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xb8,0x0a,0x7e]

v_ceil_f16 v5, m0
// GFX11: encoding: [0x7d,0xb8,0x0a,0x7e]

v_ceil_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xb8,0x0a,0x7e]

v_ceil_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xb8,0x0a,0x7e]

v_ceil_f16 v5, null
// GFX11: encoding: [0x7c,0xb8,0x0a,0x7e]

v_ceil_f16 v5, -1
// GFX11: encoding: [0xc1,0xb8,0x0a,0x7e]

v_ceil_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xb8,0x0a,0x7e]

v_ceil_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xb8,0x0a,0x7e]

v_ceil_f16 v127, 0xfe0b
// GFX11: encoding: [0xff,0xb8,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_rcp_f16 v5, v1
// GFX11: encoding: [0x01,0xa9,0x0a,0x7e]

v_rcp_f16 v5, v127
// GFX11: encoding: [0x7f,0xa9,0x0a,0x7e]

v_rcp_f16 v5, s1
// GFX11: encoding: [0x01,0xa8,0x0a,0x7e]

v_rcp_f16 v5, s105
// GFX11: encoding: [0x69,0xa8,0x0a,0x7e]

v_rcp_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xa8,0x0a,0x7e]

v_rcp_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xa8,0x0a,0x7e]

v_rcp_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xa8,0x0a,0x7e]

v_rcp_f16 v5, m0
// GFX11: encoding: [0x7d,0xa8,0x0a,0x7e]

v_rcp_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xa8,0x0a,0x7e]

v_rcp_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xa8,0x0a,0x7e]

v_rcp_f16 v5, null
// GFX11: encoding: [0x7c,0xa8,0x0a,0x7e]

v_rcp_f16 v5, -1
// GFX11: encoding: [0xc1,0xa8,0x0a,0x7e]

v_rcp_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xa8,0x0a,0x7e]

v_rcp_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xa8,0x0a,0x7e]

v_rcp_f16 v127, 0xfe0b
// GFX11: encoding: [0xff,0xa8,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_sqrt_f16 v5, v1
// GFX11: encoding: [0x01,0xab,0x0a,0x7e]

v_sqrt_f16 v5, v127
// GFX11: encoding: [0x7f,0xab,0x0a,0x7e]

v_sqrt_f16 v5, s1
// GFX11: encoding: [0x01,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, s105
// GFX11: encoding: [0x69,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, m0
// GFX11: encoding: [0x7d,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, null
// GFX11: encoding: [0x7c,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, -1
// GFX11: encoding: [0xc1,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xaa,0x0a,0x7e]

v_sqrt_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xaa,0x0a,0x7e]

v_sqrt_f16 v127, 0xfe0b
// GFX11: encoding: [0xff,0xaa,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_rsq_f16 v5, v1
// GFX11: encoding: [0x01,0xad,0x0a,0x7e]

v_rsq_f16 v5, v127
// GFX11: encoding: [0x7f,0xad,0x0a,0x7e]

v_rsq_f16 v5, s1
// GFX11: encoding: [0x01,0xac,0x0a,0x7e]

v_rsq_f16 v5, s105
// GFX11: encoding: [0x69,0xac,0x0a,0x7e]

v_rsq_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xac,0x0a,0x7e]

v_rsq_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xac,0x0a,0x7e]

v_rsq_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xac,0x0a,0x7e]

v_rsq_f16 v5, m0
// GFX11: encoding: [0x7d,0xac,0x0a,0x7e]

v_rsq_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xac,0x0a,0x7e]

v_rsq_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xac,0x0a,0x7e]

v_rsq_f16 v5, null
// GFX11: encoding: [0x7c,0xac,0x0a,0x7e]

v_rsq_f16 v5, -1
// GFX11: encoding: [0xc1,0xac,0x0a,0x7e]

v_rsq_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xac,0x0a,0x7e]

v_rsq_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xac,0x0a,0x7e]

v_log_f16 v5, v1
// GFX11: encoding: [0x01,0xaf,0x0a,0x7e]

v_log_f16 v5, v127
// GFX11: encoding: [0x7f,0xaf,0x0a,0x7e]

v_log_f16 v5, s1
// GFX11: encoding: [0x01,0xae,0x0a,0x7e]

v_log_f16 v5, s105
// GFX11: encoding: [0x69,0xae,0x0a,0x7e]

v_log_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xae,0x0a,0x7e]

v_log_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xae,0x0a,0x7e]

v_log_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xae,0x0a,0x7e]

v_log_f16 v5, m0
// GFX11: encoding: [0x7d,0xae,0x0a,0x7e]

v_log_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xae,0x0a,0x7e]

v_log_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xae,0x0a,0x7e]

v_log_f16 v5, null
// GFX11: encoding: [0x7c,0xae,0x0a,0x7e]

v_log_f16 v5, -1
// GFX11: encoding: [0xc1,0xae,0x0a,0x7e]

v_log_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xae,0x0a,0x7e]

v_log_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xae,0x0a,0x7e]

v_log_f16 v127, 0xfe0b
// GFX11: encoding: [0xff,0xae,0xfe,0x7e,0x0b,0xfe,0x00,0x00]

v_exp_f16 v5, v1
// GFX11: encoding: [0x01,0xb1,0x0a,0x7e]

v_exp_f16 v5, v127
// GFX11: encoding: [0x7f,0xb1,0x0a,0x7e]

v_exp_f16 v5, s1
// GFX11: encoding: [0x01,0xb0,0x0a,0x7e]

v_exp_f16 v5, s105
// GFX11: encoding: [0x69,0xb0,0x0a,0x7e]

v_exp_f16 v5, vcc_lo
// GFX11: encoding: [0x6a,0xb0,0x0a,0x7e]

v_exp_f16 v5, vcc_hi
// GFX11: encoding: [0x6b,0xb0,0x0a,0x7e]

v_exp_f16 v5, ttmp15
// GFX11: encoding: [0x7b,0xb0,0x0a,0x7e]

v_exp_f16 v5, m0
// GFX11: encoding: [0x7d,0xb0,0x0a,0x7e]

v_exp_f16 v5, exec_lo
// GFX11: encoding: [0x7e,0xb0,0x0a,0x7e]

v_exp_f16 v5, exec_hi
// GFX11: encoding: [0x7f,0xb0,0x0a,0x7e]

v_exp_f16 v5, null
// GFX11: encoding: [0x7c,0xb0,0x0a,0x7e]

v_exp_f16 v5, -1
// GFX11: encoding: [0xc1,0xb0,0x0a,0x7e]

v_exp_f16 v5, 0.5
// GFX11: encoding: [0xf0,0xb0,0x0a,0x7e]

v_exp_f16 v5, src_scc
// GFX11: encoding: [0xfd,0xb0,0x0a,0x7e]

v_exp_f16 v127, 0xfe0b
// GFX11: encoding: [0xff,0xb0,0xfe,0x7e,0x0b,0xfe,0x00,0x00]
