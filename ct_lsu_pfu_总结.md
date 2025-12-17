ct_lsu_pfu 模块摘要

概述
- 模块 `ct_lsu_pfu` 是负责编译和发起数据预取（Prefetch）的 LSU 侧预取单元（PFU）。它综合负载/存储管线的访存行为、步幅检测、页表/权限信息，通过 MMU 解析物理地址并向总线（BIU/AXI）发起只读预取请求，以提升缓存命中率。

架构要点
- 三类条目队列：
  - `PMB`（8 路）：prefetch match buffer，承载从管线产生的候选预取记录，提供到 `SDB` 的输入。
  - `SDB`（2 路）：stride detection buffer，做步幅检测与聚合，向 `PFB` 输出（PC、stride 等）创建信息。
  - `PFB`（8 路）：prefetch buffer，最终持有预取地址与页属性，向 `BIU`/`MMU` 发起请求。
- 全局控制：
  - `GSDB`：全局步幅/创建控制，协调 `gpfb` 的产生与弹出。
  - `GPFB`：全局 pfb 条目，作为第 9 路（索引 8）参与 BIU/MMU 指针仲裁。
- 双通道 Pop 引擎：
  - `MMU Pop`：按 `pfu_mmu_pe_*` 指针选择 L1/L2 VPN，驱动 `lsu_mmu_va2` 解析 PPN 以及页属性 `sec/share`。
  - `BIU Pop`：按 `pfu_biu_pe_*` 指针选择 L1/L2 物理地址，构造 AXI `AR` 通道请求（地址/len/size/burst/cache/prot/user/snoop/domain/bar）。

关键数据流
- PC/步幅链路：`PMB -> SDB -> PFB`，逐级通过 `pop_ptr` 选择与 `create_ptr` 分配空/驱逐目标。
- MMU 链路：`PFB/GPFB -> MMU`，返回 PPN 与页属性后更新条目页安全/共享状态。
- BIU 链路：`PFB/GPFB -> LFB/AXI`，按 L1/L2 选择发送预取读；L1 走 LFB（有 `lfb_pfu_*` 反馈命中/未命中），L2 直接走 AXI 预取通道。

仲裁与优先级
- 指针选择使用 `casez` 与位掩码，支持优先级 0/1 双级（`pfu_biu_pe_req_ptr_priority_0/1`），优先选择优先级 0 的请求。
- `pfu_biu_req_priority_next` 累积已处理位置，形成“低位到高位逐步置 1”的优先级掩码。
- MMU/BIU 的 `update_permit` 保证同一时刻仅在安全窗口更新请求寄存器，避免竞争。

时钟门控
- `gated_clk_cell` 对 `pfu_mmu_pe_clk` 与 `pfu_biu_pe_clk` 做本地门控，依据 `pfu_mmu_pe_clk_en` 与 `pfu_biu_pe_clk_en` 省电。

安全与权限
- 页安全 `sec` 与共享 `share` 从 MMU 返回后参与 AXI `AR.cache/prot/snoop/domain` 的形成，分别影响读共享与域选择。
- `priv_mode` 随入口条目传递并映射到 `AR.prot/user`。

CP0 控制
- 预取总使能：`cp0_lsu_dcache_pref_en`（L1）、`cp0_lsu_l2_pref_en`（L2）。
- 超时/无请求计数：`cp0_lsu_timeout_cnt` 拆分到 `pmb/sdb/pfb_timeout_cnt_val` 与 `pfb_no_req_cnt_val`。
- `cp0_lsu_no_op_req` 提供全局禁止窗口；`icc_idle` 协同 I-cache 空闲判断触发 `pfu_pop_all_vld`。

接口摘要
- MMU：
  - 输出 `lsu_mmu_va2_vld` 与 `lsu_mmu_va2`，输入 `mmu_lsu_pa2_vld/err/pa2/sec2/share2` 以完成 PPN 与页属性解析。
- BIU/AXI：
  - 输出 `pfu_biu_ar_*` 完整 AXI-AR 通道；与总线仲裁 `bus_arb_pfu_ar_ready/grnt` 交互，命中索引由多源 `*_pfu_biu_req_hit_idx` 提供。
- LFB：
  - 创建 `pfu_lfb_create_*`，ID 来自 `lfb_pfu_create_id`，并接收 `lfb_pfu_dcache_hit/miss` 反馈。

文件位置引用
- 模块与端口：`/Users/change/projects/file-decomposer-agent-demo/ct_lsu_pfu.v:17-115`、`118-214`
- 参数与门控：`552-557`、`558-603`
- 条目实例：PMB `608-877`，SDB `967-1062`，PFB `1158-1752`
- 条目控制：PMB `883-963`，SDB `1069-1151`，PFB `1760-1845`
- 全局 PFU：`1851-1929`
- MMU Pop：`1939-2051`、选择 `2005-2041`、接口 `2044-2051`
- BIU Pop：寄存器/许可/仲裁 `2059-2176`，地址/页属性/权限选择 `2179-2247`，优先级掩码 `2251-2260`
- AXI-AR 构造与 LFB 交互：`2263-2346`
- 全局弹出与空闲判断：`2350-2372`
- CP0 超时与计数：`2375-2381`

备注
- 本摘要覆盖模块职责、数据流、仲裁策略与关键接口，详细逐段解释请参考工作区对原文件的逐段解读。
