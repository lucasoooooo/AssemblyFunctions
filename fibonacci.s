#Lucas Balangero
#U ID: 115334465
#Directory ID: lbalange

fibonacci: #fibonacci(int $a0)
    
    beqz $a0, return0 #if n = 0 return 0
    beq $a0, 1, return1 #if n = 1 return 1 

    sub $sp, $sp, 4 #storing on stack
    sw $ra, 0($sp)

    sub $a0, $a0, 1 #subtracting 1 from n

    jal fibonacci #calling fibonacci with n-1

    add $a0, $a0, 1 #adding 1 to n, back to normal

    lw $ra, 0($sp) #restoring return address from stack
    add $sp, $sp, 4

    sub $sp, $sp, 4 #pushing to stack
    sw $v0, 0($sp)

    sub $sp, $sp, 4 #storing on stack 
    sw $ra, 0($sp)

    sub $a0, $a0, 2 #subtracting 2 from normal
    
    jal fibonacci #calling fibonacci with n-2 
    
    add $a0, $a0, 2 #adding 2 to n, back to normal

    lw $ra, 0($sp) #restoring return address from stack
    add $sp, $sp, 4

    lw $s7, 0($sp)
    add $sp, $sp, 4

    add $v0, $v0, $s7 #add both returns

    jr $ra

return0:
    li $v0, 0
    jr $ra

return1:
    li $v0, 1
    jr $ra


