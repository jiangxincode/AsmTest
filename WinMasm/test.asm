TITLE cpuid3b
DOSSEG
.model small
.stack 100h
OP_O MACRO
db 66h ; hardcoded operand override
ENDM
.data
extrn _cpu_type: byte
extrn _fpu_type: byte
extrn _cpuid_flag: byte
extrn _intel_CPU: byte
extrn _vendor_id: byte
extrn _cpu_signature: dword
extrn _features_ecx: dword
extrn _features_edx: dword
extrn _features_ebx: dword
extrn _ext_funct_1_eax: dword
extrn _ext_funct_1_ebx: dword
extrn _ext_funct_1_ecx: dword
extrn _ext_funct_1_edx: dword
extrn _ext_funct_6_eax: dword
extrn _ext_funct_6_ebx: dword
extrn _ext_funct_6_ecx: dword
extrn _ext_funct_6_edx: dword
extrn _ext_funct_8_eax: dword
extrn _ext_funct_8_ebx: dword
extrn _ext_funct_8_ecx: dword
extrn _ext_funct_8_edx: dword
extrn _cache_eax: dword
extrn _cache_ebx: dword
extrn _cache_ecx: dword
extrn _cache_edx: dword
extrn _dcp_cache_eax: dword
extrn _dcp_cache_ebx: dword
extrn _dcp_cache_ecx: dword
extrn _dcp_cache_edx: dword
extrn _brand_string: byte
; The purpose of this code is to identify the processor and
; coprocessor that is currently in the system. The program
; first determines the processor type. Then it determines
; whether a coprocessor exists in the system. If a
; coprocessor or integrated coprocessor exists, the program
; identifies the coprocessor type. The program then prints
; the processor and floating point processors present and type.
.code
.8086
start:
mov ax, @data
mov ds, ax ; set segment register
mov es, ax ; set segment register
and sp, not 3 ; align stack to avoid AC fault
call _get_cpu_type ; determine processor type
call _get_fpu_type
call print
mov ax, 4c00h
int 21h
;*********************************************************************
extrn _get_cpu_type: proc
;*********************************************************************
extrn _get_fpu_type: proc
;*********************************************************************
FPU_FLAG equ 0001h
VME_FLAG equ 0002h
DE_FLAG equ 0004h
PSE_FLAG equ 0008h
TSC_FLAG equ 0010h
MSR_FLAG equ 0020h
PAE_FLAG equ 0040h
MCE_FLAG equ 0080h
CX8_FLAG equ 0100h
APIC_FLAG equ 0200h
SEP_FLAG equ 0800h
MTRR_FLAG equ 1000h
PGE_FLAG equ 2000h
MCA_FLAG equ 4000h
CMOV_FLAG equ 8000h
PAT_FLAG equ 10000h
PSE36_FLAG equ 20000h
PSNUM_FLAG equ 40000h
CLFLUSH_FLAG equ 80000h
DTS_FLAG equ 200000h
ACPI_FLAG equ 400000h
MMX_FLAG equ 800000h
FXSR_FLAG equ 1000000h
SSE_FLAG equ 2000000h
SSE2_FLAG equ 4000000h
SS_FLAG equ 8000000h
HTT_FLAG equ 10000000h
TM_FLAG equ 20000000h
IA64_FLAG equ 40000000h
PBE_FLAG equ 80000000h
SSE3_FLAG equ 0001h
MONITOR_FLAG equ 0008h
DS_CPL_FLAG equ 0010h
VMX_FLAG equ 0020h
SMX_FLAG equ 0040h
EIST_FLAG equ 0080h
TM2_FLAG equ 0100h
SSSE3_FLAG equ 0200h
CID_FLAG equ 0400h
CX16_FLAG equ 02000h
XTPR_FLAG equ 04000h
PDCM_FLAG equ 08000h
DCA_FLAG equ 040000h
SSE4_1_FLAG equ 080000h
SSE4_2_FLAG equ 0100000h
EM64T_FLAG equ 20000000h
XD_FLAG equ 00100000h
SYSCALL_FLAG equ 00000800h
LAHF_FLAG equ 00000001h
.data
id_msg db "This system has a$"
cp_error db "n unknown processor$"
cp_8086 db "n 8086/8088 processor$"
cp_286 db "n 80286 processor$"
cp_386 db "n 80386 processor$"
cp_486 db "n 80486DX, 80486DX2 processor or"
db " 80487SX math coprocessor$"
cp_486sx db "n 80486SX processor$"
fp_8087 db " and an 8087 math coprocessor$"
fp_287 db " and an 80287 math coprocessor$"
fp_387 db " and an 80387 math coprocessor$"
intel486_msg db " Genuine Intel486(TM) processor$"
intel486dx_msg db " Genuine Intel486(TM) DX processor$"
intel486sx_msg db " Genuine Intel486(TM) SX processor$"
inteldx2_msg db " Genuine IntelDX2(TM) processor$"
intelsx2_msg db " Genuine IntelSX2(TM) processor$"
inteldx4_msg db " Genuine IntelDX4(TM) processor$"
inteldx2wb_msg db " Genuine Write-Back Enhanced"
db " IntelDX2(TM) processor$"
pentium_msg db " Genuine Intel(R) Pentium(R) processor$"
pentiumpro_msg db " Genuine Intel Pentium(R) Pro processor$"
pentiumiimodel3_msg db " Genuine Intel(R) Pentium(R) II processor, model 3$"
pentiumiixeon_m5_msg db " Genuine Intel(R) Pentium(R) II processor, model 5 or"
db " Intel(R) Pentium(R) II Xeon(R) processor$"
pentiumiixeon_msg db " Genuine Intel(R) Pentium(R) II Xeon(R) processor$"
celeron_msg db " Genuine Intel(R) Celeron(R) processor, model 5$"
celeronmodel6_msg db " Genuine Intel(R) Celeron(R) processor, model 6$"
celeron_brand db " Genuine Intel(R) Celeron(R) processor$"
pentiumiii_msg db " Genuine Intel(R) Pentium(R) III processor, model 7 or"
db " Intel Pentium(R) III Xeon(R) processor, model 7$"
pentiumiiixeon_msg db " Genuine Intel(R) Pentium(R) III Xeon(R) processor,model 7$"
pentiumiiixeon_brand db " Genuine Intel(R) Pentium(R) III Xeon(R) processor$"
pentiumiii_brand db " Genuine Intel(R) Pentium(R) III processor$"
mobile_piii_brand db " Genuine Mobile Intel(R) Pentium(R) III Processor-M$"
mobile_icp_brand db " Genuine Mobile Intel(R) Celeron(R) processor$"
mobile_P4_brand db " Genuine Mobile Intel(R) Pentium(R) 4 processor - M$"
pentium4_brand db " Genuine Intel(R) Pentium(R) 4 processor$"
xeon_brand db " Genuine Intel(R) Xeon(R) processor$"
xeon_mp_brand db " Genuine Intel(R) Xeon(R) processor MP$"
mobile_icp_brand_2 db " Genuine Mobile Intel(R) Celeron(R) processor$"
mobile_pentium_m_brand db " Genuine Intel(R) Pentium(R) M processor$"
mobile_genuine_brand db " Mobile Genuine Intel(R) processor$"
mobile_icp_m_brand db " Genuine Intel(R) Celeron(R) M processor$"
unknown_msg db "n unknown Genuine Intel(R) processor$"
brand_entry struct
brand_value db ?
brand_string dw ?
brand_entry ends
brand_table brand_entry <01h, offset celeron_brand>
brand_entry <02h, offset pentiumiii_brand>
brand_entry <03h, offset pentiumiiixeon_brand>
brand_entry <04h, offset pentiumiii_brand>
brand_entry <06h, offset mobile_piii_brand>
brand_entry <07h, offset mobile_icp_brand>
brand_entry <08h, offset pentium4_brand>
brand_entry <09h, offset pentium4_brand>
brand_entry <0Ah, offset celeron_brand>
brand_entry <0Bh, offset xeon_brand>
brand_entry <0Ch, offset xeon_mp_brand>
brand_entry <0Eh, offset mobile_p4_brand>
brand_entry <0Fh, offset mobile_icp_brand>
brand_entry <11h, offset mobile_genuine_brand>
brand_entry <12h, offset mobile_icp_m_brand>
brand_entry <13h, offset mobile_icp_brand_2>
brand_entry <14h, offset celeron_brand>
brand_entry <15h, offset mobile_genuine_brand>
brand_entry <16h, offset mobile_pentium_m_brand>
brand_entry <17h, offset mobile_icp_brand_2>
brand_table_size equ ($ - offset brand_table) / (sizeof brand_entry)
; The following 16 entries must stay intact as an array
intel_486_0 dw offset intel486dx_msg
intel_486_1 dw offset intel486dx_msg
intel_486_2 dw offset intel486sx_msg
intel_486_3 dw offset inteldx2_msg
intel_486_4 dw offset intel486_msg
intel_486_5 dw offset intelsx2_msg
intel_486_6 dw offset intel486_msg
intel_486_7 dw offset inteldx2wb_msg
intel_486_8 dw offset inteldx4_msg
intel_486_9 dw offset intel486_msg
intel_486_a dw offset intel486_msg
intel_486_b dw offset intel486_msg
intel_486_c dw offset intel486_msg
intel_486_d dw offset intel486_msg
intel_486_e dw offset intel486_msg
intel_486_f dw offset intel486_msg
; end of array
signature_msg db 13, 10,"Processor Signature / Version Information: $"
family_msg db 13,10,"Processor Family: $"
model_msg db 13,10,"Model: $"
stepping_msg db 13,10,"Stepping: $"
ext_fam_msg db 13,10," Extended Family: $"
ext_mod_msg db 13,10," Extended Model: $"
cr_lf db 13,10,"$"
turbo_msg db 13,10,"The processor is an OverDrive(R)"
db " processor$"
dp_msg db 13,10,"The processor is the upgrade"
db " processor in a dual processor system$"
fpu_msg db 13,10,"The processor contains an on-chip"
db " FPU$"
vme_msg db 13,10,"The processor supports Virtual"
db " Mode Extensions$"
de_msg db 13,10,"The processor supports Debugging"
db " Extensions$"
pse_msg db 13,10,"The processor supports Page Size"
db " Extensions$"
tsc_msg db 13,10,"The processor supports Time Stamp"
db " Counter$"
msr_msg db 13,10,"The processor supports Model"
db " Specific Registers$"
pae_msg db 13,10,"The processor supports Physical"
db " Address Extensions$"
mce_msg db 13,10,"The processor supports Machine"
db " Check Exceptions$"
cx8_msg db 13,10,"The processor supports the"
db " CMPXCHG8B instruction$"
apic_msg db 13,10,"The processor contains an on-chip"
db " APIC$"
sep_msg db 13,10,"The processor supports Fast System"
db " Call$"
no_sep_msg db 13,10,"The processor does not support Fast"
db " System Call$"
mtrr_msg db 13,10,"The processor supports Memory Type"
db " Range Registers$"
pge_msg db 13,10,"The processor supports Page Global"
db " Enable$"
mca_msg db 13,10,"The processor supports Machine"
db " Check Architecture$"
cmov_msg db 13,10,"The processor supports Conditional"
db " Move Instruction$"
pat_msg db 13,10,"The processor supports Page Attribute"
db " Table$"
pse36_msg db 13,10,"The processor supports 36-bit Page"
db " Size Extension$"
psnum_msg db 13,10,"The processor supports the"
db " processor serial number$"
clflush_msg db 13,10,"The processor supports the"
db " CLFLUSH instruction$"
dts_msg db 13,10,"The processor supports the"
db " Debug Trace Store feature$"
acpi_msg db 13,10,"The processor supports the"
db " ACPI registers in MSR space$"
mmx_msg db 13,10,"The processor supports Intel Architecture"
db " MMX(TM) Technology$"
fxsr_msg db 13,10,"The processor supports Fast floating point"
db " save and restore$"
sse_msg db 13,10,"The processor supports the Streaming"
db " SIMD extensions$"
sse2_msg db 13,10,"The processor supports the Streaming"
db " SIMD extensions 2 instructions$"
ss_msg db 13,10,"The processor supports Self-Snoop$"
htt_msg db 13,10,"The processor supports Hyper-Threading Technology$"
tm_msg db 13,10,"The processor supports the"
db " Thermal Monitor$"
ia64_msg db 13,10,"The processor is a member of the"
db "Intel(R) Itanium(R) processor family executing in IA32 emulation mode$"
pbe_msg db 13,10,"The processor supports the"
db " Pending Break Event$"
sse3_msg db 13,10,"The processor supports the Streaming SIMD"
db " Extensions 3 instructions$"
monitor_msg db 13,10,"The processor supports the MONITOR and MWAIT"
db " instructions$"
ds_cpl_msg db 13,10,"The processor supports Debug Store extensions for"
db " branch message storage by CPL$"
vmx_msg db 13,10,"The processor supports Intel(R) Virtualization Technology$"
smx_msg db 13,10,"The processor supports Intel(R) Trusted Execution "
db "Technology$"
eist_msg db 13,10,"The processor supports"
db " Enhanced SpeedStep(R) Technology$"
tm2_msg db 13,10,"The processor supports the"
db " Thermal Monitor 2$"
ssse3_msg db 13,10, "The processor supports the Supplemental Streaming SIMD"
db " Extensions 3 instructions$"
cid_msg db 13,10,"The processor supports L1 Data Cache Context ID$"
cx16_msg db 13,10,"The processor supports CMPXCHG16B instruction$"
xtpr_msg db 13,10,"The processor supports transmitting TPR messages$"
pdcm_msg db 13,10,"The processor supports the Performance Capabilities MSR$"
dca_msg db 13,10,"The processor supports the Direct Cache Access feature$"
sse4_1_msg db 13,10,"The processor supports the Supplemental Streaming SIMD "
db "Extensions 4.1 instructions$"
sse4_2_msg db 13,10,"The processor supports the Supplemental Streaming SIMD "
db "Extensions 4.2 instructions$"
em64t_msg db 13,10, "The processor supports Intel(R) Extended Memory 64 Technology$"
xd_bit_msg db 13,10, "The processor supports the Execute Disable Bit$"
syscall_msg db 13,10, "The processor supports the SYSCALL & SYSRET instructions$"
lahf_msg db 13,10, "The processor supports the LAHF & SAHF instructions$"
not_intel db "t least an 80486 processor."
db 13,10,"It does not contain a Genuine"
db "Intel part and as a result,"
db "the",13,10,"CPUID"
db " detection information cannot be"
db " determined at this time.$"
ASC_MSG MACRO msg
LOCAL ascii_done ; local label
add al, 30h
cmp al, 39h ; is it 0-9?
jle ascii_done
add al, 07h
ascii_done:
mov byte ptr msg[20], al
mov dx, offset msg
mov ah, 9h
int 21h
ENDM
.code
.8086
print proc
; This procedure prints the appropriate cpuid string and
; numeric processor presence status. If the CPUID instruction
; was used, this procedure prints out the CPUID info.
; All registers are used by this procedure, none are
; preserved.
mov dx, offset cr_lf
mov ah, 9h
int 21h
mov dx, offset id_msg ; print initial message
mov ah, 9h
int 21h
cmp _cpuid_flag, 1 ; if set to 1, processor
; supports CPUID instruction
je print_cpuid_data ; print detailed CPUID info
print_86:
cmp _cpu_type, 0
jne print_286
mov dx, offset cp_8086
mov ah, 9h
int 21h
cmp _fpu_type, 0
je end_print
mov dx, offset fp_8087
mov ah, 9h
int 21h
jmp end_print
print_286:
cmp _cpu_type, 2
jne print_386
mov dx, offset cp_286
mov ah, 9h
int 21h
cmp _fpu_type, 0
je end_print
print_287:
mov dx, offset fp_287
mov ah, 9h
int 21h
jmp end_print
print_386:
cmp _cpu_type, 3
jne print_486
mov dx, offset cp_386
mov ah, 9h
int 21h
cmp _fpu_type, 0
je end_print
cmp _fpu_type, 2
je print_287
mov dx, offset fp_387
mov ah, 9h
int 21h
jmp end_print
print_486:
cmp _cpu_type, 4
jne print_unknown ; Intel processors will have
mov dx, offset cp_486sx ; CPUID instruction
cmp _fpu_type, 0
je print_486sx
mov dx, offset cp_486
print_486sx:
mov ah, 9h
int 21h
jmp end_print
print_unknown:
mov dx, offset cp_error
jmp print_486sx
print_cpuid_data:
.486
cmp _intel_CPU, 1 ; check for genuine Intel
jne not_GenuineIntel ; processor
mov di, offset _brand_string ; brand string supported?
cmp byte ptr [di], 0
je print_brand_id
mov cx, 47 ; max brand string length
skip_spaces:
cmp byte ptr [di], ' ' ; skip leading space chars
jne print_brand_string
inc di
loop skip_spaces
print_brand_string:
cmp cx, 0 ; Nothing to print
je print_brand_id
cmp byte ptr [di], 0
je print_brand_id
mov dl, ' ' ; Print a space (' ') character
mov ah, 2
int 21h
print_brand_char:
mov dl, [di] ; print upto the max chars
mov ah, 2
int 21h
inc di
cmp byte ptr [di], 0
je print_family
loop print_brand_char
jmp print_family
print_brand_id:


