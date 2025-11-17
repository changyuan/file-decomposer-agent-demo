/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.  // 第1行 - 
  // 第2行 - 
Licensed under the Apache License, Version 2.0 (the "License");  // 第3行 - 
you may not use this file except in compliance with the License.  // 第4行 - 
You may obtain a copy of the License at  // 第5行 - 
  // 第6行 - 
    http://www.apache.org/licenses/LICENSE-2.0  // 第7行 - 
  // 第8行 - 
Unless required by applicable law or agreed to in writing, software  // 第9行 - 
distributed under the License is distributed on an "AS IS" BASIS,  // 第10行 - 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  // 第11行 - 
See the License for the specific language governing permissions and  // 第12行 - 
limitations under the License.  // 第13行 - 
*/  // 第14行 - 
  // 第15行 - 
// &ModuleBeg; @28  // 第16行 - 
module ct_lsu_pfu(  // 第17行 - 
  amr_wa_cancel,  // 第18行 - 
  bus_arb_pfu_ar_grnt,  // 第19行 - 
  bus_arb_pfu_ar_ready,  // 第20行 - 
  cp0_lsu_dcache_en,  // 第21行 - 
  cp0_lsu_dcache_pref_en,  // 第22行 - 
  cp0_lsu_icg_en,  // 第23行 - 
  cp0_lsu_l2_pref_en,  // 第24行 - 
  cp0_lsu_l2_st_pref_en,  // 第25行 - 
  cp0_lsu_no_op_req,  // 第26行 - 
  cp0_lsu_pfu_mmu_dis,  // 第27行 - 
  cp0_lsu_timeout_cnt,  // 第28行 - 
  cp0_yy_clk_en,  // 第29行 - 
  cp0_yy_dcache_pref_en,  // 第30行 - 
  cp0_yy_priv_mode,  // 第31行 - 
  cpurst_b,  // 第32行 - 
  forever_cpuclk,  // 第33行 - 
  icc_idle,  // 第34行 - 
  ld_da_iid,  // 第35行 - 
  ld_da_ldfifo_pc,  // 第36行 - 
  ld_da_page_sec_ff,  // 第37行 - 
  ld_da_page_share_ff,  // 第38行 - 
  ld_da_pfu_act_dp_vld,  // 第39行 - 
  ld_da_pfu_act_vld,  // 第40行 - 
  ld_da_pfu_biu_req_hit_idx,  // 第41行 - 
  ld_da_pfu_evict_cnt_vld,  // 第42行 - 
  ld_da_pfu_pf_inst_vld,  // 第43行 - 
  ld_da_pfu_va,  // 第44行 - 
  ld_da_ppfu_va,  // 第45行 - 
  ld_da_ppn_ff,  // 第46行 - 
  lfb_addr_full,  // 第47行 - 
  lfb_addr_less2,  // 第48行 - 
  lfb_pfu_biu_req_hit_idx,  // 第49行 - 
  lfb_pfu_create_id,  // 第50行 - 
  lfb_pfu_dcache_hit,  // 第51行 - 
  lfb_pfu_dcache_miss,  // 第52行 - 
  lfb_pfu_rready_grnt,  // 第53行 - 
  lm_pfu_biu_req_hit_idx,  // 第54行 - 
  lsu_mmu_va2,  // 第55行 - 
  lsu_mmu_va2_vld,  // 第56行 - 
  lsu_pfu_l1_dist_sel,  // 第57行 - 
  lsu_pfu_l2_dist_sel,  // 第58行 - 
  lsu_special_clk,  // 第59行 - 
  mmu_lsu_pa2,  // 第60行 - 
  mmu_lsu_pa2_err,  // 第61行 - 
  mmu_lsu_pa2_vld,  // 第62行 - 
  mmu_lsu_sec2,  // 第63行 - 
  mmu_lsu_share2,  // 第64行 - 
  pad_yy_icg_scan_en,  // 第65行 - 
  pfu_biu_ar_addr,  // 第66行 - 
  pfu_biu_ar_bar,  // 第67行 - 
  pfu_biu_ar_burst,  // 第68行 - 
  pfu_biu_ar_cache,  // 第69行 - 
  pfu_biu_ar_domain,  // 第70行 - 
  pfu_biu_ar_dp_req,  // 第71行 - 
  pfu_biu_ar_id,  // 第72行 - 
  pfu_biu_ar_len,  // 第73行 - 
  pfu_biu_ar_lock,  // 第74行 - 
  pfu_biu_ar_prot,  // 第75行 - 
  pfu_biu_ar_req,  // 第76行 - 
  pfu_biu_ar_req_gateclk_en,  // 第77行 - 
  pfu_biu_ar_size,  // 第78行 - 
  pfu_biu_ar_snoop,  // 第79行 - 
  pfu_biu_ar_user,  // 第80行 - 
  pfu_biu_req_addr,  // 第81行 - 
  pfu_icc_ready,  // 第82行 - 
  pfu_lfb_create_dp_vld,  // 第83行 - 
  pfu_lfb_create_gateclk_en,  // 第84行 - 
  pfu_lfb_create_req,  // 第85行 - 
  pfu_lfb_create_vld,  // 第86行 - 
  pfu_lfb_id,  // 第87行 - 
  pfu_part_empty,  // 第88行 - 
  pfu_pfb_empty,  // 第89行 - 
  pfu_sdb_create_gateclk_en,  // 第90行 - 
  pfu_sdb_empty,  // 第91行 - 
  rb_pfu_biu_req_hit_idx,  // 第92行 - 
  rb_pfu_nc_no_pending,  // 第93行 - 
  rtu_yy_xx_commit0,  // 第94行 - 
  rtu_yy_xx_commit0_iid,  // 第95行 - 
  rtu_yy_xx_commit1,  // 第96行 - 
  rtu_yy_xx_commit1_iid,  // 第97行 - 
  rtu_yy_xx_commit2,  // 第98行 - 
  rtu_yy_xx_commit2_iid,  // 第99行 - 
  rtu_yy_xx_flush,  // 第100行 - 
  sq_pfu_pop_synci_inst,  // 第101行 - 
  st_da_iid,  // 第102行 - 
  st_da_page_sec_ff,  // 第103行 - 
  st_da_page_share_ff,  // 第104行 - 
  st_da_pc,  // 第105行 - 
  st_da_pfu_act_dp_vld,  // 第106行 - 
  st_da_pfu_act_vld,  // 第107行 - 
  st_da_pfu_biu_req_hit_idx,  // 第108行 - 
  st_da_pfu_evict_cnt_vld,  // 第109行 - 
  st_da_pfu_pf_inst_vld,  // 第110行 - 
  st_da_ppfu_va,  // 第111行 - 
  st_da_ppn_ff,  // 第112行 - 
  vb_pfu_biu_req_hit_idx,  // 第113行 - 
  wmb_pfu_biu_req_hit_idx  // 第114行 - 
);  // 第115行 - 
  // 第116行 - 
// &Ports; @29  // 第117行 - 
input           amr_wa_cancel;                       // 第118行 - 
input           bus_arb_pfu_ar_grnt;                 // 第119行 - 
input           bus_arb_pfu_ar_ready;                // 第120行 - 
input           cp0_lsu_dcache_en;                   // 第121行 - 
input           cp0_lsu_dcache_pref_en;              // 第122行 - 
input           cp0_lsu_icg_en;                      // 第123行 - 
input           cp0_lsu_l2_pref_en;                  // 第124行 - 
input           cp0_lsu_l2_st_pref_en;               // 第125行 - 
input           cp0_lsu_no_op_req;                   // 第126行 - 
input           cp0_lsu_pfu_mmu_dis;                 // 第127行 - 
input   [29:0]  cp0_lsu_timeout_cnt;                 // 第128行 - 
input           cp0_yy_clk_en;                       // 第129行 - 
input           cp0_yy_dcache_pref_en;               // 第130行 - 
input   [1 :0]  cp0_yy_priv_mode;                    // 第131行 - 
input           cpurst_b;                            // 第132行 - 
input           forever_cpuclk;                      // 第133行 - 
input           icc_idle;                            // 第134行 - 
input   [6 :0]  ld_da_iid;                           // 第135行 - 
input   [14:0]  ld_da_ldfifo_pc;                     // 第136行 - 
input           ld_da_page_sec_ff;                   // 第137行 - 
input           ld_da_page_share_ff;                 // 第138行 - 
input           ld_da_pfu_act_dp_vld;                // 第139行 - 
input           ld_da_pfu_act_vld;                   // 第140行 - 
input           ld_da_pfu_biu_req_hit_idx;           // 第141行 - 
input           ld_da_pfu_evict_cnt_vld;             // 第142行 - 
input           ld_da_pfu_pf_inst_vld;               // 第143行 - 
input   [39:0]  ld_da_pfu_va;                        // 第144行 - 
input   [39:0]  ld_da_ppfu_va;                       // 第145行 - 
input   [27:0]  ld_da_ppn_ff;                        // 第146行 - 
input           lfb_addr_full;                       // 第147行 - 
input           lfb_addr_less2;                      // 第148行 - 
input           lfb_pfu_biu_req_hit_idx;             // 第149行 - 
input   [4 :0]  lfb_pfu_create_id;                   // 第150行 - 
input   [8 :0]  lfb_pfu_dcache_hit;                  // 第151行 - 
input   [8 :0]  lfb_pfu_dcache_miss;                 // 第152行 - 
input           lfb_pfu_rready_grnt;                 // 第153行 - 
input           lm_pfu_biu_req_hit_idx;              // 第154行 - 
input   [3 :0]  lsu_pfu_l1_dist_sel;                 // 第155行 - 
input   [3 :0]  lsu_pfu_l2_dist_sel;                 // 第156行 - 
input           lsu_special_clk;                     // 第157行 - 
input   [27:0]  mmu_lsu_pa2;                         // 第158行 - 
input           mmu_lsu_pa2_err;                     // 第159行 - 
input           mmu_lsu_pa2_vld;                     // 第160行 - 
input           mmu_lsu_sec2;                        // 第161行 - 
input           mmu_lsu_share2;                      // 第162行 - 
input           pad_yy_icg_scan_en;                  // 第163行 - 
input           rb_pfu_biu_req_hit_idx;              // 第164行 - 
input           rb_pfu_nc_no_pending;                // 第165行 - 
input           rtu_yy_xx_commit0;                   // 第166行 - 
input   [6 :0]  rtu_yy_xx_commit0_iid;               // 第167行 - 
input           rtu_yy_xx_commit1;                   // 第168行 - 
input   [6 :0]  rtu_yy_xx_commit1_iid;               // 第169行 - 
input           rtu_yy_xx_commit2;                   // 第170行 - 
input   [6 :0]  rtu_yy_xx_commit2_iid;               // 第171行 - 
input           rtu_yy_xx_flush;                     // 第172行 - 
input           sq_pfu_pop_synci_inst;               // 第173行 - 
input   [6 :0]  st_da_iid;                           // 第174行 - 
input           st_da_page_sec_ff;                   // 第175行 - 
input           st_da_page_share_ff;                 // 第176行 - 
input   [14:0]  st_da_pc;                            // 第177行 - 
input           st_da_pfu_act_dp_vld;                // 第178行 - 
input           st_da_pfu_act_vld;                   // 第179行 - 
input           st_da_pfu_biu_req_hit_idx;           // 第180行 - 
input           st_da_pfu_evict_cnt_vld;             // 第181行 - 
input           st_da_pfu_pf_inst_vld;               // 第182行 - 
input   [39:0]  st_da_ppfu_va;                       // 第183行 - 
input   [27:0]  st_da_ppn_ff;                        // 第184行 - 
input           vb_pfu_biu_req_hit_idx;              // 第185行 - 
input           wmb_pfu_biu_req_hit_idx;             // 第186行 - 
output  [27:0]  lsu_mmu_va2;                         // 第187行 - 
output          lsu_mmu_va2_vld;                     // 第188行 - 
output  [39:0]  pfu_biu_ar_addr;                     // 第189行 - 
output  [1 :0]  pfu_biu_ar_bar;                      // 第190行 - 
output  [1 :0]  pfu_biu_ar_burst;                    // 第191行 - 
output  [3 :0]  pfu_biu_ar_cache;                    // 第192行 - 
output  [1 :0]  pfu_biu_ar_domain;                   // 第193行 - 
output          pfu_biu_ar_dp_req;                   // 第194行 - 
output  [4 :0]  pfu_biu_ar_id;                       // 第195行 - 
output  [1 :0]  pfu_biu_ar_len;                      // 第196行 - 
output          pfu_biu_ar_lock;                     // 第197行 - 
output  [2 :0]  pfu_biu_ar_prot;                     // 第198行 - 
output          pfu_biu_ar_req;                      // 第199行 - 
output          pfu_biu_ar_req_gateclk_en;           // 第200行 - 
output  [2 :0]  pfu_biu_ar_size;                     // 第201行 - 
output  [3 :0]  pfu_biu_ar_snoop;                    // 第202行 - 
output  [2 :0]  pfu_biu_ar_user;                     // 第203行 - 
output  [39:0]  pfu_biu_req_addr;                    // 第204行 - 
output          pfu_icc_ready;                       // 第205行 - 
output          pfu_lfb_create_dp_vld;               // 第206行 - 
output          pfu_lfb_create_gateclk_en;           // 第207行 - 
output          pfu_lfb_create_req;                  // 第208行 - 
output          pfu_lfb_create_vld;                  // 第209行 - 
output  [3 :0]  pfu_lfb_id;                          // 第210行 - 
output          pfu_part_empty;                      // 第211行 - 
output          pfu_pfb_empty;                       // 第212行 - 
output          pfu_sdb_create_gateclk_en;           // 第213行 - 
output          pfu_sdb_empty;                       // 第214行 - 
  // 第215行 - 
// &Regs; @30  // 第216行 - 
reg     [8 :0]  pfu_biu_pe_req_ptr_priority_0;       // 第217行 - 
reg     [8 :0]  pfu_biu_pe_req_ptr_priority_1;       // 第218行 - 
reg     [33:0]  pfu_biu_req_addr_tto6;               // 第219行 - 
reg             pfu_biu_req_l1;                      // 第220行 - 
reg             pfu_biu_req_page_sec;                // 第221行 - 
reg             pfu_biu_req_page_share;              // 第222行 - 
reg     [8 :0]  pfu_biu_req_priority;                // 第223行 - 
reg     [1 :0]  pfu_biu_req_priv_mode;               // 第224行 - 
reg     [8 :0]  pfu_biu_req_ptr;                     // 第225行 - 
reg             pfu_biu_req_unmask;                  // 第226行 - 
reg     [8 :0]  pfu_mmu_pe_req_ptr;                  // 第227行 - 
reg             pfu_mmu_req;                         // 第228行 - 
reg             pfu_mmu_req_l1;                      // 第229行 - 
reg     [8 :0]  pfu_mmu_req_ptr;                     // 第230行 - 
reg     [27:0]  pfu_mmu_req_vpn;                     // 第231行 - 
reg     [7 :0]  pfu_pfb_empty_create_ptr;            // 第232行 - 
reg     [7 :0]  pfu_pfb_evict_create_ptr;            // 第233行 - 
reg     [7 :0]  pfu_pmb_empty_create_ptr;            // 第234行 - 
reg     [7 :0]  pfu_pmb_evict_create_ptr;            // 第235行 - 
reg     [7 :0]  pfu_pmb_pop_ptr;                     // 第236行 - 
reg     [1 :0]  pfu_sdb_empty_create_ptr;            // 第237行 - 
reg     [1 :0]  pfu_sdb_evict_create_ptr;            // 第238行 - 
reg     [1 :0]  pfu_sdb_pop_ptr;                     // 第239行 - 
  // 第240行 - 
