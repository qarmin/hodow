# Expands the shaders and manifest of dEQP-VK.memory_model.{message_passing,write_after_read,transitive}.
# Usage: python3 -I hodow_cts/scripts/gen_memory_model_mp.py <repo root>, then just cts-shaders.
# enumerates dEQP-VK.memory_model.{message_passing,write_after_read} cases, mirrors createTests() filters
import itertools, sys

TT=[(0,"message_passing"),(1,"write_after_read")]
CORE11=[(1,"core11"),(0,"ext")]
DT=[(0,"u32"),(1,"u64"),(2,"f32"),(3,"f64")]
COH=[(1,"coherent"),(0,"noncoherent")]
ST=[(0,"fence_fence"),(1,"fence_atomic"),(2,"atomic_fence"),(3,"atomic_atomic"),(4,"control_barrier"),(5,"control_and_memory_barrier"),(6,"split_control_barrier"),(7,"split_control_and_memory_barrier"),(8,"split_control_barrier_and_barrier")]
RMW=[(0,"atomicwrite"),(1,"atomicrmw")]
SCOPE=[(0,"device"),(1,"queuefamily"),(2,"workgroup"),(3,"subgroup")]
PL=[(0,"payload_nonlocal"),(1,"payload_local")]
PSC=[(0,"buffer"),(1,"image"),(2,"workgroup"),(3,"physbuffer")]
GL=[(0,"guard_nonlocal"),(1,"guard_local")]
GSC=PSC
STAGE=[(0,"comp"),(1,"vert"),(2,"frag")]
BUF,IMG,WG,PHYS=0,1,2,3
def split(st): return st in (6,7,8)

def cases():
    out=[]
    for tt,ttn in TT:
      for c11,c11n in CORE11:
        for dt,dtn in DT:
          for coh,cohn in COH:
            for st,stn in ST:
              for rmw,rmwn in RMW:
                for sc,scn in SCOPE:
                  for pl,pln in PL:
                    for psc,pscn in PSC:
                      for gl,gln in GL:
                        for gsc,gscn in GSC:
                          for stage,stagen in STAGE:
                            c=dict(pl=pl,gl=gl,coh=coh,core11=c11,rmw=rmw,tt=tt,psc=psc,gsc=gsc,scope=sc,st=st,stage=stage,dt=dt,trans=0,transvis=0)
                            if c['core11'] and (c['coh']==0 or st in (1,2,3) or dt in (1,3) or sc==1 or psc==PHYS or gsc==PHYS): continue
                            if stage!=0 and sc==2: continue
                            if psc==WG and (pl!=0 or stage!=0): continue
                            if gsc==WG and (gl!=0 or stage!=0): continue
                            if st in (4,5) or split(st):
                                if sc in (0,1) or stage!=0: continue
                            if st==8 and sc!=2: continue
                            if rmw and st!=3: continue
                            atomic_testing = dt in (1,2,3)
                            if atomic_testing and st!=3: continue
                            if dt==1 and psc==IMG and gsc==IMG: continue
                            if dt==3 and (psc==IMG or gsc==IMG): continue
                            if st in (4,5) and (gsc!=0 or gl!=0): continue
                            path=[ttn,c11n,dtn,cohn,stn,[r for r in RMW if r[0]==rmw][0][1],scn,pln,pscn,gln,gscn,stagen]
                            out.append((path,c))
    TV=[(0,"nontransvis"),(1,"transvis")]
    for coh,cohn in COH:
      for st,stn in ST:
        for pl,pln in PL:
          for psc,pscn in PSC:
            for gl,gln in GL:
              for gsc,gscn in GSC:
                for tv,tvn in TV:
                    c=dict(pl=pl,gl=gl,coh=coh,core11=0,rmw=0,tt=0,psc=psc,gsc=gsc,scope=0,st=st,stage=0,dt=0,trans=1,transvis=tv)
                    if psc==WG or gsc==WG: continue
                    if st in (4,5) or split(st): continue
                    out.append((["transitive",cohn,stn,pln,pscn,gln,gscn,tvn],c))
    return out