cmp _cpu_type, 6
jb print_486_type
ja print_pentiumiiimodel8_type
mov eax, dword ptr _cpu_signature
shr eax, 4
and al, 0fh
cmp al, 8
jae print_pentiumiiimodel8_type
print_486_type:
cmp _cpu_type, 4 ; if 4, print 80486 processor
jne print_pentium_type
mov eax, dword ptr _cpu_signature
shr eax, 4
and eax, 0fh ; isolate model
mov dx, intel_486_0[eax*2]
jmp print_common
print_pentium_type:
cmp _cpu_type, 5 ; if 5, print Pentium processor
jne print_pentiumpro_type
mov dx, offset pentium_msg
jmp print_common
print_pentiumpro_type:
cmp _cpu_type, 6 ; if 6 & model 1, print Pentium
; Pro processor
jne print_unknown_type
mov eax, dword ptr _cpu_signature
shr eax, 4
and eax, 0fh ; isolate model
cmp eax, 3
jge print_pentiumiimodel3_type
cmp eax, 1
jne print_unknown_type ; incorrect model number = 2
mov dx, offset pentiumpro_msg
jmp print_common
print_pentiumiimodel3_type:
cmp eax, 3 ; if 6 & model 3, print Pentium
; II processor, model 3
jne print_pentiumiimodel5_type
mov dx, offset pentiumiimodel3_msg
jmp print_common
print_pentiumiimodel5_type:
cmp eax, 5 ; if 6 & model 5, either Pentium
; II processor, model 5, Pentium II
; Xeon processor or Intel Celeron
; processor, model 5
je celeron_xeon_detect
cmp eax, 7 ; If model 7 check cache descriptors
; to determine Pentium III or Pentium III Xeon
jne print_celeronmodel6_type
celeron_xeon_detect:


