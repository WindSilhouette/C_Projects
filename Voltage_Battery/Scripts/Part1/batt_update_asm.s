## THIS IS AN EXAMPLE FILE FOR batt_update_asm.s
## You may choose to use all or none of the starter / example code below
## Make sure to implement the below functions in your batt_update_asm.s file:
## set_batt_from_ports set_display_from_batt batt_update

.text
.global  set_batt_from_ports
        
# James Sargsyan; sargs005
# Dylan Nieminski; niemi170




# ENTRY POINT FOR REQUIRED FUNCTION
set_batt_from_ports:
    pushq %rbp # save base pointer
    movq %rsp, %rbp # set base pointer
    pushq %rbx # save rbx register
    movw BATT_VOLTAGE_PORT(%rip), %bx # move BATT_VOLTAGE_PORT into bx register
    cmpw $0, %bx # compare voltage to 0
    jl error # jump to error section if voltage < 0
    shrw $1, %bx # voltage = voltage >> 1
    movw %bx, (%rdi) # store voltage in batt->mlvolts
    cmpw $3000, %bx # compare voltage to 3000
    jge set_percent # jump to set_percent if voltage >= 3000
    movb $0, 2(%rdi) # store 0 in batt->percent
    jmp set_mode # jump to set_mode
set_percent:
    subw $3000, %bx # subtract 3000 from voltage
    shrw $3, %bx # voltage = voltage >> 3
    cmpb $100, %bl # compare percent to 100
    jle set_percent_ok # jump to set_percent_ok if percent <= 100
    movb $100, %bl # store 100 in batt->percent
set_percent_ok:
    movb %bl, 2(%rdi) # store percent in batt->percent
set_mode:
    movb BATT_STATUS_PORT(%rip), %bl # move BATT_STATUS_PORT into bl register
    andb $0x10, %bl # read bit 4 of bl register (battery status port)
    jnz set_mode_1 # jump to set_mode_1 if bit 4 is set
    movb $2, 3(%rdi) # store 2 in batt->mode
    jmp end # jump to end
set_mode_1:
    movb $1, 3(%rdi) # store 1 in batt->mode
end: # for regular cases
    xorl %eax, %eax # set eax to 0 for a return value
    jmp end1 # jump to end
end1:
    popq %rbx # restore bx register
    popq %rbp # restore base pointer
    ret # return to caller
error:
    movl $1, %eax # set eax to 1 for error
    jmp end1           # jump to end


    ## a useful technique for this problem
    ## movX    SOME_GLOBAL_VAR(%rip), %reg
    # load global variable into register
    # Check the C type of the variable
    #    char / short / int / long
    # and use one of
    #    movb / movw / movl / movq 
    # and appropriately sized destination register                                            


### Change to definint semi-global variables used with the next function 
### via the '.data' directive
.data
	
my_int:                     # declare location an single integer named 'my_int'
    .int 1234               # value 1234

other_int:                  # declare another int accessible via name 'other_int'
    .int 0b0101             # binary value as per C

my_array:                   # declare multiple ints sequentially starting at location
    .int 10                 # 'my_array' for an array. Each are spaced 4 bytes from the
    .int 0x00014            # next and can be given values using the same prefixes as 
    .int 0b11110            # are understood by gcc.


# WARNING: Don't forget to switch back to .text as below
# Otherwise you may get weird permission errors when executing 
.text
.global  set_display_from_batt

# ENTRY POINT FOR REQUIRED FUNCTION
.section .data
digits:
    .int 0b0111111    # 0
    .int 0b0000110    # 1
    .int 0b1011011    # 2
    .int 0b1001111    # 3
    .int 0b1100110    # 4
    .int 0b1101101    # 5
    .int 0b1111101    # 6
    .int 0b0000111    # 7
    .int 0b1111111    # 8
    .int 0b1101111    # 9
    .int 0b0000000    # empty
.section .text
.global set_display_from_batt
set_display_from_batt: 
    ## assembly instructions here
    # check if batt.mode is valid
    movl %edi, %eax      # stores the whole batt value in eax
    andl $0xff000000, %eax  # and the eax (masking)
    shrl $24, %eax   # shifting right 24 bits

    cmpb $1, %al       # compare al to 1
    je .percent_mode   # jump to valid_mode label if equal
    cmpb $2, %al         # compare al to 2
    je .volt_mode       # jump to valid_mode label if equal
    movl $1, %eax       # set return value to 1
    jmp .exit         # jump to exit label
.percent_mode:
    movl %edi, %edx
    andl $0xff0000, %edx
    shrl $16, %edx # gets batt.percent

    jmp .exit
.volt_mode:
    movl $0, %eax   # set return value to 0  

    jmp .exit
.exit:
    ret
# ENTRY POINT FOR REQUIRED FUNCTION
.global batt_update
batt_update:
    ## assembly instructions here
    pushq %rbp # saves base pointer
    movq %rsp, %rbp # set base pointer
    subq $16, %rsp # assign space for batt struct in stack
    movl    $-100, (%rsp)   # set batt.mlvolts to -100
    movl    $-1, 4(%rsp)    # set batt.percent to -1
    movl    $-1, 8(%rsp)    # set batt.mode to -1

    leaq    (%rsp), %rdi    # pass pointer to batt struct as argument
    call    set_batt_from_ports
    testl   %eax, %eax      # do some extra stuff
    jne     error1          # jump to error section if there was an error
 

    leaq    BATT_DISPLAY_PORT(%rip), %rdx  # pass pointer to display port as argument
    movq (%rsp), %rsi # pass pointer the batt struct as argument
    call set_display_from_batt
    jmp end2 # jump to the end

error1:
    movl    $1, %eax        # set eax to 1 for error
    jmp end2 # jump to end
end2:
    addq    $16, %rsp       # deallocate space for batt struct on stack
    popq    %rbp            # restore base pointer
    ret                     # return to caller