if __name__=="__main__":
    cs=cases()
    print(len(cs))
    keys=set(tuple(sorted((k,v) for k,v in c.items() if k not in('pl','gl'))) for p,c in cs)
    print(len(keys))


# ---------------------------------------------------------------- shader generation (port of initPrograms)
def gen_shader(c):
    """returns dict name->(stage, glsl)"""
    return gen_transitive(c) if c['trans'] else gen_normal(c)

def type_str(dt): return {1:"uint64_t",2:"float",3:"double"}.get(dt,"uint")

def sem_str(sc):
    return {BUF:"gl_StorageSemanticsBuffer",PHYS:"gl_StorageSemanticsBuffer",IMG:"gl_StorageSemanticsImage",WG:"gl_StorageSemanticsShared"}[sc]

HEADER_EXT = ("#extension GL_KHR_shader_subgroup_basic : enable\n"
 "#extension GL_KHR_shader_subgroup_shuffle : enable\n"
 "#extension GL_KHR_shader_subgroup_ballot : enable\n"
 "#extension GL_KHR_memory_scope_semantics : enable\n"
 "#extension GL_ARB_gpu_shader_int64 : enable\n"
 "#extension GL_EXT_buffer_reference : enable\n"
 "// DIM/NUM_WORKGROUP_EACH_DIM overriden by spec constants\n"
 "layout(constant_id = 0) const int DIM = 1;\n"
 "layout(constant_id = 1) const int NUM_WORKGROUP_EACH_DIM = 1;\n")

VERT = ("#version 450 core\n"
 "vec2 coords[4] = {ivec2(-1,-1), ivec2(-1, 1), ivec2(1, -1), ivec2(1, 1)};\n"
 "void main() { gl_Position = vec4(coords[gl_VertexIndex], 0, 1); }\n")