; Is it Pentium II processor, model 5, Pentium II Xeon processor, Intel Celeron processor,
; Pentium III processor or Pentium III Xeon processor.
mov eax, dword ptr _cache_eax
rol eax, 8
mov cx, 3
celeron_detect_eax:
cmp al, 40h ; Is it no L2
je print_celeron_type
cmp al, 44h ; Is L2 >= 1M
jae print_pentiumiixeon_type
rol eax, 8
loop celeron_detect_eax
mov eax, dword ptr _cache_ebx
mov cx, 4
celeron_detect_ebx:
cmp al, 40h ; Is it no L2
je print_celeron_type
cmp al, 44h ; Is L2 >= 1M
jae print_pentiumiixeon_type
rol eax, 8
loop celeron_detect_ebx
mov eax, dword ptr _cache_ecx
mov cx, 4
celeron_detect_ecx:
cmp al, 40h ; Is it no L2
je print_celeron_type
cmp al, 44h ; Is L2 >= 1M
jae print_pentiumiixeon_type
rol eax, 8
loop celeron_detect_ecx
mov eax, dword ptr _cache_edx
mov cx, 4
celeron_detect_edx:
cmp al, 40h ; Is it no L2
je print_celeron_type
cmp al, 44h ; Is L2 >= 1M
jae print_pentiumiixeon_type
rol eax, 8
loop celeron_detect_edx
mov dx, offset pentiumiixeon_m5_msg
mov eax, dword ptr _cpu_signature
shr eax, 4
and eax, 0fh ; isolate model
cmp eax, 5
je print_common