// &Wires; @31  // 第241行 - 
wire            amr_wa_cancel;                       // 第242行 - 
wire            bus_arb_pfu_ar_grnt;                 // 第243行 - 
wire            bus_arb_pfu_ar_ready;                // 第244行 - 
wire            cp0_lsu_dcache_en;                   // 第245行 - 
wire            cp0_lsu_dcache_pref_en;              // 第246行 - 
wire            cp0_lsu_icg_en;                      // 第247行 - 
wire            cp0_lsu_l2_pref_en;                  // 第248行 - 
wire            cp0_lsu_l2_st_pref_en;               // 第249行 - 
wire            cp0_lsu_no_op_req;                   // 第250行 - 
wire            cp0_lsu_pfu_mmu_dis;                 // 第251行 - 
wire    [29:0]  cp0_lsu_timeout_cnt;                 // 第252行 - 
wire            cp0_yy_clk_en;                       // 第253行 - 
wire            cp0_yy_dcache_pref_en;               // 第254行 - 
wire    [1 :0]  cp0_yy_priv_mode;                    // 第255行 - 
wire            cpurst_b;                            // 第256行 - 
wire            forever_cpuclk;                      // 第257行 - 
wire            icc_idle;                            // 第258行 - 
wire    [6 :0]  ld_da_iid;                           // 第259行 - 
wire    [14:0]  ld_da_ldfifo_pc;                     // 第260行 - 
wire            ld_da_page_sec_ff;                   // 第261行 - 
wire            ld_da_page_share_ff;                 // 第262行 - 
wire            ld_da_pfu_act_dp_vld;                // 第263行 - 
wire            ld_da_pfu_act_vld;                   // 第264行 - 
wire            ld_da_pfu_biu_req_hit_idx;           // 第265行 - 
wire            ld_da_pfu_evict_cnt_vld;             // 第266行 - 
wire            ld_da_pfu_pf_inst_vld;               // 第267行 - 
wire    [39:0]  ld_da_pfu_va;                        // 第268行 - 
wire    [39:0]  ld_da_ppfu_va;                       // 第269行 - 
wire    [27:0]  ld_da_ppn_ff;                        // 第270行 - 
wire            lfb_addr_full;                       // 第271行 - 
wire            lfb_addr_less2;                      // 第272行 - 
wire            lfb_pfu_biu_req_hit_idx;             // 第273行 - 
wire    [4 :0]  lfb_pfu_create_id;                   // 第274行 - 
wire    [8 :0]  lfb_pfu_dcache_hit;                  // 第275行 - 
wire    [8 :0]  lfb_pfu_dcache_miss;                 // 第276行 - 
wire            lfb_pfu_rready_grnt;                 // 第277行 - 
wire            lm_pfu_biu_req_hit_idx;              // 第278行 - 
wire    [27:0]  lsu_mmu_va2;                         // 第279行 - 
wire            lsu_mmu_va2_vld;                     // 第280行 - 
wire    [3 :0]  lsu_pfu_l1_dist_sel;                 // 第281行 - 
wire    [3 :0]  lsu_pfu_l2_dist_sel;                 // 第282行 - 
wire            lsu_special_clk;                     // 第283行 - 
wire    [27:0]  mmu_lsu_pa2;                         // 第284行 - 
wire            mmu_lsu_pa2_err;                     // 第285行 - 
wire            mmu_lsu_pa2_vld;                     // 第286行 - 
wire            mmu_lsu_sec2;                        // 第287行 - 
wire            mmu_lsu_share2;                      // 第288行 - 
wire            pad_yy_icg_scan_en;                  // 第289行 - 
wire    [5 :0]  pfb_no_req_cnt_val;                  // 第290行 - 
wire    [7 :0]  pfb_timeout_cnt_val;                 // 第291行 - 
wire    [8 :0]  pfu_all_pfb_biu_pe_req;              // 第292行 - 
wire    [8 :0]  pfu_all_pfb_biu_pe_req_ptiority_0;   // 第293行 - 
wire    [8 :0]  pfu_all_pfb_biu_pe_req_ptiority_1;   // 第294行 - 
wire    [8 :0]  pfu_all_pfb_mmu_pe_req;              // 第295行 - 
wire    [39:0]  pfu_biu_ar_addr;                     // 第296行 - 
wire    [1 :0]  pfu_biu_ar_bar;                      // 第297行 - 
wire    [1 :0]  pfu_biu_ar_burst;                    // 第298行 - 
wire    [3 :0]  pfu_biu_ar_cache;                    // 第299行 - 
wire    [1 :0]  pfu_biu_ar_domain;                   // 第300行 - 
wire            pfu_biu_ar_dp_req;                   // 第301行 - 
wire    [4 :0]  pfu_biu_ar_id;                       // 第302行 - 
wire    [1 :0]  pfu_biu_ar_len;                      // 第303行 - 
wire            pfu_biu_ar_lock;                     // 第304行 - 
wire    [2 :0]  pfu_biu_ar_prot;                     // 第305行 - 
wire            pfu_biu_ar_req;                      // 第306行 - 
wire            pfu_biu_ar_req_gateclk_en;           // 第307行 - 
wire    [2 :0]  pfu_biu_ar_size;                     // 第308行 - 
wire    [3 :0]  pfu_biu_ar_snoop;                    // 第309行 - 
wire    [2 :0]  pfu_biu_ar_user;                     // 第310行 - 
wire    [33:0]  pfu_biu_l1_pe_req_addr_tto6;         // 第311行 - 
wire            pfu_biu_l1_pe_req_page_sec;          // 第312行 - 
wire            pfu_biu_l1_pe_req_page_share;        // 第313行 - 
wire    [33:0]  pfu_biu_l2_pe_req_addr_tto6;         // 第314行 - 
wire            pfu_biu_l2_pe_req_page_sec;          // 第315行 - 
wire            pfu_biu_l2_pe_req_page_share;        // 第316行 - 
wire            pfu_biu_pe_clk;                      // 第317行 - 
wire            pfu_biu_pe_clk_en;                   // 第318行 - 
wire            pfu_biu_pe_req;                      // 第319行 - 
wire    [33:0]  pfu_biu_pe_req_addr_tto6;            // 第320行 - 
wire            pfu_biu_pe_req_grnt;                 // 第321行 - 
wire            pfu_biu_pe_req_page_sec;             // 第322行 - 
wire            pfu_biu_pe_req_page_share;           // 第323行 - 
wire    [1 :0]  pfu_biu_pe_req_priv_mode;            // 第324行 - 
wire            pfu_biu_pe_req_ptiority_0;           // 第325行 - 
wire    [8 :0]  pfu_biu_pe_req_ptr;                  // 第326行 - 
wire            pfu_biu_pe_req_sel_l1;               // 第327行 - 
wire    [1 :0]  pfu_biu_pe_req_src;                  // 第328行 - 
wire            pfu_biu_pe_update_permit;            // 第329行 - 
wire            pfu_biu_pe_update_vld;               // 第330行 - 
wire    [39:0]  pfu_biu_req_addr;                    // 第331行 - 
wire            pfu_biu_req_bus_grnt;                // 第332行 - 
wire            pfu_biu_req_grnt;                    // 第333行 - 
wire            pfu_biu_req_hit_idx;                 // 第334行 - 
wire    [8 :0]  pfu_biu_req_priority_next;           // 第335行 - 
wire            pfu_dcache_pref_en;                  // 第336行 - 
wire            pfu_get_page_sec;                    // 第337行 - 
wire            pfu_get_page_share;                  // 第338行 - 
wire    [27:0]  pfu_get_ppn;                         // 第339行 - 
wire            pfu_get_ppn_err;                     // 第340行 - 
wire            pfu_get_ppn_vld;                     // 第341行 - 
wire            pfu_gpfb_biu_pe_req;                 // 第342行 - 
wire            pfu_gpfb_biu_pe_req_grnt;            // 第343行 - 
wire    [1 :0]  pfu_gpfb_biu_pe_req_src;             // 第344行 - 
wire            pfu_gpfb_from_lfb_dcache_hit;        // 第345行 - 
wire            pfu_gpfb_from_lfb_dcache_miss;       // 第346行 - 
wire            pfu_gpfb_l1_page_sec;                // 第347行 - 
wire            pfu_gpfb_l1_page_share;              // 第348行 - 
wire    [39:0]  pfu_gpfb_l1_pf_addr;                 // 第349行 - 
wire    [27:0]  pfu_gpfb_l1_vpn;                     // 第350行 - 
wire            pfu_gpfb_l2_page_sec;                // 第351行 - 
wire            pfu_gpfb_l2_page_share;              // 第352行 - 
wire    [39:0]  pfu_gpfb_l2_pf_addr;                 // 第353行 - 
wire    [27:0]  pfu_gpfb_l2_vpn;                     // 第354行 - 
wire            pfu_gpfb_mmu_pe_req;                 // 第355行 - 
wire            pfu_gpfb_mmu_pe_req_grnt;            // 第356行 - 
wire    [1 :0]  pfu_gpfb_mmu_pe_req_src;             // 第357行 - 
wire    [1 :0]  pfu_gpfb_priv_mode;                  // 第358行 - 
wire            pfu_gpfb_vld;                        // 第359行 - 
wire            pfu_gsdb_gpfb_create_vld;            // 第360行 - 
wire            pfu_gsdb_gpfb_pop_req;               // 第361行 - 
wire    [10:0]  pfu_gsdb_stride;                     // 第362行 - 
wire            pfu_gsdb_stride_neg;                 // 第363行 - 
wire    [6 :0]  pfu_gsdb_strideh_6to0;               // 第364行 - 
wire            pfu_hit_pc;                          // 第365行 - 
wire            pfu_icc_ready;                       // 第366行 - 
wire            pfu_l2_pref_en;                      // 第367行 - 
wire            pfu_lfb_create_dp_vld;               // 第368行 - 
wire            pfu_lfb_create_gateclk_en;           // 第369行 - 
wire            pfu_lfb_create_req;                  // 第370行 - 
wire            pfu_lfb_create_vld;                  // 第371行 - 
wire    [3 :0]  pfu_lfb_id;                          // 第372行 - 
wire    [27:0]  pfu_mmu_l1_pe_req_vpn;               // 第373行 - 
wire    [27:0]  pfu_mmu_l2_pe_req_vpn;               // 第374行 - 
wire            pfu_mmu_pe_clk;                      // 第375行 - 
wire            pfu_mmu_pe_clk_en;                   // 第376行 - 
wire            pfu_mmu_pe_req;                      // 第377行 - 
wire            pfu_mmu_pe_req_sel_l1;               // 第378行 - 
wire    [1 :0]  pfu_mmu_pe_req_src;                  // 第379行 - 
wire    [27:0]  pfu_mmu_pe_req_vpn;                  // 第380行 - 
wire            pfu_mmu_pe_update_permit;            // 第381行 - 
wire            pfu_part_empty;                      // 第382行 - 
wire            pfu_pfb_create_dp_vld;               // 第383行 - 
wire            pfu_pfb_create_gateclk_en;           // 第384行 - 
wire    [14:0]  pfu_pfb_create_pc;                   // 第385行 - 
wire    [7 :0]  pfu_pfb_create_ptr;                  // 第386行 - 
wire    [10:0]  pfu_pfb_create_stride;               // 第387行 - 
wire            pfu_pfb_create_stride_neg;           // 第388行 - 
wire    [6 :0]  pfu_pfb_create_strideh_6to0;         // 第389行 - 
wire            pfu_pfb_create_type_ld;              // 第390行 - 
wire            pfu_pfb_create_vld;                  // 第391行 - 
wire            pfu_pfb_empty;                       // 第392行 - 
wire    [7 :0]  pfu_pfb_entry_biu_pe_req;            // 第393行 - 
wire    [7 :0]  pfu_pfb_entry_biu_pe_req_grnt;       // 第394行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_0;      // 第395行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_1;      // 第396行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_2;      // 第397行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_3;      // 第398行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_4;      // 第399行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_5;      // 第400行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_6;      // 第401行 - 
wire    [1 :0]  pfu_pfb_entry_biu_pe_req_src_7;      // 第402行 - 
wire    [7 :0]  pfu_pfb_entry_create_dp_vld;         // 第403行 - 
wire    [7 :0]  pfu_pfb_entry_create_gateclk_en;     // 第404行 - 
wire    [7 :0]  pfu_pfb_entry_create_vld;            // 第405行 - 
wire    [7 :0]  pfu_pfb_entry_evict;                 // 第406行 - 
wire    [7 :0]  pfu_pfb_entry_from_lfb_dcache_hit;   // 第407行 - 
wire    [7 :0]  pfu_pfb_entry_from_lfb_dcache_miss;   // 第408行 - 
wire    [7 :0]  pfu_pfb_entry_hit_pc;                // 第409行 - 
wire    [7 :0]  pfu_pfb_entry_l1_page_sec;           // 第410行 - 
wire    [7 :0]  pfu_pfb_entry_l1_page_share;         // 第411行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_0;          // 第412行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_1;          // 第413行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_2;          // 第414行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_3;          // 第415行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_4;          // 第416行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_5;          // 第417行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_6;          // 第418行 - 
wire    [39:0]  pfu_pfb_entry_l1_pf_addr_7;          // 第419行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_0;              // 第420行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_1;              // 第421行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_2;              // 第422行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_3;              // 第423行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_4;              // 第424行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_5;              // 第425行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_6;              // 第426行 - 
wire    [27:0]  pfu_pfb_entry_l1_vpn_7;              // 第427行 - 
wire    [7 :0]  pfu_pfb_entry_l2_page_sec;           // 第428行 - 
wire    [7 :0]  pfu_pfb_entry_l2_page_share;         // 第429行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_0;          // 第430行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_1;          // 第431行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_2;          // 第432行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_3;          // 第433行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_4;          // 第434行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_5;          // 第435行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_6;          // 第436行 - 
wire    [39:0]  pfu_pfb_entry_l2_pf_addr_7;          // 第437行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_0;              // 第438行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_1;              // 第439行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_2;              // 第440行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_3;              // 第441行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_4;              // 第442行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_5;              // 第443行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_6;              // 第444行 - 
wire    [27:0]  pfu_pfb_entry_l2_vpn_7;              // 第445行 - 
wire    [7 :0]  pfu_pfb_entry_mmu_pe_req;            // 第446行 - 
wire    [7 :0]  pfu_pfb_entry_mmu_pe_req_grnt;       // 第447行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_0;      // 第448行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_1;      // 第449行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_2;      // 第450行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_3;      // 第451行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_4;      // 第452行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_5;      // 第453行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_6;      // 第454行 - 
wire    [1 :0]  pfu_pfb_entry_mmu_pe_req_src_7;      // 第455行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_0;           // 第456行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_1;           // 第457行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_2;           // 第458行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_3;           // 第459行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_4;           // 第460行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_5;           // 第461行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_6;           // 第462行 - 
wire    [1 :0]  pfu_pfb_entry_priv_mode_7;           // 第463行 - 
wire    [7 :0]  pfu_pfb_entry_vld;                   // 第464行 - 
wire            pfu_pfb_full;                        // 第465行 - 
wire            pfu_pfb_has_evict;                   // 第466行 - 
wire            pfu_pfb_hit_pc;                      // 第467行 - 
wire            pfu_pmb_create_dp_vld;               // 第468行 - 
wire            pfu_pmb_create_gateclk_en;           // 第469行 - 
wire    [7 :0]  pfu_pmb_create_ptr;                  // 第470行 - 
wire            pfu_pmb_create_vld;                  // 第471行 - 
wire            pfu_pmb_empty;                       // 第472行 - 
wire    [7 :0]  pfu_pmb_entry_create_dp_vld;         // 第473行 - 
wire    [7 :0]  pfu_pmb_entry_create_gateclk_en;     // 第474行 - 
wire    [7 :0]  pfu_pmb_entry_create_vld;            // 第475行 - 
wire    [7 :0]  pfu_pmb_entry_evict;                 // 第476行 - 
wire    [7 :0]  pfu_pmb_entry_hit_pc;                // 第477行 - 
wire    [14:0]  pfu_pmb_entry_pc_0;                  // 第478行 - 
wire    [14:0]  pfu_pmb_entry_pc_1;                  // 第479行 - 
wire    [14:0]  pfu_pmb_entry_pc_2;                  // 第480行 - 
wire    [14:0]  pfu_pmb_entry_pc_3;                  // 第481行 - 
wire    [14:0]  pfu_pmb_entry_pc_4;                  // 第482行 - 
wire    [14:0]  pfu_pmb_entry_pc_5;                  // 第483行 - 
wire    [14:0]  pfu_pmb_entry_pc_6;                  // 第484行 - 
wire    [14:0]  pfu_pmb_entry_pc_7;                  // 第485行 - 
wire    [7 :0]  pfu_pmb_entry_ready;                 // 第486行 - 
wire    [7 :0]  pfu_pmb_entry_ready_grnt;            // 第487行 - 
wire    [7 :0]  pfu_pmb_entry_type_ld;               // 第488行 - 
wire    [7 :0]  pfu_pmb_entry_vld;                   // 第489行 - 
wire            pfu_pmb_full;                        // 第490行 - 
wire            pfu_pmb_hit_pc;                      // 第491行 - 
wire            pfu_pmb_ready_grnt;                  // 第492行 - 
wire            pfu_pop_all_part_vld;                // 第493行 - 
wire            pfu_pop_all_vld;                     // 第494行 - 
wire            pfu_sdb_create_dp_vld;               // 第495行 - 
wire            pfu_sdb_create_gateclk_en;           // 第496行 - 
wire    [14:0]  pfu_sdb_create_pc;                   // 第497行 - 
wire    [1 :0]  pfu_sdb_create_ptr;                  // 第498行 - 
wire            pfu_sdb_create_type_ld;              // 第499行 - 
wire            pfu_sdb_create_vld;                  // 第500行 - 
wire            pfu_sdb_empty;                       // 第501行 - 
wire    [1 :0]  pfu_sdb_entry_create_dp_vld;         // 第502行 - 
wire    [1 :0]  pfu_sdb_entry_create_gateclk_en;     // 第503行 - 
wire    [1 :0]  pfu_sdb_entry_create_vld;            // 第504行 - 
wire    [1 :0]  pfu_sdb_entry_evict;                 // 第505行 - 
wire    [1 :0]  pfu_sdb_entry_hit_pc;                // 第506行 - 
wire    [14:0]  pfu_sdb_entry_pc_0;                  // 第507行 - 
wire    [14:0]  pfu_sdb_entry_pc_1;                  // 第508行 - 
wire    [1 :0]  pfu_sdb_entry_ready;                 // 第509行 - 
wire    [1 :0]  pfu_sdb_entry_ready_grnt;            // 第510行 - 
wire    [10:0]  pfu_sdb_entry_stride_0;              // 第511行 - 
wire    [10:0]  pfu_sdb_entry_stride_1;              // 第512行 - 
wire    [1 :0]  pfu_sdb_entry_stride_neg;            // 第513行 - 
wire    [6 :0]  pfu_sdb_entry_strideh_6to0_0;        // 第514行 - 
wire    [6 :0]  pfu_sdb_entry_strideh_6to0_1;        // 第515行 - 
wire    [1 :0]  pfu_sdb_entry_type_ld;               // 第516行 - 
wire    [1 :0]  pfu_sdb_entry_vld;                   // 第517行 - 
wire            pfu_sdb_full;                        // 第518行 - 
wire            pfu_sdb_has_evict;                   // 第519行 - 
wire            pfu_sdb_hit_pc;                      // 第520行 - 
wire            pfu_sdb_ready_grnt;                  // 第521行 - 
wire            pipe_create_dp_vld;                  // 第522行 - 
wire    [14:0]  pipe_create_pc;                      // 第523行 - 
wire            pipe_create_vld;                     // 第524行 - 
wire    [7 :0]  pmb_timeout_cnt_val;                 // 第525行 - 
wire            rb_pfu_biu_req_hit_idx;              // 第526行 - 
wire            rb_pfu_nc_no_pending;                // 第527行 - 
wire            rtu_yy_xx_commit0;                   // 第528行 - 
wire    [6 :0]  rtu_yy_xx_commit0_iid;               // 第529行 - 
wire            rtu_yy_xx_commit1;                   // 第530行 - 
wire    [6 :0]  rtu_yy_xx_commit1_iid;               // 第531行 - 
wire            rtu_yy_xx_commit2;                   // 第532行 - 
wire    [6 :0]  rtu_yy_xx_commit2_iid;               // 第533行 - 
wire            rtu_yy_xx_flush;                     // 第534行 - 
wire    [7 :0]  sdb_timeout_cnt_val;                 // 第535行 - 
wire            sq_pfu_pop_synci_inst;               // 第536行 - 
wire    [6 :0]  st_da_iid;                           // 第537行 - 
wire            st_da_page_sec_ff;                   // 第538行 - 
wire            st_da_page_share_ff;                 // 第539行 - 
wire    [14:0]  st_da_pc;                            // 第540行 - 
wire            st_da_pfu_act_dp_vld;                // 第541行 - 
wire            st_da_pfu_act_vld;                   // 第542行 - 
wire            st_da_pfu_biu_req_hit_idx;           // 第543行 - 
wire            st_da_pfu_evict_cnt_vld;             // 第544行 - 
wire            st_da_pfu_pf_inst_vld;               // 第545行 - 
wire    [39:0]  st_da_ppfu_va;                       // 第546行 - 
wire    [27:0]  st_da_ppn_ff;                        // 第547行 - 
wire            vb_pfu_biu_req_hit_idx;              // 第548行 - 
wire            wmb_pfu_biu_req_hit_idx;             // 第549行 - 
  // 第550行 - 
  // 第551行 - 
parameter PMB_ENTRY = 8,  // 第552行 - 
          SDB_ENTRY = 2,  // 第553行 - 
          PFB_ENTRY = 8;  // 第554行 - 
parameter PC_LEN    = 15;  // 第555行 - 
parameter BIU_R_L2PREF_ID = 5'd25;  // 第556行 - 
  // 第557行 - 
//==========================================================  // 第558行 - 
//                 Instance of Gated Cell    // 第559行 - 
//==========================================================  // 第560行 - 
//--------------------mmu req pop entry---------------------  // 第561行 - 
assign pfu_mmu_pe_clk_en  = pfu_get_ppn_vld  // 第562行 - 
                            || pfu_mmu_pe_req;  // 第563行 - 