def gen_normal(c):
    dt=c['dt']; ts=type_str(dt); int_type = dt in (0,1)
    scope=c['scope']; psc=c['psc']; gsc=c['gsc']; st=c['st']; stage=c['stage']; tt=c['tt']
    core11=c['core11']; coh=c['coh']; rmw=c['rmw']
    inv = scope
    if scope in (0,1) and (psc==WG or gsc==WG): inv = 2
    scopeStr = ["gl_ScopeDevice","gl_ScopeQueueFamily","gl_ScopeWorkgroup","gl_ScopeSubgroup"][scope]
    ssr = sem_str(psc)
    ssa = ssr
    if st in (1,0): ssr += " | " + sem_str(gsc)
    if st in (2,0): ssa += " | " + sem_str(gsc)
    semR="gl_SemanticsRelease"; semA="gl_SemanticsAcquire"; semAR="gl_SemanticsAcquireRelease"
    if not coh and tt != 1:
        assert not core11
        semR+=" | gl_SemanticsMakeAvailable"; semA+=" | gl_SemanticsMakeVisible"; semAR+=" | gl_SemanticsMakeAvailable | gl_SemanticsMakeVisible"
    s="#version 450 core\n"
    if not core11: s+="#pragma use_vulkan_memory_model\n"
    if not int_type:
        s+="#extension GL_EXT_shader_atomic_float : enable\n#extension GL_KHR_memory_scope_semantics : enable\n"
    if split(st): s+="#extension GL_EXT_split_barrier : enable\n"
    s+=HEADER_EXT
    s+="struct S { %s x[DIM*DIM]; };\n"%ts
    if stage==0: s+="layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;\n"
    if coh:
        if core11: memqual="coherent"
        else: memqual=["devicecoherent","queuefamilycoherent","workgroupcoherent","subgroupcoherent"][scope]
    else:
        assert not core11
        memqual="nonprivate"
    pcm=""
    if psc==PHYS:
        s+="layout(buffer_reference) buffer PayloadRef { %s x[]; };\n"%ts
        pcm+="   layout(offset = 0) PayloadRef payloadref;\n"
    elif psc==BUF:
        s+="layout(set=0, binding=0) %s buffer Payload { %s x[]; } payload;\n"%(memqual,ts)
    elif psc==IMG:
        s+=("layout(set=0, binding=0, r32ui) uniform %s uimage2D payload;\n" if int_type else "layout(set=0, binding=0, r32f) uniform %s image2D payload;\n")%memqual
    else:
        s+="shared S payload;\n"
    if st not in (5,4):
        if gsc==PHYS:
            s+="layout(buffer_reference) buffer GuardRef { %s x[]; };\n"%ts
            pcm+="layout(offset = 8) GuardRef guard;\n"
        elif gsc==BUF:
            s+="layout(set=0, binding=1) buffer Guard { %s x[]; } guard;\n"%ts
        elif gsc==IMG:
            s+=("layout(set=0, binding=1, r32ui) uniform %s uimage2D guard;\n" if int_type else "layout(set=0, binding=1, r32f) uniform %s image2D guard;\n")%memqual
        else:
            s+="shared S guard;\n"
    s+="layout(set=0, binding=2) buffer Fail { uint x[]; } fail;\n"
    if pcm: s+="layout (push_constant, std430) uniform PC {\n"+pcm+"};\n"
    s+="void main()\n{\n   bool pass = true;\n   bool skip = false;\n"
    if psc==PHYS: s+="   %s PayloadRef payload = payloadref;\n"%memqual
    if stage==2: s+="   if (gl_HelperInvocation) { return; }\n"
    if inv==3:
        s+=("   uvec4 ballot = subgroupBallot(true);\n"
            "   if (!subgroupBallotBitExtract(ballot, gl_SubgroupInvocationID^(gl_SubgroupSize-1))) { return; }\n")
        if stage==0:
            s+=("   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);\n"
                "   ivec2 partnerLocalId    = subgroupShuffleXor(localId, gl_SubgroupSize-1);\n"
                "   uint sharedCoord        = localId.y * DIM + localId.x;\n"
                "   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;\n"
                "   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;\n"
                "   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;\n"
                "   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);\n"
                "   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);\n")
        elif stage==1:
            s+=("   uint bufferCoord        = gl_VertexIndex;\n"
                "   uint partnerBufferCoord = subgroupShuffleXor(gl_VertexIndex, gl_SubgroupSize-1);\n"
                "   ivec2 imageCoord        = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));\n"
                "   ivec2 partnerImageCoord = subgroupShuffleXor(imageCoord, gl_SubgroupSize-1);\n"
                "   gl_PointSize            = 1.0f;\n"
                "   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);\n\n")
        else:
            s+=("   ivec2 localId        = ivec2(gl_FragCoord.xy) % ivec2(DIM);\n"
                "   ivec2 groupId        = ivec2(gl_FragCoord.xy) / ivec2(DIM);\n"
                "   ivec2 partnerLocalId = subgroupShuffleXor(localId, gl_SubgroupSize-1);\n"
                "   ivec2 partnerGroupId = subgroupShuffleXor(groupId, gl_SubgroupSize-1);\n"
                "   uint sharedCoord     = localId.y * DIM + localId.x;\n"
                "   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;\n"
                "   uint bufferCoord     = (groupId.y * NUM_WORKGROUP_EACH_DIM + groupId.x)*DIM*DIM + sharedCoord;\n"
                "   uint partnerBufferCoord = (partnerGroupId.y * NUM_WORKGROUP_EACH_DIM + partnerGroupId.x)*DIM*DIM + partnerSharedCoord;\n"
                "   ivec2 imageCoord     = ivec2(groupId.xy * ivec2(DIM) + localId);\n"
                "   ivec2 partnerImageCoord = ivec2(partnerGroupId.xy * ivec2(DIM) + partnerLocalId);\n")
    elif inv==2:
        s+=("   ivec2 localId           = ivec2(gl_LocalInvocationID.xy);\n"
            "   ivec2 partnerLocalId    = ivec2(DIM-1)-ivec2(gl_LocalInvocationID.xy);\n"
            "   uint sharedCoord        = localId.y * DIM + localId.x;\n"
            "   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;\n"
            "   uint bufferCoord        = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + sharedCoord;\n"
            "   uint partnerBufferCoord = (gl_WorkGroupID.y * NUM_WORKGROUP_EACH_DIM + gl_WorkGroupID.x)*DIM*DIM + partnerSharedCoord;\n"
            "   ivec2 imageCoord        = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + localId);\n"
            "   ivec2 partnerImageCoord = ivec2(gl_WorkGroupID.xy * gl_WorkGroupSize.xy + partnerLocalId);\n")
    else:
        if stage==0:
            s+=("   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);\n"
                "   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);\n"
                "   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;\n"
                "   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;\n"
                "   ivec2 imageCoord        = globalId;\n"
                "   ivec2 partnerImageCoord = partnerGlobalId;\n")
        elif stage==1:
            s+=("   ivec2 globalId          = ivec2(gl_VertexIndex % (DIM*NUM_WORKGROUP_EACH_DIM), gl_VertexIndex / (DIM*NUM_WORKGROUP_EACH_DIM));\n"
                "   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - globalId;\n"
                "   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;\n"
                "   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;\n"
                "   ivec2 imageCoord        = globalId;\n"
                "   ivec2 partnerImageCoord = partnerGlobalId;\n"
                "   gl_PointSize            = 1.0f;\n"
                "   gl_Position             = vec4(0.0f, 0.0f, 0.0f, 1.0f);\n\n")
        else:
            s+=("   ivec2 localId       = ivec2(gl_FragCoord.xy) % ivec2(DIM);\n"
                "   ivec2 groupId       = ivec2(gl_FragCoord.xy) / ivec2(DIM);\n"
                "   ivec2 partnerLocalId = ivec2(DIM-1)-localId;\n"
                "   ivec2 partnerGroupId = groupId;\n"
                "   uint sharedCoord    = localId.y * DIM + localId.x;\n"
                "   uint partnerSharedCoord = partnerLocalId.y * DIM + partnerLocalId.x;\n"
                "   uint bufferCoord    = (groupId.y * NUM_WORKGROUP_EACH_DIM + groupId.x)*DIM*DIM + sharedCoord;\n"
                "   uint partnerBufferCoord = (partnerGroupId.y * NUM_WORKGROUP_EACH_DIM + partnerGroupId.x)*DIM*DIM + partnerSharedCoord;\n"
                "   ivec2 imageCoord    = ivec2(groupId.xy * ivec2(DIM) + localId);\n"
                "   ivec2 partnerImageCoord = ivec2(partnerGroupId.xy * ivec2(DIM) + partnerLocalId);\n")
    if psc==WG: s+="   payload.x[sharedCoord] = 0;\n"
    if gsc==WG: s+="   guard.x[sharedCoord] = 0;\n"
    if psc==WG or gsc==WG:
        s+="   subgroupBarrier();\n" if inv==3 else "   barrier();\n"
    PAY = lambda: None
    if tt==0:
        if int_type:
            if psc in (BUF,PHYS): s+="   payload.x[bufferCoord] = bufferCoord + (payload.x[partnerBufferCoord]>>31);\n"
            elif psc==IMG: s+="   imageStore(payload, imageCoord, uvec4(bufferCoord + (imageLoad(payload, partnerImageCoord).x>>31), 0, 0, 0));\n"
            else: s+="   payload.x[sharedCoord] = bufferCoord + (payload.x[partnerSharedCoord]>>31);\n"
        else:
            if psc in (BUF,PHYS): s+="   payload.x[bufferCoord] = %s(bufferCoord) + ((floatBitsToInt(float(payload.x[partnerBufferCoord])))>>31);\n"%ts
            elif psc==IMG: s+="   imageStore(payload, imageCoord, vec4(%s(bufferCoord + (floatBitsToInt(float(imageLoad(payload, partnerImageCoord).x))>>31)), 0, 0, 0)); \n"%ts
            else: s+="   payload.x[sharedCoord] = %s(bufferCoord) + ((floatBitsToInt(float(payload.x[partnerSharedCoord])))>>31);\n"%ts
    else:
        if psc in (BUF,PHYS): s+="   %s r = payload.x[partnerBufferCoord];\n"%ts
        elif psc==IMG: s+="   %s r = imageLoad(payload, partnerImageCoord).x;\n"%ts
        else: s+="   %s r = payload.x[partnerSharedCoord];\n"%ts
    if st==5:
        s+=("   memoryBarrier(%s, %s, %s);\n   controlBarrier(%s, gl_ScopeInvocation, 0, 0);\n   memoryBarrier(%s, %s, %s);\n"%(scopeStr,ssr,semR,scopeStr,scopeStr,ssa,semA))
    elif st==4:
        s+="   controlBarrier(%s, %s, %s | %s, %s);\n"%(scopeStr,scopeStr,ssr,ssa,semAR)
    elif st==6:
        s+=("   controlBarrierArrive(%s, %s, %s, %s);\n   controlBarrierWait(%s, %s, %s, %s);\n"%(scopeStr,scopeStr,ssr,semR,scopeStr,scopeStr,ssa,semA))
    elif st==7:
        s+=("   memoryBarrier(%s, %s, %s);\n   controlBarrierArrive(%s, %s, 0, gl_SemanticsRelaxed);\n "
            "   controlBarrierWait(%s, %s, 0, gl_SemanticsRelaxed);\n "
            "   memoryBarrier(%s, %s, %s);\n"%(scopeStr,ssr,semR,scopeStr,scopeStr,scopeStr,scopeStr,scopeStr,ssa,semA))
    elif st==8:
        s+=("   controlBarrierArrive(gl_ScopeWorkgroup, gl_ScopeWorkgroup, %s, %s);\n   barrier();\n   controlBarrierWait(gl_ScopeWorkgroup, gl_ScopeWorkgroup, %s, %s);\n"%(ssr,semR,ssa,semA))
    else:
        cast = "" if dt in (1,3) else ts
        if st in (1,0):
            s+="   memoryBarrier(%s, %s, %s);\n"%(scopeStr,ssr,semR)
            rel=", 0, 0"
        else:
            rel=", %s, %s"%(ssr,semR)
        if rmw:
            if gsc in (BUF,PHYS): s+="   atomicExchange(guard.x[bufferCoord], %s(1u), %s%s);\n"%(ts,scopeStr,rel)
            elif gsc==IMG: s+="   imageAtomicExchange(guard, imageCoord, %s(1u), %s%s);\n"%(cast,scopeStr,rel)
            else: s+="   atomicExchange(guard.x[sharedCoord], %s(1u), %s%s);\n"%(ts,scopeStr,rel)
        else:
            if gsc in (BUF,PHYS): s+="   atomicStore(guard.x[bufferCoord], %s(1u), %s%s);\n"%(ts,scopeStr,rel)
            elif gsc==IMG: s+="   imageAtomicStore(guard, imageCoord, %s(1u), %s%s);\n"%(cast,scopeStr,rel)
            else: s+="   atomicStore(guard.x[sharedCoord], %s(1u), %s%s);\n"%(ts,scopeStr,rel)
        if st in (2,0): acq=", 0, 0"
        else: acq=", %s, %s"%(ssa,semA)
        if rmw:
            if gsc in (BUF,PHYS): s+="   skip = atomicExchange(guard.x[partnerBufferCoord], %s(2u), %s%s) == 0;\n"%(ts,scopeStr,acq)
            elif gsc==IMG: s+="   skip = imageAtomicExchange(guard, partnerImageCoord, %s(2u), %s%s) == 0;\n"%(cast,scopeStr,acq)
            else: s+="   skip = atomicExchange(guard.x[partnerSharedCoord], %s(2u), %s%s) == 0;\n"%(ts,scopeStr,acq)
        else:
            if gsc in (BUF,PHYS): s+="   skip = atomicLoad(guard.x[partnerBufferCoord], %s%s) == 0;\n"%(scopeStr,acq)
            elif gsc==IMG: s+="   skip = imageAtomicLoad(guard, partnerImageCoord, %s%s) == 0;\n"%(scopeStr,acq)
            else: s+="   skip = atomicLoad(guard.x[partnerSharedCoord], %s%s) == 0;\n"%(scopeStr,acq)
        if st in (2,0):
            s+="   memoryBarrier(%s, %s, %s);\n"%(scopeStr,ssa,semA)
    if tt==0:
        if psc in (BUF,PHYS): s+="   %s r = payload.x[partnerBufferCoord];\n"%ts
        elif psc==IMG: s+="   %s r = imageLoad(payload, partnerImageCoord).x;\n"%ts
        else: s+="   %s r = payload.x[partnerSharedCoord];\n"%ts
        s+="   if (!skip && r != %s(partnerBufferCoord)) { fail.x[bufferCoord] = 1; }\n}\n"%ts
    else:
        s+="   if (!skip) {\n   "
        if psc in (BUF,PHYS): s+="   payload.x[bufferCoord] = %s(bufferCoord);\n"%ts
        elif psc==IMG:
            s+=("   imageStore(payload, imageCoord, uvec4(bufferCoord, 0, 0, 0));\n" if int_type else "   imageStore(payload, imageCoord, vec4(%s(bufferCoord), 0, 0, 0));\n"%ts)
        else: s+="   payload.x[sharedCoord] = %s(bufferCoord);\n"%ts
        s+="   }\n   if (r != 0) { fail.x[bufferCoord] = 1; }\n}\n"
    if stage==0: return {"test":("comp",s)}
    if stage==1: return {"test":("vert",s)}
    return {"vert":("vert",VERT),"test":("frag",s)}

