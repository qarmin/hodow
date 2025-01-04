#!/bin/bash
# Writes the user_defined_io shader templates (text only); re-running it is diff-clean.
set -e
OUT="$(cd "$(dirname "$0")/.." && pwd)/shaders/src/tessellation"
T=$'\t'

struct_decl() { # $1 = z to include the array member
    echo "struct S"
    echo "{"
    echo "${T}highp int x;"
    echo "${T}highp vec4 y;"
    [ "$1" = z ] && echo "${T}highp float z[2];"
    echo "};"
}

block_decl() { # $1 = qualifier ("patch out"/"patch in"/"out"/"in"), $2 = full|light, $3 = instance, $4 = array suffix, $5 = location
    echo "layout(location = $5) $1 TheBlock"
    echo "{"
    [ "$2" = full ] && echo "${T}S blockS;"
    echo "${T}highp float blockFa[3];"
    echo "${T}S blockSa[2];"
    echo "${T}highp float blockF;"
    echo "} $3$4;"
}

s_assign() { # name indent zvar
    local n=$1 i=$2 z=$3
    echo "${i}${n}.x = int(v);"
    echo "${i}v += 0.4;"
    echo "${i}${n}.y = vec4(v, v+0.8, v+1.6, v+2.4);"
    echo "${i}v += 0.4;"
    if [ -n "$z" ]; then
        echo "${i}for (int ${z} = 0; ${z} < 2; ++${z})"
        echo "${i}{"
        echo "${i}${T}${n}.z[${z}] = v;"
        echo "${i}${T}v += 0.4;"
        echo "${i}}"
    fi
}

s_check() {
    local n=$1 i=$2 z=$3
    echo "${i}allOk = allOk && compare_int(${n}.x, int(v));"
    echo "${i}v += 0.4;"
    echo "${i}if (allOk) ++firstFailedInputIndex;"
    echo "${i}allOk = allOk && compare_vec4(${n}.y, vec4(v, v+0.8, v+1.6, v+2.4));"
    echo "${i}v += 0.4;"
    echo "${i}if (allOk) ++firstFailedInputIndex;"
    if [ -n "$z" ]; then
        echo "${i}for (int ${z} = 0; ${z} < 2; ++${z})"
        echo "${i}{"
        echo "${i}${T}allOk = allOk && compare_float(${n}.z[${z}], v);"
        echo "${i}${T}v += 0.4;"
        echo "${i}${T}if (allOk) ++firstFailedInputIndex;"
        echo "${i}}"
    fi
}

f_assign() { echo "$2$1 = v;"; echo "${2}v += 0.4;"; }
f_check() { echo "${2}allOk = allOk && compare_float($1, v);"; echo "${2}v += 0.4;"; echo "${2}if (allOk) ++firstFailedInputIndex;"; }

fa_assign() { # name indent var count
    echo "${2}for (int $3 = 0; $3 < $4; ++$3)"; echo "${2}{"; f_assign "$1[$3]" "${2}${T}"; echo "${2}}"
}
fa_check() {
    echo "${2}for (int $3 = 0; $3 < $4; ++$3)"; echo "${2}{"; f_check "$1[$3]" "${2}${T}"; echo "${2}}"
}

# block_traverse mode prefix k indent full|light
block_traverse() {
    local mode=$1 p=$2 k=$3 i=$4 kind=$5
    local v0="i$k" v1="i$((k + 1))"
    if [ "$kind" = full ]; then
        s_$mode "${p}.blockS" "$i" "$v0"
    fi
    fa_$mode "${p}.blockFa" "$i" "$v0" 3
    echo "${i}for (int $v0 = 0; $v0 < 2; ++$v0)"
    echo "${i}{"
    s_$mode "${p}.blockSa[$v0]" "${i}${T}" "$v1"
    echo "${i}}"
    f_$mode "${p}.blockF" "$i"
}

TCS_HEAD='#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(vertices = 5) out;

