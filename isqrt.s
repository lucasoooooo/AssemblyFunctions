#Lucas Balangero
#U ID: 115334465
#Directory ID: lbalange

isqrt:
    li $t0, 1 #biggest possible int
    li $t1, 1 #t0 squared
loop:
    bgt $t1, $a0, max   #found max
    add $t0, $t0, 1     #iterates
    mul $t1, $t0, $t0   #prepares next number to check  
    j loop  

max:
    sub $t0, $t0, 1     #Goes to biggest possible int
    move $v0, $t0       
    jr $ra