def gen_transitive(c):
    dt=0; ts="uint"; int_type=True
    psc=c['psc']; gsc=c['gsc']; st=c['st']; coh=c['coh']; tv=c['transvis']
    sp=sem_str(psc); sg=sem_str(gsc); sall=sp+" | "+sg
    s="#version 450 core\n#pragma use_vulkan_memory_model\n"
    s+=HEADER_EXT+"shared bool sharedSkip;\n"
    s+="layout(local_size_x_id = 0, local_size_y_id = 0, local_size_z = 1) in;\n"
    if coh: memqual="workgroupcoherent"; semAvail=""; semVis=""
    else: memqual="nonprivate"; semAvail=" | gl_SemanticsMakeAvailable"; semVis=" | gl_SemanticsMakeVisible"
    pcm=""
    if psc==PHYS:
        s+="layout(buffer_reference) buffer PayloadRef { uint x[]; };\n"; pcm+="   layout(offset = 0) PayloadRef payloadref;\n"
    elif psc==BUF: s+="layout(set=0, binding=0) %s buffer Payload { uint x[]; } payload;\n"%memqual
    else: s+="layout(set=0, binding=0, r32ui) uniform %s uimage2D payload;\n"%memqual
    if gsc==PHYS:
        s+="layout(buffer_reference) buffer GuardRef { uint x[]; };\n"; pcm+="layout(offset = 8) GuardRef guard;\n"
    elif gsc==BUF: s+="layout(set=0, binding=1) buffer Guard { uint x[]; } guard;\n"
    else: s+="layout(set=0, binding=1, r32ui) uniform %s uimage2D guard;\n"%memqual
    s+="layout(set=0, binding=2) buffer Fail { uint x[]; } fail;\n"
    if pcm: s+="layout (push_constant, std430) uniform PC {\n"+pcm+"};\n"
    s+="void main()\n{\n   bool pass = true;\n   bool skip = false;\n   sharedSkip = false;\n"
    if psc==PHYS: s+="   %s PayloadRef payload = payloadref;\n"%memqual
    s+=("   ivec2 globalId          = ivec2(gl_GlobalInvocationID.xy);\n"
        "   ivec2 partnerGlobalId   = ivec2(DIM*NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_GlobalInvocationID.xy);\n"
        "   uint bufferCoord        = globalId.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId.x;\n"
        "   uint partnerBufferCoord = partnerGlobalId.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId.x;\n"
        "   ivec2 imageCoord        = globalId;\n"
        "   ivec2 partnerImageCoord = partnerGlobalId;\n"
        "   ivec2 globalId00          = ivec2(DIM) * ivec2(gl_WorkGroupID.xy);\n"
        "   ivec2 partnerGlobalId00   = ivec2(DIM) * (ivec2(NUM_WORKGROUP_EACH_DIM-1) - ivec2(gl_WorkGroupID.xy));\n"
        "   uint bufferCoord00        = globalId00.y * DIM*NUM_WORKGROUP_EACH_DIM + globalId00.x;\n"
        "   uint partnerBufferCoord00 = partnerGlobalId00.y * DIM*NUM_WORKGROUP_EACH_DIM + partnerGlobalId00.x;\n"
        "   ivec2 imageCoord00        = globalId00;\n"
        "   ivec2 partnerImageCoord00 = partnerGlobalId00;\n")
    if psc in (BUF,PHYS): s+="   payload.x[bufferCoord] = bufferCoord + (payload.x[partnerBufferCoord]>>31);\n"
    else: s+="   imageStore(payload, imageCoord, uvec4(bufferCoord + (imageLoad(payload, partnerImageCoord).x>>31), 0, 0, 0));\n"
    s+="   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, %s | gl_StorageSemanticsShared, gl_SemanticsAcquireRelease%s);\n"%(sp,semAvail)
    s+="   if (all(equal(gl_LocalInvocationID.xy, ivec2(0,0)))) {\n"
    if st in (3,2):
        if gsc in (BUF,PHYS): s+="       atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, %s, gl_SemanticsRelease | gl_SemanticsMakeAvailable);\n"%sp
        else: s+="       imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeDevice, %s, gl_SemanticsRelease | gl_SemanticsMakeAvailable);\n"%sp
    else:
        s+="       memoryBarrier(gl_ScopeDevice, %s, gl_SemanticsRelease | gl_SemanticsMakeAvailable);\n"%sall
        if gsc in (BUF,PHYS): s+="       atomicStore(guard.x[bufferCoord], uint(1u), gl_ScopeDevice, 0, 0);\n"
        else: s+="       imageAtomicStore(guard, imageCoord, uint(1u), gl_ScopeDevice, 0, 0);\n"
    if not tv: s+="   }\n"
    if st in (3,1):
        if gsc in (BUF,PHYS): s+="       skip = atomicLoad(guard.x[partnerBufferCoord00], gl_ScopeDevice, %s, gl_SemanticsAcquire | gl_SemanticsMakeVisible) == 0;\n"%sp
        else: s+="       skip = imageAtomicLoad(guard, partnerImageCoord00, gl_ScopeDevice, %s, gl_SemanticsAcquire | gl_SemanticsMakeVisible) == 0;\n"%sp
    else:
        if gsc in (BUF,PHYS): s+="       skip = atomicLoad(guard.x[partnerBufferCoord00], gl_ScopeDevice, 0, 0) == 0;\n"
        else: s+="       skip = imageAtomicLoad(guard, partnerImageCoord00, gl_ScopeDevice, 0, 0) == 0;\n"
        s+="       memoryBarrier(gl_ScopeDevice, %s, gl_SemanticsAcquire | gl_SemanticsMakeVisible);\n"%sall
    if tv:
        s+="       sharedSkip = skip;\n   }\n"
        s+="   controlBarrier(gl_ScopeWorkgroup, gl_ScopeWorkgroup, %s | gl_StorageSemanticsShared, gl_SemanticsAcquireRelease%s);\n"%(sp,semVis)
        s+="   skip = sharedSkip;\n"
    if psc in (BUF,PHYS): s+="   uint r = payload.x[partnerBufferCoord];\n"
    else: s+="   uint r = imageLoad(payload, partnerImageCoord).x;\n"
    s+="   if (!skip && r != uint(partnerBufferCoord)) { fail.x[bufferCoord] = 1; }\n}\n"
    return {"test":("comp",s)}


