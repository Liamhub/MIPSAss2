.data
prompt_a:.asciiz "Enter value for a \n:"
prompt_b:.asciiz "Enter value for b :\n"
prompt_c:.asciiz "Enter value for c :\n"
complex_error:.asciiz "Complex root, please enter a valid value \n "
X1:.asciiz "X1 = \n"
X2:.asciiz "X2 = \n"
buzz_question:.asciiz "Press 1 to continue and any other key to quit\n"
buzz_two: .float 2
buzz_four: .float 4
discriminant_checker:.float 0

.text
Starting_starting:
lwc1 $f1,buzz_two                   #$f1 they hold 2.0
lwc1 $f2,buzz_four                  #$f2 they hold 4.0
lwc1 $f3,discriminant_checker       #$f3 they hold 0.0 i won use am check my discriminant

la $a0,prompt_a                       #prompt user for value of A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #Na $f4 i take hold A

la $a0,prompt_b                       #prompt user for value of B
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #Na $f5 i take hold B

la $a0,prompt_c                     #prompt user for value of C
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #Na $f6 i take hold C

#Na now i start to calculate my discriminant when be ## d = b^2-4*a*c
#And my 4=$f2, a=$f4, b=$f5, c=$f6

mul.s $f7,$f5,$f5                  #$f7 = b^2
mul.s $f8,$f2,$f4                  
mul.s $f8,$f8,$f6                  #$f8 = 4*a*c
sub.s $f8,$f7,$f8                  #$f8 = d = b^2-4*a*c#$f9 = d = b^2-4*a*c
mfc1 $t1,$f8                       #i change $f8 to $t1 make i for fit check if my discriminat small pass zero(0)

blez $t1,error_label               #Na to check if the discriminant small pass zero or na zero
sqrt.s $f10,$f8                    #$f10 they hold the square root of the discriminant

#Compute roots                     
neg.s $f9,$f5                      #change b to -b
add.s $f23,$f9,$f10                #-b+sqrtd
sub.s $f25,$f9,$f10                #-b-sqrtd
mul.s $f1,$f1,$f4                  #the divisor 2*a
div.s $f24,$f23,$f1                #compute -b+sqrtd by 2*a
div.s $f26,$f25,$f1                #compute -b-sqrtd by 2*a
la $a0,X1
li $v0,4
syscall

mov.s $f12,$f24
li $v0,2
syscall

la $a0,X2
li $v0,4
syscall

mov.s $f12,$f26
li $v0,2
syscall

la $a0,buzz_question
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0
li $t3,1
beq $t4,$t3,Starting_starting
b exit

error_label:
la $a0,complex_error
li $v0,4
syscall


la $a0,buzz_question
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0
li $t3,1
beq $t4,$t3,Starting_starting

b exit
exit:
la $a0,buzz_goodbye
li $v0,4
syscall

li $v0,10
syscall
