#Lucas Balangero
#U ID: 115334465
#Directory ID: lbalange

strlen:
   li $v0, 0

loop:
    lb $t0, 0($a0)
    beqz $t0, endloop
    add $a0, $a0, 1
    add $v0, $v0, 1
    j loop

endloop:

    jr $ra            # return to kernelg

is_palindrome:
    subu $sp, $sp, 8        # expand stack by 8 bytes
    sw   $ra, 0($sp)        # push $ra (ret addr, 4 bytes)
    sw   $a0, 4($sp)        # push $fp (4 bytes)
    
    jal strlen
    move $t0, $v0  # t0 = lenght of word
    
    lw $a0, 4($sp)
    move $t1, $a0 #t1 = String
    li  $t2, 1 #counter
    li $v0, 1 #v0 == 1, palindrome, v0 == 0, non palindrome

    div $t3, $t0, 2 #t3 = half of the string
    add $t3, $t3, 1 #incase length is even
loop_p:

    bge $t2, $t3, endloop_p #reached halfway through string
 
    lb $t4, 0($a0)   #t4 = pointer to start of string
    #lb $t2, 0($t3) #t2 = pointer to end of string
    sub $t5, $t0, $t2 #end of string
    add $t6, $t5, $t1
    lb $t7, 0($t6) #charcter from end of string

    beq $t4, $t7, continue_p # If characters match
    li $v0, 0                # Else, characters don't match 
    j endloop_p

#iterate string pointers
continue_p:
    addi $a0, $a0, 1 
    addi $t2, $t2, 1
    j loop_p

endloop_p:
    lw $ra 0($sp)       #retrive address
    addi $sp, $sp, 8
    jr $ra            #return to main


    