def write_all(root):
    import hashlib, os
    src_dir = os.path.join(root, "hodow_cts/shaders/src/memory_model/mp")
    os.makedirs(src_dir, exist_ok=True)
    ext = {"comp": "comp", "vert": "vert", "frag": "frag"}
    written = {}
    def put(stage, text):
        h = hashlib.sha1(text.encode()).hexdigest()[:12]
        rel = "memory_model/mp/%s.%s" % (h, ext[stage])
        if rel not in written:
            with open(os.path.join(root, "hodow_cts/shaders/src", rel), "w") as f:
                f.write(text)
            written[rel] = 1
        return rel
    head = '''# Shader manifest for dEQP-VK.memory_model.message_passing.*, write_after_read.* and transitive.*
#
# `MemoryModelTestCase::initPrograms` / `initProgramsTransitive`, pre-expanded by hodow_cts/scripts/gen_memory_model_mp.py over the loops of
# createTests() and its skip filters. One entry per distinct parameter set: the shader does not depend on the memory
# locality flags, so the local/nonlocal variants of a case share an entry. The split control barrier cases
# (sync_type 6, 7, 8) get no entry: GL_EXT_split_barrier is not something every glslang knows, and the port reports
# those cases as not supported because vulkanalia has no shaderSplitBarrier feature struct to query.
# Fields: test_type 0 mp / 1 war, sync_type 0..8 as SyncType, payload_sc / guard_sc 0 buffer, 1 image, 2 workgroup,
# 3 physbuffer, scope 0 device, 1 queuefamily, 2 workgroup, 3 subgroup, stage 0 comp, 1 vert, 2 frag, data_type 0 u32,
# 1 u64, 2 f32, 3 f64.

upstream_source = "external/vulkancts/modules/vulkan/memory_model/vktMemoryModelMessagePassing.cpp"
rust_module = "memory_model/message_passing_tests"

'''
    out = [head]
    seen = {}
    n = 0
    vert_rel = put("vert", VERT)
    for path, c in cases():
        if c['st'] in (6, 7, 8):
            continue
        key = tuple(sorted((k, v) for k, v in c.items() if k not in ('pl', 'gl')))
        if key in seen:
            continue
        seen[key] = n
        d = gen_shader(c)
        progs = []
        for name, (stage, text) in d.items():
            rel = vert_rel if name == "vert" else put(stage, text)
            progs.append('    { name = "%s", template = "%s", stage = "%s" },' % (name, rel, stage))
        b = lambda v: "true" if v else "false"
        out.append('[[case]]\nname = "mp%d"\nrust_const = "MP_%d"\nrust_type = "MessagePassingPrograms"\nprograms = [\n%s\n]\n'
                   'params = { test_type = { type = "u32", value = %d }, core11 = { type = "bool", value = %s }, coherent = { type = "bool", value = %s }, '
                   'atomic_rmw = { type = "bool", value = %s }, payload_sc = { type = "u32", value = %d }, guard_sc = { type = "u32", value = %d }, '
                   'scope = { type = "u32", value = %d }, sync_type = { type = "u32", value = %d }, stage = { type = "u32", value = %d }, '
                   'data_type = { type = "u32", value = %d }, transitive = { type = "bool", value = %s }, transitive_vis = { type = "bool", value = %s } }\n'
                   % (n, n, "\n".join(progs), c['tt'], b(c['core11']), b(c['coh']), b(c['rmw']), c['psc'], c['gsc'], c['scope'], c['st'], c['stage'], c['dt'], b(c['trans']), b(c['transvis'])))
        n += 1
    with open(os.path.join(root, "hodow_cts/shaders/manifest/memory_model_message_passing.toml"), "w") as f:
        f.write("\n".join(out))
    return n, len(written)

if __name__ == "__main__" and len(sys.argv) > 1:
    print(write_all(sys.argv[1]))