// &Instance("gated_clk_cell", "x_lsu_pfu_mmu_pe_gated_clk"); @45  // 第564行 - 
gated_clk_cell  x_lsu_pfu_mmu_pe_gated_clk (  // 第565行 - 
  .clk_in             (forever_cpuclk    ),  // 第566行 - 
  .clk_out            (pfu_mmu_pe_clk    ),  // 第567行 - 
  .external_en        (1'b0              ),  // 第568行 - 
  .global_en          (cp0_yy_clk_en     ),  // 第569行 - 
  .local_en           (pfu_mmu_pe_clk_en ),  // 第570行 - 
  .module_en          (cp0_lsu_icg_en    ),  // 第571行 - 
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)  // 第572行 - 
);  // 第573行 - 
  // 第574行 - 
// &Connect(.clk_in        (forever_cpuclk     ), @46  // 第575行 - 
//          .external_en   (1'b0               ), @47  // 第576行 - 
//          .global_en     (cp0_yy_clk_en      ), @48  // 第577行 - 
//          .module_en     (cp0_lsu_icg_en     ), @49  // 第578行 - 
//          .local_en      (pfu_mmu_pe_clk_en ), @50  // 第579行 - 
//          .clk_out       (pfu_mmu_pe_clk    )); @51  // 第580行 - 
  // 第581行 - 
//--------------------biu req pop entry---------------------  // 第582行 - 
assign pfu_biu_pe_clk_en  = pfu_biu_pe_req  // 第583行 - 
                            ||  pfu_biu_req_unmask;  // 第584行 - 
  // 第585行 - 
// &Instance("gated_clk_cell", "x_lsu_pfu_biu_pe_gated_clk"); @57  // 第586行 - 
gated_clk_cell  x_lsu_pfu_biu_pe_gated_clk (  // 第587行 - 
  .clk_in             (forever_cpuclk    ),  // 第588行 - 
  .clk_out            (pfu_biu_pe_clk    ),  // 第589行 - 
  .external_en        (1'b0              ),  // 第590行 - 
  .global_en          (cp0_yy_clk_en     ),  // 第591行 - 
  .local_en           (pfu_biu_pe_clk_en ),  // 第592行 - 
  .module_en          (cp0_lsu_icg_en    ),  // 第593行 - 
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)  // 第594行 - 
);  // 第595行 - 
  // 第596行 - 
// &Connect(.clk_in        (forever_cpuclk     ), @58  // 第597行 - 
//          .external_en   (1'b0               ), @59  // 第598行 - 
//          .global_en     (cp0_yy_clk_en      ), @60  // 第599行 - 
//          .module_en     (cp0_lsu_icg_en     ), @61  // 第600行 - 
//          .local_en      (pfu_biu_pe_clk_en ), @62  // 第601行 - 
//          .clk_out       (pfu_biu_pe_clk    )); @63  // 第602行 - 
  // 第603行 - 
//==========================================================  // 第604行 - 
//                 Instance pmb entry  // 第605行 - 
//==========================================================  // 第606行 - 
  // 第607行 - 
// &ConnRule(s/_x$/[0]/); @69  // 第608行 - 
// &ConnRule(s/_v$/_0/); @70  // 第609行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_0"); @71  // 第610行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_0 (  // 第611行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第612行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第613行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第614行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第615行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第616行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第617行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第618行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第619行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第620行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第621行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第622行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[0]    ),  // 第623行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[0]),  // 第624行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[0]       ),  // 第625行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[0]            ),  // 第626行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[0]           ),  // 第627行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_0                ),  // 第628行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[0]       ),  // 第629行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[0]            ),  // 第630行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[0]          ),  // 第631行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[0]              ),  // 第632行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第633行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第634行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第635行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第636行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第637行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第638行 - 
);  // 第639行 - 
  // 第640行 - 
  // 第641行 - 
// &ConnRule(s/_x$/[1]/); @73  // 第642行 - 
// &ConnRule(s/_v$/_1/); @74  // 第643行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_1"); @75  // 第644行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_1 (  // 第645行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第646行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第647行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第648行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第649行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第650行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第651行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第652行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第653行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第654行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第655行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第656行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[1]    ),  // 第657行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[1]),  // 第658行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[1]       ),  // 第659行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[1]            ),  // 第660行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[1]           ),  // 第661行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_1                ),  // 第662行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[1]       ),  // 第663行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[1]            ),  // 第664行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[1]          ),  // 第665行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[1]              ),  // 第666行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第667行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第668行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第669行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第670行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第671行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第672行 - 
);  // 第673行 - 
  // 第674行 - 
  // 第675行 - 
// &ConnRule(s/_x$/[2]/); @77  // 第676行 - 
// &ConnRule(s/_v$/_2/); @78  // 第677行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_2"); @79  // 第678行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_2 (  // 第679行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第680行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第681行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第682行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第683行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第684行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第685行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第686行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第687行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第688行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第689行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第690行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[2]    ),  // 第691行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[2]),  // 第692行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[2]       ),  // 第693行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[2]            ),  // 第694行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[2]           ),  // 第695行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_2                ),  // 第696行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[2]       ),  // 第697行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[2]            ),  // 第698行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[2]          ),  // 第699行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[2]              ),  // 第700行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第701行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第702行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第703行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第704行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第705行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第706行 - 
);  // 第707行 - 
  // 第708行 - 
  // 第709行 - 
// &ConnRule(s/_x$/[3]/); @81  // 第710行 - 
// &ConnRule(s/_v$/_3/); @82  // 第711行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_3"); @83  // 第712行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_3 (  // 第713行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第714行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第715行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第716行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第717行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第718行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第719行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第720行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第721行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第722行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第723行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第724行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[3]    ),  // 第725行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[3]),  // 第726行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[3]       ),  // 第727行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[3]            ),  // 第728行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[3]           ),  // 第729行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_3                ),  // 第730行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[3]       ),  // 第731行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[3]            ),  // 第732行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[3]          ),  // 第733行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[3]              ),  // 第734行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第735行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第736行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第737行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第738行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第739行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第740行 - 
);  // 第741行 - 
  // 第742行 - 
  // 第743行 - 
// &ConnRule(s/_x$/[4]/); @85  // 第744行 - 
// &ConnRule(s/_v$/_4/); @86  // 第745行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_4"); @87  // 第746行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_4 (  // 第747行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第748行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第749行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第750行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第751行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第752行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第753行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第754行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第755行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第756行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第757行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第758行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[4]    ),  // 第759行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[4]),  // 第760行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[4]       ),  // 第761行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[4]            ),  // 第762行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[4]           ),  // 第763行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_4                ),  // 第764行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[4]       ),  // 第765行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[4]            ),  // 第766行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[4]          ),  // 第767行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[4]              ),  // 第768行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第769行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第770行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第771行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第772行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第773行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第774行 - 
);  // 第775行 - 
  // 第776行 - 
  // 第777行 - 
// &ConnRule(s/_x$/[5]/); @89  // 第778行 - 
// &ConnRule(s/_v$/_5/); @90  // 第779行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_5"); @91  // 第780行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_5 (  // 第781行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第782行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第783行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第784行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第785行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第786行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第787行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第788行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第789行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第790行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第791行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第792行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[5]    ),  // 第793行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[5]),  // 第794行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[5]       ),  // 第795行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[5]            ),  // 第796行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[5]           ),  // 第797行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_5                ),  // 第798行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[5]       ),  // 第799行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[5]            ),  // 第800行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[5]          ),  // 第801行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[5]              ),  // 第802行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第803行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第804行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第805行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第806行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第807行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第808行 - 
);  // 第809行 - 
  // 第810行 - 
  // 第811行 - 
// &ConnRule(s/_x$/[6]/); @93  // 第812行 - 
// &ConnRule(s/_v$/_6/); @94  // 第813行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_6"); @95  // 第814行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_6 (  // 第815行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第816行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第817行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第818行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第819行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第820行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第821行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第822行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第823行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第824行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第825行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第826行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[6]    ),  // 第827行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[6]),  // 第828行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[6]       ),  // 第829行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[6]            ),  // 第830行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[6]           ),  // 第831行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_6                ),  // 第832行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[6]       ),  // 第833行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[6]            ),  // 第834行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[6]          ),  // 第835行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[6]              ),  // 第836行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第837行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第838行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第839行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第840行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第841行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第842行 - 
);  // 第843行 - 
  // 第844行 - 
  // 第845行 - 
// &ConnRule(s/_x$/[7]/); @97  // 第846行 - 
// &ConnRule(s/_v$/_7/); @98  // 第847行 - 
// &Instance("ct_lsu_pfu_pmb_entry","x_ct_lsu_pfu_pmb_entry_7"); @99  // 第848行 - 
ct_lsu_pfu_pmb_entry  x_ct_lsu_pfu_pmb_entry_7 (  // 第849行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第850行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第851行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第852行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第853行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第854行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第855行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第856行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第857行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第858行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第859行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第860行 - 
  .pfu_pmb_entry_create_dp_vld_x      (pfu_pmb_entry_create_dp_vld[7]    ),  // 第861行 - 
  .pfu_pmb_entry_create_gateclk_en_x  (pfu_pmb_entry_create_gateclk_en[7]),  // 第862行 - 
  .pfu_pmb_entry_create_vld_x         (pfu_pmb_entry_create_vld[7]       ),  // 第863行 - 
  .pfu_pmb_entry_evict_x              (pfu_pmb_entry_evict[7]            ),  // 第864行 - 
  .pfu_pmb_entry_hit_pc_x             (pfu_pmb_entry_hit_pc[7]           ),  // 第865行 - 
  .pfu_pmb_entry_pc_v                 (pfu_pmb_entry_pc_7                ),  // 第866行 - 
  .pfu_pmb_entry_ready_grnt_x         (pfu_pmb_entry_ready_grnt[7]       ),  // 第867行 - 
  .pfu_pmb_entry_ready_x              (pfu_pmb_entry_ready[7]            ),  // 第868行 - 
  .pfu_pmb_entry_type_ld_x            (pfu_pmb_entry_type_ld[7]          ),  // 第869行 - 
  .pfu_pmb_entry_vld_x                (pfu_pmb_entry_vld[7]              ),  // 第870行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第871行 - 
  .pipe_create_pc                     (pipe_create_pc                    ),  // 第872行 - 
  .pmb_timeout_cnt_val                (pmb_timeout_cnt_val               ),  // 第873行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第874行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第875行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             )  // 第876行 - 
);  // 第877行 - 
  // 第878行 - 
  // 第879行 - 
