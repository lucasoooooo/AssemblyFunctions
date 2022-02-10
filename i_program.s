   .data
str1:
   .asciiz "abba"
str2:
   .asciiz "racecar"
str3:
   .asciiz "swap paws",
str4:
   .asciiz "not a palindrome"
str5:
   .asciiz "another non palindrome"
str6:
   .asciiz "almost but tsomla"

# array of char pointers = {&str1, &str2, ..., &str6}
ptr_arr:
   .word str1, str2, str3, str4, str5, str6, 0

yes_str:
   .asciiz " --> Y\n"
no_str:
   .asciiz " --> N\n"

   .text

# main(): ##################################################
#   char ** j = ptr_arr
#   while (*j != 0):
#     rval = is_palindrome(*j)
#     printf("%s --> %c\n", *j, rval ? yes_str: no_str)
#     j++
#
main:
   li   $sp, 0x7ffffffc    # initialize $sp

   # PROLOGUE
   subu $sp, $sp, 8        # expand stack by 8 bytes
   sw   $ra, 8($sp)        # push $ra (ret addr, 4 bytes)
   sw   $fp, 4($sp)        # push $fp (4 bytes)
   addu $fp, $sp, 8        # set $fp to saved $ra

   subu $sp, $sp, 8        # save s0, s1 on stack before using them
   sw   $s0, 8($sp)        # push $s0
   sw   $s1, 4($sp)        # push $s1

   la   $s0, ptr_arr        # use s0 for j. init ptr_arr
main_while:
   lw   $s1, ($s0)         # use s1 for *j
   beqz $s1, main_end      # while (*j != 0):
   move $a0, $s1           #    print_str(*j)
   li   $v0, 4
   syscall
   move $a0, $s1           #    v0 = is_palindrome(*j)
   jal  is_palindrome
   beqz $v0, main_print_no #    if v0 != 0:
   la   $a0, yes_str       #       print_str(yes_str)
   b    main_print_resp
main_print_no:             #    else:
   la   $a0, no_str        #       print_str(no_str)
main_print_resp:
   li   $v0, 4
   syscall

   addu $s0, $s0, 4       #     j++
   b    main_while        # end while
main_end:

   # EPILOGUE
   move $sp, $fp           # restore $sp
   lw   $ra, ($fp)         # restore saved $ra
   lw   $fp, -4($sp)       # restore saved $fp
   j    $ra                # return to kernel
# end main ################################################
is_palindrome:
    subu $sp, $sp, 8        # expand stack by 8 bytes
    sw   $ra, 8($sp)        # push $ra (ret addr, 4 bytes)
    sw   $fp, 4($sp)        # push $fp (4 bytes)
    
    j strlen
    move $t0, $v0  # t0 = lenght of word
    
    lw $a0, 4($sp)
    move $t1, $a0 #t1 = String
    li  $t2, 1 #counter
    li $v0, 1 #v0 == 1, palindrome, v0 == 0, non palindrome

    div $t3, $t0, 2 #t3 = half of the string

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


strlen:
   li $v0, 0

loop:
    lb $t0, 0($a0)
    beqz $t0, endloop
    add $a0, $a0, 1
    add $v0, $v0, 1
    j loop

endloop:
    sub $v0, $v0, 4
    jr $ra            # return to kernelg
    