mov dx, offset pentiumiii_msg
jmp print_common
print_celeron_type:
mov dx, offset celeron_msg
jmp print_common
print_pentiumiixeon_type:
mov dx, offset pentiumiixeon_msg
mov ax, word ptr _cpu_signature
shr ax, 4
and eax, 0fh ; isolate model
cmp eax, 5
je print_common
mov dx, offset pentiumiiixeon_msg
jmp print_common
print_celeronmodel6_type:
cmp eax, 6 ; if 6 & model 6, print Intel Celeron
; processor, model 6
jne print_pentiumiiimodel8_type
mov dx, offset celeronmodel6_msg
jmp print_common
print_pentiumiiimodel8_type:
cmp eax, 8 ; Pentium III processor, model 8, or
; Pentium III Xeon processor, model 8
jb print_unknown_type
mov eax, dword ptr _features_ebx
cmp al, 0 ; Is brand_id supported?
je print_unknown_type
mov di, offset brand_table ; Setup pointer to brand_id table
mov cx, brand_table_size ; Get maximum entry count
next_brand:
cmp al, byte ptr [di] ; Is this the brand reported by the processor
je brand_found
add di, sizeof brand_entry ; Point to next Brand Defined
loop next_brand ; Check next brand if the table is not exhausted
jmp print_unknown_type
brand_found:
mov eax, dword ptr _cpu_signature
cmp eax, 06B1h ; Check for Pentium III, model B, stepping 1
jne not_b1_celeron
mov dx, offset celeron_brand ; Assume this is a the special case (see Table 9)
cmp byte ptr[di], 3 ; Is this a B1 Celeron?
je print_common
not_b1_celeron:
cmp eax, 0F13h
jae not_xeon_mp
mov dx, offset xeon_mp_brand ; Early "Intel(R) Xeon(R) processor MP"?


