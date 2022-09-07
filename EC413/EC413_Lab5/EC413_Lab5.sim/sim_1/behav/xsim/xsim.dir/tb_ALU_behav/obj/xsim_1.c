/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern void execute_304(char*, char *);
extern void execute_305(char*, char *);
extern void execute_306(char*, char *);
extern void execute_1639(char*, char *);
extern void execute_1640(char*, char *);
extern void execute_1641(char*, char *);
extern void execute_1642(char*, char *);
extern void execute_1643(char*, char *);
extern void execute_1644(char*, char *);
extern void execute_1645(char*, char *);
extern void execute_1646(char*, char *);
extern void execute_1647(char*, char *);
extern void execute_1648(char*, char *);
extern void execute_1649(char*, char *);
extern void execute_301(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_1633(char*, char *);
extern void execute_1634(char*, char *);
extern void execute_1635(char*, char *);
extern void execute_1636(char*, char *);
extern void execute_1637(char*, char *);
extern void execute_1638(char*, char *);
extern void execute_311(char*, char *);
extern void execute_343(char*, char *);
extern void execute_375(char*, char *);
extern void execute_407(char*, char *);
extern void execute_792(char*, char *);
extern void execute_408(char*, char *);
extern void execute_409(char*, char *);
extern void execute_410(char*, char *);
extern void execute_411(char*, char *);
extern void execute_412(char*, char *);
extern void execute_413(char*, char *);
extern void execute_414(char*, char *);
extern void execute_415(char*, char *);
extern void execute_416(char*, char *);
extern void execute_417(char*, char *);
extern void execute_418(char*, char *);
extern void execute_419(char*, char *);
extern void execute_1597(char*, char *);
extern void execute_1598(char*, char *);
extern void execute_1599(char*, char *);
extern void execute_300(char*, char *);
extern void execute_1600(char*, char *);
extern void execute_1601(char*, char *);
extern void execute_1602(char*, char *);
extern void execute_1603(char*, char *);
extern void execute_1604(char*, char *);
extern void execute_1605(char*, char *);
extern void execute_1606(char*, char *);
extern void execute_1607(char*, char *);
extern void execute_1608(char*, char *);
extern void execute_1609(char*, char *);
extern void execute_1610(char*, char *);
extern void execute_1611(char*, char *);
extern void execute_1612(char*, char *);
extern void execute_1613(char*, char *);
extern void execute_1614(char*, char *);
extern void execute_1615(char*, char *);
extern void execute_1616(char*, char *);
extern void execute_1617(char*, char *);
extern void execute_1618(char*, char *);
extern void execute_1619(char*, char *);
extern void execute_1620(char*, char *);
extern void execute_1621(char*, char *);
extern void execute_1622(char*, char *);
extern void execute_1623(char*, char *);
extern void execute_1624(char*, char *);
extern void execute_1625(char*, char *);
extern void execute_1626(char*, char *);
extern void execute_1627(char*, char *);
extern void execute_1628(char*, char *);
extern void execute_1629(char*, char *);
extern void execute_1630(char*, char *);
extern void execute_1631(char*, char *);
extern void execute_237(char*, char *);
extern void execute_303(char*, char *);
extern void execute_308(char*, char *);
extern void execute_309(char*, char *);
extern void execute_310(char*, char *);
extern void execute_1650(char*, char *);
extern void execute_1651(char*, char *);
extern void execute_1652(char*, char *);
extern void execute_1653(char*, char *);
extern void execute_1654(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_353(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[87] = {(funcp)execute_304, (funcp)execute_305, (funcp)execute_306, (funcp)execute_1639, (funcp)execute_1640, (funcp)execute_1641, (funcp)execute_1642, (funcp)execute_1643, (funcp)execute_1644, (funcp)execute_1645, (funcp)execute_1646, (funcp)execute_1647, (funcp)execute_1648, (funcp)execute_1649, (funcp)execute_301, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_1633, (funcp)execute_1634, (funcp)execute_1635, (funcp)execute_1636, (funcp)execute_1637, (funcp)execute_1638, (funcp)execute_311, (funcp)execute_343, (funcp)execute_375, (funcp)execute_407, (funcp)execute_792, (funcp)execute_408, (funcp)execute_409, (funcp)execute_410, (funcp)execute_411, (funcp)execute_412, (funcp)execute_413, (funcp)execute_414, (funcp)execute_415, (funcp)execute_416, (funcp)execute_417, (funcp)execute_418, (funcp)execute_419, (funcp)execute_1597, (funcp)execute_1598, (funcp)execute_1599, (funcp)execute_300, (funcp)execute_1600, (funcp)execute_1601, (funcp)execute_1602, (funcp)execute_1603, (funcp)execute_1604, (funcp)execute_1605, (funcp)execute_1606, (funcp)execute_1607, (funcp)execute_1608, (funcp)execute_1609, (funcp)execute_1610, (funcp)execute_1611, (funcp)execute_1612, (funcp)execute_1613, (funcp)execute_1614, (funcp)execute_1615, (funcp)execute_1616, (funcp)execute_1617, (funcp)execute_1618, (funcp)execute_1619, (funcp)execute_1620, (funcp)execute_1621, (funcp)execute_1622, (funcp)execute_1623, (funcp)execute_1624, (funcp)execute_1625, (funcp)execute_1626, (funcp)execute_1627, (funcp)execute_1628, (funcp)execute_1629, (funcp)execute_1630, (funcp)execute_1631, (funcp)execute_237, (funcp)execute_303, (funcp)execute_308, (funcp)execute_309, (funcp)execute_310, (funcp)execute_1650, (funcp)execute_1651, (funcp)execute_1652, (funcp)execute_1653, (funcp)execute_1654, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_353};
const int NumRelocateId= 87;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/tb_ALU_behav/xsim.reloc",  (void **)funcTab, 87);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/tb_ALU_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/tb_ALU_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/tb_ALU_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/tb_ALU_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/tb_ALU_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
