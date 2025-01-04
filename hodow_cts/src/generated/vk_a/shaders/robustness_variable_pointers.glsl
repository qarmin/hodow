OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0014	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0014
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002f	=	OpLoad	%0014	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0032	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0035	=	OpLoad	%0014	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0038	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%003b	=	OpLoad	%0014	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%0041	=	OpLoad	%0014	%003f
OpStore	%0040	%0041
%0042	=	OpLoad	%0013	%0003
%0043	=	OpAccessChain	%0020	%0004
OpStore	%0043	%0042
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
; ----------------- TYPES --------------------
%0004	=	OpTypeVoid
%0006	=	OpTypeFloat	32
%0007	=	OpTypeVector	%0006	4
; ----------------- CONSTANTS ----------------
%0009	=	OpConstant	%0006	1
; ----------------- ADVANCED TYPES -----------
%0005	=	OpTypeFunction	%0004
%0008	=	OpTypePointer	Output	%0007
; ----------------- CONSTANTS ----------------
%000a	=	OpConstantComposite	%0007	%0009	%0009	%0009	%0009
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%0008	Output
%0002	=	OpFunction	%0004	None	%0005
%000b	=	OpLabel
OpStore	%0003	%000a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0014	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0014
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0014	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0032	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0033	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0014	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0038	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%0039	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0014	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%003f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0014	%003d
OpStore	%0040	%0041
%0042	=	OpLoad	%0013	%0003
%0043	=	OpAccessChain	%0020	%0004
OpStore	%0043	%0042
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0015	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0015
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002f	=	OpLoad	%0015	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0032	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0035	=	OpLoad	%0015	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0038	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%003b	=	OpLoad	%0015	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%0041	=	OpLoad	%0015	%003f
OpStore	%0040	%0041
%0042	=	OpLoad	%0013	%0003
%0043	=	OpAccessChain	%0020	%0004
OpStore	%0043	%0042
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0015	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0015
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0015	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0032	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0033	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0015	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0038	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%0039	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0015	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%003f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0015	%003d
OpStore	%0040	%0041
%0042	=	OpLoad	%0013	%0003
%0043	=	OpAccessChain	%0020	%0004
OpStore	%0043	%0042
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0013	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0013
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002f	=	OpLoad	%0013	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0032	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0035	=	OpLoad	%0013	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0038	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%003b	=	OpLoad	%0013	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%0041	=	OpLoad	%0013	%003f
OpStore	%0040	%0041
%0042	=	OpLoad	%0013	%0003
%0043	=	OpAccessChain	%0020	%0004
OpStore	%0043	%0042
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0013	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0013
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016
%002c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0013	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017
%0032	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0033	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0013	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018
%0038	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%0039	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0013	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019
%003e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%003f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0013	%003d
OpStore	%0040	%0041
%0042	=	OpLoad	%0013	%0003
%0043	=	OpAccessChain	%0020	%0004
OpStore	%0043	%0042
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	32
OpDecorate	%0008	ArrayStride	128
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeInt	64	1
%0014	=	OpTypeInt	64	0
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
%0019	=	OpTypeVector	%0014	4
; ----------------- CONSTANTS ----------------
%001a	=	OpConstant	%0011	0
%001b	=	OpConstant	%0011	1
%001c	=	OpConstant	%0011	2
%001d	=	OpConstant	%0011	3
%001e	=	OpConstant	%0012	4
%001f	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0018	%001e
%0008	=	OpTypeArray	%0007	%001f
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%0020	=	OpTypePointer	StorageBuffer	%000a
%0021	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%0022	=	OpTypePointer	Uniform	%000b
%0023	=	OpTypePointer	Input	%0015
%0024	=	OpTypePointer	Output	%0015
%0025	=	OpTypePointer	StorageBuffer	%0013
%0026	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%0020	StorageBuffer
%0006	=	OpVariable	%0021	StorageBuffer
%000c	=	OpVariable	%0022	Uniform
%0003	=	OpVariable	%0023	Input
%0004	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000d	None	%000e
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000c	%001b
%0029	=	OpLoad	%0011	%0028
%002a	=	OpAccessChain	%0026	%000c	%001a
%002b	=	OpLoad	%0011	%002a
%002c	=	OpAccessChain	%0026	%000c	%001c
%002d	=	OpLoad	%0011	%002c
%002e	=	OpIEqual	%000f	%002d	%001a
%002f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001a
%0030	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001a
%0031	=	OpSelect	%0025	%002e	%002f	%0030
%0032	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001a
%0033	=	OpLoad	%0013	%0031
OpStore	%0032	%0033
%0034	=	OpIEqual	%000f	%002d	%001a
%0035	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001b
%0036	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001b
%0037	=	OpSelect	%0025	%0034	%0035	%0036
%0038	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001b
%0039	=	OpLoad	%0013	%0037
OpStore	%0038	%0039
%003a	=	OpIEqual	%000f	%002d	%001a
%003b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001c
%003c	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001c
%003d	=	OpSelect	%0025	%003a	%003b	%003c
%003e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001c
%003f	=	OpLoad	%0013	%003d
OpStore	%003e	%003f
%0040	=	OpIEqual	%000f	%002d	%001a
%0041	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001d
%0042	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001d
%0043	=	OpSelect	%0025	%0040	%0041	%0042
%0044	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001d
%0045	=	OpLoad	%0013	%0043
OpStore	%0044	%0045
%0046	=	OpIEqual	%000f	%002d	%001a
%0047	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001a
%0048	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001a
%0049	=	OpSelect	%0025	%0046	%0047	%0048
%004a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001a
%004b	=	OpLoad	%0013	%0049
OpStore	%004a	%004b
%004c	=	OpIEqual	%000f	%002d	%001a
%004d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001b
%004e	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001b
%004f	=	OpSelect	%0025	%004c	%004d	%004e
%0050	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001b
%0051	=	OpLoad	%0013	%004f
OpStore	%0050	%0051
%0052	=	OpIEqual	%000f	%002d	%001a
%0053	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001c
%0054	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001c
%0055	=	OpSelect	%0025	%0052	%0053	%0054
%0056	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001c
%0057	=	OpLoad	%0013	%0055
OpStore	%0056	%0057
%0058	=	OpIEqual	%000f	%002d	%001a
%0059	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001d
%005a	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001d
%005b	=	OpSelect	%0025	%0058	%0059	%005a
%005c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001d
%005d	=	OpLoad	%0013	%005b
OpStore	%005c	%005d
%005e	=	OpIEqual	%000f	%002d	%001a
%005f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001a
%0060	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001a
%0061	=	OpSelect	%0025	%005e	%005f	%0060
%0062	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001a
%0063	=	OpLoad	%0013	%0061
OpStore	%0062	%0063
%0064	=	OpIEqual	%000f	%002d	%001a
%0065	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001b
%0066	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001b
%0067	=	OpSelect	%0025	%0064	%0065	%0066
%0068	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001b
%0069	=	OpLoad	%0013	%0067
OpStore	%0068	%0069
%006a	=	OpIEqual	%000f	%002d	%001a
%006b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001c
%006c	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001c
%006d	=	OpSelect	%0025	%006a	%006b	%006c
%006e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001c
%006f	=	OpLoad	%0013	%006d
OpStore	%006e	%006f
%0070	=	OpIEqual	%000f	%002d	%001a
%0071	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001d
%0072	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001d
%0073	=	OpSelect	%0025	%0070	%0071	%0072
%0074	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001d
%0075	=	OpLoad	%0013	%0073
OpStore	%0074	%0075
%0076	=	OpIEqual	%000f	%002d	%001a
%0077	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001a
%0078	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001a
%0079	=	OpSelect	%0025	%0076	%0077	%0078
%007a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001a
%007b	=	OpLoad	%0013	%0079
OpStore	%007a	%007b
%007c	=	OpIEqual	%000f	%002d	%001a
%007d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001b
%007e	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001b
%007f	=	OpSelect	%0025	%007c	%007d	%007e
%0080	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001b
%0081	=	OpLoad	%0013	%007f
OpStore	%0080	%0081
%0082	=	OpIEqual	%000f	%002d	%001a
%0083	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001c
%0084	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001c
%0085	=	OpSelect	%0025	%0082	%0083	%0084
%0086	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001c
%0087	=	OpLoad	%0013	%0085
OpStore	%0086	%0087
%0088	=	OpIEqual	%000f	%002d	%001a
%0089	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001d
%008a	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001d
%008b	=	OpSelect	%0025	%0088	%0089	%008a
%008c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001d
%008d	=	OpLoad	%0013	%008b
OpStore	%008c	%008d
%008e	=	OpLoad	%0015	%0003
%008f	=	OpAccessChain	%0024	%0004
OpStore	%008f	%008e
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
; ----------------- TYPES --------------------
%0004	=	OpTypeVoid
%0006	=	OpTypeFloat	32
%0007	=	OpTypeVector	%0006	4
; ----------------- CONSTANTS ----------------
%0009	=	OpConstant	%0006	1
; ----------------- ADVANCED TYPES -----------
%0005	=	OpTypeFunction	%0004
%0008	=	OpTypePointer	Output	%0007
; ----------------- CONSTANTS ----------------
%000a	=	OpConstantComposite	%0007	%0009	%0009	%0009	%0009
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%0008	Output
%0002	=	OpFunction	%0004	None	%0005
%000b	=	OpLabel
OpStore	%0003	%000a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	32
OpDecorate	%0008	ArrayStride	128
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeInt	64	1
%0014	=	OpTypeInt	64	0
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
%0019	=	OpTypeVector	%0014	4
; ----------------- CONSTANTS ----------------
%001a	=	OpConstant	%0011	0
%001b	=	OpConstant	%0011	1
%001c	=	OpConstant	%0011	2
%001d	=	OpConstant	%0011	3
%001e	=	OpConstant	%0012	4
%001f	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0018	%001e
%0008	=	OpTypeArray	%0007	%001f
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%0020	=	OpTypePointer	StorageBuffer	%000a
%0021	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%0022	=	OpTypePointer	Uniform	%000b
%0023	=	OpTypePointer	Input	%0015
%0024	=	OpTypePointer	Output	%0015
%0025	=	OpTypePointer	StorageBuffer	%0013
%0026	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%0020	StorageBuffer
%0006	=	OpVariable	%0021	StorageBuffer
%000c	=	OpVariable	%0022	Uniform
%0003	=	OpVariable	%0023	Input
%0004	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000d	None	%000e
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000c	%001b
%0029	=	OpLoad	%0011	%0028
%002a	=	OpAccessChain	%0026	%000c	%001a
%002b	=	OpLoad	%0011	%002a
%002c	=	OpAccessChain	%0026	%000c	%001c
%002d	=	OpLoad	%0011	%002c
%002e	=	OpIEqual	%000f	%002d	%001a
%002f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001a
%0030	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001a
%0031	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001a
%0032	=	OpSelect	%0025	%002e	%0030	%0031
%0033	=	OpLoad	%0013	%002f
OpStore	%0032	%0033
%0034	=	OpIEqual	%000f	%002d	%001a
%0035	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001b
%0036	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001b
%0037	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001b
%0038	=	OpSelect	%0025	%0034	%0036	%0037
%0039	=	OpLoad	%0013	%0035
OpStore	%0038	%0039
%003a	=	OpIEqual	%000f	%002d	%001a
%003b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001c
%003c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001c
%003d	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001c
%003e	=	OpSelect	%0025	%003a	%003c	%003d
%003f	=	OpLoad	%0013	%003b
OpStore	%003e	%003f
%0040	=	OpIEqual	%000f	%002d	%001a
%0041	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001d
%0042	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001d
%0043	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001d
%0044	=	OpSelect	%0025	%0040	%0042	%0043
%0045	=	OpLoad	%0013	%0041
OpStore	%0044	%0045
%0046	=	OpIEqual	%000f	%002d	%001a
%0047	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001a
%0048	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001a
%0049	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001a
%004a	=	OpSelect	%0025	%0046	%0048	%0049
%004b	=	OpLoad	%0013	%0047
OpStore	%004a	%004b
%004c	=	OpIEqual	%000f	%002d	%001a
%004d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001b
%004e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001b
%004f	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001b
%0050	=	OpSelect	%0025	%004c	%004e	%004f
%0051	=	OpLoad	%0013	%004d
OpStore	%0050	%0051
%0052	=	OpIEqual	%000f	%002d	%001a
%0053	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001c
%0054	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001c
%0055	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001c
%0056	=	OpSelect	%0025	%0052	%0054	%0055
%0057	=	OpLoad	%0013	%0053
OpStore	%0056	%0057
%0058	=	OpIEqual	%000f	%002d	%001a
%0059	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001d
%005a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001d
%005b	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001d
%005c	=	OpSelect	%0025	%0058	%005a	%005b
%005d	=	OpLoad	%0013	%0059
OpStore	%005c	%005d
%005e	=	OpIEqual	%000f	%002d	%001a
%005f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001a
%0060	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001a
%0061	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001a
%0062	=	OpSelect	%0025	%005e	%0060	%0061
%0063	=	OpLoad	%0013	%005f
OpStore	%0062	%0063
%0064	=	OpIEqual	%000f	%002d	%001a
%0065	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001b
%0066	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001b
%0067	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001b
%0068	=	OpSelect	%0025	%0064	%0066	%0067
%0069	=	OpLoad	%0013	%0065
OpStore	%0068	%0069
%006a	=	OpIEqual	%000f	%002d	%001a
%006b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001c
%006c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001c
%006d	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001c
%006e	=	OpSelect	%0025	%006a	%006c	%006d
%006f	=	OpLoad	%0013	%006b
OpStore	%006e	%006f
%0070	=	OpIEqual	%000f	%002d	%001a
%0071	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001d
%0072	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001d
%0073	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001d
%0074	=	OpSelect	%0025	%0070	%0072	%0073
%0075	=	OpLoad	%0013	%0071
OpStore	%0074	%0075
%0076	=	OpIEqual	%000f	%002d	%001a
%0077	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001a
%0078	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001a
%0079	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001a
%007a	=	OpSelect	%0025	%0076	%0078	%0079
%007b	=	OpLoad	%0013	%0077
OpStore	%007a	%007b
%007c	=	OpIEqual	%000f	%002d	%001a
%007d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001b
%007e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001b
%007f	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001b
%0080	=	OpSelect	%0025	%007c	%007e	%007f
%0081	=	OpLoad	%0013	%007d
OpStore	%0080	%0081
%0082	=	OpIEqual	%000f	%002d	%001a
%0083	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001c
%0084	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001c
%0085	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001c
%0086	=	OpSelect	%0025	%0082	%0084	%0085
%0087	=	OpLoad	%0013	%0083
OpStore	%0086	%0087
%0088	=	OpIEqual	%000f	%002d	%001a
%0089	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001d
%008a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001d
%008b	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001d
%008c	=	OpSelect	%0025	%0088	%008a	%008b
%008d	=	OpLoad	%0013	%0089
OpStore	%008c	%008d
%008e	=	OpLoad	%0015	%0003
%008f	=	OpAccessChain	%0024	%0004
OpStore	%008f	%008e
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	32
OpDecorate	%0008	ArrayStride	128
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeInt	64	1
%0014	=	OpTypeInt	64	0
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
%0019	=	OpTypeVector	%0014	4
; ----------------- CONSTANTS ----------------
%001a	=	OpConstant	%0011	0
%001b	=	OpConstant	%0011	1
%001c	=	OpConstant	%0011	2
%001d	=	OpConstant	%0011	3
%001e	=	OpConstant	%0012	4
%001f	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0019	%001e
%0008	=	OpTypeArray	%0007	%001f
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%0020	=	OpTypePointer	StorageBuffer	%000a
%0021	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%0022	=	OpTypePointer	Uniform	%000b
%0023	=	OpTypePointer	Input	%0015
%0024	=	OpTypePointer	Output	%0015
%0025	=	OpTypePointer	StorageBuffer	%0014
%0026	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%0020	StorageBuffer
%0006	=	OpVariable	%0021	StorageBuffer
%000c	=	OpVariable	%0022	Uniform
%0003	=	OpVariable	%0023	Input
%0004	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000d	None	%000e
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000c	%001b
%0029	=	OpLoad	%0011	%0028
%002a	=	OpAccessChain	%0026	%000c	%001a
%002b	=	OpLoad	%0011	%002a
%002c	=	OpAccessChain	%0026	%000c	%001c
%002d	=	OpLoad	%0011	%002c
%002e	=	OpIEqual	%000f	%002d	%001a
%002f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001a
%0030	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001a
%0031	=	OpSelect	%0025	%002e	%002f	%0030
%0032	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001a
%0033	=	OpLoad	%0014	%0031
OpStore	%0032	%0033
%0034	=	OpIEqual	%000f	%002d	%001a
%0035	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001b
%0036	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001b
%0037	=	OpSelect	%0025	%0034	%0035	%0036
%0038	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001b
%0039	=	OpLoad	%0014	%0037
OpStore	%0038	%0039
%003a	=	OpIEqual	%000f	%002d	%001a
%003b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001c
%003c	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001c
%003d	=	OpSelect	%0025	%003a	%003b	%003c
%003e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001c
%003f	=	OpLoad	%0014	%003d
OpStore	%003e	%003f
%0040	=	OpIEqual	%000f	%002d	%001a
%0041	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001d
%0042	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001d
%0043	=	OpSelect	%0025	%0040	%0041	%0042
%0044	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001d
%0045	=	OpLoad	%0014	%0043
OpStore	%0044	%0045
%0046	=	OpIEqual	%000f	%002d	%001a
%0047	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001a
%0048	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001a
%0049	=	OpSelect	%0025	%0046	%0047	%0048
%004a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001a
%004b	=	OpLoad	%0014	%0049
OpStore	%004a	%004b
%004c	=	OpIEqual	%000f	%002d	%001a
%004d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001b
%004e	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001b
%004f	=	OpSelect	%0025	%004c	%004d	%004e
%0050	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001b
%0051	=	OpLoad	%0014	%004f
OpStore	%0050	%0051
%0052	=	OpIEqual	%000f	%002d	%001a
%0053	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001c
%0054	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001c
%0055	=	OpSelect	%0025	%0052	%0053	%0054
%0056	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001c
%0057	=	OpLoad	%0014	%0055
OpStore	%0056	%0057
%0058	=	OpIEqual	%000f	%002d	%001a
%0059	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001d
%005a	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001d
%005b	=	OpSelect	%0025	%0058	%0059	%005a
%005c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001d
%005d	=	OpLoad	%0014	%005b
OpStore	%005c	%005d
%005e	=	OpIEqual	%000f	%002d	%001a
%005f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001a
%0060	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001a
%0061	=	OpSelect	%0025	%005e	%005f	%0060
%0062	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001a
%0063	=	OpLoad	%0014	%0061
OpStore	%0062	%0063
%0064	=	OpIEqual	%000f	%002d	%001a
%0065	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001b
%0066	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001b
%0067	=	OpSelect	%0025	%0064	%0065	%0066
%0068	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001b
%0069	=	OpLoad	%0014	%0067
OpStore	%0068	%0069
%006a	=	OpIEqual	%000f	%002d	%001a
%006b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001c
%006c	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001c
%006d	=	OpSelect	%0025	%006a	%006b	%006c
%006e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001c
%006f	=	OpLoad	%0014	%006d
OpStore	%006e	%006f
%0070	=	OpIEqual	%000f	%002d	%001a
%0071	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001d
%0072	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001d
%0073	=	OpSelect	%0025	%0070	%0071	%0072
%0074	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001d
%0075	=	OpLoad	%0014	%0073
OpStore	%0074	%0075
%0076	=	OpIEqual	%000f	%002d	%001a
%0077	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001a
%0078	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001a
%0079	=	OpSelect	%0025	%0076	%0077	%0078
%007a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001a
%007b	=	OpLoad	%0014	%0079
OpStore	%007a	%007b
%007c	=	OpIEqual	%000f	%002d	%001a
%007d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001b
%007e	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001b
%007f	=	OpSelect	%0025	%007c	%007d	%007e
%0080	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001b
%0081	=	OpLoad	%0014	%007f
OpStore	%0080	%0081
%0082	=	OpIEqual	%000f	%002d	%001a
%0083	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001c
%0084	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001c
%0085	=	OpSelect	%0025	%0082	%0083	%0084
%0086	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001c
%0087	=	OpLoad	%0014	%0085
OpStore	%0086	%0087
%0088	=	OpIEqual	%000f	%002d	%001a
%0089	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001d
%008a	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001d
%008b	=	OpSelect	%0025	%0088	%0089	%008a
%008c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001d
%008d	=	OpLoad	%0014	%008b
OpStore	%008c	%008d
%008e	=	OpLoad	%0015	%0003
%008f	=	OpAccessChain	%0024	%0004
OpStore	%008f	%008e
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	32
OpDecorate	%0008	ArrayStride	128
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeInt	64	1
%0014	=	OpTypeInt	64	0
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
%0019	=	OpTypeVector	%0014	4
; ----------------- CONSTANTS ----------------
%001a	=	OpConstant	%0011	0
%001b	=	OpConstant	%0011	1
%001c	=	OpConstant	%0011	2
%001d	=	OpConstant	%0011	3
%001e	=	OpConstant	%0012	4
%001f	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0019	%001e
%0008	=	OpTypeArray	%0007	%001f
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%0020	=	OpTypePointer	StorageBuffer	%000a
%0021	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%0022	=	OpTypePointer	Uniform	%000b
%0023	=	OpTypePointer	Input	%0015
%0024	=	OpTypePointer	Output	%0015
%0025	=	OpTypePointer	StorageBuffer	%0014
%0026	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%0020	StorageBuffer
%0006	=	OpVariable	%0021	StorageBuffer
%000c	=	OpVariable	%0022	Uniform
%0003	=	OpVariable	%0023	Input
%0004	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000d	None	%000e
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000c	%001b
%0029	=	OpLoad	%0011	%0028
%002a	=	OpAccessChain	%0026	%000c	%001a
%002b	=	OpLoad	%0011	%002a
%002c	=	OpAccessChain	%0026	%000c	%001c
%002d	=	OpLoad	%0011	%002c
%002e	=	OpIEqual	%000f	%002d	%001a
%002f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001a
%0030	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001a
%0031	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001a
%0032	=	OpSelect	%0025	%002e	%0030	%0031
%0033	=	OpLoad	%0014	%002f
OpStore	%0032	%0033
%0034	=	OpIEqual	%000f	%002d	%001a
%0035	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001b
%0036	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001b
%0037	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001b
%0038	=	OpSelect	%0025	%0034	%0036	%0037
%0039	=	OpLoad	%0014	%0035
OpStore	%0038	%0039
%003a	=	OpIEqual	%000f	%002d	%001a
%003b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001c
%003c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001c
%003d	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001c
%003e	=	OpSelect	%0025	%003a	%003c	%003d
%003f	=	OpLoad	%0014	%003b
OpStore	%003e	%003f
%0040	=	OpIEqual	%000f	%002d	%001a
%0041	=	OpAccessChain	%0025	%0005	%001a	%002b	%001a	%001d
%0042	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001d
%0043	=	OpAccessChain	%0025	%0006	%001a	%0029	%001a	%001d
%0044	=	OpSelect	%0025	%0040	%0042	%0043
%0045	=	OpLoad	%0014	%0041
OpStore	%0044	%0045
%0046	=	OpIEqual	%000f	%002d	%001a
%0047	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001a
%0048	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001a
%0049	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001a
%004a	=	OpSelect	%0025	%0046	%0048	%0049
%004b	=	OpLoad	%0014	%0047
OpStore	%004a	%004b
%004c	=	OpIEqual	%000f	%002d	%001a
%004d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001b
%004e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001b
%004f	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001b
%0050	=	OpSelect	%0025	%004c	%004e	%004f
%0051	=	OpLoad	%0014	%004d
OpStore	%0050	%0051
%0052	=	OpIEqual	%000f	%002d	%001a
%0053	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001c
%0054	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001c
%0055	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001c
%0056	=	OpSelect	%0025	%0052	%0054	%0055
%0057	=	OpLoad	%0014	%0053
OpStore	%0056	%0057
%0058	=	OpIEqual	%000f	%002d	%001a
%0059	=	OpAccessChain	%0025	%0005	%001a	%002b	%001b	%001d
%005a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001d
%005b	=	OpAccessChain	%0025	%0006	%001a	%0029	%001b	%001d
%005c	=	OpSelect	%0025	%0058	%005a	%005b
%005d	=	OpLoad	%0014	%0059
OpStore	%005c	%005d
%005e	=	OpIEqual	%000f	%002d	%001a
%005f	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001a
%0060	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001a
%0061	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001a
%0062	=	OpSelect	%0025	%005e	%0060	%0061
%0063	=	OpLoad	%0014	%005f
OpStore	%0062	%0063
%0064	=	OpIEqual	%000f	%002d	%001a
%0065	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001b
%0066	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001b
%0067	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001b
%0068	=	OpSelect	%0025	%0064	%0066	%0067
%0069	=	OpLoad	%0014	%0065
OpStore	%0068	%0069
%006a	=	OpIEqual	%000f	%002d	%001a
%006b	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001c
%006c	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001c
%006d	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001c
%006e	=	OpSelect	%0025	%006a	%006c	%006d
%006f	=	OpLoad	%0014	%006b
OpStore	%006e	%006f
%0070	=	OpIEqual	%000f	%002d	%001a
%0071	=	OpAccessChain	%0025	%0005	%001a	%002b	%001c	%001d
%0072	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001d
%0073	=	OpAccessChain	%0025	%0006	%001a	%0029	%001c	%001d
%0074	=	OpSelect	%0025	%0070	%0072	%0073
%0075	=	OpLoad	%0014	%0071
OpStore	%0074	%0075
%0076	=	OpIEqual	%000f	%002d	%001a
%0077	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001a
%0078	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001a
%0079	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001a
%007a	=	OpSelect	%0025	%0076	%0078	%0079
%007b	=	OpLoad	%0014	%0077
OpStore	%007a	%007b
%007c	=	OpIEqual	%000f	%002d	%001a
%007d	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001b
%007e	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001b
%007f	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001b
%0080	=	OpSelect	%0025	%007c	%007e	%007f
%0081	=	OpLoad	%0014	%007d
OpStore	%0080	%0081
%0082	=	OpIEqual	%000f	%002d	%001a
%0083	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001c
%0084	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001c
%0085	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001c
%0086	=	OpSelect	%0025	%0082	%0084	%0085
%0087	=	OpLoad	%0014	%0083
OpStore	%0086	%0087
%0088	=	OpIEqual	%000f	%002d	%001a
%0089	=	OpAccessChain	%0025	%0005	%001a	%002b	%001d	%001d
%008a	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001d
%008b	=	OpAccessChain	%0025	%0006	%001a	%0029	%001d	%001d
%008c	=	OpSelect	%0025	%0088	%008a	%008b
%008d	=	OpLoad	%0014	%0089
OpStore	%008c	%008d
%008e	=	OpLoad	%0015	%0003
%008f	=	OpAccessChain	%0024	%0004
OpStore	%008f	%008e
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0014	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0011
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002f	=	OpLoad	%0011	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0032	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0035	=	OpLoad	%0011	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0038	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%003b	=	OpLoad	%0011	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%0041	=	OpLoad	%0011	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000f	%0029	%0016
%0043	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0044	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0047	=	OpLoad	%0011	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000f	%0029	%0016
%0049	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004a	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004d	=	OpLoad	%0011	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000f	%0029	%0016
%004f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0050	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0053	=	OpLoad	%0011	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000f	%0029	%0016
%0055	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0056	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0059	=	OpLoad	%0011	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000f	%0029	%0016
%005b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005f	=	OpLoad	%0011	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000f	%0029	%0016
%0061	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0062	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0065	=	OpLoad	%0011	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000f	%0029	%0016
%0067	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0068	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%006b	=	OpLoad	%0011	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000f	%0029	%0016
%006d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%0071	=	OpLoad	%0011	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000f	%0029	%0016
%0073	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0074	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0077	=	OpLoad	%0011	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000f	%0029	%0016
%0079	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007a	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007d	=	OpLoad	%0011	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000f	%0029	%0016
%007f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0080	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0083	=	OpLoad	%0011	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000f	%0029	%0016
%0085	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0086	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0089	=	OpLoad	%0011	%0087
OpStore	%0088	%0089
%008a	=	OpLoad	%0013	%0003
%008b	=	OpAccessChain	%0020	%0004
OpStore	%008b	%008a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0014	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0011
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0011	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0032	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0033	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0011	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0038	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%0039	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0011	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%003f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0011	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000f	%0029	%0016
%0043	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0044	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0045	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0011	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000f	%0029	%0016
%0049	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004b	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0011	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000f	%0029	%0016
%004f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0050	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0051	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0011	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000f	%0029	%0016
%0055	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0056	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0057	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0011	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000f	%0029	%0016
%005b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0011	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000f	%0029	%0016
%0061	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0062	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0063	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0011	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000f	%0029	%0016
%0067	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0068	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%0069	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0011	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000f	%0029	%0016
%006d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%006f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0011	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000f	%0029	%0016
%0073	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0074	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0075	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0011	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000f	%0029	%0016
%0079	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007b	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0011	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000f	%0029	%0016
%007f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0080	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0081	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0011	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000f	%0029	%0016
%0085	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0086	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0087	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0011	%0085
OpStore	%0088	%0089
%008a	=	OpLoad	%0013	%0003
%008b	=	OpAccessChain	%0020	%0004
OpStore	%008b	%008a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0015	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0012
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002f	=	OpLoad	%0012	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0032	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0035	=	OpLoad	%0012	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0038	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%003b	=	OpLoad	%0012	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%0041	=	OpLoad	%0012	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000f	%0029	%0016
%0043	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0044	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0047	=	OpLoad	%0012	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000f	%0029	%0016
%0049	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004a	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004d	=	OpLoad	%0012	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000f	%0029	%0016
%004f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0050	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0053	=	OpLoad	%0012	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000f	%0029	%0016
%0055	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0056	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0059	=	OpLoad	%0012	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000f	%0029	%0016
%005b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005f	=	OpLoad	%0012	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000f	%0029	%0016
%0061	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0062	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0065	=	OpLoad	%0012	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000f	%0029	%0016
%0067	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0068	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%006b	=	OpLoad	%0012	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000f	%0029	%0016
%006d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%0071	=	OpLoad	%0012	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000f	%0029	%0016
%0073	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0074	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0077	=	OpLoad	%0012	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000f	%0029	%0016
%0079	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007a	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007d	=	OpLoad	%0012	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000f	%0029	%0016
%007f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0080	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0083	=	OpLoad	%0012	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000f	%0029	%0016
%0085	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0086	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0089	=	OpLoad	%0012	%0087
OpStore	%0088	%0089
%008a	=	OpLoad	%0013	%0003
%008b	=	OpAccessChain	%0020	%0004
OpStore	%008b	%008a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0015	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0012
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0012	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0032	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0033	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0012	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0038	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%0039	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0012	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%003f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0012	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000f	%0029	%0016
%0043	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0044	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0045	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0012	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000f	%0029	%0016
%0049	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004b	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0012	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000f	%0029	%0016
%004f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0050	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0051	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0012	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000f	%0029	%0016
%0055	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0056	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0057	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0012	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000f	%0029	%0016
%005b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0012	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000f	%0029	%0016
%0061	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0062	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0063	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0012	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000f	%0029	%0016
%0067	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0068	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%0069	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0012	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000f	%0029	%0016
%006d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%006f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0012	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000f	%0029	%0016
%0073	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0074	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0075	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0012	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000f	%0029	%0016
%0079	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007b	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0012	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000f	%0029	%0016
%007f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0080	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0081	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0012	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000f	%0029	%0016
%0085	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0086	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0087	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0012	%0085
OpStore	%0088	%0089
%008a	=	OpLoad	%0013	%0003
%008b	=	OpAccessChain	%0020	%0004
OpStore	%008b	%008a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0013	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0010
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002f	=	OpLoad	%0010	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0032	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0035	=	OpLoad	%0010	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0038	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%003b	=	OpLoad	%0010	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%0041	=	OpLoad	%0010	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000f	%0029	%0016
%0043	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0044	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0047	=	OpLoad	%0010	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000f	%0029	%0016
%0049	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004a	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004d	=	OpLoad	%0010	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000f	%0029	%0016
%004f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0050	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0053	=	OpLoad	%0010	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000f	%0029	%0016
%0055	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0056	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0059	=	OpLoad	%0010	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000f	%0029	%0016
%005b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005c	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005f	=	OpLoad	%0010	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000f	%0029	%0016
%0061	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0062	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0065	=	OpLoad	%0010	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000f	%0029	%0016
%0067	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0068	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%006b	=	OpLoad	%0010	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000f	%0029	%0016
%006d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006e	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%0071	=	OpLoad	%0010	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000f	%0029	%0016
%0073	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0074	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0077	=	OpLoad	%0010	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000f	%0029	%0016
%0079	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007a	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007d	=	OpLoad	%0010	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000f	%0029	%0016
%007f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0080	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0083	=	OpLoad	%0010	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000f	%0029	%0016
%0085	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0086	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0089	=	OpLoad	%0010	%0087
OpStore	%0088	%0089
%008a	=	OpLoad	%0013	%0003
%008b	=	OpAccessChain	%0020	%0004
OpStore	%008b	%008a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	0
OpDecorate	%0006	DescriptorSet	0
OpDecorate	%0006	Binding	1
OpDecorate	%0007	ArrayStride	16
OpDecorate	%0008	ArrayStride	64
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	NonWritable
OpMemberDecorate	%000a	0	Offset	0
OpDecorate	%000a	Block
OpMemberDecorate	%000b	0	Offset	0
OpMemberDecorate	%000b	1	Offset	4
OpMemberDecorate	%000b	2	Offset	8
OpDecorate	%000b	Block
OpDecorate	%000c	DescriptorSet	0
OpDecorate	%000c	Binding	2
; ----------------- TYPES --------------------
%000d	=	OpTypeVoid
%000f	=	OpTypeBool
%0010	=	OpTypeFloat	32
%0011	=	OpTypeInt	32	1
%0012	=	OpTypeInt	32	0
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
%0015	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0016	=	OpConstant	%0011	0
%0017	=	OpConstant	%0011	1
%0018	=	OpConstant	%0011	2
%0019	=	OpConstant	%0011	3
%001a	=	OpConstant	%0012	4
%001b	=	OpConstant	%0012	1024
; ----------------- ADVANCED TYPES -----------
%000e	=	OpTypeFunction	%000d
%0007	=	OpTypeArray	%0013	%001a
%0008	=	OpTypeArray	%0007	%001b
%000a	=	OpTypeStruct	%0008
%0009	=	OpTypeStruct	%0008
%001c	=	OpTypePointer	StorageBuffer	%000a
%001d	=	OpTypePointer	StorageBuffer	%0009
%000b	=	OpTypeStruct	%0011	%0011	%0011
%001e	=	OpTypePointer	Uniform	%000b
%001f	=	OpTypePointer	Input	%0013
%0020	=	OpTypePointer	Output	%0013
%0021	=	OpTypePointer	StorageBuffer	%0010
%0022	=	OpTypePointer	Uniform	%0011
; ----------------- VARIABLES & FUNCTIONS ----
%0005	=	OpVariable	%001c	StorageBuffer
%0006	=	OpVariable	%001d	StorageBuffer
%000c	=	OpVariable	%001e	Uniform
%0003	=	OpVariable	%001f	Input
%0004	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000d	None	%000e
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000c	%0017
%0025	=	OpLoad	%0011	%0024
%0026	=	OpAccessChain	%0022	%000c	%0016
%0027	=	OpLoad	%0011	%0026
%0028	=	OpAccessChain	%0022	%000c	%0018
%0029	=	OpLoad	%0011	%0028
%002a	=	OpIEqual	%000f	%0029	%0016
%002b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0016
%002c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0016
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0010	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000f	%0029	%0016
%0031	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0017
%0032	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0033	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0017
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0010	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000f	%0029	%0016
%0037	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0018
%0038	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%0039	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0018
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0010	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000f	%0029	%0016
%003d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0016	%0019
%003e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%003f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0016	%0019
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0010	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000f	%0029	%0016
%0043	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0016
%0044	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0045	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0016
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0010	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000f	%0029	%0016
%0049	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0017
%004a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004b	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0017
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0010	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000f	%0029	%0016
%004f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0018
%0050	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0051	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0018
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0010	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000f	%0029	%0016
%0055	=	OpAccessChain	%0021	%0005	%0016	%0027	%0017	%0019
%0056	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0057	=	OpAccessChain	%0021	%0006	%0016	%0025	%0017	%0019
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0010	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000f	%0029	%0016
%005b	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0016
%005c	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005d	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0016
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0010	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000f	%0029	%0016
%0061	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0017
%0062	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0063	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0017
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0010	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000f	%0029	%0016
%0067	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0018
%0068	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%0069	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0018
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0010	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000f	%0029	%0016
%006d	=	OpAccessChain	%0021	%0005	%0016	%0027	%0018	%0019
%006e	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%006f	=	OpAccessChain	%0021	%0006	%0016	%0025	%0018	%0019
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0010	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000f	%0029	%0016
%0073	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0016
%0074	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0075	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0016
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0010	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000f	%0029	%0016
%0079	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0017
%007a	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007b	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0017
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0010	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000f	%0029	%0016
%007f	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0018
%0080	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0081	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0018
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0010	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000f	%0029	%0016
%0085	=	OpAccessChain	%0021	%0005	%0016	%0027	%0019	%0019
%0086	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0087	=	OpAccessChain	%0021	%0006	%0016	%0025	%0019	%0019
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0010	%0085
OpStore	%0088	%0089
%008a	=	OpLoad	%0013	%0003
%008b	=	OpAccessChain	%0020	%0004
OpStore	%008b	%008a
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
; ----------------- TYPES --------------------
%0005	=	OpTypeVoid
%0007	=	OpTypeFloat	32
%0008	=	OpTypeVector	%0007	4
; ----------------- CONSTANTS ----------------
; ----------------- ADVANCED TYPES -----------
%0006	=	OpTypeFunction	%0005
%0009	=	OpTypePointer	Output	%0008
%000a	=	OpTypePointer	Input	%0008
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%0009	Output
%0003	=	OpVariable	%000a	Input
%0002	=	OpFunction	%0005	None	%0006
%000b	=	OpLabel
%000c	=	OpLoad	%0008	%0003
%000d	=	OpAccessChain	%0009	%0004
OpStore	%000d	%000c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0013	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0013
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002f	=	OpLoad	%0013	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0032	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0035	=	OpLoad	%0013	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0038	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%003b	=	OpLoad	%0013	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%0041	=	OpLoad	%0013	%003f
OpStore	%0040	%0041
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0013	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0013
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0013	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0032	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0033	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0013	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0038	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%0039	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0013	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%003f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0013	%003d
OpStore	%0040	%0041
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0014	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0014
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002f	=	OpLoad	%0014	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0032	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0035	=	OpLoad	%0014	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0038	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%003b	=	OpLoad	%0014	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%0041	=	OpLoad	%0014	%003f
OpStore	%0040	%0041
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0014	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0014
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0014	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0032	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0033	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0014	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0038	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%0039	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0014	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%003f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0014	%003d
OpStore	%0040	%0041
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0012	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0012
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002f	=	OpLoad	%0012	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0032	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0035	=	OpLoad	%0012	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0038	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%003b	=	OpLoad	%0012	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%0041	=	OpLoad	%0012	%003f
OpStore	%0040	%0041
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0012	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0012
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015
%002c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0012	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016
%0032	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0033	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0012	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017
%0038	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%0039	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0012	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018
%003e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%003f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0012	%003d
OpStore	%0040	%0041
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Vertex	%0002	"main"	%0003	%0004
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0004	BuiltIn	Position
OpDecorate	%0003	Location	0
; ----------------- TYPES --------------------
%0005	=	OpTypeVoid
%0007	=	OpTypeFloat	32
%0008	=	OpTypeVector	%0007	4
; ----------------- CONSTANTS ----------------
; ----------------- ADVANCED TYPES -----------
%0006	=	OpTypeFunction	%0005
%0009	=	OpTypePointer	Output	%0008
%000a	=	OpTypePointer	Input	%0008
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%0009	Output
%0003	=	OpVariable	%000a	Input
%0002	=	OpFunction	%0005	None	%0006
%000b	=	OpLabel
%000c	=	OpLoad	%0008	%0003
%000d	=	OpAccessChain	%0009	%0004
OpStore	%000d	%000c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	32
OpDecorate	%0007	ArrayStride	128
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeInt	64	1
%0013	=	OpTypeInt	64	0
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
; ----------------- CONSTANTS ----------------
%0019	=	OpConstant	%0010	0
%001a	=	OpConstant	%0010	1
%001b	=	OpConstant	%0010	2
%001c	=	OpConstant	%0010	3
%001d	=	OpConstant	%0011	4
%001e	=	OpConstant	%0011	1024
%001f	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0017	%001d
%0007	=	OpTypeArray	%0006	%001e
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%0021	=	OpTypePointer	StorageBuffer	%0009
%0022	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%0023	=	OpTypePointer	Uniform	%000a
%0024	=	OpTypePointer	Output	%0014
%0025	=	OpTypePointer	StorageBuffer	%0012
%0026	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%0020	=	OpConstantComposite	%0014	%001f	%001f	%001f	%001f
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%0021	StorageBuffer
%0005	=	OpVariable	%0022	StorageBuffer
%000b	=	OpVariable	%0023	Uniform
%0003	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000c	None	%000d
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000b	%001a
%0029	=	OpLoad	%0010	%0028
%002a	=	OpAccessChain	%0026	%000b	%0019
%002b	=	OpLoad	%0010	%002a
%002c	=	OpAccessChain	%0026	%000b	%001b
%002d	=	OpLoad	%0010	%002c
%002e	=	OpIEqual	%000e	%002d	%0019
%002f	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%0019
%0030	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%0019
%0031	=	OpSelect	%0025	%002e	%002f	%0030
%0032	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%0019
%0033	=	OpLoad	%0012	%0031
OpStore	%0032	%0033
%0034	=	OpIEqual	%000e	%002d	%0019
%0035	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001a
%0036	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001a
%0037	=	OpSelect	%0025	%0034	%0035	%0036
%0038	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001a
%0039	=	OpLoad	%0012	%0037
OpStore	%0038	%0039
%003a	=	OpIEqual	%000e	%002d	%0019
%003b	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001b
%003c	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001b
%003d	=	OpSelect	%0025	%003a	%003b	%003c
%003e	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001b
%003f	=	OpLoad	%0012	%003d
OpStore	%003e	%003f
%0040	=	OpIEqual	%000e	%002d	%0019
%0041	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001c
%0042	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001c
%0043	=	OpSelect	%0025	%0040	%0041	%0042
%0044	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001c
%0045	=	OpLoad	%0012	%0043
OpStore	%0044	%0045
%0046	=	OpIEqual	%000e	%002d	%0019
%0047	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%0019
%0048	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%0019
%0049	=	OpSelect	%0025	%0046	%0047	%0048
%004a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%0019
%004b	=	OpLoad	%0012	%0049
OpStore	%004a	%004b
%004c	=	OpIEqual	%000e	%002d	%0019
%004d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001a
%004e	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001a
%004f	=	OpSelect	%0025	%004c	%004d	%004e
%0050	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001a
%0051	=	OpLoad	%0012	%004f
OpStore	%0050	%0051
%0052	=	OpIEqual	%000e	%002d	%0019
%0053	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001b
%0054	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001b
%0055	=	OpSelect	%0025	%0052	%0053	%0054
%0056	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001b
%0057	=	OpLoad	%0012	%0055
OpStore	%0056	%0057
%0058	=	OpIEqual	%000e	%002d	%0019
%0059	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001c
%005a	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001c
%005b	=	OpSelect	%0025	%0058	%0059	%005a
%005c	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001c
%005d	=	OpLoad	%0012	%005b
OpStore	%005c	%005d
%005e	=	OpIEqual	%000e	%002d	%0019
%005f	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%0019
%0060	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%0019
%0061	=	OpSelect	%0025	%005e	%005f	%0060
%0062	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%0019
%0063	=	OpLoad	%0012	%0061
OpStore	%0062	%0063
%0064	=	OpIEqual	%000e	%002d	%0019
%0065	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001a
%0066	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001a
%0067	=	OpSelect	%0025	%0064	%0065	%0066
%0068	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001a
%0069	=	OpLoad	%0012	%0067
OpStore	%0068	%0069
%006a	=	OpIEqual	%000e	%002d	%0019
%006b	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001b
%006c	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001b
%006d	=	OpSelect	%0025	%006a	%006b	%006c
%006e	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001b
%006f	=	OpLoad	%0012	%006d
OpStore	%006e	%006f
%0070	=	OpIEqual	%000e	%002d	%0019
%0071	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001c
%0072	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001c
%0073	=	OpSelect	%0025	%0070	%0071	%0072
%0074	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001c
%0075	=	OpLoad	%0012	%0073
OpStore	%0074	%0075
%0076	=	OpIEqual	%000e	%002d	%0019
%0077	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%0019
%0078	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%0019
%0079	=	OpSelect	%0025	%0076	%0077	%0078
%007a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%0019
%007b	=	OpLoad	%0012	%0079
OpStore	%007a	%007b
%007c	=	OpIEqual	%000e	%002d	%0019
%007d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001a
%007e	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001a
%007f	=	OpSelect	%0025	%007c	%007d	%007e
%0080	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001a
%0081	=	OpLoad	%0012	%007f
OpStore	%0080	%0081
%0082	=	OpIEqual	%000e	%002d	%0019
%0083	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001b
%0084	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001b
%0085	=	OpSelect	%0025	%0082	%0083	%0084
%0086	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001b
%0087	=	OpLoad	%0012	%0085
OpStore	%0086	%0087
%0088	=	OpIEqual	%000e	%002d	%0019
%0089	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001c
%008a	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001c
%008b	=	OpSelect	%0025	%0088	%0089	%008a
%008c	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001c
%008d	=	OpLoad	%0012	%008b
OpStore	%008c	%008d
OpStore	%0003	%0020
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	32
OpDecorate	%0007	ArrayStride	128
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeInt	64	1
%0013	=	OpTypeInt	64	0
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
; ----------------- CONSTANTS ----------------
%0019	=	OpConstant	%0010	0
%001a	=	OpConstant	%0010	1
%001b	=	OpConstant	%0010	2
%001c	=	OpConstant	%0010	3
%001d	=	OpConstant	%0011	4
%001e	=	OpConstant	%0011	1024
%001f	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0017	%001d
%0007	=	OpTypeArray	%0006	%001e
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%0021	=	OpTypePointer	StorageBuffer	%0009
%0022	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%0023	=	OpTypePointer	Uniform	%000a
%0024	=	OpTypePointer	Output	%0014
%0025	=	OpTypePointer	StorageBuffer	%0012
%0026	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%0020	=	OpConstantComposite	%0014	%001f	%001f	%001f	%001f
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%0021	StorageBuffer
%0005	=	OpVariable	%0022	StorageBuffer
%000b	=	OpVariable	%0023	Uniform
%0003	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000c	None	%000d
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000b	%001a
%0029	=	OpLoad	%0010	%0028
%002a	=	OpAccessChain	%0026	%000b	%0019
%002b	=	OpLoad	%0010	%002a
%002c	=	OpAccessChain	%0026	%000b	%001b
%002d	=	OpLoad	%0010	%002c
%002e	=	OpIEqual	%000e	%002d	%0019
%002f	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%0019
%0030	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%0019
%0031	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%0019
%0032	=	OpSelect	%0025	%002e	%0030	%0031
%0033	=	OpLoad	%0012	%002f
OpStore	%0032	%0033
%0034	=	OpIEqual	%000e	%002d	%0019
%0035	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001a
%0036	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001a
%0037	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001a
%0038	=	OpSelect	%0025	%0034	%0036	%0037
%0039	=	OpLoad	%0012	%0035
OpStore	%0038	%0039
%003a	=	OpIEqual	%000e	%002d	%0019
%003b	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001b
%003c	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001b
%003d	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001b
%003e	=	OpSelect	%0025	%003a	%003c	%003d
%003f	=	OpLoad	%0012	%003b
OpStore	%003e	%003f
%0040	=	OpIEqual	%000e	%002d	%0019
%0041	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001c
%0042	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001c
%0043	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001c
%0044	=	OpSelect	%0025	%0040	%0042	%0043
%0045	=	OpLoad	%0012	%0041
OpStore	%0044	%0045
%0046	=	OpIEqual	%000e	%002d	%0019
%0047	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%0019
%0048	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%0019
%0049	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%0019
%004a	=	OpSelect	%0025	%0046	%0048	%0049
%004b	=	OpLoad	%0012	%0047
OpStore	%004a	%004b
%004c	=	OpIEqual	%000e	%002d	%0019
%004d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001a
%004e	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001a
%004f	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001a
%0050	=	OpSelect	%0025	%004c	%004e	%004f
%0051	=	OpLoad	%0012	%004d
OpStore	%0050	%0051
%0052	=	OpIEqual	%000e	%002d	%0019
%0053	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001b
%0054	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001b
%0055	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001b
%0056	=	OpSelect	%0025	%0052	%0054	%0055
%0057	=	OpLoad	%0012	%0053
OpStore	%0056	%0057
%0058	=	OpIEqual	%000e	%002d	%0019
%0059	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001c
%005a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001c
%005b	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001c
%005c	=	OpSelect	%0025	%0058	%005a	%005b
%005d	=	OpLoad	%0012	%0059
OpStore	%005c	%005d
%005e	=	OpIEqual	%000e	%002d	%0019
%005f	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%0019
%0060	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%0019
%0061	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%0019
%0062	=	OpSelect	%0025	%005e	%0060	%0061
%0063	=	OpLoad	%0012	%005f
OpStore	%0062	%0063
%0064	=	OpIEqual	%000e	%002d	%0019
%0065	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001a
%0066	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001a
%0067	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001a
%0068	=	OpSelect	%0025	%0064	%0066	%0067
%0069	=	OpLoad	%0012	%0065
OpStore	%0068	%0069
%006a	=	OpIEqual	%000e	%002d	%0019
%006b	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001b
%006c	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001b
%006d	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001b
%006e	=	OpSelect	%0025	%006a	%006c	%006d
%006f	=	OpLoad	%0012	%006b
OpStore	%006e	%006f
%0070	=	OpIEqual	%000e	%002d	%0019
%0071	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001c
%0072	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001c
%0073	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001c
%0074	=	OpSelect	%0025	%0070	%0072	%0073
%0075	=	OpLoad	%0012	%0071
OpStore	%0074	%0075
%0076	=	OpIEqual	%000e	%002d	%0019
%0077	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%0019
%0078	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%0019
%0079	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%0019
%007a	=	OpSelect	%0025	%0076	%0078	%0079
%007b	=	OpLoad	%0012	%0077
OpStore	%007a	%007b
%007c	=	OpIEqual	%000e	%002d	%0019
%007d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001a
%007e	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001a
%007f	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001a
%0080	=	OpSelect	%0025	%007c	%007e	%007f
%0081	=	OpLoad	%0012	%007d
OpStore	%0080	%0081
%0082	=	OpIEqual	%000e	%002d	%0019
%0083	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001b
%0084	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001b
%0085	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001b
%0086	=	OpSelect	%0025	%0082	%0084	%0085
%0087	=	OpLoad	%0012	%0083
OpStore	%0086	%0087
%0088	=	OpIEqual	%000e	%002d	%0019
%0089	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001c
%008a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001c
%008b	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001c
%008c	=	OpSelect	%0025	%0088	%008a	%008b
%008d	=	OpLoad	%0012	%0089
OpStore	%008c	%008d
OpStore	%0003	%0020
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	32
OpDecorate	%0007	ArrayStride	128
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeInt	64	1
%0013	=	OpTypeInt	64	0
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
; ----------------- CONSTANTS ----------------
%0019	=	OpConstant	%0010	0
%001a	=	OpConstant	%0010	1
%001b	=	OpConstant	%0010	2
%001c	=	OpConstant	%0010	3
%001d	=	OpConstant	%0011	4
%001e	=	OpConstant	%0011	1024
%001f	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0018	%001d
%0007	=	OpTypeArray	%0006	%001e
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%0021	=	OpTypePointer	StorageBuffer	%0009
%0022	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%0023	=	OpTypePointer	Uniform	%000a
%0024	=	OpTypePointer	Output	%0014
%0025	=	OpTypePointer	StorageBuffer	%0013
%0026	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%0020	=	OpConstantComposite	%0014	%001f	%001f	%001f	%001f
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%0021	StorageBuffer
%0005	=	OpVariable	%0022	StorageBuffer
%000b	=	OpVariable	%0023	Uniform
%0003	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000c	None	%000d
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000b	%001a
%0029	=	OpLoad	%0010	%0028
%002a	=	OpAccessChain	%0026	%000b	%0019
%002b	=	OpLoad	%0010	%002a
%002c	=	OpAccessChain	%0026	%000b	%001b
%002d	=	OpLoad	%0010	%002c
%002e	=	OpIEqual	%000e	%002d	%0019
%002f	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%0019
%0030	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%0019
%0031	=	OpSelect	%0025	%002e	%002f	%0030
%0032	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%0019
%0033	=	OpLoad	%0013	%0031
OpStore	%0032	%0033
%0034	=	OpIEqual	%000e	%002d	%0019
%0035	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001a
%0036	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001a
%0037	=	OpSelect	%0025	%0034	%0035	%0036
%0038	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001a
%0039	=	OpLoad	%0013	%0037
OpStore	%0038	%0039
%003a	=	OpIEqual	%000e	%002d	%0019
%003b	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001b
%003c	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001b
%003d	=	OpSelect	%0025	%003a	%003b	%003c
%003e	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001b
%003f	=	OpLoad	%0013	%003d
OpStore	%003e	%003f
%0040	=	OpIEqual	%000e	%002d	%0019
%0041	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001c
%0042	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001c
%0043	=	OpSelect	%0025	%0040	%0041	%0042
%0044	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001c
%0045	=	OpLoad	%0013	%0043
OpStore	%0044	%0045
%0046	=	OpIEqual	%000e	%002d	%0019
%0047	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%0019
%0048	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%0019
%0049	=	OpSelect	%0025	%0046	%0047	%0048
%004a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%0019
%004b	=	OpLoad	%0013	%0049
OpStore	%004a	%004b
%004c	=	OpIEqual	%000e	%002d	%0019
%004d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001a
%004e	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001a
%004f	=	OpSelect	%0025	%004c	%004d	%004e
%0050	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001a
%0051	=	OpLoad	%0013	%004f
OpStore	%0050	%0051
%0052	=	OpIEqual	%000e	%002d	%0019
%0053	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001b
%0054	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001b
%0055	=	OpSelect	%0025	%0052	%0053	%0054
%0056	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001b
%0057	=	OpLoad	%0013	%0055
OpStore	%0056	%0057
%0058	=	OpIEqual	%000e	%002d	%0019
%0059	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001c
%005a	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001c
%005b	=	OpSelect	%0025	%0058	%0059	%005a
%005c	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001c
%005d	=	OpLoad	%0013	%005b
OpStore	%005c	%005d
%005e	=	OpIEqual	%000e	%002d	%0019
%005f	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%0019
%0060	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%0019
%0061	=	OpSelect	%0025	%005e	%005f	%0060
%0062	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%0019
%0063	=	OpLoad	%0013	%0061
OpStore	%0062	%0063
%0064	=	OpIEqual	%000e	%002d	%0019
%0065	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001a
%0066	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001a
%0067	=	OpSelect	%0025	%0064	%0065	%0066
%0068	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001a
%0069	=	OpLoad	%0013	%0067
OpStore	%0068	%0069
%006a	=	OpIEqual	%000e	%002d	%0019
%006b	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001b
%006c	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001b
%006d	=	OpSelect	%0025	%006a	%006b	%006c
%006e	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001b
%006f	=	OpLoad	%0013	%006d
OpStore	%006e	%006f
%0070	=	OpIEqual	%000e	%002d	%0019
%0071	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001c
%0072	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001c
%0073	=	OpSelect	%0025	%0070	%0071	%0072
%0074	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001c
%0075	=	OpLoad	%0013	%0073
OpStore	%0074	%0075
%0076	=	OpIEqual	%000e	%002d	%0019
%0077	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%0019
%0078	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%0019
%0079	=	OpSelect	%0025	%0076	%0077	%0078
%007a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%0019
%007b	=	OpLoad	%0013	%0079
OpStore	%007a	%007b
%007c	=	OpIEqual	%000e	%002d	%0019
%007d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001a
%007e	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001a
%007f	=	OpSelect	%0025	%007c	%007d	%007e
%0080	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001a
%0081	=	OpLoad	%0013	%007f
OpStore	%0080	%0081
%0082	=	OpIEqual	%000e	%002d	%0019
%0083	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001b
%0084	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001b
%0085	=	OpSelect	%0025	%0082	%0083	%0084
%0086	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001b
%0087	=	OpLoad	%0013	%0085
OpStore	%0086	%0087
%0088	=	OpIEqual	%000e	%002d	%0019
%0089	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001c
%008a	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001c
%008b	=	OpSelect	%0025	%0088	%0089	%008a
%008c	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001c
%008d	=	OpLoad	%0013	%008b
OpStore	%008c	%008d
OpStore	%0003	%0020
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	32
OpDecorate	%0007	ArrayStride	128
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeInt	64	1
%0013	=	OpTypeInt	64	0
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
%0018	=	OpTypeVector	%0013	4
; ----------------- CONSTANTS ----------------
%0019	=	OpConstant	%0010	0
%001a	=	OpConstant	%0010	1
%001b	=	OpConstant	%0010	2
%001c	=	OpConstant	%0010	3
%001d	=	OpConstant	%0011	4
%001e	=	OpConstant	%0011	1024
%001f	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0018	%001d
%0007	=	OpTypeArray	%0006	%001e
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%0021	=	OpTypePointer	StorageBuffer	%0009
%0022	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%0023	=	OpTypePointer	Uniform	%000a
%0024	=	OpTypePointer	Output	%0014
%0025	=	OpTypePointer	StorageBuffer	%0013
%0026	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%0020	=	OpConstantComposite	%0014	%001f	%001f	%001f	%001f
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%0021	StorageBuffer
%0005	=	OpVariable	%0022	StorageBuffer
%000b	=	OpVariable	%0023	Uniform
%0003	=	OpVariable	%0024	Output
%0002	=	OpFunction	%000c	None	%000d
%0027	=	OpLabel
%0028	=	OpAccessChain	%0026	%000b	%001a
%0029	=	OpLoad	%0010	%0028
%002a	=	OpAccessChain	%0026	%000b	%0019
%002b	=	OpLoad	%0010	%002a
%002c	=	OpAccessChain	%0026	%000b	%001b
%002d	=	OpLoad	%0010	%002c
%002e	=	OpIEqual	%000e	%002d	%0019
%002f	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%0019
%0030	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%0019
%0031	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%0019
%0032	=	OpSelect	%0025	%002e	%0030	%0031
%0033	=	OpLoad	%0013	%002f
OpStore	%0032	%0033
%0034	=	OpIEqual	%000e	%002d	%0019
%0035	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001a
%0036	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001a
%0037	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001a
%0038	=	OpSelect	%0025	%0034	%0036	%0037
%0039	=	OpLoad	%0013	%0035
OpStore	%0038	%0039
%003a	=	OpIEqual	%000e	%002d	%0019
%003b	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001b
%003c	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001b
%003d	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001b
%003e	=	OpSelect	%0025	%003a	%003c	%003d
%003f	=	OpLoad	%0013	%003b
OpStore	%003e	%003f
%0040	=	OpIEqual	%000e	%002d	%0019
%0041	=	OpAccessChain	%0025	%0004	%0019	%002b	%0019	%001c
%0042	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001c
%0043	=	OpAccessChain	%0025	%0005	%0019	%0029	%0019	%001c
%0044	=	OpSelect	%0025	%0040	%0042	%0043
%0045	=	OpLoad	%0013	%0041
OpStore	%0044	%0045
%0046	=	OpIEqual	%000e	%002d	%0019
%0047	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%0019
%0048	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%0019
%0049	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%0019
%004a	=	OpSelect	%0025	%0046	%0048	%0049
%004b	=	OpLoad	%0013	%0047
OpStore	%004a	%004b
%004c	=	OpIEqual	%000e	%002d	%0019
%004d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001a
%004e	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001a
%004f	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001a
%0050	=	OpSelect	%0025	%004c	%004e	%004f
%0051	=	OpLoad	%0013	%004d
OpStore	%0050	%0051
%0052	=	OpIEqual	%000e	%002d	%0019
%0053	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001b
%0054	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001b
%0055	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001b
%0056	=	OpSelect	%0025	%0052	%0054	%0055
%0057	=	OpLoad	%0013	%0053
OpStore	%0056	%0057
%0058	=	OpIEqual	%000e	%002d	%0019
%0059	=	OpAccessChain	%0025	%0004	%0019	%002b	%001a	%001c
%005a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001c
%005b	=	OpAccessChain	%0025	%0005	%0019	%0029	%001a	%001c
%005c	=	OpSelect	%0025	%0058	%005a	%005b
%005d	=	OpLoad	%0013	%0059
OpStore	%005c	%005d
%005e	=	OpIEqual	%000e	%002d	%0019
%005f	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%0019
%0060	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%0019
%0061	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%0019
%0062	=	OpSelect	%0025	%005e	%0060	%0061
%0063	=	OpLoad	%0013	%005f
OpStore	%0062	%0063
%0064	=	OpIEqual	%000e	%002d	%0019
%0065	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001a
%0066	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001a
%0067	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001a
%0068	=	OpSelect	%0025	%0064	%0066	%0067
%0069	=	OpLoad	%0013	%0065
OpStore	%0068	%0069
%006a	=	OpIEqual	%000e	%002d	%0019
%006b	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001b
%006c	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001b
%006d	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001b
%006e	=	OpSelect	%0025	%006a	%006c	%006d
%006f	=	OpLoad	%0013	%006b
OpStore	%006e	%006f
%0070	=	OpIEqual	%000e	%002d	%0019
%0071	=	OpAccessChain	%0025	%0004	%0019	%002b	%001b	%001c
%0072	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001c
%0073	=	OpAccessChain	%0025	%0005	%0019	%0029	%001b	%001c
%0074	=	OpSelect	%0025	%0070	%0072	%0073
%0075	=	OpLoad	%0013	%0071
OpStore	%0074	%0075
%0076	=	OpIEqual	%000e	%002d	%0019
%0077	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%0019
%0078	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%0019
%0079	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%0019
%007a	=	OpSelect	%0025	%0076	%0078	%0079
%007b	=	OpLoad	%0013	%0077
OpStore	%007a	%007b
%007c	=	OpIEqual	%000e	%002d	%0019
%007d	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001a
%007e	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001a
%007f	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001a
%0080	=	OpSelect	%0025	%007c	%007e	%007f
%0081	=	OpLoad	%0013	%007d
OpStore	%0080	%0081
%0082	=	OpIEqual	%000e	%002d	%0019
%0083	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001b
%0084	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001b
%0085	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001b
%0086	=	OpSelect	%0025	%0082	%0084	%0085
%0087	=	OpLoad	%0013	%0083
OpStore	%0086	%0087
%0088	=	OpIEqual	%000e	%002d	%0019
%0089	=	OpAccessChain	%0025	%0004	%0019	%002b	%001c	%001c
%008a	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001c
%008b	=	OpAccessChain	%0025	%0005	%0019	%0029	%001c	%001c
%008c	=	OpSelect	%0025	%0088	%008a	%008b
%008d	=	OpLoad	%0013	%0089
OpStore	%008c	%008d
OpStore	%0003	%0020
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0013	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0010
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002f	=	OpLoad	%0010	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0032	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0035	=	OpLoad	%0010	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0038	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%003b	=	OpLoad	%0010	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%0041	=	OpLoad	%0010	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000e	%0029	%0015
%0043	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0044	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0047	=	OpLoad	%0010	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000e	%0029	%0015
%0049	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004a	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004d	=	OpLoad	%0010	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000e	%0029	%0015
%004f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0050	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0053	=	OpLoad	%0010	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000e	%0029	%0015
%0055	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0056	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0059	=	OpLoad	%0010	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000e	%0029	%0015
%005b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005f	=	OpLoad	%0010	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000e	%0029	%0015
%0061	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0062	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0065	=	OpLoad	%0010	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000e	%0029	%0015
%0067	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0068	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%006b	=	OpLoad	%0010	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000e	%0029	%0015
%006d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%0071	=	OpLoad	%0010	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000e	%0029	%0015
%0073	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0074	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0077	=	OpLoad	%0010	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000e	%0029	%0015
%0079	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007a	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007d	=	OpLoad	%0010	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000e	%0029	%0015
%007f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0080	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0083	=	OpLoad	%0010	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000e	%0029	%0015
%0085	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0086	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0089	=	OpLoad	%0010	%0087
OpStore	%0088	%0089
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0013	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0010
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0010	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0032	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0033	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0010	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0038	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%0039	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0010	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%003f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0010	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000e	%0029	%0015
%0043	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0044	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0045	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0010	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000e	%0029	%0015
%0049	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004b	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0010	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000e	%0029	%0015
%004f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0050	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0051	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0010	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000e	%0029	%0015
%0055	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0056	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0057	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0010	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000e	%0029	%0015
%005b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0010	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000e	%0029	%0015
%0061	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0062	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0063	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0010	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000e	%0029	%0015
%0067	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0068	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%0069	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0010	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000e	%0029	%0015
%006d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%006f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0010	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000e	%0029	%0015
%0073	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0074	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0075	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0010	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000e	%0029	%0015
%0079	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007b	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0010	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000e	%0029	%0015
%007f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0080	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0081	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0010	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000e	%0029	%0015
%0085	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0086	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0087	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0010	%0085
OpStore	%0088	%0089
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0014	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0011
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002f	=	OpLoad	%0011	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0032	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0035	=	OpLoad	%0011	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0038	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%003b	=	OpLoad	%0011	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%0041	=	OpLoad	%0011	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000e	%0029	%0015
%0043	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0044	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0047	=	OpLoad	%0011	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000e	%0029	%0015
%0049	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004a	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004d	=	OpLoad	%0011	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000e	%0029	%0015
%004f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0050	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0053	=	OpLoad	%0011	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000e	%0029	%0015
%0055	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0056	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0059	=	OpLoad	%0011	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000e	%0029	%0015
%005b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005f	=	OpLoad	%0011	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000e	%0029	%0015
%0061	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0062	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0065	=	OpLoad	%0011	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000e	%0029	%0015
%0067	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0068	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%006b	=	OpLoad	%0011	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000e	%0029	%0015
%006d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%0071	=	OpLoad	%0011	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000e	%0029	%0015
%0073	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0074	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0077	=	OpLoad	%0011	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000e	%0029	%0015
%0079	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007a	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007d	=	OpLoad	%0011	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000e	%0029	%0015
%007f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0080	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0083	=	OpLoad	%0011	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000e	%0029	%0015
%0085	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0086	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0089	=	OpLoad	%0011	%0087
OpStore	%0088	%0089
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0014	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%0011
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0011	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0032	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0033	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0011	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0038	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%0039	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0011	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%003f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0011	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000e	%0029	%0015
%0043	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0044	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0045	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0011	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000e	%0029	%0015
%0049	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004b	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0011	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000e	%0029	%0015
%004f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0050	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0051	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0011	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000e	%0029	%0015
%0055	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0056	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0057	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0011	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000e	%0029	%0015
%005b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0011	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000e	%0029	%0015
%0061	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0062	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0063	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0011	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000e	%0029	%0015
%0067	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0068	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%0069	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0011	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000e	%0029	%0015
%006d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%006f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0011	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000e	%0029	%0015
%0073	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0074	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0075	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0011	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000e	%0029	%0015
%0079	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007b	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0011	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000e	%0029	%0015
%007f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0080	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0081	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0011	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000e	%0029	%0015
%0085	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0086	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0087	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0011	%0085
OpStore	%0088	%0089
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0012	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%000f
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002f	=	OpLoad	%000f	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0032	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0035	=	OpLoad	%000f	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0038	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%003b	=	OpLoad	%000f	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%0041	=	OpLoad	%000f	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000e	%0029	%0015
%0043	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0044	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0047	=	OpLoad	%000f	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000e	%0029	%0015
%0049	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004a	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004d	=	OpLoad	%000f	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000e	%0029	%0015
%004f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0050	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0053	=	OpLoad	%000f	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000e	%0029	%0015
%0055	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0056	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0059	=	OpLoad	%000f	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000e	%0029	%0015
%005b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005c	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005f	=	OpLoad	%000f	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000e	%0029	%0015
%0061	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0062	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0065	=	OpLoad	%000f	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000e	%0029	%0015
%0067	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0068	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%006b	=	OpLoad	%000f	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000e	%0029	%0015
%006d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006e	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%0071	=	OpLoad	%000f	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000e	%0029	%0015
%0073	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0074	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0077	=	OpLoad	%000f	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000e	%0029	%0015
%0079	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007a	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007d	=	OpLoad	%000f	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000e	%0029	%0015
%007f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0080	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0083	=	OpLoad	%000f	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000e	%0029	%0015
%0085	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0086	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0089	=	OpLoad	%000f	%0087
OpStore	%0088	%0089
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	Fragment	%0002	"main"	%0003
OpExecutionMode	%0002	OriginUpperLeft
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	Location	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	0
OpDecorate	%0005	DescriptorSet	0
OpDecorate	%0005	Binding	1
OpDecorate	%0006	ArrayStride	16
OpDecorate	%0007	ArrayStride	64
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	NonWritable
OpMemberDecorate	%0009	0	Offset	0
OpDecorate	%0009	Block
OpMemberDecorate	%000a	0	Offset	0
OpMemberDecorate	%000a	1	Offset	4
OpMemberDecorate	%000a	2	Offset	8
OpDecorate	%000a	Block
OpDecorate	%000b	DescriptorSet	0
OpDecorate	%000b	Binding	2
; ----------------- TYPES --------------------
%000c	=	OpTypeVoid
%000e	=	OpTypeBool
%000f	=	OpTypeFloat	32
%0010	=	OpTypeInt	32	1
%0011	=	OpTypeInt	32	0
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
%0014	=	OpTypeVector	%0011	4
; ----------------- CONSTANTS ----------------
%0015	=	OpConstant	%0010	0
%0016	=	OpConstant	%0010	1
%0017	=	OpConstant	%0010	2
%0018	=	OpConstant	%0010	3
%0019	=	OpConstant	%0011	4
%001a	=	OpConstant	%0011	1024
%001b	=	OpConstant	%000f	1
; ----------------- ADVANCED TYPES -----------
%000d	=	OpTypeFunction	%000c
%0006	=	OpTypeArray	%0012	%0019
%0007	=	OpTypeArray	%0006	%001a
%0009	=	OpTypeStruct	%0007
%0008	=	OpTypeStruct	%0007
%001d	=	OpTypePointer	StorageBuffer	%0009
%001e	=	OpTypePointer	StorageBuffer	%0008
%000a	=	OpTypeStruct	%0010	%0010	%0010
%001f	=	OpTypePointer	Uniform	%000a
%0020	=	OpTypePointer	Output	%0012
%0021	=	OpTypePointer	StorageBuffer	%000f
%0022	=	OpTypePointer	Uniform	%0010
; ----------------- CONSTANTS ----------------
%001c	=	OpConstantComposite	%0012	%001b	%001b	%001b	%001b
; ----------------- VARIABLES & FUNCTIONS ----
%0004	=	OpVariable	%001d	StorageBuffer
%0005	=	OpVariable	%001e	StorageBuffer
%000b	=	OpVariable	%001f	Uniform
%0003	=	OpVariable	%0020	Output
%0002	=	OpFunction	%000c	None	%000d
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000b	%0016
%0025	=	OpLoad	%0010	%0024
%0026	=	OpAccessChain	%0022	%000b	%0015
%0027	=	OpLoad	%0010	%0026
%0028	=	OpAccessChain	%0022	%000b	%0017
%0029	=	OpLoad	%0010	%0028
%002a	=	OpIEqual	%000e	%0029	%0015
%002b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0015
%002c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0015
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%000f	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000e	%0029	%0015
%0031	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0016
%0032	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0033	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0016
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%000f	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000e	%0029	%0015
%0037	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0017
%0038	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%0039	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0017
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%000f	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000e	%0029	%0015
%003d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0015	%0018
%003e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%003f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0015	%0018
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%000f	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000e	%0029	%0015
%0043	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0015
%0044	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0045	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0015
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%000f	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000e	%0029	%0015
%0049	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0016
%004a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004b	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0016
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%000f	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000e	%0029	%0015
%004f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0017
%0050	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0051	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0017
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%000f	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000e	%0029	%0015
%0055	=	OpAccessChain	%0021	%0004	%0015	%0027	%0016	%0018
%0056	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0057	=	OpAccessChain	%0021	%0005	%0015	%0025	%0016	%0018
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%000f	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000e	%0029	%0015
%005b	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0015
%005c	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005d	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0015
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%000f	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000e	%0029	%0015
%0061	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0016
%0062	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0063	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0016
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%000f	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000e	%0029	%0015
%0067	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0017
%0068	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%0069	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0017
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%000f	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000e	%0029	%0015
%006d	=	OpAccessChain	%0021	%0004	%0015	%0027	%0017	%0018
%006e	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%006f	=	OpAccessChain	%0021	%0005	%0015	%0025	%0017	%0018
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%000f	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000e	%0029	%0015
%0073	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0015
%0074	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0075	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0015
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%000f	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000e	%0029	%0015
%0079	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0016
%007a	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007b	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0016
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%000f	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000e	%0029	%0015
%007f	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0017
%0080	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0081	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0017
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%000f	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000e	%0029	%0015
%0085	=	OpAccessChain	%0021	%0004	%0015	%0027	%0018	%0018
%0086	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0087	=	OpAccessChain	%0021	%0005	%0015	%0025	%0018	%0018
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%000f	%0085
OpStore	%0088	%0089
OpStore	%0003	%001c
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0012	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0012
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0028	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0029	=	OpSelect	%001d	%0026	%0027	%0028
%002a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%002b	=	OpLoad	%0012	%0029
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002f	=	OpSelect	%001d	%002c	%002d	%002e
%0030	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%0031	=	OpLoad	%0012	%002f
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0034	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0035	=	OpSelect	%001d	%0032	%0033	%0034
%0036	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0037	=	OpLoad	%0012	%0035
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003b	=	OpSelect	%001d	%0038	%0039	%003a
%003c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003d	=	OpLoad	%0012	%003b
OpStore	%003c	%003d
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0012	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0012
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0028	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%0029	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%002a	=	OpSelect	%001d	%0026	%0028	%0029
%002b	=	OpLoad	%0012	%0027
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%002f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%0030	=	OpSelect	%001d	%002c	%002e	%002f
%0031	=	OpLoad	%0012	%002d
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0034	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0035	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0036	=	OpSelect	%001d	%0032	%0034	%0035
%0037	=	OpLoad	%0012	%0033
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003c	=	OpSelect	%001d	%0038	%003a	%003b
%003d	=	OpLoad	%0012	%0039
OpStore	%003c	%003d
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0013	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0013
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0028	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0029	=	OpSelect	%001d	%0026	%0027	%0028
%002a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%002b	=	OpLoad	%0013	%0029
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002f	=	OpSelect	%001d	%002c	%002d	%002e
%0030	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%0031	=	OpLoad	%0013	%002f
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0034	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0035	=	OpSelect	%001d	%0032	%0033	%0034
%0036	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0037	=	OpLoad	%0013	%0035
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003b	=	OpSelect	%001d	%0038	%0039	%003a
%003c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003d	=	OpLoad	%0013	%003b
OpStore	%003c	%003d
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0013	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0013
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0028	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%0029	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%002a	=	OpSelect	%001d	%0026	%0028	%0029
%002b	=	OpLoad	%0013	%0027
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%002f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%0030	=	OpSelect	%001d	%002c	%002e	%002f
%0031	=	OpLoad	%0013	%002d
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0034	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0035	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0036	=	OpSelect	%001d	%0032	%0034	%0035
%0037	=	OpLoad	%0013	%0033
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003c	=	OpSelect	%001d	%0038	%003a	%003b
%003d	=	OpLoad	%0013	%0039
OpStore	%003c	%003d
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0011	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0011
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0028	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0029	=	OpSelect	%001d	%0026	%0027	%0028
%002a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%002b	=	OpLoad	%0011	%0029
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002f	=	OpSelect	%001d	%002c	%002d	%002e
%0030	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%0031	=	OpLoad	%0011	%002f
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0034	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0035	=	OpSelect	%001d	%0032	%0033	%0034
%0036	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0037	=	OpLoad	%0011	%0035
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003b	=	OpSelect	%001d	%0038	%0039	%003a
%003c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003d	=	OpLoad	%0011	%003b
OpStore	%003c	%003d
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0011	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0011
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014
%0028	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%0029	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014
%002a	=	OpSelect	%001d	%0026	%0028	%0029
%002b	=	OpLoad	%0011	%0027
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015
%002e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%002f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015
%0030	=	OpSelect	%001d	%002c	%002e	%002f
%0031	=	OpLoad	%0011	%002d
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016
%0034	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0035	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016
%0036	=	OpSelect	%001d	%0032	%0034	%0035
%0037	=	OpLoad	%0011	%0033
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017
%003a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017
%003c	=	OpSelect	%001d	%0038	%003a	%003b
%003d	=	OpLoad	%0011	%0039
OpStore	%003c	%003d
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	32
OpDecorate	%0006	ArrayStride	128
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeInt	64	1
%0012	=	OpTypeInt	64	0
%0013	=	OpTypeVector	%000e	4
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0018	=	OpConstant	%000f	0
%0019	=	OpConstant	%000f	1
%001a	=	OpConstant	%000f	2
%001b	=	OpConstant	%000f	3
%001c	=	OpConstant	%0010	4
%001d	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0016	%001c
%0006	=	OpTypeArray	%0005	%001d
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001e	=	OpTypePointer	StorageBuffer	%0008
%001f	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%0020	=	OpTypePointer	Uniform	%0009
%0021	=	OpTypePointer	StorageBuffer	%0011
%0022	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001e	StorageBuffer
%0004	=	OpVariable	%001f	StorageBuffer
%000a	=	OpVariable	%0020	Uniform
%0002	=	OpFunction	%000b	None	%000c
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000a	%0019
%0025	=	OpLoad	%000f	%0024
%0026	=	OpAccessChain	%0022	%000a	%0018
%0027	=	OpLoad	%000f	%0026
%0028	=	OpAccessChain	%0022	%000a	%001a
%0029	=	OpLoad	%000f	%0028
%002a	=	OpIEqual	%000d	%0029	%0018
%002b	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0018
%002c	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0018
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0018
%002f	=	OpLoad	%0011	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000d	%0029	%0018
%0031	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0019
%0032	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0019
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0019
%0035	=	OpLoad	%0011	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000d	%0029	%0018
%0037	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001a
%0038	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001a
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001a
%003b	=	OpLoad	%0011	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000d	%0029	%0018
%003d	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001b
%003e	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001b
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001b
%0041	=	OpLoad	%0011	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000d	%0029	%0018
%0043	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0018
%0044	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0018
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0018
%0047	=	OpLoad	%0011	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000d	%0029	%0018
%0049	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0019
%004a	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0019
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0019
%004d	=	OpLoad	%0011	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000d	%0029	%0018
%004f	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001a
%0050	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001a
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001a
%0053	=	OpLoad	%0011	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000d	%0029	%0018
%0055	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001b
%0056	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001b
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001b
%0059	=	OpLoad	%0011	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000d	%0029	%0018
%005b	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0018
%005c	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0018
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0018
%005f	=	OpLoad	%0011	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000d	%0029	%0018
%0061	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0019
%0062	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0019
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0019
%0065	=	OpLoad	%0011	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000d	%0029	%0018
%0067	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001a
%0068	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001a
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001a
%006b	=	OpLoad	%0011	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000d	%0029	%0018
%006d	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001b
%006e	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001b
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001b
%0071	=	OpLoad	%0011	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000d	%0029	%0018
%0073	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0018
%0074	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0018
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0018
%0077	=	OpLoad	%0011	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000d	%0029	%0018
%0079	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0019
%007a	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0019
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0019
%007d	=	OpLoad	%0011	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000d	%0029	%0018
%007f	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001a
%0080	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001a
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001a
%0083	=	OpLoad	%0011	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000d	%0029	%0018
%0085	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001b
%0086	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001b
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001b
%0089	=	OpLoad	%0011	%0087
OpStore	%0088	%0089
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	32
OpDecorate	%0006	ArrayStride	128
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeInt	64	1
%0012	=	OpTypeInt	64	0
%0013	=	OpTypeVector	%000e	4
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0018	=	OpConstant	%000f	0
%0019	=	OpConstant	%000f	1
%001a	=	OpConstant	%000f	2
%001b	=	OpConstant	%000f	3
%001c	=	OpConstant	%0010	4
%001d	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0016	%001c
%0006	=	OpTypeArray	%0005	%001d
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001e	=	OpTypePointer	StorageBuffer	%0008
%001f	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%0020	=	OpTypePointer	Uniform	%0009
%0021	=	OpTypePointer	StorageBuffer	%0011
%0022	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001e	StorageBuffer
%0004	=	OpVariable	%001f	StorageBuffer
%000a	=	OpVariable	%0020	Uniform
%0002	=	OpFunction	%000b	None	%000c
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000a	%0019
%0025	=	OpLoad	%000f	%0024
%0026	=	OpAccessChain	%0022	%000a	%0018
%0027	=	OpLoad	%000f	%0026
%0028	=	OpAccessChain	%0022	%000a	%001a
%0029	=	OpLoad	%000f	%0028
%002a	=	OpIEqual	%000d	%0029	%0018
%002b	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0018
%002c	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0018
%002d	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0018
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0011	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000d	%0029	%0018
%0031	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0019
%0032	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0019
%0033	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0019
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0011	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000d	%0029	%0018
%0037	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001a
%0038	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001a
%0039	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001a
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0011	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000d	%0029	%0018
%003d	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001b
%003e	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001b
%003f	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001b
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0011	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000d	%0029	%0018
%0043	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0018
%0044	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0018
%0045	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0018
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0011	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000d	%0029	%0018
%0049	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0019
%004a	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0019
%004b	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0019
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0011	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000d	%0029	%0018
%004f	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001a
%0050	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001a
%0051	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001a
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0011	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000d	%0029	%0018
%0055	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001b
%0056	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001b
%0057	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001b
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0011	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000d	%0029	%0018
%005b	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0018
%005c	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0018
%005d	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0018
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0011	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000d	%0029	%0018
%0061	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0019
%0062	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0019
%0063	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0019
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0011	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000d	%0029	%0018
%0067	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001a
%0068	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001a
%0069	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001a
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0011	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000d	%0029	%0018
%006d	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001b
%006e	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001b
%006f	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001b
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0011	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000d	%0029	%0018
%0073	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0018
%0074	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0018
%0075	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0018
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0011	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000d	%0029	%0018
%0079	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0019
%007a	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0019
%007b	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0019
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0011	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000d	%0029	%0018
%007f	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001a
%0080	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001a
%0081	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001a
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0011	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000d	%0029	%0018
%0085	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001b
%0086	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001b
%0087	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001b
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0011	%0085
OpStore	%0088	%0089
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	32
OpDecorate	%0006	ArrayStride	128
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeInt	64	1
%0012	=	OpTypeInt	64	0
%0013	=	OpTypeVector	%000e	4
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0018	=	OpConstant	%000f	0
%0019	=	OpConstant	%000f	1
%001a	=	OpConstant	%000f	2
%001b	=	OpConstant	%000f	3
%001c	=	OpConstant	%0010	4
%001d	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0017	%001c
%0006	=	OpTypeArray	%0005	%001d
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001e	=	OpTypePointer	StorageBuffer	%0008
%001f	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%0020	=	OpTypePointer	Uniform	%0009
%0021	=	OpTypePointer	StorageBuffer	%0012
%0022	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001e	StorageBuffer
%0004	=	OpVariable	%001f	StorageBuffer
%000a	=	OpVariable	%0020	Uniform
%0002	=	OpFunction	%000b	None	%000c
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000a	%0019
%0025	=	OpLoad	%000f	%0024
%0026	=	OpAccessChain	%0022	%000a	%0018
%0027	=	OpLoad	%000f	%0026
%0028	=	OpAccessChain	%0022	%000a	%001a
%0029	=	OpLoad	%000f	%0028
%002a	=	OpIEqual	%000d	%0029	%0018
%002b	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0018
%002c	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0018
%002d	=	OpSelect	%0021	%002a	%002b	%002c
%002e	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0018
%002f	=	OpLoad	%0012	%002d
OpStore	%002e	%002f
%0030	=	OpIEqual	%000d	%0029	%0018
%0031	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0019
%0032	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0019
%0033	=	OpSelect	%0021	%0030	%0031	%0032
%0034	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0019
%0035	=	OpLoad	%0012	%0033
OpStore	%0034	%0035
%0036	=	OpIEqual	%000d	%0029	%0018
%0037	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001a
%0038	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001a
%0039	=	OpSelect	%0021	%0036	%0037	%0038
%003a	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001a
%003b	=	OpLoad	%0012	%0039
OpStore	%003a	%003b
%003c	=	OpIEqual	%000d	%0029	%0018
%003d	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001b
%003e	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001b
%003f	=	OpSelect	%0021	%003c	%003d	%003e
%0040	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001b
%0041	=	OpLoad	%0012	%003f
OpStore	%0040	%0041
%0042	=	OpIEqual	%000d	%0029	%0018
%0043	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0018
%0044	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0018
%0045	=	OpSelect	%0021	%0042	%0043	%0044
%0046	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0018
%0047	=	OpLoad	%0012	%0045
OpStore	%0046	%0047
%0048	=	OpIEqual	%000d	%0029	%0018
%0049	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0019
%004a	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0019
%004b	=	OpSelect	%0021	%0048	%0049	%004a
%004c	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0019
%004d	=	OpLoad	%0012	%004b
OpStore	%004c	%004d
%004e	=	OpIEqual	%000d	%0029	%0018
%004f	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001a
%0050	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001a
%0051	=	OpSelect	%0021	%004e	%004f	%0050
%0052	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001a
%0053	=	OpLoad	%0012	%0051
OpStore	%0052	%0053
%0054	=	OpIEqual	%000d	%0029	%0018
%0055	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001b
%0056	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001b
%0057	=	OpSelect	%0021	%0054	%0055	%0056
%0058	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001b
%0059	=	OpLoad	%0012	%0057
OpStore	%0058	%0059
%005a	=	OpIEqual	%000d	%0029	%0018
%005b	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0018
%005c	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0018
%005d	=	OpSelect	%0021	%005a	%005b	%005c
%005e	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0018
%005f	=	OpLoad	%0012	%005d
OpStore	%005e	%005f
%0060	=	OpIEqual	%000d	%0029	%0018
%0061	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0019
%0062	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0019
%0063	=	OpSelect	%0021	%0060	%0061	%0062
%0064	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0019
%0065	=	OpLoad	%0012	%0063
OpStore	%0064	%0065
%0066	=	OpIEqual	%000d	%0029	%0018
%0067	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001a
%0068	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001a
%0069	=	OpSelect	%0021	%0066	%0067	%0068
%006a	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001a
%006b	=	OpLoad	%0012	%0069
OpStore	%006a	%006b
%006c	=	OpIEqual	%000d	%0029	%0018
%006d	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001b
%006e	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001b
%006f	=	OpSelect	%0021	%006c	%006d	%006e
%0070	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001b
%0071	=	OpLoad	%0012	%006f
OpStore	%0070	%0071
%0072	=	OpIEqual	%000d	%0029	%0018
%0073	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0018
%0074	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0018
%0075	=	OpSelect	%0021	%0072	%0073	%0074
%0076	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0018
%0077	=	OpLoad	%0012	%0075
OpStore	%0076	%0077
%0078	=	OpIEqual	%000d	%0029	%0018
%0079	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0019
%007a	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0019
%007b	=	OpSelect	%0021	%0078	%0079	%007a
%007c	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0019
%007d	=	OpLoad	%0012	%007b
OpStore	%007c	%007d
%007e	=	OpIEqual	%000d	%0029	%0018
%007f	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001a
%0080	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001a
%0081	=	OpSelect	%0021	%007e	%007f	%0080
%0082	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001a
%0083	=	OpLoad	%0012	%0081
OpStore	%0082	%0083
%0084	=	OpIEqual	%000d	%0029	%0018
%0085	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001b
%0086	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001b
%0087	=	OpSelect	%0021	%0084	%0085	%0086
%0088	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001b
%0089	=	OpLoad	%0012	%0087
OpStore	%0088	%0089
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpCapability	Int64
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	32
OpDecorate	%0006	ArrayStride	128
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeInt	64	1
%0012	=	OpTypeInt	64	0
%0013	=	OpTypeVector	%000e	4
%0014	=	OpTypeVector	%000f	4
%0015	=	OpTypeVector	%0010	4
%0016	=	OpTypeVector	%0011	4
%0017	=	OpTypeVector	%0012	4
; ----------------- CONSTANTS ----------------
%0018	=	OpConstant	%000f	0
%0019	=	OpConstant	%000f	1
%001a	=	OpConstant	%000f	2
%001b	=	OpConstant	%000f	3
%001c	=	OpConstant	%0010	4
%001d	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0017	%001c
%0006	=	OpTypeArray	%0005	%001d
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001e	=	OpTypePointer	StorageBuffer	%0008
%001f	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%0020	=	OpTypePointer	Uniform	%0009
%0021	=	OpTypePointer	StorageBuffer	%0012
%0022	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001e	StorageBuffer
%0004	=	OpVariable	%001f	StorageBuffer
%000a	=	OpVariable	%0020	Uniform
%0002	=	OpFunction	%000b	None	%000c
%0023	=	OpLabel
%0024	=	OpAccessChain	%0022	%000a	%0019
%0025	=	OpLoad	%000f	%0024
%0026	=	OpAccessChain	%0022	%000a	%0018
%0027	=	OpLoad	%000f	%0026
%0028	=	OpAccessChain	%0022	%000a	%001a
%0029	=	OpLoad	%000f	%0028
%002a	=	OpIEqual	%000d	%0029	%0018
%002b	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0018
%002c	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0018
%002d	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0018
%002e	=	OpSelect	%0021	%002a	%002c	%002d
%002f	=	OpLoad	%0012	%002b
OpStore	%002e	%002f
%0030	=	OpIEqual	%000d	%0029	%0018
%0031	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%0019
%0032	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0019
%0033	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%0019
%0034	=	OpSelect	%0021	%0030	%0032	%0033
%0035	=	OpLoad	%0012	%0031
OpStore	%0034	%0035
%0036	=	OpIEqual	%000d	%0029	%0018
%0037	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001a
%0038	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001a
%0039	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001a
%003a	=	OpSelect	%0021	%0036	%0038	%0039
%003b	=	OpLoad	%0012	%0037
OpStore	%003a	%003b
%003c	=	OpIEqual	%000d	%0029	%0018
%003d	=	OpAccessChain	%0021	%0003	%0018	%0027	%0018	%001b
%003e	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001b
%003f	=	OpAccessChain	%0021	%0004	%0018	%0025	%0018	%001b
%0040	=	OpSelect	%0021	%003c	%003e	%003f
%0041	=	OpLoad	%0012	%003d
OpStore	%0040	%0041
%0042	=	OpIEqual	%000d	%0029	%0018
%0043	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0018
%0044	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0018
%0045	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0018
%0046	=	OpSelect	%0021	%0042	%0044	%0045
%0047	=	OpLoad	%0012	%0043
OpStore	%0046	%0047
%0048	=	OpIEqual	%000d	%0029	%0018
%0049	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%0019
%004a	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0019
%004b	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%0019
%004c	=	OpSelect	%0021	%0048	%004a	%004b
%004d	=	OpLoad	%0012	%0049
OpStore	%004c	%004d
%004e	=	OpIEqual	%000d	%0029	%0018
%004f	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001a
%0050	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001a
%0051	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001a
%0052	=	OpSelect	%0021	%004e	%0050	%0051
%0053	=	OpLoad	%0012	%004f
OpStore	%0052	%0053
%0054	=	OpIEqual	%000d	%0029	%0018
%0055	=	OpAccessChain	%0021	%0003	%0018	%0027	%0019	%001b
%0056	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001b
%0057	=	OpAccessChain	%0021	%0004	%0018	%0025	%0019	%001b
%0058	=	OpSelect	%0021	%0054	%0056	%0057
%0059	=	OpLoad	%0012	%0055
OpStore	%0058	%0059
%005a	=	OpIEqual	%000d	%0029	%0018
%005b	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0018
%005c	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0018
%005d	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0018
%005e	=	OpSelect	%0021	%005a	%005c	%005d
%005f	=	OpLoad	%0012	%005b
OpStore	%005e	%005f
%0060	=	OpIEqual	%000d	%0029	%0018
%0061	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%0019
%0062	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0019
%0063	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%0019
%0064	=	OpSelect	%0021	%0060	%0062	%0063
%0065	=	OpLoad	%0012	%0061
OpStore	%0064	%0065
%0066	=	OpIEqual	%000d	%0029	%0018
%0067	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001a
%0068	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001a
%0069	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001a
%006a	=	OpSelect	%0021	%0066	%0068	%0069
%006b	=	OpLoad	%0012	%0067
OpStore	%006a	%006b
%006c	=	OpIEqual	%000d	%0029	%0018
%006d	=	OpAccessChain	%0021	%0003	%0018	%0027	%001a	%001b
%006e	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001b
%006f	=	OpAccessChain	%0021	%0004	%0018	%0025	%001a	%001b
%0070	=	OpSelect	%0021	%006c	%006e	%006f
%0071	=	OpLoad	%0012	%006d
OpStore	%0070	%0071
%0072	=	OpIEqual	%000d	%0029	%0018
%0073	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0018
%0074	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0018
%0075	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0018
%0076	=	OpSelect	%0021	%0072	%0074	%0075
%0077	=	OpLoad	%0012	%0073
OpStore	%0076	%0077
%0078	=	OpIEqual	%000d	%0029	%0018
%0079	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%0019
%007a	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0019
%007b	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%0019
%007c	=	OpSelect	%0021	%0078	%007a	%007b
%007d	=	OpLoad	%0012	%0079
OpStore	%007c	%007d
%007e	=	OpIEqual	%000d	%0029	%0018
%007f	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001a
%0080	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001a
%0081	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001a
%0082	=	OpSelect	%0021	%007e	%0080	%0081
%0083	=	OpLoad	%0012	%007f
OpStore	%0082	%0083
%0084	=	OpIEqual	%000d	%0029	%0018
%0085	=	OpAccessChain	%0021	%0003	%0018	%0027	%001b	%001b
%0086	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001b
%0087	=	OpAccessChain	%0021	%0004	%0018	%0025	%001b	%001b
%0088	=	OpSelect	%0021	%0084	%0086	%0087
%0089	=	OpLoad	%0012	%0085
OpStore	%0088	%0089
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0012	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%000f
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0028	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0029	=	OpSelect	%001d	%0026	%0027	%0028
%002a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%002b	=	OpLoad	%000f	%0029
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002f	=	OpSelect	%001d	%002c	%002d	%002e
%0030	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%0031	=	OpLoad	%000f	%002f
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0034	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0035	=	OpSelect	%001d	%0032	%0033	%0034
%0036	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0037	=	OpLoad	%000f	%0035
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003b	=	OpSelect	%001d	%0038	%0039	%003a
%003c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003d	=	OpLoad	%000f	%003b
OpStore	%003c	%003d
%003e	=	OpIEqual	%000d	%0025	%0014
%003f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0040	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0041	=	OpSelect	%001d	%003e	%003f	%0040
%0042	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0043	=	OpLoad	%000f	%0041
OpStore	%0042	%0043
%0044	=	OpIEqual	%000d	%0025	%0014
%0045	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0046	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0047	=	OpSelect	%001d	%0044	%0045	%0046
%0048	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0049	=	OpLoad	%000f	%0047
OpStore	%0048	%0049
%004a	=	OpIEqual	%000d	%0025	%0014
%004b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004c	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004d	=	OpSelect	%001d	%004a	%004b	%004c
%004e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004f	=	OpLoad	%000f	%004d
OpStore	%004e	%004f
%0050	=	OpIEqual	%000d	%0025	%0014
%0051	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0052	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0053	=	OpSelect	%001d	%0050	%0051	%0052
%0054	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0055	=	OpLoad	%000f	%0053
OpStore	%0054	%0055
%0056	=	OpIEqual	%000d	%0025	%0014
%0057	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0058	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0059	=	OpSelect	%001d	%0056	%0057	%0058
%005a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%005b	=	OpLoad	%000f	%0059
OpStore	%005a	%005b
%005c	=	OpIEqual	%000d	%0025	%0014
%005d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005f	=	OpSelect	%001d	%005c	%005d	%005e
%0060	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%0061	=	OpLoad	%000f	%005f
OpStore	%0060	%0061
%0062	=	OpIEqual	%000d	%0025	%0014
%0063	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0064	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0065	=	OpSelect	%001d	%0062	%0063	%0064
%0066	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0067	=	OpLoad	%000f	%0065
OpStore	%0066	%0067
%0068	=	OpIEqual	%000d	%0025	%0014
%0069	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006b	=	OpSelect	%001d	%0068	%0069	%006a
%006c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006d	=	OpLoad	%000f	%006b
OpStore	%006c	%006d
%006e	=	OpIEqual	%000d	%0025	%0014
%006f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0070	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0071	=	OpSelect	%001d	%006e	%006f	%0070
%0072	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0073	=	OpLoad	%000f	%0071
OpStore	%0072	%0073
%0074	=	OpIEqual	%000d	%0025	%0014
%0075	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0076	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0077	=	OpSelect	%001d	%0074	%0075	%0076
%0078	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0079	=	OpLoad	%000f	%0077
OpStore	%0078	%0079
%007a	=	OpIEqual	%000d	%0025	%0014
%007b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007c	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007d	=	OpSelect	%001d	%007a	%007b	%007c
%007e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007f	=	OpLoad	%000f	%007d
OpStore	%007e	%007f
%0080	=	OpIEqual	%000d	%0025	%0014
%0081	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0082	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0083	=	OpSelect	%001d	%0080	%0081	%0082
%0084	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0085	=	OpLoad	%000f	%0083
OpStore	%0084	%0085
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0012	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%000f
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0028	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%0029	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%002a	=	OpSelect	%001d	%0026	%0028	%0029
%002b	=	OpLoad	%000f	%0027
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%002f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%0030	=	OpSelect	%001d	%002c	%002e	%002f
%0031	=	OpLoad	%000f	%002d
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0034	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0035	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0036	=	OpSelect	%001d	%0032	%0034	%0035
%0037	=	OpLoad	%000f	%0033
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003c	=	OpSelect	%001d	%0038	%003a	%003b
%003d	=	OpLoad	%000f	%0039
OpStore	%003c	%003d
%003e	=	OpIEqual	%000d	%0025	%0014
%003f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0040	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0041	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0042	=	OpSelect	%001d	%003e	%0040	%0041
%0043	=	OpLoad	%000f	%003f
OpStore	%0042	%0043
%0044	=	OpIEqual	%000d	%0025	%0014
%0045	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0046	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0047	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0048	=	OpSelect	%001d	%0044	%0046	%0047
%0049	=	OpLoad	%000f	%0045
OpStore	%0048	%0049
%004a	=	OpIEqual	%000d	%0025	%0014
%004b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004d	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004e	=	OpSelect	%001d	%004a	%004c	%004d
%004f	=	OpLoad	%000f	%004b
OpStore	%004e	%004f
%0050	=	OpIEqual	%000d	%0025	%0014
%0051	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0052	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0053	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0054	=	OpSelect	%001d	%0050	%0052	%0053
%0055	=	OpLoad	%000f	%0051
OpStore	%0054	%0055
%0056	=	OpIEqual	%000d	%0025	%0014
%0057	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0058	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%0059	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%005a	=	OpSelect	%001d	%0056	%0058	%0059
%005b	=	OpLoad	%000f	%0057
OpStore	%005a	%005b
%005c	=	OpIEqual	%000d	%0025	%0014
%005d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%005f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%0060	=	OpSelect	%001d	%005c	%005e	%005f
%0061	=	OpLoad	%000f	%005d
OpStore	%0060	%0061
%0062	=	OpIEqual	%000d	%0025	%0014
%0063	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0064	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0065	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0066	=	OpSelect	%001d	%0062	%0064	%0065
%0067	=	OpLoad	%000f	%0063
OpStore	%0066	%0067
%0068	=	OpIEqual	%000d	%0025	%0014
%0069	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006c	=	OpSelect	%001d	%0068	%006a	%006b
%006d	=	OpLoad	%000f	%0069
OpStore	%006c	%006d
%006e	=	OpIEqual	%000d	%0025	%0014
%006f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0070	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0071	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0072	=	OpSelect	%001d	%006e	%0070	%0071
%0073	=	OpLoad	%000f	%006f
OpStore	%0072	%0073
%0074	=	OpIEqual	%000d	%0025	%0014
%0075	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0076	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0077	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0078	=	OpSelect	%001d	%0074	%0076	%0077
%0079	=	OpLoad	%000f	%0075
OpStore	%0078	%0079
%007a	=	OpIEqual	%000d	%0025	%0014
%007b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007d	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007e	=	OpSelect	%001d	%007a	%007c	%007d
%007f	=	OpLoad	%000f	%007b
OpStore	%007e	%007f
%0080	=	OpIEqual	%000d	%0025	%0014
%0081	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0082	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0083	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0084	=	OpSelect	%001d	%0080	%0082	%0083
%0085	=	OpLoad	%000f	%0081
OpStore	%0084	%0085
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0013	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0010
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0028	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0029	=	OpSelect	%001d	%0026	%0027	%0028
%002a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%002b	=	OpLoad	%0010	%0029
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002f	=	OpSelect	%001d	%002c	%002d	%002e
%0030	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%0031	=	OpLoad	%0010	%002f
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0034	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0035	=	OpSelect	%001d	%0032	%0033	%0034
%0036	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0037	=	OpLoad	%0010	%0035
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003b	=	OpSelect	%001d	%0038	%0039	%003a
%003c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003d	=	OpLoad	%0010	%003b
OpStore	%003c	%003d
%003e	=	OpIEqual	%000d	%0025	%0014
%003f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0040	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0041	=	OpSelect	%001d	%003e	%003f	%0040
%0042	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0043	=	OpLoad	%0010	%0041
OpStore	%0042	%0043
%0044	=	OpIEqual	%000d	%0025	%0014
%0045	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0046	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0047	=	OpSelect	%001d	%0044	%0045	%0046
%0048	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0049	=	OpLoad	%0010	%0047
OpStore	%0048	%0049
%004a	=	OpIEqual	%000d	%0025	%0014
%004b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004c	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004d	=	OpSelect	%001d	%004a	%004b	%004c
%004e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004f	=	OpLoad	%0010	%004d
OpStore	%004e	%004f
%0050	=	OpIEqual	%000d	%0025	%0014
%0051	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0052	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0053	=	OpSelect	%001d	%0050	%0051	%0052
%0054	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0055	=	OpLoad	%0010	%0053
OpStore	%0054	%0055
%0056	=	OpIEqual	%000d	%0025	%0014
%0057	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0058	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0059	=	OpSelect	%001d	%0056	%0057	%0058
%005a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%005b	=	OpLoad	%0010	%0059
OpStore	%005a	%005b
%005c	=	OpIEqual	%000d	%0025	%0014
%005d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005f	=	OpSelect	%001d	%005c	%005d	%005e
%0060	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%0061	=	OpLoad	%0010	%005f
OpStore	%0060	%0061
%0062	=	OpIEqual	%000d	%0025	%0014
%0063	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0064	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0065	=	OpSelect	%001d	%0062	%0063	%0064
%0066	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0067	=	OpLoad	%0010	%0065
OpStore	%0066	%0067
%0068	=	OpIEqual	%000d	%0025	%0014
%0069	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006b	=	OpSelect	%001d	%0068	%0069	%006a
%006c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006d	=	OpLoad	%0010	%006b
OpStore	%006c	%006d
%006e	=	OpIEqual	%000d	%0025	%0014
%006f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0070	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0071	=	OpSelect	%001d	%006e	%006f	%0070
%0072	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0073	=	OpLoad	%0010	%0071
OpStore	%0072	%0073
%0074	=	OpIEqual	%000d	%0025	%0014
%0075	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0076	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0077	=	OpSelect	%001d	%0074	%0075	%0076
%0078	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0079	=	OpLoad	%0010	%0077
OpStore	%0078	%0079
%007a	=	OpIEqual	%000d	%0025	%0014
%007b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007c	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007d	=	OpSelect	%001d	%007a	%007b	%007c
%007e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007f	=	OpLoad	%0010	%007d
OpStore	%007e	%007f
%0080	=	OpIEqual	%000d	%0025	%0014
%0081	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0082	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0083	=	OpSelect	%001d	%0080	%0081	%0082
%0084	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0085	=	OpLoad	%0010	%0083
OpStore	%0084	%0085
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0013	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%0010
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0028	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%0029	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%002a	=	OpSelect	%001d	%0026	%0028	%0029
%002b	=	OpLoad	%0010	%0027
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%002f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%0030	=	OpSelect	%001d	%002c	%002e	%002f
%0031	=	OpLoad	%0010	%002d
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0034	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0035	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0036	=	OpSelect	%001d	%0032	%0034	%0035
%0037	=	OpLoad	%0010	%0033
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003c	=	OpSelect	%001d	%0038	%003a	%003b
%003d	=	OpLoad	%0010	%0039
OpStore	%003c	%003d
%003e	=	OpIEqual	%000d	%0025	%0014
%003f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0040	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0041	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0042	=	OpSelect	%001d	%003e	%0040	%0041
%0043	=	OpLoad	%0010	%003f
OpStore	%0042	%0043
%0044	=	OpIEqual	%000d	%0025	%0014
%0045	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0046	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0047	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0048	=	OpSelect	%001d	%0044	%0046	%0047
%0049	=	OpLoad	%0010	%0045
OpStore	%0048	%0049
%004a	=	OpIEqual	%000d	%0025	%0014
%004b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004d	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004e	=	OpSelect	%001d	%004a	%004c	%004d
%004f	=	OpLoad	%0010	%004b
OpStore	%004e	%004f
%0050	=	OpIEqual	%000d	%0025	%0014
%0051	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0052	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0053	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0054	=	OpSelect	%001d	%0050	%0052	%0053
%0055	=	OpLoad	%0010	%0051
OpStore	%0054	%0055
%0056	=	OpIEqual	%000d	%0025	%0014
%0057	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0058	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%0059	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%005a	=	OpSelect	%001d	%0056	%0058	%0059
%005b	=	OpLoad	%0010	%0057
OpStore	%005a	%005b
%005c	=	OpIEqual	%000d	%0025	%0014
%005d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%005f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%0060	=	OpSelect	%001d	%005c	%005e	%005f
%0061	=	OpLoad	%0010	%005d
OpStore	%0060	%0061
%0062	=	OpIEqual	%000d	%0025	%0014
%0063	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0064	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0065	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0066	=	OpSelect	%001d	%0062	%0064	%0065
%0067	=	OpLoad	%0010	%0063
OpStore	%0066	%0067
%0068	=	OpIEqual	%000d	%0025	%0014
%0069	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006c	=	OpSelect	%001d	%0068	%006a	%006b
%006d	=	OpLoad	%0010	%0069
OpStore	%006c	%006d
%006e	=	OpIEqual	%000d	%0025	%0014
%006f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0070	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0071	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0072	=	OpSelect	%001d	%006e	%0070	%0071
%0073	=	OpLoad	%0010	%006f
OpStore	%0072	%0073
%0074	=	OpIEqual	%000d	%0025	%0014
%0075	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0076	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0077	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0078	=	OpSelect	%001d	%0074	%0076	%0077
%0079	=	OpLoad	%0010	%0075
OpStore	%0078	%0079
%007a	=	OpIEqual	%000d	%0025	%0014
%007b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007d	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007e	=	OpSelect	%001d	%007a	%007c	%007d
%007f	=	OpLoad	%0010	%007b
OpStore	%007e	%007f
%0080	=	OpIEqual	%000d	%0025	%0014
%0081	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0082	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0083	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0084	=	OpSelect	%001d	%0080	%0082	%0083
%0085	=	OpLoad	%0010	%0081
OpStore	%0084	%0085
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0011	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%000e
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0028	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0029	=	OpSelect	%001d	%0026	%0027	%0028
%002a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%002b	=	OpLoad	%000e	%0029
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002f	=	OpSelect	%001d	%002c	%002d	%002e
%0030	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%0031	=	OpLoad	%000e	%002f
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0034	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0035	=	OpSelect	%001d	%0032	%0033	%0034
%0036	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0037	=	OpLoad	%000e	%0035
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003b	=	OpSelect	%001d	%0038	%0039	%003a
%003c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003d	=	OpLoad	%000e	%003b
OpStore	%003c	%003d
%003e	=	OpIEqual	%000d	%0025	%0014
%003f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0040	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0041	=	OpSelect	%001d	%003e	%003f	%0040
%0042	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0043	=	OpLoad	%000e	%0041
OpStore	%0042	%0043
%0044	=	OpIEqual	%000d	%0025	%0014
%0045	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0046	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0047	=	OpSelect	%001d	%0044	%0045	%0046
%0048	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0049	=	OpLoad	%000e	%0047
OpStore	%0048	%0049
%004a	=	OpIEqual	%000d	%0025	%0014
%004b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004c	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004d	=	OpSelect	%001d	%004a	%004b	%004c
%004e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004f	=	OpLoad	%000e	%004d
OpStore	%004e	%004f
%0050	=	OpIEqual	%000d	%0025	%0014
%0051	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0052	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0053	=	OpSelect	%001d	%0050	%0051	%0052
%0054	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0055	=	OpLoad	%000e	%0053
OpStore	%0054	%0055
%0056	=	OpIEqual	%000d	%0025	%0014
%0057	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0058	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0059	=	OpSelect	%001d	%0056	%0057	%0058
%005a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%005b	=	OpLoad	%000e	%0059
OpStore	%005a	%005b
%005c	=	OpIEqual	%000d	%0025	%0014
%005d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005e	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005f	=	OpSelect	%001d	%005c	%005d	%005e
%0060	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%0061	=	OpLoad	%000e	%005f
OpStore	%0060	%0061
%0062	=	OpIEqual	%000d	%0025	%0014
%0063	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0064	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0065	=	OpSelect	%001d	%0062	%0063	%0064
%0066	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0067	=	OpLoad	%000e	%0065
OpStore	%0066	%0067
%0068	=	OpIEqual	%000d	%0025	%0014
%0069	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006a	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006b	=	OpSelect	%001d	%0068	%0069	%006a
%006c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006d	=	OpLoad	%000e	%006b
OpStore	%006c	%006d
%006e	=	OpIEqual	%000d	%0025	%0014
%006f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0070	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0071	=	OpSelect	%001d	%006e	%006f	%0070
%0072	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0073	=	OpLoad	%000e	%0071
OpStore	%0072	%0073
%0074	=	OpIEqual	%000d	%0025	%0014
%0075	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0076	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0077	=	OpSelect	%001d	%0074	%0075	%0076
%0078	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0079	=	OpLoad	%000e	%0077
OpStore	%0078	%0079
%007a	=	OpIEqual	%000d	%0025	%0014
%007b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007c	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007d	=	OpSelect	%001d	%007a	%007b	%007c
%007e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007f	=	OpLoad	%000e	%007d
OpStore	%007e	%007f
%0080	=	OpIEqual	%000d	%0025	%0014
%0081	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0082	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0083	=	OpSelect	%001d	%0080	%0081	%0082
%0084	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0085	=	OpLoad	%000e	%0083
OpStore	%0084	%0085
OpReturn
OpFunctionEnd
OpCapability	Shader
OpCapability	VariablePointersStorageBuffer
OpExtension	"SPV_KHR_storage_buffer_storage_class"
OpExtension	"SPV_KHR_variable_pointers"
; ----------------- PREAMBLE -----------------
%0001	=	OpExtInstImport	"GLSL.std.450"
OpMemoryModel	Logical	GLSL450
OpEntryPoint	GLCompute	%0002	"main"
OpExecutionMode	%0002	LocalSize	1	1	1
; ----------------- DEBUG --------------------
; ----------------- DECORATIONS --------------
OpDecorate	%0003	DescriptorSet	0
OpDecorate	%0003	Binding	0
OpDecorate	%0004	DescriptorSet	0
OpDecorate	%0004	Binding	1
OpDecorate	%0005	ArrayStride	16
OpDecorate	%0006	ArrayStride	64
OpMemberDecorate	%0007	0	Offset	0
OpDecorate	%0007	Block
OpMemberDecorate	%0008	0	NonWritable
OpMemberDecorate	%0008	0	Offset	0
OpDecorate	%0008	Block
OpMemberDecorate	%0009	0	Offset	0
OpMemberDecorate	%0009	1	Offset	4
OpMemberDecorate	%0009	2	Offset	8
OpDecorate	%0009	Block
OpDecorate	%000a	DescriptorSet	0
OpDecorate	%000a	Binding	2
; ----------------- TYPES --------------------
%000b	=	OpTypeVoid
%000d	=	OpTypeBool
%000e	=	OpTypeFloat	32
%000f	=	OpTypeInt	32	1
%0010	=	OpTypeInt	32	0
%0011	=	OpTypeVector	%000e	4
%0012	=	OpTypeVector	%000f	4
%0013	=	OpTypeVector	%0010	4
; ----------------- CONSTANTS ----------------
%0014	=	OpConstant	%000f	0
%0015	=	OpConstant	%000f	1
%0016	=	OpConstant	%000f	2
%0017	=	OpConstant	%000f	3
%0018	=	OpConstant	%0010	4
%0019	=	OpConstant	%0010	1024
; ----------------- ADVANCED TYPES -----------
%000c	=	OpTypeFunction	%000b
%0005	=	OpTypeArray	%0011	%0018
%0006	=	OpTypeArray	%0005	%0019
%0008	=	OpTypeStruct	%0006
%0007	=	OpTypeStruct	%0006
%001a	=	OpTypePointer	StorageBuffer	%0008
%001b	=	OpTypePointer	StorageBuffer	%0007
%0009	=	OpTypeStruct	%000f	%000f	%000f
%001c	=	OpTypePointer	Uniform	%0009
%001d	=	OpTypePointer	StorageBuffer	%000e
%001e	=	OpTypePointer	Uniform	%000f
; ----------------- VARIABLES & FUNCTIONS ----
%0003	=	OpVariable	%001a	StorageBuffer
%0004	=	OpVariable	%001b	StorageBuffer
%000a	=	OpVariable	%001c	Uniform
%0002	=	OpFunction	%000b	None	%000c
%001f	=	OpLabel
%0020	=	OpAccessChain	%001e	%000a	%0015
%0021	=	OpLoad	%000f	%0020
%0022	=	OpAccessChain	%001e	%000a	%0014
%0023	=	OpLoad	%000f	%0022
%0024	=	OpAccessChain	%001e	%000a	%0016
%0025	=	OpLoad	%000f	%0024
%0026	=	OpIEqual	%000d	%0025	%0014
%0027	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0014
%0028	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%0029	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0014
%002a	=	OpSelect	%001d	%0026	%0028	%0029
%002b	=	OpLoad	%000e	%0027
OpStore	%002a	%002b
%002c	=	OpIEqual	%000d	%0025	%0014
%002d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0015
%002e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%002f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0015
%0030	=	OpSelect	%001d	%002c	%002e	%002f
%0031	=	OpLoad	%000e	%002d
OpStore	%0030	%0031
%0032	=	OpIEqual	%000d	%0025	%0014
%0033	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0016
%0034	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0035	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0016
%0036	=	OpSelect	%001d	%0032	%0034	%0035
%0037	=	OpLoad	%000e	%0033
OpStore	%0036	%0037
%0038	=	OpIEqual	%000d	%0025	%0014
%0039	=	OpAccessChain	%001d	%0003	%0014	%0023	%0014	%0017
%003a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0014	%0017
%003c	=	OpSelect	%001d	%0038	%003a	%003b
%003d	=	OpLoad	%000e	%0039
OpStore	%003c	%003d
%003e	=	OpIEqual	%000d	%0025	%0014
%003f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0014
%0040	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0041	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0014
%0042	=	OpSelect	%001d	%003e	%0040	%0041
%0043	=	OpLoad	%000e	%003f
OpStore	%0042	%0043
%0044	=	OpIEqual	%000d	%0025	%0014
%0045	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0015
%0046	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0047	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0015
%0048	=	OpSelect	%001d	%0044	%0046	%0047
%0049	=	OpLoad	%000e	%0045
OpStore	%0048	%0049
%004a	=	OpIEqual	%000d	%0025	%0014
%004b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0016
%004c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004d	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0016
%004e	=	OpSelect	%001d	%004a	%004c	%004d
%004f	=	OpLoad	%000e	%004b
OpStore	%004e	%004f
%0050	=	OpIEqual	%000d	%0025	%0014
%0051	=	OpAccessChain	%001d	%0003	%0014	%0023	%0015	%0017
%0052	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0053	=	OpAccessChain	%001d	%0004	%0014	%0021	%0015	%0017
%0054	=	OpSelect	%001d	%0050	%0052	%0053
%0055	=	OpLoad	%000e	%0051
OpStore	%0054	%0055
%0056	=	OpIEqual	%000d	%0025	%0014
%0057	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0014
%0058	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%0059	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0014
%005a	=	OpSelect	%001d	%0056	%0058	%0059
%005b	=	OpLoad	%000e	%0057
OpStore	%005a	%005b
%005c	=	OpIEqual	%000d	%0025	%0014
%005d	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0015
%005e	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%005f	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0015
%0060	=	OpSelect	%001d	%005c	%005e	%005f
%0061	=	OpLoad	%000e	%005d
OpStore	%0060	%0061
%0062	=	OpIEqual	%000d	%0025	%0014
%0063	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0016
%0064	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0065	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0016
%0066	=	OpSelect	%001d	%0062	%0064	%0065
%0067	=	OpLoad	%000e	%0063
OpStore	%0066	%0067
%0068	=	OpIEqual	%000d	%0025	%0014
%0069	=	OpAccessChain	%001d	%0003	%0014	%0023	%0016	%0017
%006a	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006b	=	OpAccessChain	%001d	%0004	%0014	%0021	%0016	%0017
%006c	=	OpSelect	%001d	%0068	%006a	%006b
%006d	=	OpLoad	%000e	%0069
OpStore	%006c	%006d
%006e	=	OpIEqual	%000d	%0025	%0014
%006f	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0014
%0070	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0071	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0014
%0072	=	OpSelect	%001d	%006e	%0070	%0071
%0073	=	OpLoad	%000e	%006f
OpStore	%0072	%0073
%0074	=	OpIEqual	%000d	%0025	%0014
%0075	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0015
%0076	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0077	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0015
%0078	=	OpSelect	%001d	%0074	%0076	%0077
%0079	=	OpLoad	%000e	%0075
OpStore	%0078	%0079
%007a	=	OpIEqual	%000d	%0025	%0014
%007b	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0016
%007c	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007d	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0016
%007e	=	OpSelect	%001d	%007a	%007c	%007d
%007f	=	OpLoad	%000e	%007b
OpStore	%007e	%007f
%0080	=	OpIEqual	%000d	%0025	%0014
%0081	=	OpAccessChain	%001d	%0003	%0014	%0023	%0017	%0017
%0082	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0083	=	OpAccessChain	%001d	%0004	%0014	%0021	%0017	%0017
%0084	=	OpSelect	%001d	%0080	%0082	%0083
%0085	=	OpLoad	%000e	%0081
OpStore	%0084	%0085
OpReturn
OpFunctionEnd
