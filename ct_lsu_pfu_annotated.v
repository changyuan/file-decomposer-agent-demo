/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/  // 版权声明和Apache 2.0开源许可证

// &ModuleBeg; @28  // 模块开始标记
module ct_lsu_pfu(  // PFU（Prefetch Unit，预取单元）模块定义 - 负责处理器load/store指令的预取操作
  amr_wa_cancel,                      // AMR（地址重映射寄存器）写回取消信号，用于处理异常情况
  bus_arb_pfu_ar_grnt,               // 总线仲裁器到PFU的读地址通道授权信号
  bus_arb_pfu_ar_ready,              // 总线仲裁器到PFU的读地址通道就绪信号
  cp0_lsu_dcache_en,                 // CP0（协处理器0）控制的L1数据缓存使能信号
  cp0_lsu_dcache_pref_en,            // CP0控制的L1数据缓存预取使能信号
  cp0_lsu_icg_en,                    // CP0控制的时钟门控使能信号
  cp0_lsu_l2_pref_en,                // CP0控制的L2缓存预取使能信号
  cp0_lsu_l2_st_pref_en,             // CP0控制的L2缓存存储预取使能信号
  cp0_lsu_no_op_req,                 // CP0控制的无操作请求信号，用于暂停预取
  cp0_lsu_pfu_mmu_dis,               // CP0控制的PFU的MMU（内存管理单元）禁用信号
  cp0_lsu_timeout_cnt,               // CP0控制的超时计数器，用于预取条目管理
  cp0_yy_clk_en,                     // CP0控制的全局时钟使能信号
  cp0_yy_dcache_pref_en,             // CP0控制的缓存预取全局使能信号
  cp0_yy_priv_mode,                  // CP0控制的处理器特权模式（用户态/内核态）
  cpurst_b,                          // CPU复位信号（低有效）
  forever_cpuclk,                    // 永远有效的CPU时钟信号
  icc_idle,                          // ICC（指令提交控制）空闲信号
  ld_da_iid,                         // Load（加载）流水级DA阶段的指令ID
  ld_da_ldfifo_pc,                   // Load DA阶段的加载FIFO PC（程序计数器）
  ld_da_page_sec_ff,                 // Load DA阶段页面安全标志流水线寄存器
  ld_da_page_share_ff,               // Load DA阶段页面共享标志流水线寄存器
  ld_da_pfu_act_dp_vld,              // Load DA到PFU的实际数据预取有效信号（双拍有效）
  ld_da_pfu_act_vld,                 // Load DA到PFU的实际数据预取有效信号
  ld_da_pfu_biu_req_hit_idx,         // Load DA到PFU的BIU请求命中索引
  ld_da_pfu_evict_cnt_vld,           // Load DA到PFU的驱逐计数器有效信号
  ld_da_pfu_pf_inst_vld,             // Load DA到PFU的预取指令有效信号
  ld_da_pfu_va,                      // Load DA到PFU的虚地址（Virtual Address）
  ld_da_ppfu_va,                     // Load DA到PFU的物理预取虚地址
  ld_da_ppn_ff,                      // Load DA到PFU的物理页号流水线寄存器
  lfb_addr_full,                     // LFB（Line Fill Buffer，线路填充缓冲区）地址满信号
  lfb_addr_less2,                    // LFB地址少于2的信号（预留地址空间）
  lfb_pfu_biu_req_hit_idx,           // LFB到PFU的BIU请求命中索引
  lfb_pfu_create_id,                 // LFB到PFU的创建ID
  lfb_pfu_dcache_hit,                // LFB到PFU的数据缓存命中信号（8位）
  lfb_pfu_dcache_miss,               // LFB到PFU的数据缓存未命中信号（8位）
  lfb_pfu_rready_grnt,               // LFB到PFU的读就绪授权信号
  lm_pfu_biu_req_hit_idx,            // LM（Load merge）到PFU的BIU请求命中索引
  lsu_mmu_va2,                       // LSU到MMU的转换虚地址
  lsu_mmu_va2_vld,                   // LSU到MMU的转换虚地址有效信号
  lsu_pfu_l1_dist_sel,               // LSU到PFU的L1缓存分布选择信号（4位）
  lsu_pfu_l2_dist_sel,               // LSU到PFU的L2缓存分布选择信号（4位）
  lsu_special_clk,                   // LSU特殊时钟信号
  mmu_lsu_pa2,                       // MMU到LSU的转换物理地址
  mmu_lsu_pa2_err,                   // MMU到LSU的转换物理地址错误信号
  mmu_lsu_pa2_vld,                   // MMU到LSU的转换物理地址有效信号
  mmu_lsu_sec2,                      // MMU到LSU的安全标志
  mmu_lsu_share2,                    // MMU到LSU的共享标志
  pad_yy_icg_scan_en,                // PAD（Padding，填充）到ICG扫描使能信号
  pfu_biu_ar_addr,                   // PFU到BIU的读地址
  pfu_biu_ar_bar,                    // PFU到BIU的读地址响应类型（BAR - Bus Access Rights）
  pfu_biu_ar_burst,                  // PFU到BIU的读地址突发类型
  pfu_biu_ar_cache,                  // PFU到BIU的读地址缓存属性
  pfu_biu_ar_domain,                 // PFU到BIU的读地址域属性
  pfu_biu_ar_dp_req,                 // PFU到BIU的读地址双拍请求
  pfu_biu_ar_id,                     // PFU到BIU的读地址事务ID
  pfu_biu_ar_len,                    // PFU到BIU的读地址突发长度
  pfu_biu_ar_lock,                   // PFU到BIU的读地址锁定信号
  pfu_biu_ar_prot,                   // PFU到BIU的读地址保护属性
  pfu_biu_ar_req,                    // PFU到BIU的读地址请求
  pfu_biu_ar_req_gateclk_en,         // PFU到BIU的读地址请求时钟门控使能
  pfu_biu_ar_size,                   // PFU到BIU的读地址传输大小
  pfu_biu_ar_snoop,                  // PFU到BIU的读地址窥探属性
  pfu_biu_ar_user,                   // PFU到BIU的读地址用户属性
  pfu_biu_req_addr,                  // PFU到BIU的请求地址
  pfu_icc_ready,                     // PFU到ICC的就绪信号
  pfu_lfb_create_dp_vld,             // PFU到LFB的创建双拍有效信号
  pfu_lfb_create_gateclk_en,         // PFU到LFB的创建时钟门控使能
  pfu_lfb_create_req,                // PFU到LFB的创建请求
  pfu_lfb_create_vld,                // PFU到LFB的创建有效信号
  pfu_lfb_id,                        // PFU到LFB的ID（4位）
  pfu_part_empty,                    // PFU部分空信号（PMB/SDB/PFB都为空）
  pfu_pfb_empty,                     // PFU的PFB（Prefetch Fetch Buffer）空信号
  pfu_sdb_create_gateclk_en,         // PFU到SDB的创建时钟门控使能
  pfu_sdb_empty,                     // PFU的SDB（Stride Detection Buffer）空信号
  rb_pfu_biu_req_hit_idx,            // RB（Read Buffer）到PFU的BIU请求命中索引
  rb_pfu_nc_no_pending,              // RB到PFU的非缓存无待处理请求信号
  rtu_yy_xx_commit0,                 // RTU（ Retirement Unit）提交信号0
  rtu_yy_xx_commit0_iid,             // RTU提交信号0的指令ID
  rtu_yy_xx_commit1,                 // RTU提交信号1
  rtu_yy_xx_commit1_iid,             // RTU提交信号1的指令ID
  rtu_yy_xx_commit2,                 // RTU提交信号2
  rtu_yy_xx_commit2_iid,             // RTU提交信号2的指令ID
  rtu_yy_xx_flush,                   // RTU刷新信号
  sq_pfu_pop_synci_inst,             // SQ（Store Queue）到PFU的弹出同步指令信号
  st_da_iid,                         // Store（存储）流水级DA阶段的指令ID
  st_da_page_sec_ff,                 // Store DA阶段页面安全标志流水线寄存器
  st_da_page_share_ff,               // Store DA阶段页面共享标志流水线寄存器
  st_da_pc,                          // Store DA阶段的程序计数器
  st_da_pfu_act_dp_vld,              // Store DA到PFU的实际数据预取有效信号（双拍有效）
  st_da_pfu_act_vld,                 // Store DA到PFU的实际数据预取有效信号
  st_da_pfu_biu_req_hit_idx,         // Store DA到PFU的BIU请求命中索引
  st_da_pfu_evict_cnt_vld,           // Store DA到PFU的驱逐计数器有效信号
  st_da_pfu_pf_inst_vld,             // Store DA到PFU的预取指令有效信号
  st_da_ppfu_va,                     // Store DA到PFU的物理预取虚地址
  st_da_ppn_ff,                      // Store DA到PFU的物理页号流水线寄存器
  vb_pfu_biu_req_hit_idx,            // VB（Victim Buffer）到PFU的BIU请求命中索引
  wmb_pfu_biu_req_hit_idx            // WMB（Write Merge Buffer）到PFU的BIU请求命中索引
);

  // &Ports; @29  // 端口声明部分开始
  input           amr_wa_cancel;                     // AMR写回取消信号输入
  input           bus_arb_pfu_ar_grnt;               // 总线仲裁器读地址授权信号输入
  input           bus_arb_pfu_ar_ready;              // 总线仲裁器读地址就绪信号输入
  input           cp0_lsu_dcache_en;                 // L1数据缓存使能信号输入
  input           cp0_lsu_dcache_pref_en;            // L1数据缓存预取使能信号输入
  input           cp0_lsu_icg_en;                    // 时钟门控使能信号输入
  input           cp0_lsu_l2_pref_en;                // L2缓存预取使能信号输入
  input           cp0_lsu_l2_st_pref_en;             // L2缓存存储预取使能信号输入
  input           cp0_lsu_no_op_req;                 // 无操作请求信号输入
  input           cp0_lsu_pfu_mmu_dis;               // PFU的MMU禁用信号输入
  input   [29:0]  cp0_lsu_timeout_cnt;               // 超时计数器输入（30位）
  input           cp0_yy_clk_en;                      // 全局时钟使能信号输入
  input           cp0_yy_dcache_pref_en;             // 缓存预取全局使能信号输入
  input   [1 :0]  cp0_yy_priv_mode;                  // 处理器特权模式输入（2位）
  input           cpurst_b;                          // CPU复位信号输入（低有效）
  input           forever_cpuclk;                    // 永远有效的CPU时钟信号输入
  input           icc_idle;                          // ICC空闲信号输入
  input   [6 :0]  ld_da_iid;                         // Load DA阶段指令ID输入（7位）
  input   [14:0]  ld_da_ldfifo_pc;                   // Load DA阶段加载FIFO PC输入（15位）
  input           ld_da_page_sec_ff;                 // Load DA阶段页面安全标志输入
  input           ld_da_page_share_ff;               // Load DA阶段页面共享标志输入
  input           ld_da_pfu_act_dp_vld;              // Load到PFU实际数据预取双拍有效输入

  input           ld_da_pfu_act_vld;                 // Load到PFU实际数据预取有效输入
  input           ld_da_pfu_biu_req_hit_idx;         // Load到PFU的BIU请求命中索引输入
  input           ld_da_pfu_evict_cnt_vld;           // Load到PFU的驱逐计数器有效输入
  input           ld_da_pfu_pf_inst_vld;             // Load到PFU的预取指令有效输入
  input   [39:0]  ld_da_pfu_va;                      // Load到PFU的虚地址输入（40位）
  input   [39:0]  ld_da_ppfu_va;                     // Load到PFU的物理预取虚地址输入（40位）
  input   [27:0]  ld_da_ppn_ff;                      // Load到PFU的物理页号流水线寄存器输入（28位）
  input           lfb_addr_full;                      // LFB地址满信号输入
  input           lfb_addr_less2;                    // LFB地址少于2信号输入
  input           lfb_pfu_biu_req_hit_idx;           // LFB到PFU的BIU请求命中索引输入
  input   [4 :0]  lfb_pfu_create_id;                 // LFB到PFU的创建ID输入（5位）
  input   [8 :0]  lfb_pfu_dcache_hit;                // LFB到PFU的数据缓存命中信号输入（9位）
  input   [8 :0]  lfb_pfu_dcache_miss;               // LFB到PFU的数据缓存未命中信号输入（9位）
  input           lfb_pfu_rready_grnt;               // LFB到PFU的读就绪授权信号输入
  input           lm_pfu_biu_req_hit_idx;            // LM到PFU的BIU请求命中索引输入
  input   [3 :0]  lsu_pfu_l1_dist_sel;               // LSU到PFU的L1分布选择输入（4位）
  input   [3 :0]  lsu_pfu_l2_dist_sel;               // LSU到PFU的L2分布选择输入（4位）
  input           lsu_special_clk;                    // LSU特殊时钟信号输入
  input   [27:0]  mmu_lsu_pa2;                        // MMU到LSU的物理地址输入（28位）
  input           mmu_lsu_pa2_err;                    // MMU到LSU的物理地址错误信号输入
  input           mmu_lsu_pa2_vld;                    // MMU到LSU的物理地址有效信号输入
  input           mmu_lsu_sec2;                       // MMU到LSU的安全标志输入
  input           mmu_lsu_share2;                     // MMU到LSU的共享标志输入
  input           pad_yy_icg_scan_en;                 // PAD到ICG扫描使能输入
  input           rb_pfu_biu_req_hit_idx;            // RB到PFU的BIU请求命中索引输入
  input           rb_pfu_nc_no_pending;              // RB到PFU的非缓存无待处理请求输入
  input           rtu_yy_xx_commit0;                 // RTU提交信号0输入
  input   [6 :0]  rtu_yy_xx_commit0_iid;             // RTU提交信号0的指令ID输入（7位）
  input           rtu_yy_xx_commit1;                 // RTU提交信号1输入
  input   [6 :0]  rtu_yy_xx_commit1_iid;             // RTU提交信号1的指令ID输入（7位）
  input           rtu_yy_xx_commit2;                 // RTU提交信号2输入
  input   [6 :0]  rtu_yy_xx_commit2_iid;             // RTU提交信号2的指令ID输入（7位）
  input           rtu_yy_xx_flush;                    // RTU刷新信号输入
  input           sq_pfu_pop_synci_inst;             // SQ到PFU的弹出同步指令输入
  input   [6 :0]  st_da_iid;                         // Store DA阶段指令ID输入（7位）
  input           st_da_page_sec_ff;                 // Store DA阶段页面安全标志输入
  input           st_da_page_share_ff;               // Store DA阶段页面共享标志输入
  input   [14:0]  st_da_pc;                          // Store DA阶段程序计数器输入（15位）
  input           st_da_pfu_act_dp_vld;              // Store到PFU实际数据预取双拍有效输入
  input           st_da_pfu_act_vld;                 // Store到PFU实际数据预取有效输入
  input           st_da_pfu_biu_req_hit_idx;         // Store到PFU的BIU请求命中索引输入
  input           st_da_pfu_evict_cnt_vld;           // Store到PFU的驱逐计数器有效输入
  input           st_da_pfu_pf_inst_vld;             // Store到PFU的预取指令有效输入
  input   [39:0]  st_da_ppfu_va;                     // Store到PFU的物理预取虚地址输入（40位）
  input   [27:0]  st_da_ppn_ff;                      // Store到PFU的物理页号流水线寄存器输入（28位）
  input           vb_pfu_biu_req_hit_idx;            // VB到PFU的BIU请求命中索引输入
  input           wmb_pfu_biu_req_hit_idx;           // WMB到PFU的BIU请求命中索引输入
  output  [27:0]  lsu_mmu_va2;                        // LSU到MMU的转换虚地址输出（28位）
  output          lsu_mmu_va2_vld;                    // LSU到MMU的转换虚地址有效输出
  output  [39:0]  pfu_biu_ar_addr;                    // PFU到BIU的读地址输出（40位）
  output  [1 :0]  pfu_biu_ar_bar;                    // PFU到BIU的读地址响应类型输出（2位）
  output  [1 :0]  pfu_biu_ar_burst;                  // PFU到BIU的读地址突发类型输出（2位）
  output  [3 :0]  pfu_biu_ar_cache;                  // PFU到BIU的读地址缓存属性输出（4位）
  output  [1 :0]  pfu_biu_ar_domain;                 // PFU到BIU的读地址域属性输出（2位）
  output          pfu_biu_ar_dp_req;                 // PFU到BIU的读地址双拍请求输出
  output  [4 :0]  pfu_biu_ar_id;                      // PFU到BIU的读地址事务ID输出（5位）
  output  [1 :0]  pfu_biu_ar_len;                    // PFU到BIU的读地址突发长度输出（2位）
  output          pfu_biu_ar_lock;                    // PFU到BIU的读地址锁定输出
  output  [2 :0]  pfu_biu_ar_prot;                   // PFU到BIU的读地址保护属性输出（3位）
  output          pfu_biu_ar_req;                    // PFU到BIU的读地址请求输出
  output          pfu_biu_ar_req_gateclk_en;         // PFU到BIU的读地址请求时钟门控使能输出
  output  [2 :0]  pfu_biu_ar_size;                   // PFU到BIU的读地址传输大小输出（3位）
  output  [3 :0]  pfu_biu_ar_snoop;                  // PFU到BIU的读地址窥探属性输出（4位）
  output  [2 :0]  pfu_biu_ar_user;                   // PFU到BIU的读地址用户属性输出（3位）
  output  [39:0]  pfu_biu_req_addr;                 // PFU到BIU的请求地址输出（40位）
  output          pfu_icc_ready;                      // PFU到ICC的就绪输出
  output          pfu_lfb_create_dp_vld;             // PFU到LFB的创建双拍有效输出
  output          pfu_lfb_create_gateclk_en;         // PFU到LFB的创建时钟门控使能输出
  output          pfu_lfb_create_req;                // PFU到LFB的创建请求输出
  output          pfu_lfb_create_vld;                // PFU到LFB的创建有效输出
  output  [3 :0]  pfu_lfb_id;                        // PFU到LFB的ID输出（4位）
  output          pfu_part_empty;                    // PFU部分空信号输出（PMB/SDB/PFB都为空）
  output          pfu_pfb_empty;                      // PFU的PFB空信号输出
  output          pfu_sdb_create_gateclk_en;         // PFU到SDB的创建时钟门控使能输出
  output          pfu_sdb_empty;                      // PFU的SDB空信号输出

  // &Regs; @30  // 寄存器声明部分开始
  reg     [8 :0]  pfu_biu_pe_req_ptr_priority_0;     // PFU的BIU弹出请求指针优先级0（9位）
  reg     [8 :0]  pfu_biu_pe_req_ptr_priority_1;     // PFU的BIU弹出请求指针优先级1（9位）
  reg     [33:0]  pfu_biu_req_addr_tto6;             // PFU到BIU的请求地址右移6位（34位）
  reg             pfu_biu_req_l1;                    // PFU到BIU的请求L1缓存标志
  reg             pfu_biu_req_page_sec;              // PFU到BIU的请求页面安全标志
  reg             pfu_biu_req_page_share;            // PFU到BIU的请求页面共享标志
  reg     [8 :0]  pfu_biu_req_priority;              // PFU到BIU的请求优先级（9位）
  reg     [1 :0]  pfu_biu_req_priv_mode;             // PFU到BIU的请求特权模式（2位）
  reg     [8 :0]  pfu_biu_req_ptr;                    // PFU到BIU的请求指针（9位）
  reg             pfu_biu_req_unmask;                // PFU到BIU的请求去屏蔽标志
  reg     [8 :0]  pfu_mmu_pe_req_ptr;                // PFU的MMU弹出请求指针（9位）
  reg             pfu_mmu_req;                        // PFU的MMU请求标志
  reg             pfu_mmu_req_l1;                    // PFU的MMU请求L1标志
  reg     [8 :0]  pfu_mmu_req_ptr;                    // PFU的MMU请求指针（9位）
  reg     [27:0]  pfu_mmu_req_vpn;                   // PFU的MMU请求虚页号（28位）
  reg     [7 :0]  pfu_pfb_empty_create_ptr;          // PFU的PFB空创建指针（8位）
  reg     [7 :0]  pfu_pfb_evict_create_ptr;          // PFU的PFB驱逐创建指针（8位）
  reg     [7 :0]  pfu_pmb_empty_create_ptr;          // PFU的PMB空创建指针（8位）
  reg     [7 :0]  pfu_pmb_evict_create_ptr;          // PFU的PMB驱逐创建指针（8位）
  reg     [7 :0]  pfu_pmb_pop_ptr;                    // PFU的PMB弹出指针（8位）
  reg     [1 :0]  pfu_sdb_empty_create_ptr;          // PFU的SDB空创建指针（2位）
  reg     [1 :0]  pfu_sdb_evict_create_ptr;          // PFU的SDB驱逐创建指针（2位）
  reg     [1 :0]  pfu_sdb_pop_ptr;                    // PFU的SDB弹出指针（2位）

  // &Wires; @31  // 线网声明部分开始
  wire            amr_wa_cancel;                      // AMR写回取消信号线网
  wire            bus_arb_pfu_ar_grnt;               // 总线仲裁器读地址授权信号线网
  wire            bus_arb_pfu_ar_ready;              // 总线仲裁器读地址就绪信号线网
  wire            cp0_lsu_dcache_en;                 // L1数据缓存使能信号线网
  wire            cp0_lsu_dcache_pref_en;            // L1数据缓存预取使能信号线网
  wire            cp0_lsu_icg_en;                    // 时钟门控使能信号线网
  wire            cp0_lsu_l2_pref_en;                // L2缓存预取使能信号线网
  wire            cp0_lsu_l2_st_pref_en;             // L2缓存存储预取使能信号线网
  wire            cp0_lsu_no_op_req;                 // 无操作请求信号线网
  wire            cp0_lsu_pfu_mmu_dis;               // PFU的MMU禁用信号线网
  wire    [29:0]  cp0_lsu_timeout_cnt;               // 超时计数器信号线网（30位）
  wire            cp0_yy_clk_en;                      // 全局时钟使能信号线网
  wire            cp0_yy_dcache_pref_en;             // 缓存预取全局使能信号线网
  wire    [1 :0]  cp0_yy_priv_mode;                  // 处理器特权模式信号线网（2位）
  wire            cpurst_b;                          // CPU复位信号线网（低有效）
  wire            forever_cpuclk;                    // 永远有效的CPU时钟信号线网
  wire            icc_idle;                          // ICC空闲信号线网
  wire    [6 :0]  ld_da_iid;                         // Load DA阶段指令ID信号线网（7位）
  wire    [14:0]  ld_da_ldfifo_pc;                   // Load DA阶段加载FIFO PC信号线网（15位）
  wire            ld_da_page_sec_ff;                 // Load DA阶段页面安全标志信号线网
  wire            ld_da_page_share_ff;               // Load DA阶段页面共享标志信号线网
  wire            ld_da_pfu_act_dp_vld;              // Load到PFU实际数据预取双拍有效信号线网
  wire            ld_da_pfu_act_vld;                 // Load到PFU实际数据预取有效信号线网
  wire            ld_da_pfu_biu_req_hit_idx;         // Load到PFU的BIU请求命中索引信号线网
  wire            ld_da_pfu_evict_cnt_vld;           // Load到PFU的驱逐计数器有效信号线网
  wire            ld_da_pfu_pf_inst_vld;             // Load到PFU的预取指令有效信号线网
  wire    [39:0]  ld_da_pfu_va;                      // Load到PFU的虚地址信号线网（40位）
  wire    [39:0]  ld_da_ppfu_va;                     // Load到PFU的物理预取虚地址信号线网（40位）
  wire    [27:0]  ld_da_ppn_ff;                      // Load到PFU的物理页号流水线寄存器信号线网（28位）
  wire            lfb_addr_full;                      // LFB地址满信号线网
  wire            lfb_addr_less2;                    // LFB地址少于2信号线网
  wire            lfb_pfu_biu_req_hit_idx;           // LFB到PFU的BIU请求命中索引信号线网
  wire    [4 :0]  lfb_pfu_create_id;                 // LFB到PFU的创建ID信号线网（5位）
  wire    [8 :0]  lfb_pfu_dcache_hit;                // LFB到PFU的数据缓存命中信号线网（9位）
  wire    [8 :9]  lfb_pfu_dcache_miss;               // LFB到PFU的数据缓存未命中信号线网（9位）
  wire            lfb_pfu_rready_grnt;               // LFB到PFU的读就绪授权信号线网
  wire            lm_pfu_biu_req_hit_idx;            // LM到PFU的BIU请求命中索引信号线网
  wire    [27:0]  lsu_mmu_va2;                        // LSU到MMU的转换虚地址信号线网（28位）
  wire            lsu_mmu_va2_vld;                    // LSU到MMU的转换虚地址有效信号线网
  wire    [3 :0]  lsu_pfu_l1_dist_sel;               // LSU到PFU的L1分布选择信号线网（4位）
  wire    [3 :0]  lsu_pfu_l2_dist_sel;               // LSU到PFU的L2分布选择信号线网（4位）
  wire            lsu_special_clk;                    // LSU特殊时钟信号线网
  wire    [27:0]  mmu_lsu_pa2;                        // MMU到LSU的物理地址信号线网（28位）
  wire            mmu_lsu_pa2_err;                    // MMU到LSU的物理地址错误信号线网
  wire            mmu_lsu_pa2_vld;                    // MMU到LSU的物理地址有效信号线网
  wire            mmu_lsu_sec2;                       // MMU到LSU的安全标志信号线网
  wire            mmu_lsu_share2;                     // MMU到LSU的共享标志信号线网
  wire            pad_yy_icg_scan_en;                 // PAD到ICG扫描使能信号线网
  wire    [5 :0]  pfb_no_req_cnt_val;                // PFB无请求计数器值信号线网（6位）
  wire    [7 :0]  pfb_timeout_cnt_val;               // PFB超时计数器值信号线网（8位）
  wire    [8 :0]  pfu_all_pfb_biu_pe_req;            // PFU所有PFB的BIU弹出请求信号线网（9位）
  wire    [8 :0]  pfu_all_pfb_biu_pe_req_ptiority_0; // PFU所有PFB的BIU弹出请求优先级0信号线网（9位）
  wire    [8 :0]  pfu_all_pfb_biu_pe_req_ptiority_1; // PFU所有PFB的BIU弹出请求优先级1信号线网（9位）
  wire    [8 :0]  pfu_all_pfb_mmu_pe_req;            // PFU所有PFB的MMU弹出请求信号线网（9位）
  wire    [39:0]  pfu_biu_ar_addr;                    // PFU到BIU的读地址信号线网（40位）
  wire    [1 :0]  pfu_biu_ar_bar;                    // PFU到BIU的读地址响应类型信号线网（2位）
  wire    [1 :0]  pfu_biu_ar_burst;                  // PFU到BIU的读地址突发类型信号线网（2位）
  wire    [3 :0]  pfu_biu_ar_cache;                  // PFU到BIU的读地址缓存属性信号线网（4位）
  wire    [1 :0]  pfu_biu_ar_domain;                 // PFU到BIU的读地址域属性信号线网（2位）
  wire            pfu_biu_ar_dp_req;                 // PFU到BIU的读地址双拍请求信号线网
  wire    [4 :0]  pfu_biu_ar_id;                      // PFU到BIU的读地址事务ID信号线网（5位）
  wire    [1 :0]  pfu_biu_ar_len;                    // PFU到BIU的读地址突发长度信号线网（2位）
  wire            pfu_biu_ar_lock;                    // PFU到BIU的读地址锁定信号线网
  wire    [2 :0]  pfu_biu_ar_prot;                   // PFU到BIU的读地址保护属性信号线网（3位）
  wire            pfu_biu_ar_req;                    // PFU到BIU的读地址请求信号线网
  wire            pfu_biu_ar_req_gateclk_en;         // PFU到BIU的读地址请求时钟门控使能信号线网
  wire    [2 :0]  pfu_biu_ar_size;                   // PFU到BIU的读地址传输大小信号线网（3位）
  wire    [3 :0]  pfu_biu_ar_snoop;                  // PFU到BIU的读地址窥探属性信号线网（4位）
  wire    [2 :0]  pfu_biu_ar_user;                   // PFU到BIU的读地址用户属性信号线网（3位）
  wire    [33:0]  pfu_biu_l1_pe_req_addr_tto6;       // PFU的L1 BIU弹出请求地址右移6位信号线网（34位）
  wire            pfu_biu_l1_pe_req_page_sec;        // PFU的L1 BIU弹出请求页面安全标志信号线网
  wire            pfu_biu_l1_pe_req_page_share;      // PFU的L1 BIU弹出请求页面共享标志信号线网
  wire    [33:0]  pfu_biu_l2_pe_req_addr_tto6;       // PFU的L2 BIU弹出请求地址右移6位信号线网（34位）
  wire            pfu_biu_l2_pe_req_page_sec;        // PFU的L2 BIU弹出请求页面安全标志信号线网
  wire            pfu_biu_l2_pe_req_page_share;      // PFU的L2 BIU弹出请求页面共享标志信号线网
  wire            pfu_biu_pe_clk;                    // PFU的BIU弹出时钟信号
  wire            pfu_biu_pe_clk_en;                 // PFU的BIU弹出时钟门控使能信号
  wire            pfu_biu_pe_req;                    // PFU的BIU弹出请求信号
  wire    [33:0]  pfu_biu_pe_req_addr_tto6;          // PFU的BIU弹出请求地址右移6位信号线网（34位）
  wire            pfu_biu_pe_req_grnt;               // PFU的BIU弹出请求授权信号
  wire            pfu_biu_pe_req_page_sec;           // PFU的BIU弹出请求页面安全标志信号
  wire            pfu_biu_pe_req_page_share;         // PFU的BIU弹出请求页面共享标志信号
  wire    [1 :0]  pfu_biu_pe_req_priv_mode;          // PFU的BIU弹出请求特权模式信号线网（2位）
  wire            pfu_biu_pe_req_ptiority_0;         // PFU的BIU弹出请求优先级0信号
  wire    [8 :0]  pfu_biu_pe_req_ptr;                // PFU的BIU弹出请求指针信号线网（9位）
  wire            pfu_biu_pe_req_sel_l1;             // PFU的BIU弹出请求选择L1信号
  wire    [1 :0]  pfu_biu_pe_req_src;                // PFU的BIU弹出请求源信号线网（2位）
  wire            pfu_biu_pe_update_permit;          // PFU的BIU弹出更新允许信号线网
  wire            pfu_biu_pe_update_vld;             // PFU的BIU弹出更新有效信号线网
  wire    [39:0]  pfu_biu_req_addr;                 // PFU到BIU的请求地址信号线网（40位）
  wire            pfu_biu_req_bus_grnt;              // PFU到BIU的请求总线授权信号
  wire            pfu_biu_req_grnt;                 // PFU到BIU的请求授权信号
  wire            pfu_biu_req_hit_idx;               // PFU到BIU的请求命中索引信号
  wire    [8 :0]  pfu_biu_req_priority_next;         // PFU到BIU的请求下一个优先级信号线网（9位）
  wire            pfu_dcache_pref_en;                // PFU数据缓存预取使能信号线网
  wire            pfu_get_page_sec;                  // PFU获取页面安全标志信号线网
  wire            pfu_get_page_share;                // PFU获取页面共享标志信号线网
  wire    [27:0]  pfu_get_ppn;                       // PFU获取物理页号信号线网（28位）
  wire            pfu_get_ppn_err;                   // PFU获取物理页号错误信号线网
  wire            pfu_get_ppn_vld;                   // PFU获取物理页号有效信号线网
  wire            pfu_gpfb_biu_pe_req;               // PFU的全局PFB的BIU弹出请求信号
  wire            pfu_gpfb_biu_pe_req_grnt;          // PFU的全局PFB的BIU弹出请求授权信号
  wire    [1 :0]  pfu_gpfb_biu_pe_req_src;           // PFU的全局PFB的BIU弹出请求源信号线网（2位）
  wire            pfu_gpfb_from_lfb_dcache_hit;      // PFU的全局PFB来自LFB的数据缓存命中信号线网
  wire            pfu_gpfb_from_lfb_dcache_miss;     // PFU的全局PFB来自LFB的数据缓存未命中信号线网
  wire            pfu_gpfb_l1_page_sec;              // PFU的全局PFB的L1页面安全标志信号线网
  wire            pfu_gpfb_l1_page_share;            // PFU的全局PFB的L1页面共享标志信号线网
  wire    [39:0]  pfu_gpfb_l1_pf_addr;               // PFU的全局PFB的L1预取地址信号线网（40位）
  wire    [27:0]  pfu_gpfb_l1_vpn;                   // PFU的全局PFB的L1虚页号信号线网（28位）
  wire            pfu_gpfb_l2_page_sec;              // PFU的全局PFB的L2页面安全标志信号线网
  wire            pfu_gpfb_l2_page_share;            // PFU的全局PFB的L2页面共享标志信号线网
  wire    [39:0]  pfu_gpfb_l2_pf_addr;               // PFU的全局PFB的L2预取地址信号线网（40位）
  wire    [27:0]  pfu_gpfb_l2_vpn;                   // PFU的全局PFB的L2虚页号信号线网（28位）
  wire            pfu_gpfb_mmu_pe_req;               // PFU的全局PFB的MMU弹出请求信号
  wire            pfu_gpfb_mmu_pe_req_grnt;          // PFU的全局PFB的MMU弹出请求授权信号
  wire    [1 :0]  pfu_gpfb_mmu_pe_req_src;           // PFU的全局PFB的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_gpfb_priv_mode;                // PFU的全局PFB的特权模式信号线网（2位）
  wire            pfu_gpfb_vld;                       // PFU的全局PFB有效信号线网
  wire            pfu_gsdb_gpfb_create_vld;          // PFU的全局SDB的全局PFB创建有效信号线网
  wire            pfu_gsdb_gpfb_pop_req;             // PFU的全局SDB的全局PFB弹出请求信号线网
  wire    [10:0]  pfu_gsdb_stride;                    // PFU的全局SDB步长信号线网（11位）
  wire            pfu_gsdb_stride_neg;               // PFU的全局SDB步长负标志信号线网
  wire    [6 :0]  pfu_gsdb_strideh_6to0;             // PFU的全局SDB步长高6位到0信号线网（7位）
  wire            pfu_hit_pc;                        // PFU命中PC信号线网
  wire            pfu_icc_ready;                      // PFU到ICC就绪信号线网
  wire            pfu_l2_pref_en;                    // PFU L2预取使能信号线网
  wire            pfu_lfb_create_dp_vld;             // PFU到LFB创建双拍有效信号线网
  wire            pfu_lfb_create_gateclk_en;         // PFU到LFB创建时钟门控使能信号线网
  wire            pfu_lfb_create_req;                // PFU到LFB创建请求信号线网
  wire            pfu_lfb_create_vld;                // PFU到LFB创建有效信号线网
  wire    [3 :0]  pfu_lfb_id;                        // PFU到LFB的ID信号线网（4位）
  wire    [27:0]  pfu_mmu_l1_pe_req_vpn;             // PFU的MMU的L1弹出请求虚页号信号线网（28位）
  wire    [27:0]  pfu_mmu_l2_pe_req_vpn;             // PFU的MMU的L2弹出请求虚页号信号线网（28位）
  wire            pfu_mmu_pe_clk;                    // PFU的MMU弹出时钟信号
  wire            pfu_mmu_pe_clk_en;                 // PFU的MMU弹出时钟门控使能信号
  wire            pfu_mmu_pe_req;                    // PFU的MMU弹出请求信号
  wire            pfu_mmu_pe_req_sel_l1;             // PFU的MMU弹出请求选择L1信号
  wire    [1 :0]  pfu_mmu_pe_req_src;                // PFU的MMU弹出请求源信号线网（2位）
  wire    [27:0]  pfu_mmu_pe_req_vpn;                // PFU的MMU弹出请求虚页号信号线网（28位）
  wire            pfu_mmu_pe_update_permit;          // PFU的MMU弹出更新允许信号线网
  wire            pfu_part_empty;                    // PFU部分空信号线网
  wire            pfu_pfb_create_dp_vld;             // PFU到PFB创建双拍有效信号线网
  wire            pfu_pfb_create_gateclk_en;         // PFU到PFB创建时钟门控使能信号线网
  wire    [14:0]  pfu_pfb_create_pc;                 // PFU到PFB创建PC信号线网（15位）
  wire    [7 :0]  pfu_pfb_create_ptr;                // PFU到PFB创建指针信号线网（8位）
  wire    [10:0]  pfu_pfb_create_stride;             // PFU到PFB创建步长信号线网（11位）
  wire            pfu_pfb_create_stride_neg;         // PFU到PFB创建步长负标志信号线网
  wire    [6 :0]  pfu_pfb_create_strideh_6to0;       // PFU到PFB创建步长高6位到0信号线网（7位）
  wire            pfu_pfb_create_type_ld;            // PFU到PFB创建类型加载信号线网
  wire            pfu_pfb_create_vld;                // PFU到PFB创建有效信号线网
  wire            pfu_pfb_empty;                      // PFU的PFB空信号线网
  wire    [7 :0]  pfu_pfb_entry_biu_pe_req;          // PFU的PFB条目的BIU弹出请求信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_biu_pe_req_grnt;     // PFU的PFB条目的BIU弹出请求授权信号线网（8位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_0;    // PFU的PFB条目0的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_1;    // PFU的PFB条目1的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_2;    // PFU的PFB条目2的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_3;    // PFU的PFB条目3的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_4;    // PFU的PFB条目4的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_5;    // PFU的PFB条目5的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_6;    // PFU的PFB条目6的BIU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_7;    // PFU的PFB条目7的BIU弹出请求源信号线网（2位）
  wire    [7 :0]  pfu_pfb_entry_create_dp_vld;       // PFU的PFB条目的创建双拍有效信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_create_gateclk_en;   // PFU的PFB条目的创建时钟门控使能信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_create_vld;          // PFU的PFB条目的创建有效信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_evict;               // PFU的PFB条目的驱逐信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_from_lfb_dcache_hit; // PFU的PFB条目来自LFB的数据缓存命中信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_from_lfb_dcache_miss; // PFU的PFB条目来自LFB的数据缓存未命中信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_hit_pc;              // PFU的PFB条目的命中PC信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_l1_page_sec;         // PFU的PFB条目的L1页面安全标志信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_l1_page_share;       // PFU的PFB条目的L1页面共享标志信号线网（8位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_0;        // PFU的PFB条目0的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_1;        // PFU的PFB条目1的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_2;        // PFU的PFB条目2的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_3;        // PFU的PFB条目3的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_4;        // PFU的PFB条目4的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_5;        // PFU的PFB条目5的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_6;        // PFU的PFB条目6的L1预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l1_pf_addr_7;        // PFU的PFB条目7的L1预取地址信号线网（40位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_0;            // PFU的PFB条目0的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_1;            // PFU的PFB条目1的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_2;            // PFU的PFB条目2的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_3;            // PFU的PFB条目3的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_4;            // PFU的PFB条目4的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_5;            // PFU的PFB条目5的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_6;            // PFU的PFB条目6的L1虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l1_vpn_7;            // PFU的PFB条目7的L1虚页号信号线网（28位）
  wire    [7 :0]  pfu_pfb_entry_l2_page_sec;         // PFU的PFB条目的L2页面安全标志信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_l2_page_share;       // PFU的PFB条目的L2页面共享标志信号线网（8位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_0;        // PFU的PFB条目0的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_1;        // PFU的PFB条目1的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_2;        // PFU的PFB条目2的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_3;        // PFU的PFB条目3的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_4;        // PFU的PFB条目4的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_5;        // PFU的PFB条目5的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_6;        // PFU的PFB条目6的L2预取地址信号线网（40位）
  wire    [39:0]  pfu_pfb_entry_l2_pf_addr_7;        // PFU的PFB条目7的L2预取地址信号线网（40位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_0;            // PFU的PFB条目0的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_1;            // PFU的PFB条目1的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_2;            // PFU的PFB条目2的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_3;            // PFU的PFB条目3的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_4;            // PFU的PFB条目4的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_5;            // PFU的PFB条目5的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_6;            // PFU的PFB条目6的L2虚页号信号线网（28位）
  wire    [27:0]  pfu_pfb_entry_l2_vpn_7;            // PFU的PFB条目7的L2虚页号信号线网（28位）
  wire    [7 :0]  pfu_pfb_entry_mmu_pe_req;          // PFU的PFB条目的MMU弹出请求信号线网（8位）
  wire    [7 :0]  pfu_pfb_entry_mmu_pe_req_grnt;     // PFU的PFB条目的MMU弹出请求授权信号线网（8位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_0;    // PFU的PFB条目0的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_1;    // PFU的PFB条目1的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_2;    // PFU的PFB条目2的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_3;    // PFU的PFB条目3的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_4;    // PFU的PFB条目4的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_5;    // PFU的PFB条目5的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_6;    // PFU的PFB条目6的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_7;    // PFU的PFB条目7的MMU弹出请求源信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_0;         // PFU的PFB条目0的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_1;         // PFU的PFB条目1的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_2;         // PFU的PFB条目2的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_3;         // PFU的PFB条目3的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_4;         // PFU的PFB条目4的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_5;         // PFU的PFB条目5的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_6;         // PFU的PFB条目6的特权模式信号线网（2位）
  wire    [1 :0]  pfu_pfb_entry_priv_mode_7;         // PFU的PFB条目7的特权模式信号线网（2位）
  wire    [7 :0]  pfu_pfb_entry_vld;                 // PFU的PFB条目的有效信号线网（8位）
  wire            pfu_pfb_full;                       // PFU的PFB满信号线网
  wire            pfu_pfb_has_evict;                 // PFU的PFB有驱逐信号线网
  wire            pfu_pfb_hit_pc;                    // PFU的PFB命中PC信号线网
  wire            pfu_pmb_create_dp_vld;             // PFU到PMB创建双拍有效信号线网
  wire            pfu_pmb_create_gateclk_en;         // PFU到PMB创建时钟门控使能信号线网
  wire    [7 :0]  pfu_pmb_create_ptr;                // PFU到PMB创建指针信号线网（8位）
  wire            pfu_pmb_create_vld;                // PFU到PMB创建有效信号线网
  wire            pfu_pmb_empty;                      // PFU的PMB空信号线网
  wire    [7 :0]  pfu_pmb_entry_create_dp_vld;       // PFU的PMB条目的创建双拍有效信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_create_gateclk_en;   // PFU的PMB条目的创建时钟门控使能信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_create_vld;          // PFU的PMB条目的创建有效信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_evict;               // PFU的PMB条目的驱逐信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_hit_pc;              // PFU的PMB条目的命中PC信号线网（8位）
  wire    [14:0]  pfu_pmb_entry_pc_0;                // PFU的PMB条目0的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_1;                // PFU的PMB条目1的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_2;                // PFU的PMB条目2的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_3;                // PFU的PMB条目3的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_4;                // PFU的PMB条目4的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_5;                // PFU的PMB条目5的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_6;                // PFU的PMB条目6的PC信号线网（15位）
  wire    [14:0]  pfu_pmb_entry_pc_7;                // PFU的PMB条目7的PC信号线网（15位）
  wire    [7 :0]  pfu_pmb_entry_ready;               // PFU的PMB条目的就绪信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_ready_grnt;          // PFU的PMB条目的就绪授权信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_type_ld;             // PFU的PMB条目的类型加载信号线网（8位）
  wire    [7 :0]  pfu_pmb_entry_vld;                 // PFU的PMB条目的有效信号线网（8位）
  wire            pfu_pmb_full;                       // PFU的PMB满信号线网
  wire            pfu_pmb_hit_pc;                    // PFU的PMB命中PC信号线网
  wire            pfu_pmb_ready_grnt;                // PFU的PMB就绪授权信号线网
  wire            pfu_pop_all_part_vld;              // PFU弹出所有部分有效信号线网
  wire            pfu_pop_all_vld;                   // PFU弹出所有有效信号线网
  wire            pfu_sdb_create_dp_vld;             // PFU到SDB创建双拍有效信号线网
  wire            pfu_sdb_create_gateclk_en;         // PFU到SDB创建时钟门控使能信号线网
  wire    [14:0]  pfu_sdb_create_pc;                 // PFU到SDB创建PC信号线网（15位）
  wire    [1 :0]  pfu_sdb_create_ptr;                // PFU到SDB创建指针信号线网（2位）
  wire            pfu_sdb_create_type_ld;            // PFU到SDB创建类型加载信号线网
  wire            pfu_sdb_create_vld;                // PFU到SDB创建有效信号线网
  wire            pfu_sdb_empty;                      // PFU的SDB空信号线网
  wire    [1 :0]  pfu_sdb_entry_create_dp_vld;       // PFU的SDB条目的创建双拍有效信号线网（2位）
  wire    [1 :0]  pfu_sdb_entry_create_gateclk_en;   // PFU的SDB条目的创建时钟门控使能信号线网（2位）
  wire    [1 :0]  pfu_sdb_entry_create_vld;          // PFU的SDB条目的创建有效信号线网（2位）
  wire    [1 :0]  pfu_sdb_entry_evict;               // PFU的SDB条目的驱逐信号线网（2位）
  wire    [1 :0]  pfu_sdb_entry_hit_pc;              // PFU的SDB条目的命中PC信号线网（2位）
  wire    [14:0]  pfu_sdb_entry_pc_0;                // PFU的SDB条目0的PC信号线网（15位）
  wire    [14:0]  pfu_sdb_entry_pc_1;                // PFU的SDB条目1的PC信号线网（15位）
  wire    [1 :0]  pfu_sdb_entry_ready;               // PFU的SDB条目的就绪信号线网（2位）
  wire    [1 :0]  pfu_sdb_entry_ready_grnt;          // PFU的SDB条目的就绪授权信号线网（2位）
  wire    [10:0]  pfu_sdb_entry_stride_0;            // PFU的SDB条目0的步长信号线网（11位）
  wire    [10:0]  pfu_sdb_entry_stride_1;            // PFU的SDB条目1的步长信号线网（11位）
  wire    [1 :0]  pfu_sdb_entry_stride_neg;          // PFU的SDB条目的步长负标志信号线网（2位）
  wire    [6 :0]  pfu_sdb_entry_strideh_6to0_0;      // PFU的SDB条目0的步长高6位到0信号线网（7位）
  wire    [6 :0]  pfu_sdb_entry_strideh_6to0_1;      // PFU的SDB条目1的步长高6位到0信号线网（7位）
  wire    [1 :0]  pfu_sdb_entry_type_ld;             // PFU的SDB条目的类型加载信号线网（2位）
  wire    [1 :0]  pfu_sdb_entry_vld;                 // PFU的SDB条目的有效信号线网（2位）
  wire            pfu_sdb_full;                       // PFU的SDB满信号线网
  wire            pfu_sdb_has_evict;                 // PFU的SDB有驱逐信号线网
  wire            pfu_sdb_hit_pc;                    // PFU的SDB命中PC信号线网
  wire            pfu_sdb_ready_grnt;                // PFU的SDB就绪授权信号线网
  wire            pipe_create_dp_vld;                // 管道创建双拍有效信号线网
  wire    [14:0]  pipe_create_pc;                    // 管道创建PC信号线网（15位）
  wire            pipe_create_vld;                    // 管道创建有效信号线网
  wire    [7 :0]  pmb_timeout_cnt_val;               // PMB超时计数器值信号线网（8位）
  wire            rb_pfu_biu_req_hit_idx;            // RB到PFU的BIU请求命中索引信号线网
  wire            rb_pfu_nc_no_pending;              // RB到PFU的非缓存无待处理请求信号线网
  wire            rtu_yy_xx_commit0;                 // RTU提交信号0信号线网
  wire    [6 :0]  rtu_yy_xx_commit0_iid;             // RTU提交信号0的指令ID信号线网（7位）
  wire            rtu_yy_xx_commit1;                 // RTU提交信号1信号线网
  wire    [6 :0]  rtu_yy_xx_commit1_iid;             // RTU提交信号1的指令ID信号线网（7位）
  wire            rtu_yy_xx_commit2;                 // RTU提交信号2信号线网
  wire    [6 :0]  rtu_yy_xx_commit2_iid;             // RTU提交信号2的指令ID信号线网（7位）
  wire            rtu_yy_xx_flush;                    // RTU刷新信号线网
  wire    [7 :0]  sdb_timeout_cnt_val;               // SDB超时计数器值信号线网（8位）
  wire            sq_pfu_pop_synci_inst;             // SQ到PFU的弹出同步指令信号线网
  wire    [6 :0]  st_da_iid;                         // Store DA阶段指令ID信号线网（7位）
  wire            st_da_page_sec_ff;                 // Store DA阶段页面安全标志信号线网
  wire            st_da_page_share_ff;               // Store DA阶段页面共享标志信号线网
  wire    [14:0]  st_da_pc;                          // Store DA阶段程序计数器信号线网（15位）
  wire            st_da_pfu_act_dp_vld;              // Store到PFU实际数据预取双拍有效信号线网
  wire            st_da_pfu_act_vld;                 // Store到PFU实际数据预取有效信号线网
  wire            st_da_pfu_biu_req_hit_idx;         // Store到PFU的BIU请求命中索引信号线网
  wire            st_da_pfu_evict_cnt_vld;           // Store到PFU的驱逐计数器有效信号线网
  wire            st_da_pfu_pf_inst_vld;             // Store到PFU的预取指令有效信号线网
  wire    [39:0]  st_da_ppfu_va;                     // Store到PFU的物理预取虚地址信号线网（40位）
  wire    [27:0]  st_da_ppn_ff;                      // Store到PFU的物理页号流水线寄存器信号线网（28位）
  wire            vb_pfu_biu_req_hit_idx;            // VB到PFU的BIU请求命中索引信号线网
  wire            wmb_pfu_biu_req_hit_idx;           // WMB到PFU的BIU请求命中索引信号线网

  // 参数定义部分 - 定义PFU中各个缓冲区的条目数量和其他重要参数
  parameter PMB_ENTRY = 8,          // PMB（Physical Machine Buffer）条目数量 = 8
            SDB_ENTRY = 2,          // SDB（Stride Detection Buffer）条目数量 = 2
            PFB_ENTRY = 8;          // PFB（Prefetch Fetch Buffer）条目数量 = 8
  parameter PC_LEN    = 15;         // 程序计数器长度 = 15位
  parameter BIU_R_L2PREF_ID = 5'd25; // BIU读L2预取事务ID = 25

  //==========================================================
  //                 时钟门控单元实例化
  //==========================================================
  //--------------------mmu req pop entry---------------------  // MMU请求弹出条目部分的时钟门控
  assign pfu_mmu_pe_clk_en  = pfu_get_ppn_vld      // MMU弹出时钟门控使能信号：页表项有效或MMU弹出请求有效时使能时钟
                              || pfu_mmu_pe_req;
  // &Instance("gated_clk_cell", "x_lsu_pfu_mmu_pe_gated_clk"); @45  // 实例化MMU弹出时钟门控单元
  gated_clk_cell  x_lsu_pfu_mmu_pe_gated_clk (     // MMU弹出时钟门控单元实例
    .clk_in             (forever_cpuclk    ),      // 输入时钟：永远有效的CPU时钟
    .clk_out            (pfu_mmu_pe_clk    ),      // 输出时钟：MMU弹出时钟
    .external_en        (1'b0              ),      // 外部使能：禁用
    .global_en          (cp0_yy_clk_en     ),      // 全局使能：CP0控制的时钟使能
    .local_en           (pfu_mmu_pe_clk_en ),      // 局部使能：MMU弹出时钟门控使能
    .module_en          (cp0_lsu_icg_en    ),      // 模块使能：CP0控制的时钟门控使能
    .pad_yy_icg_scan_en (pad_yy_icg_scan_en)      // 扫描使能：PAD控制的ICG扫描使能
  );

  // &Connect(.clk_in        (forever_cpuclk     ), @46  // 时钟输入连接：永远有效的CPU时钟
  //          .external_en   (1'b0               ), @47  // 外部使能连接：固定为0（禁用）
  //          .global_en     (cp0_yy_clk_en      ), @48  // 全局使能连接：CP0控制的时钟使能
  //          .module_en     (cp0_lsu_icg_en     ), @49  // 模块使能连接：CP0控制的时钟门控使能
  //          .local_en      (pfu_mmu_pe_clk_en ), @50  // 局部使能连接：MMU弹出时钟门控使能
  //          .clk_out       (pfu_mmu_pe_clk    )); @51  // 时钟输出连接：MMU弹出时钟

  //--------------------biu req pop entry---------------------  // BIU请求弹出条目部分的时钟门控
  assign pfu_biu_pe_clk_en  = pfu_biu_pe_req       // BIU弹出时钟门控使能信号：BIU弹出请求有效或BIU请求未屏蔽时使能时钟
                              ||  pfu_biu_req_unmask;

  // &Instance("gated_clk_cell", "x_lsu_pfu_biu_pe_gated_clk"); @57  // 实例化BIU弹出时钟门控单元
  gated_clk_cell  x_lsu_pfu_biu_pe_gated_clk (     // BIU弹出时钟门控单元实例
    .clk_in             (forever_cpuclk    ),      // 输入时钟：永远有效的CPU时钟
    .clk_out            (pfu_biu_pe_clk    ),      // 输出时钟：BIU弹出时钟
    .external_en        (1'b0              ),      // 外部使能：禁用
    .global_en          (cp0_yy_clk_en     ),      // 全局使能：CP0控制的时钟使能
    .local_en           (pfu_biu_pe_clk_en ),      // 局部使能：BIU弹出时钟门控使能
    .module_en          (cp0_lsu_icg_en    ),      // 模块使能：CP0控制的时钟门控使能
    .pad_yy_icg_scan_en (pad_yy_icg_scan_en)      // 扫描使能：PAD控制的ICG扫描使能
  );

  // &Connect(.clk_in        (forever_cpuclk     ), @58  // 时钟输入连接：永远有效的CPU时钟
  //          .external_en   (1'b0               ), @59  // 外部使能连接：固定为0（禁用）
  //          .global_en     (cp0_yy_clk_en      ), @60  // 全局使能连接：CP0控制的时钟使能
  //          .module_en     (cp0_lsu_icg_en     ), @61  // 模块使能连接：CP0控制的时钟门控使能
  //          .local_en      (pfu_biu_pe_clk_en ), @62  // 局部使能连接：BIU弹出时钟门控使能
  //          .clk_out       (pfu_biu_pe_clk    )); @63  // 时钟输出连接：BIU弹出时钟

  //==========================================================
  //                 PMB条目实例化
  //==========================================================
  // PMB（Physical Machine Buffer）物理机器缓冲区，用于存储物理预取指令信息

  // &ConnRule(s/_x$/[0]/); @69  // 连接规则：将_x替换为[0]
  // &ConnRule(s/_v$/_0/); @70   // 连接规则：将_v替换为_0
  // &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_0"); @71  // 实例化PMB条目0
  ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_0 (  // PMB条目0实例化
    .amr_wa_cancel                      (amr_wa_cancel                     ),  // AMR写回取消信号
    .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // CP0控制的时钟门控使能
    .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // CP0控制的L2存储预取使能
    .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // CP0控制的全局时钟使能
    .cpurst_b                           (cpurst_b                          ),  // CPU复位信号（低有效）
    .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // Load DA阶段的加载FIFO PC
    .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // Load到PFU实际数据预取双拍有效
    .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // Load到PFU驱逐计数器有效
    .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // Load到PFU预取指令有效
    .lsu_special_clk                    (lsu_special_clk                   ),  // LSU特殊时钟
    .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // PAD控制的ICG扫描使能
    .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[0]    ),  // PMB条目0的创建双拍有效
    .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[0]),  // PMB条目0的创建时钟门控使能
    .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[0]       ),  // PMB条目0的创建有效
    .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[0]            ),  // PMB条目0的驱逐信号
    .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[0]           ),  // PMB条目0的命中PC
    .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_0                ),  // PMB条目0的PC值
    .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[0]       ),  // PMB条目0的就绪授权
    .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[0]            ),  // PMB条目0的就绪信号
    .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[0]          ),  // PMB条目0的类型加载
    .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[0]              ),  // PMB条目0的有效信号
    .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // PFU弹出所有部分有效
    .pipe_create_pc                     (pipe_create_pc                    ),  // 管道创建PC
    .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // PMB超时计数器值
    .st_da_pc                           (st_da_pc                          ),  // Store DA阶段的PC
    .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // Store到PFU驱逐计数器有效
    .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )   // Store到PFU预取指令有效
  );

  // &ConnRule(s/_x$/[1]/); @73  // 连接规则：将_x替换为[1]
  // &ConnRule(s/_v$/_1/); @74   // 连接规则：将_v替换为_1
  // &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_1"); @75  // 实例化PMB条目1
  ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_1 (  // PMB条目1实例化（类似条目0的配置）
    .amr_wa_cancel                      (amr_wa_cancel                     ),
    .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
    .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),
    .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),
    .cpurst_b                           (cpurst_b                          ),
    .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),
    .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),
    .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),
    .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),
    .lsu_special_clk                    (lsu_special_clk                   ),
    .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
    .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[1]    ),
    .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[1]),
    .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[1]       ),
    .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[1]            ),
    .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[1]           ),
    .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_1                ),
    .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[1]       ),
    .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[1]            ),
    .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[1]          ),
    .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[1]              ),
    .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),
    .pipe_create_pc                     (pipe_create_pc                    ),
    .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),
    .st_da_pc                           (st_da_pc                          ),
    .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),
    .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )
  );

  // &ConnRule(s/_x$/[2]/); @77  // 连接规则：将_x替换为[2]
  // &ConnRule(s/_v$/_2/); @78   // 连接规则：将_v替换为_2
  // &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_2"); @79  // 实例化PMB条目2
  ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_2 (  // PMB条目2实例化（类似条目0的配置）
    .amr_wa_cancel                      (amr_wa_cancel                     ),
    .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
    .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),
    .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),
    .cpurst_b                           (cpurst_b                          ),
    .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),
    .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),
    .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),
    .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),
    .lsu_special_clk                    (lsu_special_clk                   ),
    .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
    .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[2]    ),
    .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[2]),
    .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[2]       ),
    .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[2]            ),
    .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[2]           ),
    .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_2                ),
    .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[2]       ),
    .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[2]            ),
    .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[2]          ),
    .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[2]              ),
    .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),
    .pipe_create_pc                     (pipe_create_pc                    ),
    .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),
    .st_da_pc                           (st_da_pc                          ),
    .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),
    .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )
  );

  // &ConnRule(s/_x$/[3]/); @81  // 连接规则：将_x替换为[3]
  // &ConnRule(s/_v$/_3/); @82   // 连接规则：将_v替换为_3
  // &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_3"); @83  // 实例化PMB条目3
  ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_3 (  // PMB条目3实例化（类似条目0的配置）
    .amr_wa_cancel                      (amr_wa_cancel                     ),
    .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
    .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),
    .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),
    .cpurst_b                           (cpurst_b                          ),
    .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),
    .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),
    .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),
    .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),
    .lsu_special_clk                    (lsu_special_clk                   ),
    .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
    .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[3]    ),
    .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[3]),
    .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[3]       ),
    .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[3]            ),
    .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[3]           ),
    .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_3                ),
    .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[3]       ),
    .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[3]            ),
    .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[3]          ),
    .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[3]              ),
    .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),
    .pipe_create_pc                     (pipe_create_pc                    ),
    .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),
    .st_da_pc                           (st_da_pc                          ),
    .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),
    .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )
  );

  // &ConnRule(s/_x$/[4]/); @85  // 连接规则：将_x替换为[4]
  // &ConnRule(s/_v$/_4/); @86   // 连接规则：将_v替换为_4
  // &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_4"); @87  // 实例化PMB条目4
  ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_4 (  // PMB条目4实例化（类似条目0的配置）
    .amr_wa_cancel                      (amr_wa_cancel                     ),
    .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
    .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),
    .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),
    .cpurst_b                           (cpurst_b                          ),
    .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),
    .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),
    .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),
    .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),
    .lsu_special_clk                    (lsu_special_clk                   ),
    .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
    .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[4]    ),
    .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[4]),
    .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[4]       ),
    .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[4]            ),
    .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[4]           ),
    .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_4                ),
    .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[4]       ),
    .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[4]            ),
    .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[4]          ),
    .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[4]              ),
    .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),
    .pipe_create_pc                     (pipe_create_pc                    ),
    .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),
    .st_da_pc                           (st_da_pc                          ),
    .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),
    .st_da_pfu_pf_inst_vld