cmp byte ptr [di], 0Bh
je print_common
mov dx, offset xeon_brand ; Early "Intel(R) Xeon(R) processor"?
cmp byte ptr[di], 0Eh
je print_common
not_xeon_mp:
mov dx, word ptr [di+1] ; Load DX with the offset of the brand string
jmp print_common
print_unknown_type:
mov dx, offset unknown_msg ; if neither, print unknown
print_common:
mov ah, 9h
int 21h
; print family, model, and stepping
print_family:
mov dx, offset cr_lf
mov ah, 9h
int 21h
mov dx, offset signature_msg
mov ah, 9h
int 21h
mov eax, dword ptr _cpu_signature
mov cx, 8
print_signature:
; print all 8 digits of the processor signature EAX[31:0]
rol eax, 4 ; Moving EAX[31:28] into EAX[3:0]
mov dl, al
and dl, 0fh
add dl, '0' ; Convert the nibble to ASCII number
cmp dl, '9'
jle @f
add dl, 7
@@:
push eax
mov ah, 2
int 21h ; print lower nibble of ext family
pop eax
loop print_signature
push eax
mov dx, offset family_msg


mov ah, 9h
int 21h
pop eax
and ah, 0Fh ; Check if Ext Family ID must be added
cmp ah, 0Fh ; to the Family ID to get the true 8-bit
; Family value to print.
jne @f
mov dl, ah
ror eax, 12 ; Place ext family in AH
add ah, dl
@@:
mov al, ah
ror ah, 4
and ax, 0F0Fh
add ax, 3030h ; convert AH and AL to ASCII digits
cmp ah, '9'
jl @f
add ah, 7
@@:
cmp al, '9'
jl @f
add al, 7
@@:
push eax
mov dl, ah ; Print upper nibble Family[7:4]
mov ah, 2
int 21h
pop eax
mov dl, al ; Print lower nibble Family[3:0]
mov ah, 2
int 21h
print_model:
mov dx, offset model_msg
mov ah, 9h
int 21h
mov eax, dword ptr _cpu_signature
;
; If the Family_ID = 06h or Family_ID = 0Fh (Family_ID is EAX[11:8])
; then we must shift and add the Extended_Model_ID to Model_ID
;
and ah, 0Fh
cmp ah, 0Fh


