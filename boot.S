.section ".text.boot"
.global _start

_start:
    mrs x1, mpidr_el1
    and x1, x1, #3
    cbz x1, start_core0

do_sleep:
    wfe
    b do_sleep

start_core0:
    ldr x1, =_start
    mov sp, x1

    ldr x1, =__bss_start
    ldr w2, =__bss_size

do_crt0:
    cbz w2, start_main
    str xzr, [x1], #8
    sub w2, w2, #1
    cbnz w2, do_crt0

start_main:
    bl main
    b do_sleep