//==========================================================  // 第880行 - 
//            Generate full/create signal of pmb  // 第881行 - 
//==========================================================  // 第882行 - 
//---------------------create pointer-----------------------  // 第883行 - 
//if it has empty entry, then create signal to empty entry,  // 第884行 - 
//else create siganl to evict entry,  // 第885行 - 
//else create fail  // 第886行 - 
// &CombBeg; @108  // 第887行 - 
always @( pfu_pmb_entry_vld[7:0])  // 第888行 - 
begin  // 第889行 - 
pfu_pmb_empty_create_ptr[PMB_ENTRY-1:0]   = {PMB_ENTRY{1'b0}};  // 第890行 - 
casez(pfu_pmb_entry_vld[PMB_ENTRY-1:0])  // 第891行 - 
  8'b????_???0:pfu_pmb_empty_create_ptr[0]  = 1'b1;  // 第892行 - 
  8'b????_??01:pfu_pmb_empty_create_ptr[1]  = 1'b1;  // 第893行 - 
  8'b????_?011:pfu_pmb_empty_create_ptr[2]  = 1'b1;  // 第894行 - 
  8'b????_0111:pfu_pmb_empty_create_ptr[3]  = 1'b1;  // 第895行 - 
  8'b???0_1111:pfu_pmb_empty_create_ptr[4]  = 1'b1;  // 第896行 - 
  8'b??01_1111:pfu_pmb_empty_create_ptr[5]  = 1'b1;  // 第897行 - 
  8'b?011_1111:pfu_pmb_empty_create_ptr[6]  = 1'b1;  // 第898行 - 
  8'b0111_1111:pfu_pmb_empty_create_ptr[7]  = 1'b1;  // 第899行 - 
  default:pfu_pmb_empty_create_ptr[PMB_ENTRY-1:0]   = {PMB_ENTRY{1'b0}};  // 第900行 - 
endcase  // 第901行 - 
// &CombEnd; @121  // 第902行 - 
end  // 第903行 - 
  // 第904行 - 
// &CombBeg; @123  // 第905行 - 
always @( pfu_pmb_entry_evict[7:0])  // 第906行 - 
begin  // 第907行 - 
pfu_pmb_evict_create_ptr[PMB_ENTRY-1:0]  = {PMB_ENTRY{1'b0}};  // 第908行 - 
casez(pfu_pmb_entry_evict[PMB_ENTRY-1:0])  // 第909行 - 
  8'b????_???1:pfu_pmb_evict_create_ptr[0]  = 1'b1;  // 第910行 - 
  8'b????_??10:pfu_pmb_evict_create_ptr[1]  = 1'b1;  // 第911行 - 
  8'b????_?100:pfu_pmb_evict_create_ptr[2]  = 1'b1;  // 第912行 - 
  8'b????_1000:pfu_pmb_evict_create_ptr[3]  = 1'b1;  // 第913行 - 
  8'b???1_0000:pfu_pmb_evict_create_ptr[4]  = 1'b1;  // 第914行 - 
  8'b??10_0000:pfu_pmb_evict_create_ptr[5]  = 1'b1;  // 第915行 - 
  8'b?100_0000:pfu_pmb_evict_create_ptr[6]  = 1'b1;  // 第916行 - 
  8'b1000_0000:pfu_pmb_evict_create_ptr[7]  = 1'b1;  // 第917行 - 
  default:pfu_pmb_evict_create_ptr[PMB_ENTRY-1:0]  = {PMB_ENTRY{1'b0}};  // 第918行 - 
endcase  // 第919行 - 
// &CombEnd; @136  // 第920行 - 
end  // 第921行 - 
  // 第922行 - 
assign pfu_pmb_full = &pfu_pmb_entry_vld[PMB_ENTRY-1:0];  // 第923行 - 
assign pfu_pmb_create_ptr[PMB_ENTRY-1:0]  = pfu_pmb_full  // 第924行 - 
                                            ? pfu_pmb_evict_create_ptr[PMB_ENTRY-1:0]  // 第925行 - 
                                            : pfu_pmb_empty_create_ptr[PMB_ENTRY-1:0];  // 第926行 - 
//==========================================================  // 第927行 - 
//            pipe info create select  // 第928行 - 
//==========================================================  // 第929行 - 
//when ld and st create pmu simultaneously,ld has higher priority  // 第930行 - 
assign pipe_create_pc[PC_LEN-1:0] = ld_da_pfu_act_dp_vld  // 第931行 - 
                                    ? ld_da_ldfifo_pc[PC_LEN-1:0]  // 第932行 - 
                                    : st_da_pc[PC_LEN-1:0];  // 第933行 - 
  // 第934行 - 
assign pipe_create_vld    = ld_da_pfu_act_vld || st_da_pfu_act_vld && !ld_da_pfu_act_dp_vld;  // 第935行 - 
   // 第936行 - 
assign pipe_create_dp_vld = ld_da_pfu_act_dp_vld || st_da_pfu_act_dp_vld;  // 第937行 - 
  // 第938行 - 
//------------------------hit pc----------------------------  // 第939行 - 
assign pfu_pmb_hit_pc     = |pfu_pmb_entry_hit_pc[PMB_ENTRY-1:0];  // 第940行 - 
assign pfu_sdb_hit_pc     = |pfu_sdb_entry_hit_pc[SDB_ENTRY-1:0];  // 第941行 - 
assign pfu_pfb_hit_pc     = |pfu_pfb_entry_hit_pc[PFB_ENTRY-1:0];  // 第942行 - 
assign pfu_hit_pc         = pfu_pmb_hit_pc  // 第943行 - 
                            ||  pfu_sdb_hit_pc  // 第944行 - 
                            ||  pfu_pfb_hit_pc;  // 第945行 - 
//-------------------create signal--------------------------  // 第946行 - 
assign pfu_pmb_create_vld         = pipe_create_vld  // 第947行 - 
                                    &&  !pfu_hit_pc  // 第948行 - 
                                    &&  !pfu_gpfb_vld;  // 第949行 - 
assign pfu_pmb_create_dp_vld      = pipe_create_dp_vld  // 第950行 - 
                                    &&  !pfu_hit_pc  // 第951行 - 
                                    &&  !pfu_gpfb_vld;  // 第952行 - 
assign pfu_pmb_create_gateclk_en  = pipe_create_dp_vld  // 第953行 - 
                                    &&  !pfu_gpfb_vld;  // 第954行 - 
  // 第955行 - 
assign pfu_pmb_entry_create_vld[PMB_ENTRY-1:0]          = {PMB_ENTRY{pfu_pmb_create_vld}}  // 第956行 - 
                                                          & pfu_pmb_create_ptr[PMB_ENTRY-1:0];  // 第957行 - 
assign pfu_pmb_entry_create_dp_vld[PMB_ENTRY-1:0]       = {PMB_ENTRY{pfu_pmb_create_dp_vld}}  // 第958行 - 
                                                          & pfu_pmb_create_ptr[PMB_ENTRY-1:0];  // 第959行 - 
assign pfu_pmb_entry_create_gateclk_en[PMB_ENTRY-1:0]   = {PMB_ENTRY{pfu_pmb_create_gateclk_en}}  // 第960行 - 
                                                          & pfu_pmb_create_ptr[PMB_ENTRY-1:0];  // 第961行 - 
  // 第962行 - 
//==========================================================  // 第963行 - 
//                 Instance sdb entry  // 第964行 - 
//==========================================================  // 第965行 - 
  // 第966行 - 
// &ConnRule(s/_x$/[0]/); @182  // 第967行 - 
// &ConnRule(s/_v$/_0/); @183  // 第968行 - 
// &Instance("ct_lsu_pfu_sdb_entry","x_ct_lsu_pfu_sdb_entry_0"); @184  // 第969行 - 
ct_lsu_pfu_sdb_entry  x_ct_lsu_pfu_sdb_entry_0 (  // 第970行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第971行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第972行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第973行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第974行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第975行 - 
  .ld_da_iid                          (ld_da_iid                         ),  // 第976行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第977行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第978行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第979行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第980行 - 
  .ld_da_ppfu_va                      (ld_da_ppfu_va                     ),  // 第981行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第982行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第983行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第984行 - 
  .pfu_sdb_create_pc                  (pfu_sdb_create_pc                 ),  // 第985行 - 
  .pfu_sdb_create_type_ld             (pfu_sdb_create_type_ld            ),  // 第986行 - 
  .pfu_sdb_entry_create_dp_vld_x      (pfu_sdb_entry_create_dp_vld[0]    ),  // 第987行 - 
  .pfu_sdb_entry_create_gateclk_en_x  (pfu_sdb_entry_create_gateclk_en[0]),  // 第988行 - 
  .pfu_sdb_entry_create_vld_x         (pfu_sdb_entry_create_vld[0]       ),  // 第989行 - 
  .pfu_sdb_entry_evict_x              (pfu_sdb_entry_evict[0]            ),  // 第990行 - 
  .pfu_sdb_entry_hit_pc_x             (pfu_sdb_entry_hit_pc[0]           ),  // 第991行 - 
  .pfu_sdb_entry_pc_v                 (pfu_sdb_entry_pc_0                ),  // 第992行 - 
  .pfu_sdb_entry_ready_grnt_x         (pfu_sdb_entry_ready_grnt[0]       ),  // 第993行 - 
  .pfu_sdb_entry_ready_x              (pfu_sdb_entry_ready[0]            ),  // 第994行 - 
  .pfu_sdb_entry_stride_neg_x         (pfu_sdb_entry_stride_neg[0]       ),  // 第995行 - 
  .pfu_sdb_entry_stride_v             (pfu_sdb_entry_stride_0            ),  // 第996行 - 
  .pfu_sdb_entry_strideh_6to0_v       (pfu_sdb_entry_strideh_6to0_0      ),  // 第997行 - 
  .pfu_sdb_entry_type_ld_x            (pfu_sdb_entry_type_ld[0]          ),  // 第998行 - 
  .pfu_sdb_entry_vld_x                (pfu_sdb_entry_vld[0]              ),  // 第999行 - 
  .rtu_yy_xx_commit0                  (rtu_yy_xx_commit0                 ),  // 第1000行 - 
  .rtu_yy_xx_commit0_iid              (rtu_yy_xx_commit0_iid             ),  // 第1001行 - 
  .rtu_yy_xx_commit1                  (rtu_yy_xx_commit1                 ),  // 第1002行 - 
  .rtu_yy_xx_commit1_iid              (rtu_yy_xx_commit1_iid             ),  // 第1003行 - 
  .rtu_yy_xx_commit2                  (rtu_yy_xx_commit2                 ),  // 第1004行 - 
  .rtu_yy_xx_commit2_iid              (rtu_yy_xx_commit2_iid             ),  // 第1005行 - 
  .rtu_yy_xx_flush                    (rtu_yy_xx_flush                   ),  // 第1006行 - 
  .sdb_timeout_cnt_val                (sdb_timeout_cnt_val               ),  // 第1007行 - 
  .st_da_iid                          (st_da_iid                         ),  // 第1008行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第1009行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第1010行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             ),  // 第1011行 - 
  .st_da_ppfu_va                      (st_da_ppfu_va                     )  // 第1012行 - 
);  // 第1013行 - 
  // 第1014行 - 
  // 第1015行 - 
// &ConnRule(s/_x$/[1]/); @186  // 第1016行 - 
// &ConnRule(s/_v$/_1/); @187  // 第1017行 - 
// &Instance("ct_lsu_pfu_sdb_entry","x_ct_lsu_pfu_sdb_entry_1"); @188  // 第1018行 - 
ct_lsu_pfu_sdb_entry  x_ct_lsu_pfu_sdb_entry_1 (  // 第1019行 - 
  .amr_wa_cancel                      (amr_wa_cancel                     ),  // 第1020行 - 
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),  // 第1021行 - 
  .cp0_lsu_l2_st_pref_en              (cp0_lsu_l2_st_pref_en             ),  // 第1022行 - 
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),  // 第1023行 - 
  .cpurst_b                           (cpurst_b                          ),  // 第1024行 - 
  .ld_da_iid                          (ld_da_iid                         ),  // 第1025行 - 
  .ld_da_ldfifo_pc                    (ld_da_ldfifo_pc                   ),  // 第1026行 - 
  .ld_da_pfu_act_dp_vld               (ld_da_pfu_act_dp_vld              ),  // 第1027行 - 
  .ld_da_pfu_evict_cnt_vld            (ld_da_pfu_evict_cnt_vld           ),  // 第1028行 - 
  .ld_da_pfu_pf_inst_vld              (ld_da_pfu_pf_inst_vld             ),  // 第1029行 - 
  .ld_da_ppfu_va                      (ld_da_ppfu_va                     ),  // 第1030行 - 
  .lsu_special_clk                    (lsu_special_clk                   ),  // 第1031行 - 
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),  // 第1032行 - 
  .pfu_pop_all_part_vld               (pfu_pop_all_part_vld              ),  // 第1033行 - 
  .pfu_sdb_create_pc                  (pfu_sdb_create_pc                 ),  // 第1034行 - 
  .pfu_sdb_create_type_ld             (pfu_sdb_create_type_ld            ),  // 第1035行 - 
  .pfu_sdb_entry_create_dp_vld_x      (pfu_sdb_entry_create_dp_vld[1]    ),  // 第1036行 - 
  .pfu_sdb_entry_create_gateclk_en_x  (pfu_sdb_entry_create_gateclk_en[1]),  // 第1037行 - 
  .pfu_sdb_entry_create_vld_x         (pfu_sdb_entry_create_vld[1]       ),  // 第1038行 - 
  .pfu_sdb_entry_evict_x              (pfu_sdb_entry_evict[1]            ),  // 第1039行 - 
  .pfu_sdb_entry_hit_pc_x             (pfu_sdb_entry_hit_pc[1]           ),  // 第1040行 - 
  .pfu_sdb_entry_pc_v                 (pfu_sdb_entry_pc_1                ),  // 第1041行 - 
  .pfu_sdb_entry_ready_grnt_x         (pfu_sdb_entry_ready_grnt[1]       ),  // 第1042行 - 
  .pfu_sdb_entry_ready_x              (pfu_sdb_entry_ready[1]            ),  // 第1043行 - 
  .pfu_sdb_entry_stride_neg_x         (pfu_sdb_entry_stride_neg[1]       ),  // 第1044行 - 
  .pfu_sdb_entry_stride_v             (pfu_sdb_entry_stride_1            ),  // 第1045行 - 
  .pfu_sdb_entry_strideh_6to0_v       (pfu_sdb_entry_strideh_6to0_1      ),  // 第1046行 - 
  .pfu_sdb_entry_type_ld_x            (pfu_sdb_entry_type_ld[1]          ),  // 第1047行 - 
  .pfu_sdb_entry_vld_x                (pfu_sdb_entry_vld[1]              ),  // 第1048行 - 
  .rtu_yy_xx_commit0                  (rtu_yy_xx_commit0                 ),  // 第1049行 - 
  .rtu_yy_xx_commit0_iid              (rtu_yy_xx_commit0_iid             ),  // 第1050行 - 
  .rtu_yy_xx_commit1                  (rtu_yy_xx_commit1                 ),  // 第1051行 - 
  .rtu_yy_xx_commit1_iid              (rtu_yy_xx_commit1_iid             ),  // 第1052行 - 
  .rtu_yy_xx_commit2                  (rtu_yy_xx_commit2                 ),  // 第1053行 - 
  .rtu_yy_xx_commit2_iid              (rtu_yy_xx_commit2_iid             ),  // 第1054行 - 
  .rtu_yy_xx_flush                    (rtu_yy_xx_flush                   ),  // 第1055行 - 
  .sdb_timeout_cnt_val                (sdb_timeout_cnt_val               ),  // 第1056行 - 
  .st_da_iid                          (st_da_iid                         ),  // 第1057行 - 
  .st_da_pc                           (st_da_pc                          ),  // 第1058行 - 
  .st_da_pfu_evict_cnt_vld            (st_da_pfu_evict_cnt_vld           ),  // 第1059行 - 
  .st_da_pfu_pf_inst_vld              (st_da_pfu_pf_inst_vld             ),  // 第1060行 - 
  .st_da_ppfu_va                      (st_da_ppfu_va                     )  // 第1061行 - 
);  // 第1062行 - 
  // 第1063行 - 
  // 第1064行 - 
//==========================================================  // 第1065行 - 
//            Generate full/create signal of sdb  // 第1066行 - 
//==========================================================  // 第1067行 - 
//------------------pop pointer of pmb----------------------  // 第1068行 - 
// &CombBeg; @194  // 第1069行 - 
always @( pfu_pmb_entry_ready[7:0])  // 第1070行 - 
begin  // 第1071行 - 
pfu_pmb_pop_ptr[PMB_ENTRY-1:0]  = {PMB_ENTRY{1'b0}};  // 第1072行 - 
casez(pfu_pmb_entry_ready[PMB_ENTRY-1:0])  // 第1073行 - 
  8'b????_???1:pfu_pmb_pop_ptr[0]  = 1'b1;  // 第1074行 - 
  8'b????_??10:pfu_pmb_pop_ptr[1]  = 1'b1;  // 第1075行 - 
  8'b????_?100:pfu_pmb_pop_ptr[2]  = 1'b1;  // 第1076行 - 
  8'b????_1000:pfu_pmb_pop_ptr[3]  = 1'b1;  // 第1077行 - 
  8'b???1_0000:pfu_pmb_pop_ptr[4]  = 1'b1;  // 第1078行 - 
  8'b??10_0000:pfu_pmb_pop_ptr[5]  = 1'b1;  // 第1079行 - 
  8'b?100_0000:pfu_pmb_pop_ptr[6]  = 1'b1;  // 第1080行 - 
  8'b1000_0000:pfu_pmb_pop_ptr[7]  = 1'b1;  // 第1081行 - 
  default:pfu_pmb_pop_ptr[PMB_ENTRY-1:0]  = {PMB_ENTRY{1'b0}};  // 第1082行 - 
endcase  // 第1083行 - 
// &CombEnd; @207  // 第1084行 - 
end  // 第1085行 - 
  // 第1086行 - 
//-------------------create info of sdb---------------------  // 第1087行 - 
assign pfu_sdb_create_pc[PC_LEN-1:0]  = {PC_LEN{pfu_pmb_pop_ptr[0]}}  & pfu_pmb_entry_pc_0[PC_LEN-1:0]  // 第1088行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[1]}}  & pfu_pmb_entry_pc_1[PC_LEN-1:0]  // 第1089行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[2]}}  & pfu_pmb_entry_pc_2[PC_LEN-1:0]  // 第1090行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[3]}}  & pfu_pmb_entry_pc_3[PC_LEN-1:0]  // 第1091行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[4]}}  & pfu_pmb_entry_pc_4[PC_LEN-1:0]  // 第1092行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[5]}}  & pfu_pmb_entry_pc_5[PC_LEN-1:0]  // 第1093行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[6]}}  & pfu_pmb_entry_pc_6[PC_LEN-1:0]  // 第1094行 - 
                                        | {PC_LEN{pfu_pmb_pop_ptr[7]}}  & pfu_pmb_entry_pc_7[PC_LEN-1:0];  // 第1095行 - 
  // 第1096行 - 
assign pfu_sdb_create_type_ld = |(pfu_pmb_pop_ptr[7:0] & pfu_pmb_entry_type_ld[7:0]);  // 第1097行 - 
  // 第1098行 - 
//---------------------create pointer-----------------------  // 第1099行 - 
//if it has empty entry, then create signal to empty entry,  // 第1100行 - 
//else create siganl to evict entry,  // 第1101行 - 
//else wait  // 第1102行 - 
// &CombBeg; @225  // 第1103行 - 
always @( pfu_sdb_entry_vld[1:0])  // 第1104行 - 
begin  // 第1105行 - 
pfu_sdb_empty_create_ptr[SDB_ENTRY-1:0]   = {SDB_ENTRY{1'b0}};  // 第1106行 - 
casez(pfu_sdb_entry_vld[SDB_ENTRY-1:0])  // 第1107行 - 
  2'b?0:pfu_sdb_empty_create_ptr[0]  = 1'b1;  // 第1108行 - 
  2'b01:pfu_sdb_empty_create_ptr[1]  = 1'b1;  // 第1109行 - 
  default:pfu_sdb_empty_create_ptr[SDB_ENTRY-1:0]   = {SDB_ENTRY{1'b0}};  // 第1110行 - 
endcase  // 第1111行 - 
// &CombEnd; @232  // 第1112行 - 
end  // 第1113行 - 
  // 第1114行 - 
// &CombBeg; @234  // 第1115行 - 
always @( pfu_sdb_entry_evict[1:0])  // 第1116行 - 
begin  // 第1117行 - 
pfu_sdb_evict_create_ptr[SDB_ENTRY-1:0]  = {SDB_ENTRY{1'b0}};  // 第1118行 - 
casez(pfu_sdb_entry_evict[SDB_ENTRY-1:0])  // 第1119行 - 
  2'b?1:pfu_sdb_evict_create_ptr[0]  = 1'b1;  // 第1120行 - 
  2'b10:pfu_sdb_evict_create_ptr[1]  = 1'b1;  // 第1121行 - 
  default:pfu_sdb_evict_create_ptr[SDB_ENTRY-1:0]  = {SDB_ENTRY{1'b0}};  // 第1122行 - 
endcase  // 第1123行 - 
// &CombEnd; @241  // 第1124行 - 
end  // 第1125行 - 
  // 第1126行 - 
assign pfu_sdb_full       = &pfu_sdb_entry_vld[SDB_ENTRY-1:0];  // 第1127行 - 
assign pfu_sdb_has_evict  = |pfu_sdb_entry_evict[SDB_ENTRY-1:0];  // 第1128行 - 
assign pfu_sdb_create_ptr[SDB_ENTRY-1:0]  = pfu_sdb_full  // 第1129行 - 
                                            ? pfu_sdb_evict_create_ptr[SDB_ENTRY-1:0]  // 第1130行 - 
                                            : pfu_sdb_empty_create_ptr[SDB_ENTRY-1:0];  // 第1131行 - 
  // 第1132行 - 
//-------------------grnt signal of pmb---------------------  // 第1133行 - 
assign pfu_pmb_ready_grnt         = !pfu_sdb_full  // 第1134行 - 
                                    ||  pfu_sdb_has_evict;  // 第1135行 - 
assign pfu_pmb_entry_ready_grnt[PMB_ENTRY-1:0]  = {PMB_ENTRY{pfu_pmb_ready_grnt}}  // 第1136行 - 
                                                  & pfu_pmb_pop_ptr[PMB_ENTRY-1:0];  // 第1137行 - 
  // 第1138行 - 
//------------------create signal of sdb--------------------  // 第1139行 - 
assign pfu_sdb_create_vld         = |pfu_pmb_entry_ready[PMB_ENTRY-1:0];  // 第1140行 - 
assign pfu_sdb_create_dp_vld      = pfu_sdb_create_vld;  // 第1141行 - 
// &Force("output","pfu_sdb_create_gateclk_en"); @258  // 第1142行 - 
assign pfu_sdb_create_gateclk_en  = pfu_sdb_create_dp_vld;  // 第1143行 - 
  // 第1144行 - 
assign pfu_sdb_entry_create_vld[SDB_ENTRY-1:0]          = {SDB_ENTRY{pfu_sdb_create_vld}}  // 第1145行 - 
                                                          & pfu_sdb_create_ptr[SDB_ENTRY-1:0];  // 第1146行 - 
assign pfu_sdb_entry_create_dp_vld[SDB_ENTRY-1:0]       = {SDB_ENTRY{pfu_sdb_create_dp_vld}}  // 第1147行 - 
                                                          & pfu_sdb_create_ptr[SDB_ENTRY-1:0];  // 第1148行 - 
assign pfu_sdb_entry_create_gateclk_en[SDB_ENTRY-1:0]   = {SDB_ENTRY{pfu_sdb_create_gateclk_en}}  // 第1149行 - 
                                                          & pfu_sdb_create_ptr[SDB_ENTRY-1:0];  // 第1150行 - 
  // 第1151行 - 
//==========================================================  // 第1152行 - 
//                 Instance pfb entry  // 第1153行 - 
//==========================================================  // 第1154行 - 
// &ConnRule(s/_x$/[0]/); @271  // 第1155行 - 
// &ConnRule(s/_v$/_0/); @272  // 第1156行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_0"); @273  // 第1157行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_0 (  // 第1158行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1159行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1160行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1161行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1162行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1163行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1164行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1165行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1166行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1167行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1168行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1169行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1170行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1171行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1172行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1173行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1174行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1175行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1176行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1177行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1178行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1179行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1180行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1181行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1182行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1183行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1184行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1185行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1186行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1187行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1188行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1189行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1190行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1191行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1192行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1193行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1194行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[0]     ),  // 第1195行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_0       ),  // 第1196行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[0]          ),  // 第1197行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[0]       ),  // 第1198行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[0]   ),  // 第1199行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[0]          ),  // 第1200行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[0]               ),  // 第1201行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[0] ),  // 第1202行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[0]),  // 第1203行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[0]              ),  // 第1204行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[0]         ),  // 第1205行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[0]       ),  // 第1206行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_0           ),  // 第1207行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_0               ),  // 第1208行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[0]         ),  // 第1209行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[0]       ),  // 第1210行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_0           ),  // 第1211行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_0               ),  // 第1212行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[0]     ),  // 第1213行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_0       ),  // 第1214行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[0]          ),  // 第1215行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_0            ),  // 第1216行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[0]                 ),  // 第1217行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1218行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1219行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1220行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1221行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1222行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1223行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1224行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1225行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1226行 - 
);  // 第1227行 - 
  // 第1228行 - 
  // 第1229行 - 
// &ConnRule(s/_x$/[1]/); @275  // 第1230行 - 
// &ConnRule(s/_v$/_1/); @276  // 第1231行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_1"); @277  // 第1232行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_1 (  // 第1233行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1234行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1235行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1236行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1237行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1238行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1239行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1240行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1241行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1242行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1243行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1244行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1245行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1246行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1247行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1248行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1249行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1250行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1251行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1252行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1253行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1254行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1255行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1256行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1257行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1258行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1259行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1260行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1261行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1262行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1263行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1264行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1265行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1266行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1267行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1268行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1269行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[1]     ),  // 第1270行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_1       ),  // 第1271行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[1]          ),  // 第1272行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[1]       ),  // 第1273行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[1]   ),  // 第1274行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[1]          ),  // 第1275行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[1]               ),  // 第1276行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[1] ),  // 第1277行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[1]),  // 第1278行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[1]              ),  // 第1279行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[1]         ),  // 第1280行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[1]       ),  // 第1281行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_1           ),  // 第1282行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_1               ),  // 第1283行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[1]         ),  // 第1284行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[1]       ),  // 第1285行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_1           ),  // 第1286行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_1               ),  // 第1287行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[1]     ),  // 第1288行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_1       ),  // 第1289行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[1]          ),  // 第1290行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_1            ),  // 第1291行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[1]                 ),  // 第1292行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1293行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1294行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1295行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1296行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1297行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1298行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1299行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1300行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1301行 - 
);  // 第1302行 - 
  // 第1303行 - 
  // 第1304行 - 
// &ConnRule(s/_x$/[2]/); @279  // 第1305行 - 
// &ConnRule(s/_v$/_2/); @280  // 第1306行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_2"); @281  // 第1307行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_2 (  // 第1308行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1309行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1310行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1311行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1312行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1313行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1314行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1315行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1316行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1317行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1318行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1319行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1320行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1321行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1322行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1323行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1324行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1325行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1326行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1327行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1328行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1329行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1330行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1331行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1332行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1333行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1334行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1335行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1336行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1337行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1338行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1339行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1340行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1341行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1342行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1343行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1344行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[2]     ),  // 第1345行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_2       ),  // 第1346行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[2]          ),  // 第1347行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[2]       ),  // 第1348行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[2]   ),  // 第1349行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[2]          ),  // 第1350行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[2]               ),  // 第1351行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[2] ),  // 第1352行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[2]),  // 第1353行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[2]              ),  // 第1354行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[2]         ),  // 第1355行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[2]       ),  // 第1356行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_2           ),  // 第1357行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_2               ),  // 第1358行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[2]         ),  // 第1359行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[2]       ),  // 第1360行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_2           ),  // 第1361行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_2               ),  // 第1362行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[2]     ),  // 第1363行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_2       ),  // 第1364行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[2]          ),  // 第1365行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_2            ),  // 第1366行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[2]                 ),  // 第1367行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1368行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1369行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1370行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1371行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1372行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1373行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1374行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1375行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1376行 - 
);  // 第1377行 - 
  // 第1378行 - 
  // 第1379行 - 
// &ConnRule(s/_x$/[3]/); @283  // 第1380行 - 
// &ConnRule(s/_v$/_3/); @284  // 第1381行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_3"); @285  // 第1382行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_3 (  // 第1383行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1384行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1385行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1386行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1387行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1388行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1389行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1390行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1391行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1392行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1393行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1394行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1395行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1396行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1397行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1398行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1399行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1400行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1401行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1402行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1403行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1404行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1405行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1406行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1407行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1408行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1409行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1410行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1411行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1412行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1413行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1414行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1415行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1416行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1417行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1418行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1419行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[3]     ),  // 第1420行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_3       ),  // 第1421行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[3]          ),  // 第1422行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[3]       ),  // 第1423行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[3]   ),  // 第1424行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[3]          ),  // 第1425行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[3]               ),  // 第1426行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[3] ),  // 第1427行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[3]),  // 第1428行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[3]              ),  // 第1429行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[3]         ),  // 第1430行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[3]       ),  // 第1431行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_3           ),  // 第1432行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_3               ),  // 第1433行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[3]         ),  // 第1434行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[3]       ),  // 第1435行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_3           ),  // 第1436行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_3               ),  // 第1437行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[3]     ),  // 第1438行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_3       ),  // 第1439行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[3]          ),  // 第1440行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_3            ),  // 第1441行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[3]                 ),  // 第1442行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1443行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1444行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1445行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1446行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1447行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1448行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1449行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1450行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1451行 - 
);  // 第1452行 - 
  // 第1453行 - 
  // 第1454行 - 
// &ConnRule(s/_x$/[4]/); @287  // 第1455行 - 
// &ConnRule(s/_v$/_4/); @288  // 第1456行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_4"); @289  // 第1457行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_4 (  // 第1458行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1459行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1460行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1461行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1462行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1463行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1464行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1465行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1466行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1467行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1468行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1469行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1470行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1471行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1472行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1473行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1474行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1475行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1476行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1477行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1478行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1479行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1480行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1481行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1482行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1483行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1484行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1485行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1486行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1487行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1488行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1489行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1490行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1491行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1492行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1493行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1494行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[4]     ),  // 第1495行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_4       ),  // 第1496行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[4]          ),  // 第1497行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[4]       ),  // 第1498行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[4]   ),  // 第1499行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[4]          ),  // 第1500行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[4]               ),  // 第1501行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[4] ),  // 第1502行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[4]),  // 第1503行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[4]              ),  // 第1504行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[4]         ),  // 第1505行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[4]       ),  // 第1506行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_4           ),  // 第1507行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_4               ),  // 第1508行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[4]         ),  // 第1509行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[4]       ),  // 第1510行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_4           ),  // 第1511行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_4               ),  // 第1512行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[4]     ),  // 第1513行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_4       ),  // 第1514行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[4]          ),  // 第1515行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_4            ),  // 第1516行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[4]                 ),  // 第1517行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1518行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1519行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1520行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1521行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1522行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1523行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1524行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1525行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1526行 - 
);  // 第1527行 - 
  // 第1528行 - 
  // 第1529行 - 
// &ConnRule(s/_x$/[5]/); @291  // 第1530行 - 
// &ConnRule(s/_v$/_5/); @292  // 第1531行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_5"); @293  // 第1532行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_5 (  // 第1533行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1534行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1535行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1536行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1537行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1538行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1539行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1540行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1541行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1542行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1543行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1544行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1545行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1546行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1547行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1548行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1549行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1550行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1551行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1552行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1553行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1554行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1555行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1556行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1557行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1558行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1559行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1560行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1561行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1562行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1563行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1564行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1565行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1566行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1567行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1568行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1569行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[5]     ),  // 第1570行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_5       ),  // 第1571行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[5]          ),  // 第1572行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[5]       ),  // 第1573行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[5]   ),  // 第1574行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[5]          ),  // 第1575行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[5]               ),  // 第1576行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[5] ),  // 第1577行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[5]),  // 第1578行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[5]              ),  // 第1579行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[5]         ),  // 第1580行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[5]       ),  // 第1581行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_5           ),  // 第1582行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_5               ),  // 第1583行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[5]         ),  // 第1584行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[5]       ),  // 第1585行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_5           ),  // 第1586行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_5               ),  // 第1587行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[5]     ),  // 第1588行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_5       ),  // 第1589行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[5]          ),  // 第1590行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_5            ),  // 第1591行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[5]                 ),  // 第1592行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1593行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1594行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1595行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1596行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1597行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1598行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1599行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1600行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1601行 - 
);  // 第1602行 - 
  // 第1603行 - 
  // 第1604行 - 
// &ConnRule(s/_x$/[6]/); @295  // 第1605行 - 
// &ConnRule(s/_v$/_6/); @296  // 第1606行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_6"); @297  // 第1607行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_6 (  // 第1608行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1609行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1610行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1611行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1612行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1613行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1614行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1615行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1616行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1617行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1618行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1619行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1620行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1621行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1622行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1623行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1624行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1625行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1626行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1627行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1628行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1629行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1630行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1631行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1632行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1633行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1634行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1635行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1636行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1637行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1638行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1639行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1640行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1641行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1642行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1643行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1644行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[6]     ),  // 第1645行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_6       ),  // 第1646行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[6]          ),  // 第1647行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[6]       ),  // 第1648行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[6]   ),  // 第1649行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[6]          ),  // 第1650行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[6]               ),  // 第1651行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[6] ),  // 第1652行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[6]),  // 第1653行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[6]              ),  // 第1654行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[6]         ),  // 第1655行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[6]       ),  // 第1656行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_6           ),  // 第1657行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_6               ),  // 第1658行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[6]         ),  // 第1659行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[6]       ),  // 第1660行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_6           ),  // 第1661行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_6               ),  // 第1662行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[6]     ),  // 第1663行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_6       ),  // 第1664行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[6]          ),  // 第1665行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_6            ),  // 第1666行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[6]                 ),  // 第1667行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1668行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1669行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1670行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1671行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1672行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1673行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1674行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1675行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1676行 - 
);  // 第1677行 - 
  // 第1678行 - 
  // 第1679行 - 
// &ConnRule(s/_x$/[7]/); @299  // 第1680行 - 
// &ConnRule(s/_v$/_7/); @300  // 第1681行 - 
// &Instance("ct_lsu_pfu_pfb_entry","x_ct_lsu_pfu_pfb_entry_7"); @301  // 第1682行 - 
ct_lsu_pfu_pfb_entry  x_ct_lsu_pfu_pfb_entry_7 (  // 第1683行 - 
  .amr_wa_cancel                         (amr_wa_cancel                        ),  // 第1684行 - 
  .cp0_lsu_icg_en                        (cp0_lsu_icg_en                       ),  // 第1685行 - 
  .cp0_lsu_l2_st_pref_en                 (cp0_lsu_l2_st_pref_en                ),  // 第1686行 - 
  .cp0_lsu_pfu_mmu_dis                   (cp0_lsu_pfu_mmu_dis                  ),  // 第1687行 - 
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),  // 第1688行 - 
  .cp0_yy_priv_mode                      (cp0_yy_priv_mode                     ),  // 第1689行 - 
  .cpurst_b                              (cpurst_b                             ),  // 第1690行 - 
  .ld_da_ldfifo_pc                       (ld_da_ldfifo_pc                      ),  // 第1691行 - 
  .ld_da_page_sec_ff                     (ld_da_page_sec_ff                    ),  // 第1692行 - 
  .ld_da_page_share_ff                   (ld_da_page_share_ff                  ),  // 第1693行 - 
  .ld_da_pfu_act_dp_vld                  (ld_da_pfu_act_dp_vld                 ),  // 第1694行 - 
  .ld_da_pfu_act_vld                     (ld_da_pfu_act_vld                    ),  // 第1695行 - 
  .ld_da_pfu_evict_cnt_vld               (ld_da_pfu_evict_cnt_vld              ),  // 第1696行 - 
  .ld_da_pfu_pf_inst_vld                 (ld_da_pfu_pf_inst_vld                ),  // 第1697行 - 
  .ld_da_ppfu_va                         (ld_da_ppfu_va                        ),  // 第1698行 - 
  .ld_da_ppn_ff                          (ld_da_ppn_ff                         ),  // 第1699行 - 
  .lsu_pfu_l1_dist_sel                   (lsu_pfu_l1_dist_sel                  ),  // 第1700行 - 
  .lsu_pfu_l2_dist_sel                   (lsu_pfu_l2_dist_sel                  ),  // 第1701行 - 
  .lsu_special_clk                       (lsu_special_clk                      ),  // 第1702行 - 
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),  // 第1703行 - 
  .pfb_no_req_cnt_val                    (pfb_no_req_cnt_val                   ),  // 第1704行 - 
  .pfb_timeout_cnt_val                   (pfb_timeout_cnt_val                  ),  // 第1705行 - 
  .pfu_biu_pe_req_sel_l1                 (pfu_biu_pe_req_sel_l1                ),  // 第1706行 - 
  .pfu_dcache_pref_en                    (pfu_dcache_pref_en                   ),  // 第1707行 - 
  .pfu_get_page_sec                      (pfu_get_page_sec                     ),  // 第1708行 - 
  .pfu_get_page_share                    (pfu_get_page_share                   ),  // 第1709行 - 
  .pfu_get_ppn                           (pfu_get_ppn                          ),  // 第1710行 - 
  .pfu_get_ppn_err                       (pfu_get_ppn_err                      ),  // 第1711行 - 
  .pfu_get_ppn_vld                       (pfu_get_ppn_vld                      ),  // 第1712行 - 
  .pfu_l2_pref_en                        (pfu_l2_pref_en                       ),  // 第1713行 - 
  .pfu_mmu_pe_req_sel_l1                 (pfu_mmu_pe_req_sel_l1                ),  // 第1714行 - 
  .pfu_pfb_create_pc                     (pfu_pfb_create_pc                    ),  // 第1715行 - 
  .pfu_pfb_create_stride                 (pfu_pfb_create_stride                ),  // 第1716行 - 
  .pfu_pfb_create_stride_neg             (pfu_pfb_create_stride_neg            ),  // 第1717行 - 
  .pfu_pfb_create_strideh_6to0           (pfu_pfb_create_strideh_6to0          ),  // 第1718行 - 
  .pfu_pfb_create_type_ld                (pfu_pfb_create_type_ld               ),  // 第1719行 - 
  .pfu_pfb_entry_biu_pe_req_grnt_x       (pfu_pfb_entry_biu_pe_req_grnt[7]     ),  // 第1720行 - 
  .pfu_pfb_entry_biu_pe_req_src_v        (pfu_pfb_entry_biu_pe_req_src_7       ),  // 第1721行 - 
  .pfu_pfb_entry_biu_pe_req_x            (pfu_pfb_entry_biu_pe_req[7]          ),  // 第1722行 - 
  .pfu_pfb_entry_create_dp_vld_x         (pfu_pfb_entry_create_dp_vld[7]       ),  // 第1723行 - 
  .pfu_pfb_entry_create_gateclk_en_x     (pfu_pfb_entry_create_gateclk_en[7]   ),  // 第1724行 - 
  .pfu_pfb_entry_create_vld_x            (pfu_pfb_entry_create_vld[7]          ),  // 第1725行 - 
  .pfu_pfb_entry_evict_x                 (pfu_pfb_entry_evict[7]               ),  // 第1726行 - 
  .pfu_pfb_entry_from_lfb_dcache_hit_x   (pfu_pfb_entry_from_lfb_dcache_hit[7] ),  // 第1727行 - 
  .pfu_pfb_entry_from_lfb_dcache_miss_x  (pfu_pfb_entry_from_lfb_dcache_miss[7]),  // 第1728行 - 
  .pfu_pfb_entry_hit_pc_x                (pfu_pfb_entry_hit_pc[7]              ),  // 第1729行 - 
  .pfu_pfb_entry_l1_page_sec_x           (pfu_pfb_entry_l1_page_sec[7]         ),  // 第1730行 - 
  .pfu_pfb_entry_l1_page_share_x         (pfu_pfb_entry_l1_page_share[7]       ),  // 第1731行 - 
  .pfu_pfb_entry_l1_pf_addr_v            (pfu_pfb_entry_l1_pf_addr_7           ),  // 第1732行 - 
  .pfu_pfb_entry_l1_vpn_v                (pfu_pfb_entry_l1_vpn_7               ),  // 第1733行 - 
  .pfu_pfb_entry_l2_page_sec_x           (pfu_pfb_entry_l2_page_sec[7]         ),  // 第1734行 - 
  .pfu_pfb_entry_l2_page_share_x         (pfu_pfb_entry_l2_page_share[7]       ),  // 第1735行 - 
  .pfu_pfb_entry_l2_pf_addr_v            (pfu_pfb_entry_l2_pf_addr_7           ),  // 第1736行 - 
  .pfu_pfb_entry_l2_vpn_v                (pfu_pfb_entry_l2_vpn_7               ),  // 第1737行 - 
  .pfu_pfb_entry_mmu_pe_req_grnt_x       (pfu_pfb_entry_mmu_pe_req_grnt[7]     ),  // 第1738行 - 
  .pfu_pfb_entry_mmu_pe_req_src_v        (pfu_pfb_entry_mmu_pe_req_src_7       ),  // 第1739行 - 
  .pfu_pfb_entry_mmu_pe_req_x            (pfu_pfb_entry_mmu_pe_req[7]          ),  // 第1740行 - 
  .pfu_pfb_entry_priv_mode_v             (pfu_pfb_entry_priv_mode_7            ),  // 第1741行 - 
  .pfu_pfb_entry_vld_x                   (pfu_pfb_entry_vld[7]                 ),  // 第1742行 - 
  .pfu_pop_all_part_vld                  (pfu_pop_all_part_vld                 ),  // 第1743行 - 
  .st_da_page_sec_ff                     (st_da_page_sec_ff                    ),  // 第1744行 - 
  .st_da_page_share_ff                   (st_da_page_share_ff                  ),  // 第1745行 - 
  .st_da_pc                              (st_da_pc                             ),  // 第1746行 - 
  .st_da_pfu_act_vld                     (st_da_pfu_act_vld                    ),  // 第1747行 - 
  .st_da_pfu_evict_cnt_vld               (st_da_pfu_evict_cnt_vld              ),  // 第1748行 - 
  .st_da_pfu_pf_inst_vld                 (st_da_pfu_pf_inst_vld                ),  // 第1749行 - 
  .st_da_ppfu_va                         (st_da_ppfu_va                        ),  // 第1750行 - 
  .st_da_ppn_ff                          (st_da_ppn_ff                         )  // 第1751行 - 
);  // 第1752行 - 
  // 第1753行 - 
  // 第1754行 - 
//==========================================================  // 第1755行 - 
//            Generate full/create signal of pfb  // 第1756行 - 
//==========================================================  // 第1757行 - 
//------------------pop pointer of sdb----------------------  // 第1758行 - 
// &CombBeg; @307  // 第1759行 - 
always @( pfu_sdb_entry_ready[1:0])  // 第1760行 - 
begin  // 第1761行 - 
pfu_sdb_pop_ptr[SDB_ENTRY-1:0]  = {SDB_ENTRY{1'b0}};  // 第1762行 - 
casez(pfu_sdb_entry_ready[SDB_ENTRY-1:0])  // 第1763行 - 
  2'b?1:pfu_sdb_pop_ptr[0]  = 1'b1;  // 第1764行 - 
  2'b10:pfu_sdb_pop_ptr[1]  = 1'b1;  // 第1765行 - 
  default:pfu_sdb_pop_ptr[SDB_ENTRY-1:0]  = {SDB_ENTRY{1'b0}};  // 第1766行 - 
endcase  // 第1767行 - 
// &CombEnd; @314  // 第1768行 - 
end  // 第1769行 - 
  // 第1770行 - 
//-------------------create info of pfb---------------------  // 第1771行 - 
assign pfu_pfb_create_pc[PC_LEN-1:0]    = {PC_LEN{pfu_sdb_pop_ptr[0]}}  & pfu_sdb_entry_pc_0[PC_LEN-1:0]  // 第1772行 - 
                                          | {PC_LEN{pfu_sdb_pop_ptr[1]}}  & pfu_sdb_entry_pc_1[PC_LEN-1:0];  // 第1773行 - 
assign pfu_pfb_create_stride[10:0]      = {11{pfu_sdb_pop_ptr[0]}}  & pfu_sdb_entry_stride_0[10:0]  // 第1774行 - 
                                          | {11{pfu_sdb_pop_ptr[1]}}  & pfu_sdb_entry_stride_1[10:0];  // 第1775行 - 
assign pfu_pfb_create_strideh_6to0[6:0] = {7{pfu_sdb_pop_ptr[0]}} & pfu_sdb_entry_strideh_6to0_0[6:0]  // 第1776行 - 
                                          | {7{pfu_sdb_pop_ptr[1]}} & pfu_sdb_entry_strideh_6to0_1[6:0];  // 第1777行 - 
assign pfu_pfb_create_stride_neg        = |(pfu_sdb_pop_ptr[SDB_ENTRY-1:0]  // 第1778行 - 
                                            & pfu_sdb_entry_stride_neg[SDB_ENTRY-1:0]);  // 第1779行 - 
assign pfu_pfb_create_type_ld           = |(pfu_sdb_pop_ptr[SDB_ENTRY-1:0]  // 第1780行 - 
                                            & pfu_sdb_entry_type_ld[SDB_ENTRY-1:0]);  // 第1781行 - 
  // 第1782行 - 
//---------------------create pointer-----------------------  // 第1783行 - 
//if it has empty entry, then create signal to empty entry,  // 第1784行 - 
//else create siganl to evict entry,  // 第1785行 - 
//else create fail  // 第1786行 - 
// &CombBeg; @332  // 第1787行 - 
always @( pfu_pfb_entry_vld[7:0])  // 第1788行 - 
begin  // 第1789行 - 
pfu_pfb_empty_create_ptr[PFB_ENTRY-1:0]   = {PFB_ENTRY{1'b0}};  // 第1790行 - 
casez(pfu_pfb_entry_vld[PFB_ENTRY-1:0])  // 第1791行 - 
  8'b????_???0:pfu_pfb_empty_create_ptr[0]  = 1'b1;  // 第1792行 - 
  8'b????_??01:pfu_pfb_empty_create_ptr[1]  = 1'b1;  // 第1793行 - 
  8'b????_?011:pfu_pfb_empty_create_ptr[2]  = 1'b1;  // 第1794行 - 
  8'b????_0111:pfu_pfb_empty_create_ptr[3]  = 1'b1;  // 第1795行 - 
  8'b???0_1111:pfu_pfb_empty_create_ptr[4]  = 1'b1;  // 第1796行 - 
  8'b??01_1111:pfu_pfb_empty_create_ptr[5]  = 1'b1;  // 第1797行 - 
  8'b?011_1111:pfu_pfb_empty_create_ptr[6]  = 1'b1;  // 第1798行 - 
  8'b0111_1111:pfu_pfb_empty_create_ptr[7]  = 1'b1;  // 第1799行 - 
  default:pfu_pfb_empty_create_ptr[PFB_ENTRY-1:0]   = {PFB_ENTRY{1'b0}};  // 第1800行 - 
endcase  // 第1801行 - 
// &CombEnd; @345  // 第1802行 - 
end  // 第1803行 - 
  // 第1804行 - 
// &CombBeg; @347  // 第1805行 - 
always @( pfu_pfb_entry_evict[7:0])  // 第1806行 - 
begin  // 第1807行 - 
pfu_pfb_evict_create_ptr[PFB_ENTRY-1:0]  = {PFB_ENTRY{1'b0}};  // 第1808行 - 
casez(pfu_pfb_entry_evict[PFB_ENTRY-1:0])  // 第1809行 - 
  8'b????_???1:pfu_pfb_evict_create_ptr[0]  = 1'b1;  // 第1810行 - 
  8'b????_??10:pfu_pfb_evict_create_ptr[1]  = 1'b1;  // 第1811行 - 
  8'b????_?100:pfu_pfb_evict_create_ptr[2]  = 1'b1;  // 第1812行 - 
  8'b????_1000:pfu_pfb_evict_create_ptr[3]  = 1'b1;  // 第1813行 - 
  8'b???1_0000:pfu_pfb_evict_create_ptr[4]  = 1'b1;  // 第1814行 - 
  8'b??10_0000:pfu_pfb_evict_create_ptr[5]  = 1'b1;  // 第1815行 - 
  8'b?100_0000:pfu_pfb_evict_create_ptr[6]  = 1'b1;  // 第1816行 - 
  8'b1000_0000:pfu_pfb_evict_create_ptr[7]  = 1'b1;  // 第1817行 - 
  default:pfu_pfb_evict_create_ptr[PFB_ENTRY-1:0]  = {PFB_ENTRY{1'b0}};  // 第1818行 - 
endcase  // 第1819行 - 
// &CombEnd; @360  // 第1820行 - 
end  // 第1821行 - 
  // 第1822行 - 
assign pfu_pfb_full       = &pfu_pfb_entry_vld[PFB_ENTRY-1:0];  // 第1823行 - 
assign pfu_pfb_has_evict  = |pfu_pfb_entry_evict[PFB_ENTRY-1:0];  // 第1824行 - 
assign pfu_pfb_create_ptr[PFB_ENTRY-1:0]  = pfu_pfb_full  // 第1825行 - 
                                            ? pfu_pfb_evict_create_ptr[PFB_ENTRY-1:0]  // 第1826行 - 
                                            : pfu_pfb_empty_create_ptr[PFB_ENTRY-1:0];  // 第1827行 - 
  // 第1828行 - 
//-------------------grnt signal of pmb---------------------  // 第1829行 - 
assign pfu_sdb_ready_grnt         = !pfu_pfb_full  // 第1830行 - 
                                    ||  pfu_pfb_has_evict;  // 第1831行 - 
assign pfu_sdb_entry_ready_grnt[SDB_ENTRY-1:0]  = {SDB_ENTRY{pfu_sdb_ready_grnt}}  // 第1832行 - 
                                                  & pfu_sdb_pop_ptr[SDB_ENTRY-1:0];  // 第1833行 - 
  // 第1834行 - 
//------------------create signal of sdb--------------------  // 第1835行 - 
assign pfu_pfb_create_vld         = |pfu_sdb_entry_ready[SDB_ENTRY-1:0];  // 第1836行 - 
assign pfu_pfb_create_dp_vld      = pfu_pfb_create_vld;  // 第1837行 - 
assign pfu_pfb_create_gateclk_en  = pfu_pfb_create_dp_vld;  // 第1838行 - 
  // 第1839行 - 
assign pfu_pfb_entry_create_vld[PFB_ENTRY-1:0]          = {PFB_ENTRY{pfu_pfb_create_vld}}  // 第1840行 - 
                                                          & pfu_pfb_create_ptr[PFB_ENTRY-1:0];  // 第1841行 - 
assign pfu_pfb_entry_create_dp_vld[PFB_ENTRY-1:0]       = {PFB_ENTRY{pfu_pfb_create_dp_vld}}  // 第1842行 - 
                                                          & pfu_pfb_create_ptr[PFB_ENTRY-1:0];  // 第1843行 - 
assign pfu_pfb_entry_create_gateclk_en[PFB_ENTRY-1:0]  = {PFB_ENTRY{pfu_pfb_create_gateclk_en}}  // 第1844行 - 
                                                          & pfu_pfb_create_ptr[PFB_ENTRY-1:0];  // 第1845行 - 
  // 第1846行 - 
//==========================================================  // 第1847行 - 
//                      Global PFU  // 第1848行 - 
//==========================================================  // 第1849行 - 
// &Instance("ct_lsu_pfu_gsdb","x_ct_lsu_pfu_gsdb"); @389  // 第1850行 - 
ct_lsu_pfu_gsdb  x_ct_lsu_pfu_gsdb (  // 第1851行 - 
  .cp0_lsu_icg_en           (cp0_lsu_icg_en          ),  // 第1852行 - 
  .cp0_yy_clk_en            (cp0_yy_clk_en           ),  // 第1853行 - 
  .cp0_yy_dcache_pref_en    (cp0_yy_dcache_pref_en   ),  // 第1854行 - 
  .cpurst_b                 (cpurst_b                ),  // 第1855行 - 
  .forever_cpuclk           (forever_cpuclk          ),  // 第1856行 - 
  .ld_da_iid                (ld_da_iid               ),  // 第1857行 - 
  .ld_da_pfu_act_vld        (ld_da_pfu_act_vld       ),  // 第1858行 - 
  .ld_da_pfu_pf_inst_vld    (ld_da_pfu_pf_inst_vld   ),  // 第1859行 - 
  .ld_da_pfu_va             (ld_da_pfu_va            ),  // 第1860行 - 
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),  // 第1861行 - 
  .pfu_gpfb_vld             (pfu_gpfb_vld            ),  // 第1862行 - 
  .pfu_gsdb_gpfb_create_vld (pfu_gsdb_gpfb_create_vld),  // 第1863行 - 
  .pfu_gsdb_gpfb_pop_req    (pfu_gsdb_gpfb_pop_req   ),  // 第1864行 - 
  .pfu_gsdb_stride          (pfu_gsdb_stride         ),  // 第1865行 - 
  .pfu_gsdb_stride_neg      (pfu_gsdb_stride_neg     ),  // 第1866行 - 
  .pfu_gsdb_strideh_6to0    (pfu_gsdb_strideh_6to0   ),  // 第1867行 - 
  .pfu_pop_all_vld          (pfu_pop_all_vld         ),  // 第1868行 - 
  .rtu_yy_xx_commit0        (rtu_yy_xx_commit0       ),  // 第1869行 - 
  .rtu_yy_xx_commit0_iid    (rtu_yy_xx_commit0_iid   ),  // 第1870行 - 
  .rtu_yy_xx_commit1        (rtu_yy_xx_commit1       ),  // 第1871行 - 
  .rtu_yy_xx_commit1_iid    (rtu_yy_xx_commit1_iid   ),  // 第1872行 - 
  .rtu_yy_xx_commit2        (rtu_yy_xx_commit2       ),  // 第1873行 - 
  .rtu_yy_xx_commit2_iid    (rtu_yy_xx_commit2_iid   ),  // 第1874行 - 
  .rtu_yy_xx_flush          (rtu_yy_xx_flush         )  // 第1875行 - 
);  // 第1876行 - 
  // 第1877行 - 
  // 第1878行 - 
// &Instance("ct_lsu_pfu_gpfb","x_ct_lsu_pfu_gpfb"); @391  // 第1879行 - 
ct_lsu_pfu_gpfb  x_ct_lsu_pfu_gpfb (  // 第1880行 - 
  .cp0_lsu_icg_en                (cp0_lsu_icg_en               ),  // 第1881行 - 
  .cp0_lsu_pfu_mmu_dis           (cp0_lsu_pfu_mmu_dis          ),  // 第1882行 - 
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),  // 第1883行 - 
  .cp0_yy_priv_mode              (cp0_yy_priv_mode             ),  // 第1884行 - 
  .cpurst_b                      (cpurst_b                     ),  // 第1885行 - 
  .forever_cpuclk                (forever_cpuclk               ),  // 第1886行 - 
  .ld_da_page_sec_ff             (ld_da_page_sec_ff            ),  // 第1887行 - 
  .ld_da_page_share_ff           (ld_da_page_share_ff          ),  // 第1888行 - 
  .ld_da_pfu_act_vld             (ld_da_pfu_act_vld            ),  // 第1889行 - 
  .ld_da_pfu_pf_inst_vld         (ld_da_pfu_pf_inst_vld        ),  // 第1890行 - 
  .ld_da_pfu_va                  (ld_da_pfu_va                 ),  // 第1891行 - 
  .ld_da_ppn_ff                  (ld_da_ppn_ff                 ),  // 第1892行 - 
  .lsu_pfu_l1_dist_sel           (lsu_pfu_l1_dist_sel          ),  // 第1893行 - 
  .lsu_pfu_l2_dist_sel           (lsu_pfu_l2_dist_sel          ),  // 第1894行 - 
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),  // 第1895行 - 
  .pfu_biu_pe_req_sel_l1         (pfu_biu_pe_req_sel_l1        ),  // 第1896行 - 
  .pfu_dcache_pref_en            (pfu_dcache_pref_en           ),  // 第1897行 - 
  .pfu_get_page_sec              (pfu_get_page_sec             ),  // 第1898行 - 
  .pfu_get_page_share            (pfu_get_page_share           ),  // 第1899行 - 
  .pfu_get_ppn                   (pfu_get_ppn                  ),  // 第1900行 - 
  .pfu_get_ppn_err               (pfu_get_ppn_err              ),  // 第1901行 - 
  .pfu_get_ppn_vld               (pfu_get_ppn_vld              ),  // 第1902行 - 
  .pfu_gpfb_biu_pe_req           (pfu_gpfb_biu_pe_req          ),  // 第1903行 - 
  .pfu_gpfb_biu_pe_req_grnt      (pfu_gpfb_biu_pe_req_grnt     ),  // 第1904行 - 
  .pfu_gpfb_biu_pe_req_src       (pfu_gpfb_biu_pe_req_src      ),  // 第1905行 - 
  .pfu_gpfb_from_lfb_dcache_hit  (pfu_gpfb_from_lfb_dcache_hit ),  // 第1906行 - 
  .pfu_gpfb_from_lfb_dcache_miss (pfu_gpfb_from_lfb_dcache_miss),  // 第1907行 - 
  .pfu_gpfb_l1_page_sec          (pfu_gpfb_l1_page_sec         ),  // 第1908行 - 
  .pfu_gpfb_l1_page_share        (pfu_gpfb_l1_page_share       ),  // 第1909行 - 
  .pfu_gpfb_l1_pf_addr           (pfu_gpfb_l1_pf_addr          ),  // 第1910行 - 
  .pfu_gpfb_l1_vpn               (pfu_gpfb_l1_vpn              ),  // 第1911行 - 
  .pfu_gpfb_l2_page_sec          (pfu_gpfb_l2_page_sec         ),  // 第1912行 - 
  .pfu_gpfb_l2_page_share        (pfu_gpfb_l2_page_share       ),  // 第1913行 - 
  .pfu_gpfb_l2_pf_addr           (pfu_gpfb_l2_pf_addr          ),  // 第1914行 - 
  .pfu_gpfb_l2_vpn               (pfu_gpfb_l2_vpn              ),  // 第1915行 - 
  .pfu_gpfb_mmu_pe_req           (pfu_gpfb_mmu_pe_req          ),  // 第1916行 - 
  .pfu_gpfb_mmu_pe_req_grnt      (pfu_gpfb_mmu_pe_req_grnt     ),  // 第1917行 - 
  .pfu_gpfb_mmu_pe_req_src       (pfu_gpfb_mmu_pe_req_src      ),  // 第1918行 - 
  .pfu_gpfb_priv_mode            (pfu_gpfb_priv_mode           ),  // 第1919行 - 
  .pfu_gpfb_vld                  (pfu_gpfb_vld                 ),  // 第1920行 - 
  .pfu_gsdb_gpfb_create_vld      (pfu_gsdb_gpfb_create_vld     ),  // 第1921行 - 
  .pfu_gsdb_gpfb_pop_req         (pfu_gsdb_gpfb_pop_req        ),  // 第1922行 - 
  .pfu_gsdb_stride               (pfu_gsdb_stride              ),  // 第1923行 - 
  .pfu_gsdb_stride_neg           (pfu_gsdb_stride_neg          ),  // 第1924行 - 
  .pfu_gsdb_strideh_6to0         (pfu_gsdb_strideh_6to0        ),  // 第1925行 - 
  .pfu_l2_pref_en                (pfu_l2_pref_en               ),  // 第1926行 - 
  .pfu_mmu_pe_req_sel_l1         (pfu_mmu_pe_req_sel_l1        ),  // 第1927行 - 
  .pfu_pop_all_vld               (pfu_pop_all_vld              )  // 第1928行 - 
);  // 第1929行 - 
  // 第1930行 - 
  // 第1931行 - 
//==========================================================  // 第1932行 - 
//          Instance mmu pop entry and logic  // 第1933行 - 
//==========================================================  // 第1934行 - 
//----------------------registers---------------------------  // 第1935行 - 
//+-----+-----+----+  // 第1936行 - 
//| req | vpn | id |  // 第1937行 - 
//+-----+-----+----+  // 第1938行 - 
always @(posedge pfu_mmu_pe_clk or negedge cpurst_b)  // 第1939行 - 
begin  // 第1940行 - 
  if (!cpurst_b)  // 第1941行 - 
    pfu_mmu_req               <=  1'b0;  // 第1942行 - 
  else if(pfu_pop_all_vld)  // 第1943行 - 
    pfu_mmu_req               <=  1'b0;  // 第1944行 - 
  else if(pfu_mmu_pe_update_permit  &&  pfu_mmu_pe_req)  // 第1945行 - 
    pfu_mmu_req               <=  1'b1;  // 第1946行 - 
  else if(pfu_get_ppn_vld)  // 第1947行 - 
    pfu_mmu_req               <=  1'b0;  // 第1948行 - 
end  // 第1949行 - 
  // 第1950行 - 
// &Force("nonport","pfu_mmu_req_l1"); @412  // 第1951行 - 
// &Force("nonport","pfu_mmu_req_ptr"); @413  // 第1952行 - 
always @(posedge pfu_mmu_pe_clk or negedge cpurst_b)  // 第1953行 - 
begin  // 第1954行 - 
  if (!cpurst_b)  // 第1955行 - 
  begin  // 第1956行 - 
    pfu_mmu_req_l1                  <=  1'b0;  // 第1957行 - 
    pfu_mmu_req_ptr[PFB_ENTRY:0]    <=  {PFB_ENTRY+1{1'b0}};  // 第1958行 - 
    pfu_mmu_req_vpn[`PA_WIDTH-13:0] <=  {`PA_WIDTH-12{1'b0}};  // 第1959行 - 
  end  // 第1960行 - 
  else if(pfu_mmu_pe_update_permit &&  pfu_mmu_pe_req)  // 第1961行 - 
  begin  // 第1962行 - 
    pfu_mmu_req_l1                  <=  pfu_mmu_pe_req_sel_l1;  // 第1963行 - 
    pfu_mmu_req_ptr[PFB_ENTRY:0]    <=  pfu_mmu_pe_req_ptr[PFB_ENTRY:0];  // 第1964行 - 
    pfu_mmu_req_vpn[`PA_WIDTH-13:0] <=  pfu_mmu_pe_req_vpn[`PA_WIDTH-13:0];  // 第1965行 - 
  end  // 第1966行 - 
end  // 第1967行 - 
  // 第1968行 - 
//---------------------update signal------------------------  // 第1969行 - 
assign pfu_all_pfb_mmu_pe_req[PFB_ENTRY:0]  = {pfu_gpfb_mmu_pe_req,  // 第1970行 - 
                                              pfu_pfb_entry_mmu_pe_req[PFB_ENTRY-1:0]};  // 第1971行 - 
assign pfu_mmu_pe_req       = |pfu_all_pfb_mmu_pe_req[PFB_ENTRY:0];  // 第1972行 - 
  // 第1973行 - 
assign pfu_mmu_pe_update_permit = !pfu_mmu_req  // 第1974行 - 
                                  ||  pfu_get_ppn_vld;  // 第1975行 - 
  // 第1976行 - 
  // 第1977行 - 
//---------------------grnt and resp signal-----------------  // 第1978行 - 
assign pfu_pfb_entry_mmu_pe_req_grnt[PFB_ENTRY-1:0] =  // 第1979行 - 
                {PFB_ENTRY{pfu_mmu_pe_update_permit}}  // 第1980行 - 
                & pfu_mmu_pe_req_ptr[PFB_ENTRY-1:0];  // 第1981行 - 
assign pfu_gpfb_mmu_pe_req_grnt = pfu_mmu_pe_update_permit  &&  pfu_mmu_pe_req_ptr[8];  // 第1982行 - 
  // 第1983行 - 
// &CombBeg; @445  // 第1984行 - 
always @( pfu_all_pfb_mmu_pe_req[8:0])  // 第1985行 - 
begin  // 第1986行 - 
pfu_mmu_pe_req_ptr[PFB_ENTRY:0] = {PFB_ENTRY+1{1'b0}};  // 第1987行 - 
casez(pfu_all_pfb_mmu_pe_req[PFB_ENTRY:0])  // 第1988行 - 
  9'b?_????_???1:pfu_mmu_pe_req_ptr[0]  = 1'b1;  // 第1989行 - 
  9'b?_????_??10:pfu_mmu_pe_req_ptr[1]  = 1'b1;  // 第1990行 - 
  9'b?_????_?100:pfu_mmu_pe_req_ptr[2]  = 1'b1;  // 第1991行 - 
  9'b?_????_1000:pfu_mmu_pe_req_ptr[3]  = 1'b1;  // 第1992行 - 
  9'b?_???1_0000:pfu_mmu_pe_req_ptr[4]  = 1'b1;  // 第1993行 - 
  9'b?_??10_0000:pfu_mmu_pe_req_ptr[5]  = 1'b1;  // 第1994行 - 
  9'b?_?100_0000:pfu_mmu_pe_req_ptr[6]  = 1'b1;  // 第1995行 - 
  9'b?_1000_0000:pfu_mmu_pe_req_ptr[7]  = 1'b1;  // 第1996行 - 
  9'b1_0000_0000:pfu_mmu_pe_req_ptr[8]  = 1'b1;  // 第1997行 - 
  default:pfu_mmu_pe_req_ptr[PFB_ENTRY:0] = {PFB_ENTRY+1{1'b0}};  // 第1998行 - 
endcase  // 第1999行 - 
// &CombEnd; @459  // 第2000行 - 
end  // 第2001行 - 
  // 第2002行 - 
  // 第2003行 - 
//------------sel info to pop entry---------------  // 第2004行 - 
assign pfu_mmu_l1_pe_req_vpn[`PA_WIDTH-13:0]  =  // 第2005行 - 
                {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[0]}} & pfu_pfb_entry_l1_vpn_0[`PA_WIDTH-13:0]  // 第2006行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[1]}} & pfu_pfb_entry_l1_vpn_1[`PA_WIDTH-13:0]  // 第2007行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[2]}} & pfu_pfb_entry_l1_vpn_2[`PA_WIDTH-13:0]  // 第2008行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[3]}} & pfu_pfb_entry_l1_vpn_3[`PA_WIDTH-13:0]  // 第2009行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[4]}} & pfu_pfb_entry_l1_vpn_4[`PA_WIDTH-13:0]  // 第2010行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[5]}} & pfu_pfb_entry_l1_vpn_5[`PA_WIDTH-13:0]  // 第2011行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[6]}} & pfu_pfb_entry_l1_vpn_6[`PA_WIDTH-13:0]  // 第2012行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[7]}} & pfu_pfb_entry_l1_vpn_7[`PA_WIDTH-13:0]  // 第2013行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[8]}} & pfu_gpfb_l1_vpn[`PA_WIDTH-13:0];  // 第2014行 - 
  // 第2015行 - 
assign pfu_mmu_l2_pe_req_vpn[`PA_WIDTH-13:0]  =  // 第2016行 - 
                {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[0]}} & pfu_pfb_entry_l2_vpn_0[`PA_WIDTH-13:0]  // 第2017行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[1]}} & pfu_pfb_entry_l2_vpn_1[`PA_WIDTH-13:0]  // 第2018行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[2]}} & pfu_pfb_entry_l2_vpn_2[`PA_WIDTH-13:0]  // 第2019行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[3]}} & pfu_pfb_entry_l2_vpn_3[`PA_WIDTH-13:0]  // 第2020行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[4]}} & pfu_pfb_entry_l2_vpn_4[`PA_WIDTH-13:0]  // 第2021行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[5]}} & pfu_pfb_entry_l2_vpn_5[`PA_WIDTH-13:0]  // 第2022行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[6]}} & pfu_pfb_entry_l2_vpn_6[`PA_WIDTH-13:0]  // 第2023行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[7]}} & pfu_pfb_entry_l2_vpn_7[`PA_WIDTH-13:0]  // 第2024行 - 
                | {`PA_WIDTH-12{pfu_mmu_pe_req_ptr[8]}} & pfu_gpfb_l2_vpn[`PA_WIDTH-13:0];  // 第2025行 - 
  // 第2026行 - 
assign pfu_mmu_pe_req_src[1:0]  = {2{pfu_mmu_pe_req_ptr[0]}}  & pfu_pfb_entry_mmu_pe_req_src_0[1:0]  // 第2027行 - 
                                  | {2{pfu_mmu_pe_req_ptr[1]}}  & pfu_pfb_entry_mmu_pe_req_src_1[1:0]  // 第2028行 - 
                                  | {2{pfu_mmu_pe_req_ptr[2]}}  & pfu_pfb_entry_mmu_pe_req_src_2[1:0]  // 第2029行 - 
                                  | {2{pfu_mmu_pe_req_ptr[3]}}  & pfu_pfb_entry_mmu_pe_req_src_3[1:0]  // 第2030行 - 
                                  | {2{pfu_mmu_pe_req_ptr[4]}}  & pfu_pfb_entry_mmu_pe_req_src_4[1:0]  // 第2031行 - 
                                  | {2{pfu_mmu_pe_req_ptr[5]}}  & pfu_pfb_entry_mmu_pe_req_src_5[1:0]  // 第2032行 - 
                                  | {2{pfu_mmu_pe_req_ptr[6]}}  & pfu_pfb_entry_mmu_pe_req_src_6[1:0]  // 第2033行 - 
                                  | {2{pfu_mmu_pe_req_ptr[7]}}  & pfu_pfb_entry_mmu_pe_req_src_7[1:0]  // 第2034行 - 
                                  | {2{pfu_mmu_pe_req_ptr[8]}}  & pfu_gpfb_mmu_pe_req_src[1:0];  // 第2035行 - 
  // 第2036行 - 
assign pfu_mmu_pe_req_sel_l1        = pfu_mmu_pe_req_src[0];  // 第2037行 - 
  // 第2038行 - 
assign pfu_mmu_pe_req_vpn[`PA_WIDTH-13:0] = pfu_mmu_pe_req_sel_l1  // 第2039行 - 
                                            ? pfu_mmu_l1_pe_req_vpn[`PA_WIDTH-13:0]  // 第2040行 - 
                                            : pfu_mmu_l2_pe_req_vpn[`PA_WIDTH-13:0];  // 第2041行 - 
  // 第2042行 - 
//------------------interface with mmu----------------------  // 第2043行 - 
assign lsu_mmu_va2_vld              = pfu_mmu_req;  // 第2044行 - 
assign lsu_mmu_va2[`PA_WIDTH-13:0]  = pfu_mmu_req_vpn[`PA_WIDTH-13:0];  // 第2045行 - 
assign pfu_get_ppn_vld              = mmu_lsu_pa2_vld;  // 第2046行 - 
assign pfu_get_ppn_err              = mmu_lsu_pa2_err;  // 第2047行 - 
assign pfu_get_ppn[`PA_WIDTH-13:0]  = mmu_lsu_pa2[`PA_WIDTH-13:0];  // 第2048行 - 
assign pfu_get_page_sec             = mmu_lsu_sec2;  // 第2049行 - 
assign pfu_get_page_share           = mmu_lsu_share2;  // 第2050行 - 
  // 第2051行 - 
//==========================================================  // 第2052行 - 
//          Instance biu pop entry and logic  // 第2053行 - 
//==========================================================  // 第2054行 - 
//----------------------registers---------------------------  // 第2055行 - 
//+-----+------+---------+----------+  // 第2056行 - 
//| req | addr | req_ptr | priority |  // 第2057行 - 
//+-----+------+---------+----------+  // 第2058行 - 
always @(posedge pfu_biu_pe_clk or negedge cpurst_b)  // 第2059行 - 
begin  // 第2060行 - 
  if (!cpurst_b)  // 第2061行 - 
    pfu_biu_req_unmask          <=  1'b0;  // 第2062行 - 
  else if(pfu_pop_all_vld)  // 第2063行 - 
    pfu_biu_req_unmask          <=  1'b0;  // 第2064行 - 
  else if(pfu_biu_pe_req_grnt)  // 第2065行 - 
    pfu_biu_req_unmask          <=  1'b1;  // 第2066行 - 
  else if(pfu_biu_req_grnt)  // 第2067行 - 
    pfu_biu_req_unmask          <=  1'b0;  // 第2068行 - 
end  // 第2069行 - 
  // 第2070行 - 
always @(posedge pfu_biu_pe_clk or negedge cpurst_b)  // 第2071行 - 
begin  // 第2072行 - 
  if (!cpurst_b)  // 第2073行 - 
  begin  // 第2074行 - 
    pfu_biu_req_l1                        <=  1'b0;  // 第2075行 - 
    pfu_biu_req_addr_tto6[`PA_WIDTH-7:0]  <=  {`PA_WIDTH-6{1'b0}};  // 第2076行 - 
    pfu_biu_req_page_sec                  <=  1'b0;  // 第2077行 - 
    pfu_biu_req_page_share                <=  1'b0;  // 第2078行 - 
    pfu_biu_req_priv_mode[1:0]            <=  2'b0;  // 第2079行 - 
    pfu_biu_req_ptr[PFB_ENTRY:0]          <=  {PFB_ENTRY+1{1'b0}};  // 第2080行 - 
    pfu_biu_req_priority[PFB_ENTRY:0]     <=  {PFB_ENTRY+1{1'b0}};  // 第2081行 - 
  end  // 第2082行 - 
  else if(pfu_biu_pe_update_vld)  // 第2083行 - 
  begin  // 第2084行 - 
    pfu_biu_req_l1                        <=  pfu_biu_pe_req_sel_l1;  // 第2085行 - 
    pfu_biu_req_addr_tto6[`PA_WIDTH-7:0]  <=  pfu_biu_pe_req_addr_tto6[`PA_WIDTH-7:0];  // 第2086行 - 
    pfu_biu_req_page_sec                  <=  pfu_biu_pe_req_page_sec;  // 第2087行 - 
    pfu_biu_req_page_share                <=  pfu_biu_pe_req_page_share;  // 第2088行 - 
    pfu_biu_req_priv_mode[1:0]            <=  pfu_biu_pe_req_priv_mode[1:0];  // 第2089行 - 
    pfu_biu_req_ptr[PFB_ENTRY:0]          <=  pfu_biu_pe_req_ptr[PFB_ENTRY:0];  // 第2090行 - 
    pfu_biu_req_priority[PFB_ENTRY:0]     <=  pfu_biu_req_priority_next[PFB_ENTRY:0];  // 第2091行 - 
  end  // 第2092行 - 
end  // 第2093行 - 
  // 第2094行 - 
//---------------------update signal------------------------  // 第2095行 - 
assign pfu_all_pfb_biu_pe_req[PFB_ENTRY:0]  = {pfu_gpfb_biu_pe_req,  // 第2096行 - 
                                              pfu_pfb_entry_biu_pe_req[PFB_ENTRY-1:0]};  // 第2097行 - 
assign pfu_biu_pe_req       = |pfu_all_pfb_biu_pe_req[PFB_ENTRY:0];  // 第2098行 - 
assign pfu_biu_req_grnt     = bus_arb_pfu_ar_grnt  // 第2099行 - 
                              ||  pfu_biu_req_unmask  // 第2100行 - 
                                  &&  pfu_biu_req_l1  // 第2101行 - 
                                  &&  pfu_biu_req_hit_idx;  // 第2102行 - 
//for timing,create bus grant without hit_idx  // 第2103行 - 
assign pfu_biu_req_bus_grnt = bus_arb_pfu_ar_ready  // 第2104行 - 
                              && (!lfb_addr_full  // 第2105行 - 
                                     && (lfb_pfu_rready_grnt  // 第2106行 - 
                                         || rb_pfu_nc_no_pending)  // 第2107行 - 
                                  || !pfu_biu_req_l1);  // 第2108行 - 
  // 第2109行 - 
//for timing, do not use pipe  // 第2110行 - 
assign pfu_biu_pe_update_permit = !pfu_biu_req_unmask  // 第2111行 - 
                                  || pfu_biu_req_bus_grnt;  // 第2112行 - 
  // 第2113行 - 
assign pfu_biu_pe_update_vld    = pfu_biu_pe_update_permit  // 第2114行 - 
                                  &&  pfu_biu_pe_req;  // 第2115行 - 
  // 第2116行 - 
//if grnt entry only req l1, and lfb_addr_less 2, then do not grnt  // 第2117行 - 
assign pfu_biu_pe_req_grnt      = pfu_biu_pe_update_permit  // 第2118行 - 
                                  &&  (pfu_biu_pe_req_sel_l1  // 第2119行 - 
                                      ||  pfu_biu_pe_req_src[1]);  // 第2120行 - 
//---------------------grnt signal--------------------------  // 第2121行 - 
//for timing grnt signal add gateclk  // 第2122行 - 
assign pfu_pfb_entry_biu_pe_req_grnt[PFB_ENTRY-1:0] =  // 第2123行 - 
                {PFB_ENTRY{pfu_biu_pe_req_grnt}}  // 第2124行 - 
                & pfu_biu_pe_req_ptr[PFB_ENTRY-1:0];  // 第2125行 - 
assign pfu_gpfb_biu_pe_req_grnt = pfu_biu_pe_req_grnt  &&  pfu_biu_pe_req_ptr[8];  // 第2126行 - 
//---------------------update info--------------------------  // 第2127行 - 
assign pfu_all_pfb_biu_pe_req_ptiority_0[PFB_ENTRY:0] = pfu_all_pfb_biu_pe_req[PFB_ENTRY:0]  // 第2128行 - 
                                                        & (~pfu_biu_req_priority[PFB_ENTRY:0]);  // 第2129行 - 
assign pfu_all_pfb_biu_pe_req_ptiority_1[PFB_ENTRY:0] = pfu_all_pfb_biu_pe_req[PFB_ENTRY:0]  // 第2130行 - 
                                                        & pfu_biu_req_priority[PFB_ENTRY:0];  // 第2131行 - 
  // 第2132行 - 
assign pfu_biu_pe_req_ptiority_0 = |pfu_all_pfb_biu_pe_req_ptiority_0[PFB_ENTRY:0];  // 第2133行 - 
//----------------req_ptr---------------  // 第2134行 - 
//sel priority 0 first, then priority 1  // 第2135行 - 
// &CombBeg; @594  // 第2136行 - 
always @( pfu_all_pfb_biu_pe_req_ptiority_0[8:0])  // 第2137行 - 
begin  // 第2138行 - 
pfu_biu_pe_req_ptr_priority_0[PFB_ENTRY:0] = {PFB_ENTRY+1{1'b0}};  // 第2139行 - 
casez(pfu_all_pfb_biu_pe_req_ptiority_0[PFB_ENTRY:0])  // 第2140行 - 
  9'b?_????_???1:pfu_biu_pe_req_ptr_priority_0[0]  = 1'b1;  // 第2141行 - 
  9'b?_????_??10:pfu_biu_pe_req_ptr_priority_0[1]  = 1'b1;  // 第2142行 - 
  9'b?_????_?100:pfu_biu_pe_req_ptr_priority_0[2]  = 1'b1;  // 第2143行 - 
  9'b?_????_1000:pfu_biu_pe_req_ptr_priority_0[3]  = 1'b1;  // 第2144行 - 
  9'b?_???1_0000:pfu_biu_pe_req_ptr_priority_0[4]  = 1'b1;  // 第2145行 - 
  9'b?_??10_0000:pfu_biu_pe_req_ptr_priority_0[5]  = 1'b1;  // 第2146行 - 
  9'b?_?100_0000:pfu_biu_pe_req_ptr_priority_0[6]  = 1'b1;  // 第2147行 - 
  9'b?_1000_0000:pfu_biu_pe_req_ptr_priority_0[7]  = 1'b1;  // 第2148行 - 
  9'b1_0000_0000:pfu_biu_pe_req_ptr_priority_0[8]  = 1'b1;  // 第2149行 - 
  default:pfu_biu_pe_req_ptr_priority_0[PFB_ENTRY:0] = {PFB_ENTRY+1{1'b0}};  // 第2150行 - 
endcase  // 第2151行 - 
// &CombEnd; @608  // 第2152行 - 
end  // 第2153行 - 
  // 第2154行 - 
// &CombBeg; @610  // 第2155行 - 
always @( pfu_all_pfb_biu_pe_req_ptiority_1[8:0])  // 第2156行 - 
begin  // 第2157行 - 
pfu_biu_pe_req_ptr_priority_1[PFB_ENTRY:0] = {PFB_ENTRY+1{1'b0}};  // 第2158行 - 
casez(pfu_all_pfb_biu_pe_req_ptiority_1[PFB_ENTRY:0])  // 第2159行 - 
  9'b?_????_???1:pfu_biu_pe_req_ptr_priority_1[0]  = 1'b1;  // 第2160行 - 
  9'b?_????_??10:pfu_biu_pe_req_ptr_priority_1[1]  = 1'b1;  // 第2161行 - 
  9'b?_????_?100:pfu_biu_pe_req_ptr_priority_1[2]  = 1'b1;  // 第2162行 - 
  9'b?_????_1000:pfu_biu_pe_req_ptr_priority_1[3]  = 1'b1;  // 第2163行 - 
  9'b?_???1_0000:pfu_biu_pe_req_ptr_priority_1[4]  = 1'b1;  // 第2164行 - 
  9'b?_??10_0000:pfu_biu_pe_req_ptr_priority_1[5]  = 1'b1;  // 第2165行 - 
  9'b?_?100_0000:pfu_biu_pe_req_ptr_priority_1[6]  = 1'b1;  // 第2166行 - 
  9'b?_1000_0000:pfu_biu_pe_req_ptr_priority_1[7]  = 1'b1;  // 第2167行 - 
  9'b1_0000_0000:pfu_biu_pe_req_ptr_priority_1[8]  = 1'b1;  // 第2168行 - 
  default:pfu_biu_pe_req_ptr_priority_1[PFB_ENTRY:0] = {PFB_ENTRY+1{1'b0}};  // 第2169行 - 
endcase  // 第2170行 - 
// &CombEnd; @624  // 第2171行 - 
end  // 第2172行 - 
  // 第2173行 - 
assign pfu_biu_pe_req_ptr[PFB_ENTRY:0]  = pfu_biu_pe_req_ptiority_0  // 第2174行 - 
                                          ? pfu_biu_pe_req_ptr_priority_0[PFB_ENTRY:0]  // 第2175行 - 
                                          : pfu_biu_pe_req_ptr_priority_1[PFB_ENTRY:0];  // 第2176行 - 
  // 第2177行 - 
//------------sel info to pop entry---------------  // 第2178行 - 
assign pfu_biu_l1_pe_req_addr_tto6[`PA_WIDTH-7:0] =  // 第2179行 - 
                {`PA_WIDTH-6{pfu_biu_pe_req_ptr[0]}} & pfu_pfb_entry_l1_pf_addr_0[`PA_WIDTH-1:6]  // 第2180行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[1]}} & pfu_pfb_entry_l1_pf_addr_1[`PA_WIDTH-1:6]  // 第2181行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[2]}} & pfu_pfb_entry_l1_pf_addr_2[`PA_WIDTH-1:6]  // 第2182行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[3]}} & pfu_pfb_entry_l1_pf_addr_3[`PA_WIDTH-1:6]  // 第2183行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[4]}} & pfu_pfb_entry_l1_pf_addr_4[`PA_WIDTH-1:6]  // 第2184行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[5]}} & pfu_pfb_entry_l1_pf_addr_5[`PA_WIDTH-1:6]  // 第2185行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[6]}} & pfu_pfb_entry_l1_pf_addr_6[`PA_WIDTH-1:6]  // 第2186行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[7]}} & pfu_pfb_entry_l1_pf_addr_7[`PA_WIDTH-1:6]  // 第2187行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[8]}} & pfu_gpfb_l1_pf_addr[`PA_WIDTH-1:6];  // 第2188行 - 
  // 第2189行 - 
assign pfu_biu_l2_pe_req_addr_tto6[`PA_WIDTH-7:0] =  // 第2190行 - 
                {`PA_WIDTH-6{pfu_biu_pe_req_ptr[0]}} & pfu_pfb_entry_l2_pf_addr_0[`PA_WIDTH-1:6]  // 第2191行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[1]}} & pfu_pfb_entry_l2_pf_addr_1[`PA_WIDTH-1:6]  // 第2192行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[2]}} & pfu_pfb_entry_l2_pf_addr_2[`PA_WIDTH-1:6]  // 第2193行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[3]}} & pfu_pfb_entry_l2_pf_addr_3[`PA_WIDTH-1:6]  // 第2194行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[4]}} & pfu_pfb_entry_l2_pf_addr_4[`PA_WIDTH-1:6]  // 第2195行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[5]}} & pfu_pfb_entry_l2_pf_addr_5[`PA_WIDTH-1:6]  // 第2196行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[6]}} & pfu_pfb_entry_l2_pf_addr_6[`PA_WIDTH-1:6]  // 第2197行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[7]}} & pfu_pfb_entry_l2_pf_addr_7[`PA_WIDTH-1:6]  // 第2198行 - 
                | {`PA_WIDTH-6{pfu_biu_pe_req_ptr[8]}} & pfu_gpfb_l2_pf_addr[`PA_WIDTH-1:6];  // 第2199行 - 
  // 第2200行 - 
assign pfu_biu_l1_pe_req_page_sec   = |(pfu_biu_pe_req_ptr[PFB_ENTRY:0]  // 第2201行 - 
                                        & {pfu_gpfb_l1_page_sec,  // 第2202行 - 
                                          pfu_pfb_entry_l1_page_sec[PFB_ENTRY-1:0]});  // 第2203行 - 
assign pfu_biu_l2_pe_req_page_sec   = |(pfu_biu_pe_req_ptr[PFB_ENTRY:0]  // 第2204行 - 
                                        & {pfu_gpfb_l2_page_sec,  // 第2205行 - 
                                          pfu_pfb_entry_l2_page_sec[PFB_ENTRY-1:0]});  // 第2206行 - 
assign pfu_biu_l1_pe_req_page_share = |(pfu_biu_pe_req_ptr[PFB_ENTRY:0]  // 第2207行 - 
                                        & {pfu_gpfb_l1_page_share,  // 第2208行 - 
                                          pfu_pfb_entry_l1_page_share[PFB_ENTRY-1:0]});  // 第2209行 - 
assign pfu_biu_l2_pe_req_page_share = |(pfu_biu_pe_req_ptr[PFB_ENTRY:0]  // 第2210行 - 
                                        & {pfu_gpfb_l2_page_share,  // 第2211行 - 
                                          pfu_pfb_entry_l2_page_share[PFB_ENTRY-1:0]});  // 第2212行 - 
  // 第2213行 - 
  // 第2214行 - 
assign pfu_biu_pe_req_src[1:0]  = {2{pfu_biu_pe_req_ptr[0]}}  & pfu_pfb_entry_biu_pe_req_src_0[1:0]  // 第2215行 - 
                                  | {2{pfu_biu_pe_req_ptr[1]}}  & pfu_pfb_entry_biu_pe_req_src_1[1:0]  // 第2216行 - 
                                  | {2{pfu_biu_pe_req_ptr[2]}}  & pfu_pfb_entry_biu_pe_req_src_2[1:0]  // 第2217行 - 
                                  | {2{pfu_biu_pe_req_ptr[3]}}  & pfu_pfb_entry_biu_pe_req_src_3[1:0]  // 第2218行 - 
                                  | {2{pfu_biu_pe_req_ptr[4]}}  & pfu_pfb_entry_biu_pe_req_src_4[1:0]  // 第2219行 - 
                                  | {2{pfu_biu_pe_req_ptr[5]}}  & pfu_pfb_entry_biu_pe_req_src_5[1:0]  // 第2220行 - 
                                  | {2{pfu_biu_pe_req_ptr[6]}}  & pfu_pfb_entry_biu_pe_req_src_6[1:0]  // 第2221行 - 
                                  | {2{pfu_biu_pe_req_ptr[7]}}  & pfu_pfb_entry_biu_pe_req_src_7[1:0]  // 第2222行 - 
                                  | {2{pfu_biu_pe_req_ptr[8]}}  & pfu_gpfb_biu_pe_req_src[1:0];  // 第2223行 - 
  // 第2224行 - 
assign pfu_biu_pe_req_sel_l1    = pfu_biu_pe_req_src[0] &&  !lfb_addr_less2;  // 第2225行 - 
  // 第2226行 - 
assign pfu_biu_pe_req_addr_tto6[`PA_WIDTH-7:0]  = pfu_biu_pe_req_sel_l1  // 第2227行 - 
                                                  ? pfu_biu_l1_pe_req_addr_tto6[`PA_WIDTH-7:0]  // 第2228行 - 
                                                  : pfu_biu_l2_pe_req_addr_tto6[`PA_WIDTH-7:0];  // 第2229行 - 
  // 第2230行 - 
  // 第2231行 - 
assign pfu_biu_pe_req_page_sec    = pfu_biu_pe_req_sel_l1  // 第2232行 - 
                                    ? pfu_biu_l1_pe_req_page_sec  // 第2233行 - 
                                    : pfu_biu_l2_pe_req_page_sec;  // 第2234行 - 
assign pfu_biu_pe_req_page_share  = pfu_biu_pe_req_sel_l1  // 第2235行 - 
                                    ? pfu_biu_l1_pe_req_page_share  // 第2236行 - 
                                    : pfu_biu_l2_pe_req_page_share;  // 第2237行 - 
  // 第2238行 - 
assign pfu_biu_pe_req_priv_mode[1:0]  = {2{pfu_biu_pe_req_ptr[0]}}  & pfu_pfb_entry_priv_mode_0[1:0]  // 第2239行 - 
                                        | {2{pfu_biu_pe_req_ptr[1]}}  & pfu_pfb_entry_priv_mode_1[1:0]  // 第2240行 - 
                                        | {2{pfu_biu_pe_req_ptr[2]}}  & pfu_pfb_entry_priv_mode_2[1:0]  // 第2241行 - 
                                        | {2{pfu_biu_pe_req_ptr[3]}}  & pfu_pfb_entry_priv_mode_3[1:0]  // 第2242行 - 
                                        | {2{pfu_biu_pe_req_ptr[4]}}  & pfu_pfb_entry_priv_mode_4[1:0]  // 第2243行 - 
                                        | {2{pfu_biu_pe_req_ptr[5]}}  & pfu_pfb_entry_priv_mode_5[1:0]  // 第2244行 - 
                                        | {2{pfu_biu_pe_req_ptr[6]}}  & pfu_pfb_entry_priv_mode_6[1:0]  // 第2245行 - 
                                        | {2{pfu_biu_pe_req_ptr[7]}}  & pfu_pfb_entry_priv_mode_7[1:0]  // 第2246行 - 
                                        | {2{pfu_biu_pe_req_ptr[8]}}  & pfu_gpfb_priv_mode[1:0];  // 第2247行 - 
  // 第2248行 - 
//----------------priority_next---------------  // 第2249行 - 
//set pfu_biu_pe_req_ptr 0~x to 1  // 第2250行 - 
assign pfu_biu_req_priority_next[PFB_ENTRY:0] = {PFB_ENTRY+1{pfu_biu_pe_req_ptr[0]}} & 9'b0_0000_0001  // 第2251行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[1]}} & 9'b0_0000_0011  // 第2252行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[2]}} & 9'b0_0000_0111  // 第2253行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[3]}} & 9'b0_0000_1111  // 第2254行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[4]}} & 9'b0_0001_1111  // 第2255行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[5]}} & 9'b0_0011_1111  // 第2256行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[6]}} & 9'b0_0111_1111  // 第2257行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[7]}} & 9'b0_1111_1111  // 第2258行 - 
                                                | {PFB_ENTRY+1{pfu_biu_pe_req_ptr[8]}} & 9'b1_1111_1111;  // 第2259行 - 
  // 第2260行 - 
//--------------------page_sel------------------------------  // 第2261行 - 
//--------------------hit index signal----------------------  // 第2262行 - 
assign pfu_biu_req_addr[`PA_WIDTH-1:0] = {pfu_biu_req_addr_tto6[`PA_WIDTH-7:0],6'b0};  // 第2263行 - 
  // 第2264行 - 
assign pfu_biu_req_hit_idx    = ld_da_pfu_biu_req_hit_idx  // 第2265行 - 
                                ||  st_da_pfu_biu_req_hit_idx  // 第2266行 - 
                                ||  lfb_pfu_biu_req_hit_idx  // 第2267行 - 
                                ||  vb_pfu_biu_req_hit_idx  // 第2268行 - 
                                ||  rb_pfu_biu_req_hit_idx  // 第2269行 - 
                                ||  wmb_pfu_biu_req_hit_idx  // 第2270行 - 
                                ||  lm_pfu_biu_req_hit_idx;  // 第2271行 - 
  // 第2272行 - 
//----------------------req bus_arb-------------------------  // 第2273行 - 
// &Force("output","pfu_biu_ar_req"); @726  // 第2274行 - 
assign pfu_biu_ar_req   = pfu_biu_req_unmask  // 第2275行 - 
                          &&  !cp0_lsu_no_op_req  // 第2276行 - 
                          &&  (!pfu_biu_req_hit_idx  // 第2277行 - 
                                  &&  !lfb_addr_full  // 第2278行 - 
                                  &&  (lfb_pfu_rready_grnt  // 第2279行 - 
                                       || rb_pfu_nc_no_pending)  // 第2280行 - 
                               || !pfu_biu_req_l1);  // 第2281行 - 
  // 第2282行 - 
assign pfu_biu_ar_dp_req= pfu_biu_req_unmask  // 第2283行 - 
                          &&  !cp0_lsu_no_op_req  // 第2284行 - 
                          &&  (!lfb_addr_full  // 第2285行 - 
                                  &&  (lfb_pfu_rready_grnt  // 第2286行 - 
                                       || rb_pfu_nc_no_pending)  // 第2287行 - 
                               || !pfu_biu_req_l1);  // 第2288行 - 
  // 第2289行 - 
assign pfu_biu_ar_req_gateclk_en = pfu_biu_req_unmask;  // 第2290行 - 
assign pfu_biu_ar_id[4:0]     = pfu_biu_req_l1  // 第2291行 - 
                                ? lfb_pfu_create_id[4:0]  // 第2292行 - 
                                : BIU_R_L2PREF_ID;  // 第2293行 - 
  // 第2294行 - 
assign pfu_biu_ar_addr[`PA_WIDTH-1:0]  = {pfu_biu_req_addr_tto6[`PA_WIDTH-7:0],6'b0};  // 第2295行 - 
//1 dcache line  // 第2296行 - 
assign pfu_biu_ar_len[1:0]    = 2'b11;  // 第2297行 - 
//128bits  // 第2298行 - 
assign pfu_biu_ar_size[2:0]   = 3'b100;  // 第2299行 - 
//increase  // 第2300行 - 
assign pfu_biu_ar_burst[1:0]  = 2'b10;  // 第2301行 - 
//not exclusive  // 第2302行 - 
assign pfu_biu_ar_lock        = 1'b0;  // 第2303行 - 
//cacheable,weak order, bufferable  // 第2304行 - 
assign pfu_biu_ar_cache[3:0]  = 4'b1111;  // 第2305行 - 
  // 第2306行 - 
assign pfu_biu_ar_prot[2:0]   = {1'b0,  // 第2307行 - 
                                pfu_biu_req_page_sec,  // 第2308行 - 
                                pfu_biu_req_priv_mode[0]};  // 第2309行 - 
  // 第2310行 - 
assign pfu_biu_ar_user[2:0]   = {!pfu_biu_req_l1,cp0_yy_priv_mode[1],1'b0};  // 第2311行 - 
//-------------ar snoop-----------------  // 第2312行 - 
//assign pfu_biu_req_l1_page_share  = pfu_biu_req_page_share && pfu_biu_req_l1;  // 第2313行 - 
assign pfu_biu_ar_snoop[3:0]  = pfu_biu_req_page_share  // 第2314行 - 
                                ? 4'b0001 //ReadShared  // 第2315行 - 
                                : 4'b0000;//ReadNoSnoop  // 第2316行 - 
assign pfu_biu_ar_domain[1:0] = {1'b0,pfu_biu_req_page_share};  // 第2317行 - 
  // 第2318行 - 
assign pfu_biu_ar_bar[1:0]    = 2'b10;  // 第2319行 - 
  // 第2320行 - 
//------------------------req lfb---------------------------  // 第2321行 - 
assign pfu_lfb_id[3:0]            = {4{pfu_biu_req_ptr[0]}} & 4'd0  // 第2322行 - 
                                    | {4{pfu_biu_req_ptr[1]}} & 4'd1  // 第2323行 - 
                                    | {4{pfu_biu_req_ptr[2]}} & 4'd2  // 第2324行 - 
                                    | {4{pfu_biu_req_ptr[3]}} & 4'd3  // 第2325行 - 
                                    | {4{pfu_biu_req_ptr[4]}} & 4'd4  // 第2326行 - 
                                    | {4{pfu_biu_req_ptr[5]}} & 4'd5  // 第2327行 - 
                                    | {4{pfu_biu_req_ptr[6]}} & 4'd6  // 第2328行 - 
                                    | {4{pfu_biu_req_ptr[7]}} & 4'd7  // 第2329行 - 
                                    | {4{pfu_biu_req_ptr[8]}} & 4'd8;  // 第2330行 - 
  // 第2331行 - 
assign pfu_lfb_create_req         = pfu_biu_req_unmask  // 第2332行 - 
                                    &&  pfu_biu_req_l1;  // 第2333行 - 
assign pfu_lfb_create_vld         = pfu_biu_ar_req  // 第2334行 - 
                                    &&  pfu_biu_req_l1  // 第2335行 - 
                                    &&  bus_arb_pfu_ar_ready;  // 第2336行 - 
assign pfu_lfb_create_dp_vld      = pfu_biu_ar_req  // 第2337行 - 
                                    &&  pfu_biu_req_l1;  // 第2338行 - 
assign pfu_lfb_create_gateclk_en  = pfu_biu_req_unmask  // 第2339行 - 
                                    &&  pfu_biu_req_l1;  // 第2340行 - 
//---------------------lfb back signal----------------------  // 第2341行 - 
assign pfu_gpfb_from_lfb_dcache_hit                       = lfb_pfu_dcache_hit[8];  // 第2342行 - 
assign pfu_pfb_entry_from_lfb_dcache_hit[PFB_ENTRY-1:0]   = lfb_pfu_dcache_hit[PFB_ENTRY-1:0];  // 第2343行 - 
assign pfu_gpfb_from_lfb_dcache_miss                      = lfb_pfu_dcache_miss[8];  // 第2344行 - 
assign pfu_pfb_entry_from_lfb_dcache_miss[PFB_ENTRY-1:0]  = lfb_pfu_dcache_miss[PFB_ENTRY-1:0];  // 第2345行 - 
  // 第2346行 - 
//==========================================================  // 第2347行 - 
//                  Generate pop signal  // 第2348行 - 
//==========================================================  // 第2349行 - 
assign pfu_dcache_pref_en = cp0_lsu_dcache_en &&  cp0_lsu_dcache_pref_en;  // 第2350行 - 
assign pfu_l2_pref_en     = cp0_lsu_l2_pref_en;  //l2 is always enabled  // 第2351行 - 
//broad cp0_yy_dcache_pref_en means l1 or l2  // 第2352行 - 
//cp0_lsu_dcache_pref_en means l1  // 第2353行 - 
//cp0_lsu_l2_pref_en means l2  // 第2354行 - 
assign pfu_pop_all_vld  = !icc_idle  // 第2355行 - 
                          ||  !(pfu_dcache_pref_en  // 第2356行 - 
                                ||  pfu_l2_pref_en)  // 第2357行 - 
                          ||  cp0_lsu_no_op_req  // 第2358行 - 
                          ||  sq_pfu_pop_synci_inst;  // 第2359行 - 
assign pfu_pop_all_part_vld = pfu_pop_all_vld  // 第2360行 - 
                              ||  pfu_gpfb_vld;  // 第2361行 - 
  // 第2362行 - 
assign pfu_pmb_empty    = !(|pfu_pmb_entry_vld[PMB_ENTRY-1:0]);  // 第2363行 - 
// &Force("output","pfu_sdb_empty"); @816  // 第2364行 - 
assign pfu_sdb_empty    = !(|pfu_sdb_entry_vld[SDB_ENTRY-1:0]);  // 第2365行 - 
// &Force("output","pfu_pfb_empty"); @818  // 第2366行 - 
assign pfu_pfb_empty    = !(|pfu_pfb_entry_vld[PFB_ENTRY-1:0]);  // 第2367行 - 
assign pfu_icc_ready    = !pfu_biu_req_unmask;  // 第2368行 - 
assign pfu_part_empty   = pfu_pmb_empty  // 第2369行 - 
                          &&  pfu_sdb_empty  // 第2370行 - 
                          &&  pfu_pfb_empty;  // 第2371行 - 
//==========================================================  // 第2372行 - 
//                  for cp0 control  // 第2373行 - 
//==========================================================  // 第2374行 - 
//timeout cnt  // 第2375行 - 
// &Force("bus","cp0_lsu_timeout_cnt",29,0); @828  // 第2376行 - 
assign pmb_timeout_cnt_val[7:0] = cp0_lsu_timeout_cnt[7:0];   // 第2377行 - 
assign sdb_timeout_cnt_val[7:0] = cp0_lsu_timeout_cnt[15:8];  // 第2378行 - 
assign pfb_timeout_cnt_val[7:0] = cp0_lsu_timeout_cnt[23:16];   // 第2379行 - 
assign pfb_no_req_cnt_val[5:0]  = cp0_lsu_timeout_cnt[29:24];  // 第2380行 - 
  // 第2381行 - 
// &ModuleEnd; @834  // 第2382行 - 
endmodule  // 第2383行 - 
  // 第2384行 - 
  // 第2385行 - 