je @f
cmp ah, 06h
jne no_ext_model
@@:
shr eax, 4 ; ext model into AH[7:4], model into AL[3:0]
and ax, 0F00Fh
add ah, al
no_ext_model:
mov al, ah
shr ah, 4
and ax, 0F0Fh
add ax, 3030h ; convert AH and AL to ASCII digits
cmp ah, '9'
jl @f
add ah, 7
@@:
cmp al, '9'
jl @f
add al, 7
@@:
push eax
mov dl, ah ; print upper nibble Model[7:4]
mov ah, 2
int 21h
pop eax
mov dl, al ; print lower nibble Model[3:0]
mov ah, 2
int 21h
print_stepping:
mov dx, offset stepping_msg
mov ah, 9h
int 21h
mov eax, dword ptr _cpu_signature
mov dl, al
and dl, 0Fh
add dl, '0'
cmp dl, '9'
jle @f
add dl, 7
@@:
mov ah, 2
int 21h


mov dx, offset cr_lf
mov ah, 9h
int 21h
print_upgrade:
mov eax, dword ptr _cpu_signature
test ax, 1000h ; check for turbo upgrade
jz check_dp
mov dx, offset turbo_msg
mov ah, 9h
int 21h
jmp print_features
check_dp:
test ax, 2000h ; check for dual processor
jz print_features
mov dx, offset dp_msg
mov ah, 9h
int 21h
print_features:
test dword ptr _features_edx, FPU_FLAG ; check for FPU
jz check_VME
mov dx, offset fpu_msg
mov ah, 9h
int 21h
check_VME:
test dword ptr _features_edx, VME_FLAG ; check for VME
jz check_DE
mov dx, offset vme_msg
mov ah, 9h
int 21h
check_DE:
test dword ptr _features_edx, DE_FLAG ; check for DE
jz check_PSE
mov dx, offset de_msg
mov ah, 9h
int 21h
check_PSE:
test dword ptr _features_edx, PSE_FLAG ; check for PSE
jz check_TSC
mov dx, offset pse_msg
mov ah, 9h
int 21h
check_TSC:
test dword ptr _features_edx, TSC_FLAG ; check for TSC
jz check_MSR
mov dx, offset tsc_msg
mov ah, 9h
int 21h
check_MSR:
test dword ptr _features_edx, MSR_FLAG ; check for MSR