layout(location = 0) patch out highp vec2 in_te_positionScale;
layout(location = 1) patch out highp vec2 in_te_positionOffset;
'
TCS_TAIL='
void main (void)
{
	{
		highp float v = 1.3;
'
TCS_END='	}

    gl_TessLevelInner[0] = in_tc_attr[0];
    gl_TessLevelInner[1] = in_tc_attr[1];

    gl_TessLevelOuter[0] = in_tc_attr[2];
    gl_TessLevelOuter[1] = in_tc_attr[3];
    gl_TessLevelOuter[2] = in_tc_attr[4];
    gl_TessLevelOuter[3] = in_tc_attr[5];

    in_te_positionScale  = vec2(in_tc_attr[6], in_tc_attr[7]);
    in_te_positionOffset = vec2(in_tc_attr[8], in_tc_attr[9]);
}'
TCS_ATTR='
layout(location = 0) in highp float in_tc_attr[${vertex_size}];
'

TES_HEAD='#version 310 es
#extension GL_EXT_tessellation_shader : require

layout(${primitive}) in;

layout(location = 0) patch in highp vec2 in_te_positionScale;
layout(location = 1) patch in highp vec2 in_te_positionOffset;
'
TES_MID='
layout(location = 0) out highp vec4 in_f_color;

// Will contain the index of the first incorrect input,
// or the number of inputs if all are correct
layout (set = 0, binding = 0, std430) coherent restrict buffer Output {
    int  numInvocations;
    uint firstFailedInputIndex[];
} sb_out;

bool compare_int   (int   a, int   b) { return a == b; }
bool compare_float (float a, float b) { return abs(a - b) < 0.01f; }
bool compare_vec4  (vec4  a, vec4  b) { return all(lessThan(abs(a - b), vec4(0.01f))); }

void main (void)
{
	bool allOk = true;
	highp uint firstFailedInputIndex = 0u;
	{
		highp float v = 1.3;
'
TES_END='	}

    gl_Position = vec4(gl_TessCoord.xy*in_te_positionScale + in_te_positionOffset, 0.0, 1.0);
    in_f_color  = allOk ? vec4(0.0, 1.0, 0.0, 1.0)
                        : vec4(1.0, 0.0, 0.0, 1.0);

    int index = atomicAdd(sb_out.numInvocations, 1);
    sb_out.firstFailedInputIndex[index] = firstFailedInputIndex;
}'

I2="${T}${T}"
I3="${T}${T}${T}"

# ---- per_patch
{
    printf '%s' "$TCS_HEAD"; echo; struct_decl; echo
    echo "layout(location = 2) patch out S in_te_s;"
    echo "layout(location = 4) patch out highp float in_te_f;"
    printf '%s' "$TCS_ATTR"; printf '%s' "$TCS_TAIL"
    echo; echo "${I2}// Assign values to output in_te_s"; s_assign in_te_s "$I2"
    echo; echo "${I2}// Assign values to output in_te_f"; f_assign in_te_f "$I2"
    printf '%s\n' "$TCS_END"
} > "$OUT/udio_per_patch.tesc"
{
    printf '%s' "$TES_HEAD"; echo; struct_decl; echo
    echo "layout(location = 2) patch in S in_te_s;"
    echo "layout(location = 4) patch in highp float in_te_f;"
    printf '%s' "$TES_MID"
    echo; echo "${I2}// Check values in input in_te_s"; s_check in_te_s "$I2"
    echo; echo "${I2}// Check values in input in_te_f"; f_check in_te_f "$I2"
    printf '%s\n' "$TES_END"
} > "$OUT/udio_per_patch.tese"

# ---- per_patch_array (no struct: arrays of structures are disallowed)
{
    printf '%s' "$TCS_HEAD"; echo
    echo "layout(location = 2) patch out highp float in_te_f[3];"
    printf '%s' "$TCS_ATTR"; printf '%s' "$TCS_TAIL"
    echo; echo "${I2}// Assign values to output in_te_f"; fa_assign in_te_f "$I2" i0 3
    printf '%s\n' "$TCS_END"
} > "$OUT/udio_per_patch_array.tesc"
{
    printf '%s' "$TES_HEAD"; echo
    echo "layout(location = 2) patch in highp float in_te_f[3];"
    printf '%s' "$TES_MID"
    echo; echo "${I2}// Check values in input in_te_f"; fa_check in_te_f "$I2" i0 3
    printf '%s\n' "$TES_END"
} > "$OUT/udio_per_patch_array.tese"

# ---- per_patch_block
{
    printf '%s' "$TCS_HEAD"; echo; struct_decl z; echo
    block_decl "patch out" full tcBlock "" 2
    printf '%s' "$TCS_ATTR"; printf '%s' "$TCS_TAIL"
    echo; echo "${I2}// Assign values to output tcBlock"; block_traverse assign tcBlock 0 "$I2" full
    printf '%s\n' "$TCS_END"
} > "$OUT/udio_per_patch_block.tesc"
{
    printf '%s' "$TES_HEAD"; echo; struct_decl z; echo
    block_decl "patch in" full teBlock "" 2
    printf '%s' "$TES_MID"
    echo; echo "${I2}// Check values in input teBlock"; block_traverse check teBlock 0 "$I2" full
    printf '%s\n' "$TES_END"
} > "$OUT/udio_per_patch_block.tese"

# ---- per_patch_block_array (lightweight block, two instances)
{
    printf '%s' "$TCS_HEAD"; echo; struct_decl z; echo
    block_decl "patch out" light tcBlock "[2]" 2
    printf '%s' "$TCS_ATTR"; printf '%s' "$TCS_TAIL"
    echo; echo "${I2}// Assign values to output tcBlock"
    echo "${I2}for (int i0 = 0; i0 < 2; ++i0)"; echo "${I2}{"
    block_traverse assign "tcBlock[i0]" 1 "$I3" light
    echo "${I2}}"
    printf '%s\n' "$TCS_END"
} > "$OUT/udio_per_patch_block_array.tesc"
{
    printf '%s' "$TES_HEAD"; echo; struct_decl z; echo
    block_decl "patch in" light teBlock "[2]" 2
    printf '%s' "$TES_MID"
    echo; echo "${I2}// Check values in input teBlock"
    echo "${I2}for (int i0 = 0; i0 < 2; ++i0)"; echo "${I2}{"
    block_traverse check "teBlock[i0]" 1 "$I3" light
    echo "${I2}}"
    printf '%s\n' "$TES_END"
} > "$OUT/udio_per_patch_block_array.tese"

# ---- per_vertex
{
    printf '%s' "$TCS_HEAD"; echo; struct_decl; echo
    echo "layout(location = 2) out S in_te_s[];"
    echo "layout(location = 4) out highp float in_te_f[];"
    printf '%s' "$TCS_ATTR"; printf '%s' "$TCS_TAIL"
    echo "${I2}v += float(gl_InvocationID)*0.8;"
    echo; echo "${I2}// Assign values to output in_te_s"; s_assign "in_te_s[gl_InvocationID]" "$I2"
    echo "${I2}v += float(5-gl_InvocationID-1)*0.8;"
    echo "${I2}v += float(gl_InvocationID)*0.4;"
    echo; echo "${I2}// Assign values to output in_te_f"; f_assign "in_te_f[gl_InvocationID]" "$I2"
    echo "${I2}v += float(5-gl_InvocationID-1)*0.4;"
    printf '%s\n' "$TCS_END"
} > "$OUT/udio_per_vertex.tesc"
{
    printf '%s' "$TES_HEAD"; echo; struct_decl; echo
    echo 'layout(location = 2) in S in_te_s[${vertex_size}];'
    echo 'layout(location = 4) in highp float in_te_f[${vertex_size}];'
    printf '%s' "$TES_MID"
    echo; echo "${I2}// Check values in input in_te_s"
    echo "${I2}for (int i0 = 0; i0 < 5; ++i0)"; echo "${I2}{"
    s_check "in_te_s[i0]" "$I3"
    echo "${I2}}"
    echo; echo "${I2}// Check values in input in_te_f"; fa_check in_te_f "$I2" i0 5
    printf '%s\n' "$TES_END"
} > "$OUT/udio_per_vertex.tese"

# ---- per_vertex_block
{
    printf '%s' "$TCS_HEAD"; echo; struct_decl z; echo
    block_decl "out" full tcBlock "[]" 2
    printf '%s' "$TCS_ATTR"; printf '%s' "$TCS_TAIL"
    echo "${I2}v += float(gl_InvocationID)*6.4;"
    echo; echo "${I2}// Assign values to output tcBlock"; block_traverse assign "tcBlock[gl_InvocationID]" 0 "$I2" full
    echo "${I2}v += float(5-gl_InvocationID-1)*6.4;"
    printf '%s\n' "$TCS_END"
} > "$OUT/udio_per_vertex_block.tesc"
{
    printf '%s' "$TES_HEAD"; echo; struct_decl z; echo
    block_decl "in" full teBlock '[${vertex_size}]' 2
    printf '%s' "$TES_MID"
    echo; echo "${I2}// Check values in input teBlock"
    echo "${I2}for (int i0 = 0; i0 < 5; ++i0)"; echo "${I2}{"
    block_traverse check "teBlock[i0]" 1 "$I3" full
    echo "${I2}}"
    printf '%s\n' "$TES_END"
} > "$OUT/udio_per_vertex_block.tese"

cat > "$OUT/udio.frag" <<'EOF'
#version 310 es

layout(location = 0) in  highp   vec4 in_f_color;
layout(location = 0) out mediump vec4 o_color;

void main (void)
{
    o_color = in_f_color;
}
EOF
