# Assembly Description Address Machine
main: addi $2, $0, 5            # initialize $2 = 5 
addi $3, $0, 12                 # initialize $3 = 12 
addi $7, $3, −9                 # initialize $7 = 3 
or $4, $7, $2                   # $4 = (3 OR 5) = 7 
and $5, $3, $4                  # $5 = (12 AND 7) = 4 
add $5, $5, $4                  # $5 = 4 + 7 = 11 
beq $5, $7, end                 # shouldn't be taken
slt $4, $3, $4                  # $4 = 12 < 7 = 0 
beq $4, $0, around              # should be taken 
addi $5, $0, 0                  # shouldn’t happen 
around: slt $4, $7, $2          # $4 = 3 < 5 = 1 
add $7, $4, $5                  # $7 = 1 + 11 = 12 
sub $7, $7, $2                  # $7 = 12 − 5 = 7 
sw $7, 68($3)                   # [80] = 7 
lw $2, 80($0)                   # $2 = [80] = 7 
j end                           # should be taken 
addi $2, $0, 1                  # shouldn't happen 
end: sw $2, 84($0)              # write mem[84] = 7 