jz check_PAE
mov dx, offset msr_msg
mov ah, 9h
int 21h
check_PAE:
test dword ptr _features_edx, PAE_FLAG ; check for PAE
jz check_MCE
mov dx, offset pae_msg
mov ah, 9h
int 21h
check_MCE:
test dword ptr _features_edx, MCE_FLAG ; check for MCE
jz check_CX8
mov dx, offset mce_msg
mov ah, 9h
int 21h
check_CX8:
test dword ptr _features_edx, CX8_FLAG ; check for CMPXCHG8B
jz check_APIC
mov dx, offset cx8_msg
mov ah, 9h
int 21h
check_APIC:
test dword ptr _features_edx, APIC_FLAG ; check for APIC
jz check_SEP
mov dx, offset apic_msg
mov ah, 9h
int 21h
check_SEP:
test dword ptr _features_edx, SEP_FLAG ; Check for Fast System Call
jz check_MTRR
cmp _cpu_type, 6 ; Determine if Fast System
jne print_sep ; Calls are supported.
mov eax, dword ptr _cpu_signature
cmp al, 33h
jb print_no_sep
print_sep:
mov dx, offset sep_msg
mov ah, 9h
int 21h
jmp check_MTRR
print_no_sep:
mov dx, offset no_sep_msg
mov ah, 9h
int 21h
check_MTRR:
test dword ptr _features_edx, MTRR_FLAG ; check for MTRR


jz check_PGE
mov dx, offset mtrr_msg
mov ah, 9h
int 21h
check_PGE:
test dword ptr _features_edx, PGE_FLAG ; check for PGE
jz check_MCA
mov dx, offset pge_msg
mov ah, 9h
int 21h
check_MCA:
test dword ptr _features_edx, MCA_FLAG ; check for MCA
jz check_CMOV
mov dx, offset mca_msg
mov ah, 9h
int 21h
check_CMOV:
test dword ptr _features_edx, CMOV_FLAG ; check for CMOV
jz check_PAT
mov dx, offset cmov_msg
mov ah, 9h
int 21h
check_PAT:
test dword ptr _features_edx, PAT_FLAG ; Page Attribute Table?
jz check_PSE36
mov dx, offset pat_msg
mov ah, 9h
int 21h
check_PSE36:
test dword ptr _features_edx, PSE36_FLAG ; Page Size Extensions?
jz check_PSNUM
mov dx, offset pse36_msg
mov ah, 9h
int 21h
check_PSNUM:
test dword ptr _features_edx, PSNUM_FLAG ; check for processor serial number
jz check_CLFLUSH
mov dx, offset psnum_msg
mov ah, 9h
int 21h
check_CLFLUSH:
test dword ptr _features_edx, CLFLUSH_FLAG ; check for Cache Line Flush
jz check_DTS
mov dx, offset clflush_msg
mov ah, 9h
int 21h
check_DTS:
test dword ptr _features_edx, DTS_FLAG ; check for Debug Trace Store
jz check_ACPI


mov dx, offset dts_msg
mov ah, 9h
int 21h
check_ACPI:
test dword ptr _features_edx, ACPI_FLAG ; check for processor serial number
jz check_MMX
mov dx, offset acpi_msg
mov ah, 9h
int 21h
check_MMX:
test dword ptr _features_edx, MMX_FLAG ; check for MMX technology
jz check_FXSR
mov dx, offset mmx_msg
mov ah, 9h
int 21h
check_FXSR:
test dword ptr _features_edx, FXSR_FLAG ; check for FXSR
jz check_SSE
mov dx, offset fxsr_msg
mov ah, 9h
int 21h
check_SSE:
test dword ptr _features_edx, SSE_FLAG ; check for Streaming SIMD
jz check_SSE2 ; Extensions
mov dx, offset sse_msg
mov ah, 9h
int 21h
check_SSE2:
test dword ptr _features_edx, SSE2_FLAG ; check for Streaming SIMD
jz check_SS ; Extensions 2
mov dx, offset sse2_msg
mov ah, 9h
int 21h
check_SS:
test dword ptr _features_edx, SS_FLAG ; check for Self Snoop
jz check_HTT
mov dx, offset ss_msg
mov ah, 9h
int 21h
check_HTT:
test dword ptr _features_edx, HTT_FLAG ; check for Hyper-Thread Technology
jz check_IA64
mov eax, dword ptr _features_ebx
shr eax, 16 ; Place the logical processor count in AL
xor ah, ah ; clear AH.
mov ebx, dword ptr _dcp_cache_eax
shr ebx, 26 ; Place core count in BL (originally in EAX[31:26])
and bx, 3Fh ; clear BL preserving the core count
inc bl


