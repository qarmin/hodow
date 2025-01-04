#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""A python mirror of the case tree of src/vkt/tests/compute/cooperative_matrix_tests.rs, compared with the vk-default mustpass.

Prints the number of generated names, distinct names and mustpass names, how many names each side has that the other lacks, and five samples of each. The second difference is the mustpass names outside the mirrored tree (groups ported elsewhere or not at all).

Usage: check_coopmat_tree.py   (needs the upstream checkout in tmp/VK-GL-CTS)
"""
from pathlib import Path

REPO_DIR = Path(__file__).resolve().parents[2]
MUSTPASS = REPO_DIR / "tmp/VK-GL-CTS/external/vulkancts/mustpass/main/vk-default"
PREFIX = "dEQP-VK.compute.pipeline.cooperative_matrix."


def mustpass_names():
    for path in sorted(MUSTPASS.rglob("*.txt")):
        for line in path.read_text(errors="ignore").splitlines():
            if line.strip().startswith(PREFIX):
                yield line.strip()


NV,A,B,C,R = 'nv','khr_a','khr_b','khr_c','khr_r'
F16,F32,F64,S8,S16,S32,S64,U8,U16,U32,U64,BF16,E5M2,E4M3 = ['float16_t','float32_t','float64_t','int8_t','int16_t','int32_t','int64_t','uint8_t','uint16_t','uint32_t','uint64_t','bfloat16_t','floate5m2_t','floate4m3_t']
bits = {F16:16,F32:32,F64:64,S8:8,S16:16,S32:32,S64:64,U8:8,U16:16,U32:32,U64:64,BF16:16,E5M2:8,E4M3:8}
isfloat = lambda t: t in (F16,F32,F64,BF16,E5M2,E4M3)
issint = lambda t: t in (S8,S16,S32,S64)
noarith = lambda t: t in (BF16,E5M2,E4M3)
MMA = ['matrixmuladd','matrixmuladd_array','matrixmuladd_saturated','matrixmuladd_wrapping','matrixmuladd_stride0','matrixmuladd_cross','matrixmuladd_dequant','matrixmuladd_push','matrixmuladd_split_barrier','matrixmuladd_split_barrier_loop','matrixmuladd_split_barrier_skew']
# tt entries: (testtype, name, feature)
def T(t,n=None,f='base'): return (t,n or t,f)
tt = []
for n in ['length','constant','composite','composite_rvalue','add','sub','div','mul','negate','matrixtimesscalar','func','func_const_in','matrixmuladd','composite_array','matrixmuladd_array','matrixmuladd_saturated','matrixmuladd_wrapping','matrixmuladd_stride0','matrixmuladd_cross','matrixmuladd_dequant','matrixmuladd_push','matrixmuladd_split_barrier','matrixmuladd_split_barrier_loop','matrixmuladd_split_barrier_skew','transpose_acc_to_a','transpose_acc_to_b']:
    tt.append((n,n,'base'))
red = ['reduce_sum_row','reduce_sum_col','reduce_sum_rowcol','reduce_sum_2x2','reduce_sum_row_changedim','reduce_sum_col_changedim','reduce_sum_rowcol_changedim','reduce_min_row','reduce_min_col','reduce_min_rowcol','reduce_min_2x2']
per = ['per_element_op','per_element_op_row_col','per_element_op_struct','per_element_op_mat']
for n in red: tt.append((n,n,'nv2'))
for n in per: tt.append((n,n,'nv2'))
for n in red: tt.append((n,n+'_maint1','maint1'))
for n in per: tt.append((n,n+'_maint1','maint1'))
for d in '12345': tt.append(('tensorlayout'+d+'d','tensorlayout'+d+'d','base'))
for d in '12345': tt.append(('tensorlayout'+d+'dclip','tensorlayout'+d+'dclip','base'))
tt.append(('spacetodepth','spacetodepth','base'))
for n in ['clampconstant','clamptoedge','clamprepeat','clampmirrorrepeat']: tt.append((n,n,'base'))
tt.append(('getcoordinate','getcoordinate','maint1'))
isMMA = lambda t: t in MMA
isReduce = lambda t: t in red
isPer = lambda t: t in per
isClamp = lambda t: t in ('clampconstant','clamptoedge','clamprepeat','clampmirrorrepeat')
isTL = lambda t: t.startswith('tensorlayout') or t=='spacetodepth'
isSplit = lambda t: t.startswith('matrixmuladd_split_barrier')
isArith = lambda t: t in ('composite','func','func_const_in','add','sub','mul','div','negate','matrixtimesscalar') or isPer(t)
dt = [(F32,F32),(F32,F16),(F16,F32),(F16,F16),(U8,U8),(U8,U32),(S8,S8),(S8,S32),(U8,S32),(U32,U32),(U32,U8),(S32,S32),(S32,S8),(BF16,F32),(BF16,BF16),(F32,BF16),(E5M2,E5M2),(E4M3,E4M3),(E5M2,F16),(E4M3,F16),(E5M2,F32),(E4M3,F32),(F16,E5M2),(F16,E4M3),(F32,E5M2),(F32,E4M3)]
dtname = lambda a,b: a[:-2]+'_'+b[:-2] if False else None
def dn(t): return {S8:'sint8',S32:'sint32',U8:'uint8',U32:'uint32',F16:'float16',F32:'float32',BF16:'bfloat16',E5M2:'floate5m2',E4M3:'floate4m3'}[t]
def tn(t): return t[:-2] if t.endswith('_t') else t
allTypes=[F16,F32,S8,S16,S32,U8,U16,U32,E5M2,E4M3,BF16]
def gen(use):
    out=[]
    for scope in ['subgroupscope','workgroupscope']:
        if use==NV and scope=='workgroupscope': continue
        for (t,n,feat) in tt:
            for sgs,sfx in [(0,''),(1,'_min'),(2,'_max')]:
                if t!='matrixmuladd' and sgs!=0: continue
                if t=='matrixmuladd' and sgs!=0 and use==NV: continue
                name=n+sfx
                for (it,ot) in dt:
                    dtn=dn(it)+'_'+dn(ot)
                    for sc in ['buffer','workgroup','buffer_varptr','workgroup_varptr','physical_buffer']:
                        if isSplit(t) and (sc!='workgroup' or use!=R): continue
                        for col in ['rowmajor','colmajor']:
                            for addr in ['linear','tensorlayout','blocksize','decode']:
                                mm=isMMA(t)
                                if feat=='maint1' and (isReduce(t) or isPer(t)) and (scope!='subgroupscope' or addr!='linear'): continue
                                if t=='matrixmuladd_cross':
                                    if isfloat(it) or isfloat(ot) or use==NV or sc!='buffer': continue
                                    if scope=='workgroupscope': continue
                                else:
                                    if use==C: continue
                                    if mm and use in (A,B): continue
                                    if mm and use==NV and issint(it)!=issint(ot): continue
                                    if mm and bits[it]>bits[ot]: continue
                                    if noarith(it) or noarith(ot):
                                        if use==NV: continue
                                        if isArith(t): continue
                                if t=='matrixmuladd_dequant':
                                    if it!=F16 and not noarith(it): continue
                                    if addr!='decode': continue
                                    if col=='colmajor': continue
                                if addr in('blocksize','decode') and t not in ('negate','matrixmuladd_dequant'): continue
                                if addr in('blocksize','decode') and sc in ('workgroup','workgroup_varptr'): continue
                                if not mm and it!=ot: continue
                                if t=='mul' and use==NV: continue
                                if t=='matrixmuladd_saturated' and (isfloat(it) or use==NV): continue
                                if t=='matrixmuladd_wrapping' and (isfloat(it) or use==NV): continue
                                if t=='matrixmuladd_stride0' and use==NV: continue
                                if t=='getcoordinate' and use==NV: continue
                                if t=='length' and use!=NV and ot in (S8,U8): continue
                                if t=='matrixmuladd_push' and addr!='linear': continue
                                if use==NV and (addr!='linear' or isReduce(t) or isPer(t)): continue
                                if isReduce(t) and use in (A,B): continue
                                if isReduce(t) and it!=ot: continue
                                if isTL(t) and (col=='colmajor' or sc in ('workgroup','workgroup_varptr','physical_buffer') or addr=='linear'): continue
                                if sc in ('buffer_varptr','workgroup_varptr') and (not (t in('matrixmuladd','mul')) or sgs!=0): continue
                                if col=='colmajor' and not (mm or t=='mul'): continue
                                if sc in('workgroup','workgroup_varptr') or addr=='linear':
                                    if isClamp(t): continue
                                if isSplit(t) and addr!='linear': continue
                                out.append('.'.join([use,scope,name,dtn,sc,col,addr]))
        if use!=C:
            for dst in [NV,A,B,R]:
                if (use==NV)!=(dst==NV): continue
                if use!=dst and use in(A,B) and dst in(A,B): continue
                cc=[]
                if use==dst:
                    cc.append(('convert_base','convert','base'))
                    cc.append(('convert_nv','convert','nv2'))
                    cc.append(('convert_sat_nv','sat','nv2'))
                    if use!=NV:
                        cc.append(('convert_maint1','convert','maint1')); cc.append(('convert_sat_maint1','sat','maint1'))
                elif use==R:
                    cc+= [('convert_nv','convert','nv2'),('convert_maint1','convert','maint1'),('convert_sat_nv','sat','nv2'),('convert_sat_maint1','sat','maint1')]
                elif dst==R:
                    cc+= [('convert_maint1','convert','maint1'),('convert_sat_maint1','sat','maint1')]
                if use==R and dst==B:
                    cc+=[('transpose','tr','nv2'),('transpose_maint1','tr','maint1')]
                if use==R and dst==A:
                    cc+=[('transpose_maint1','tr','maint1')]
                for (n,k,f) in cc:
                    for i in allTypes:
                        for o in allTypes:
                            if k=='sat':
                                if i in (E5M2,E4M3): continue
                                if o not in (E5M2,E4M3): continue
                            out.append('.'.join([use,scope,n+'_dst_'+dst,'input_%s_output_%s'%(i,o),'buffer','rowmajor']))
        if use not in (NV,C):
            for ct in ['vec2','vec4']:
                for io in ['load','save']:
                    for i in allTypes:
                        for sc in ['buffer','workgroup','buffer_varptr','workgroup_varptr','physical_buffer']:
                            out.append('.'.join([use,scope,'multicomponent',ct,io,i,sc,'rowmajor']))
    return out
allout=[]
for u in [NV,A,B,C,R]: allout+=gen(u)
mp = [name.removeprefix(PREFIX) for name in mustpass_names()]
ms=set(mp)
mine=set(allout)
print(len(allout),len(mine),len(ms), len(mine-ms), len(ms-mine))
import itertools
print(list(itertools.islice(mine-ms,5))); print(list(itertools.islice(ms-mine,5)))
