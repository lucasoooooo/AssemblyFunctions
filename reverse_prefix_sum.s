#Lucas Balangero
#U ID: 115334465
#Directory ID: lbalange


  reverse_prefix_sum:           #returns the array with each element being the sum of all the elements to the right
            addiu   $sp,$sp,-40
            sw      $ra,8($sp)
            sw      $fp,4($sp)
            move    $fp,$sp

            sw      $4,40($fp)      #return value
            lw      $a0,40($fp)
       
            lw      $t0,0($a0)
            li      $a0,-1                 
            bne     $t0,$a0,rec     #checking for end of list
           
            move    $a0,$0
            j       ret
           
    rec:                        #recursive func
            lw      $a0,40($fp)
            addiu   $a0,$a0,4
            move    $4,$a0          
            jal     reverse_prefix_sum
            
            move    $t0,$a0             
            lw      $a0,40($fp)
            lw      $a0,0($a0)
           
            addu    $a0,$t0,$a0
            sw      $a0,0($fp)
            lw      $a0,40($fp)
            lw      $t0,0($fp)
            
            sw      $t0,0($a0)
            lw      $a0,0($fp)
 
    ret:                        #return/end
            move    $sp,$fp
            lw      $ra,8($sp)
            lw      $fp,4($sp)
            addiu   $sp,$sp,8
            j       $ra
          