div bl
cmp al, 2
jl check_IA64
mov dx, offset htt_msg ; Supports HTT
mov ah, 9h
int 21h
check_IA64:
test dword ptr _features_edx, IA64_FLAG ; check for IA64 capabilites
jz check_TM
mov dx, offset ia64_msg
mov ah, 9h
int 21h
check_TM:
test dword ptr _features_edx, TM_FLAG ; check for Thermal Monitor
jz check_PBE
mov dx, offset tm_msg
mov ah, 9h
int 21h
check_PBE:
test dword ptr _features_edx, PBE_FLAG ; check for Pending Break Event
jz check_sse3
mov dx, offset pbe_msg
mov ah, 9h
int 21h
check_sse3:
test dword ptr _features_ecx, SSE3_FLAG ; check for SSE3 instructions
jz check_monitor
mov dx, offset sse3_msg
mov ah, 9h
int 21h
check_monitor:
test dword ptr _features_ecx, MONITOR_FLAG ; check for monitor/mwait instructions
jz check_ds_cpl
mov dx, offset monitor_msg
mov ah, 9h
int 21h
check_ds_cpl:
test dword ptr _features_ecx, DS_CPL_FLAG ; Check for DS_CPL
jz check_VMX
mov dx, offset ds_cpl_msg
mov ah, 9h
int 21h
check_VMX:
test dword ptr _features_ecx, VMX_FLAG ; Virtualization Technology?
jz check_SMX
mov dx, offset vmx_msg
mov ah, 9h


int 21h
check_SMX:
test dword ptr _features_ecx, SMX_FLAG ; Trusted Execution Technology?
jz check_EIST
mov dx, offset smx_msg
mov ah, 9h
int 21h
check_EIST: ; check for Enhanced Intel SpeedStep Technology
test dword ptr _features_ecx, EIST_FLAG
jz check_TM2
mov dx, offset eist_msg
mov ah, 9h
int 21h
check_TM2:
test dword ptr _features_ecx, TM2_FLAG ; check for Thermal Monitor 2
jz check_SSSE3
mov dx, offset tm2_msg
mov ah, 9h
int 21h
check_SSSE3:
test dword ptr _features_ecx, SSSE3_FLAG ; check for SSSE3
jz check_CID
mov dx, offset ssse3_msg
mov ah, 9h
int 21h
check_CID:
test dword ptr _features_ecx, CID_FLAG ; check for L1 Context ID
jz check_CX16
mov dx, offset cid_msg
mov ah, 9h
int 21h
check_CX16:
test dword ptr _features_ecx, CX16_FLAG ; check for CMPXCHG16B
jz check_XTPR
mov dx, offset cx16_msg
mov ah, 9h
int 21h
check_XTPR:
test dword ptr _features_ecx, XTPR_FLAG ; check for echo Task Priority
jz check_PDCM
mov dx, offset xtpr_msg
mov ah, 9h
int 21h
check_PDCM:
test dword ptr _features_ecx, PDCM_FLAG ; check for echo Task Priority
jz check_DCA
mov dx, offset pdcm_msg
mov ah, 9h


int 21h
check_DCA:
test dword ptr _features_ecx, DCA_FLAG ; Direct Cache Access?
jz check_SSE4_1
mov dx, offset dca_msg
mov ah, 9h
int 21h
check_SSE4_1:
test dword ptr _features_ecx, SSE4_1_FLAG ; SSE4.1 Instructions?
jz check_SSE4_2
mov dx, offset sse4_1_msg
mov ah, 9h
int 21h
check_SSE4_2:
test dword ptr _features_ecx, SSE4_2_FLAG ; SSE4.2 Instructions?
jz check_LAHF
mov dx, offset sse4_2_msg
mov ah, 9h
int 21h
check_LAHF:
test dword ptr _ext_funct_1_ecx, LAHF_FLAG ; check for LAHF/SAHF instructions
jz check_SYSCALL
mov dx, offset LAHF_msg
mov ah, 9h
int 21h
check_SYSCALL: ; check for SYSCALL/SYSRET instructions
test dword ptr _ext_funct_1_edx, SYSCALL_FLAG
jz check_XD
mov dx, offset syscall_msg
mov ah, 9h
int 21h
check_XD:
test dword ptr _ext_funct_1_edx, XD_FLAG ; Check for Execute Disable
jz check_EM64T
mov dx, offset xd_bit_msg
mov ah, 9h
int 21h
check_EM64T:
test dword ptr _ext_funct_1_edx, EM64T_FLAG ; check for Intel EM64T
jz end_print
mov dx, offset em64t_msg
mov ah, 9h
int 21h
jmp end_print
not_GenuineIntel:
mov dx, offset not_intel
mov ah, 9h

int 21h
end_print:
mov dx, offset cr_lf
mov ah, 9h
int 21h
ret
print endp
end start