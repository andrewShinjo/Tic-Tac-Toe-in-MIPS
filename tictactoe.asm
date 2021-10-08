.data
	xAxis: .asciiz " 012"
	newLine: .asciiz "\n"
	xPrompt: .asciiz "X: "
	yPrompt: .asciiz "Y: "
	userPlayedPrompt: .asciiz "User played "
	board: .byte  ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
.text
	
	### t0 to hold x position
	### t1 to hold y position
	### t2 to hold array index
	### t3 to hold current player's position
	
	main:
		li $t3, 'X'
		while:
			jal drawBoard
			la $a0, newLine
			li $v0, 4		# print_string
			syscall
			syscall
		
			# Get x input from the user, and store it in $t0
			la $a0, xPrompt		# $a0 = "X: "
			li $v0, 4		# print_string
			syscall
			li $v0, 5		# input_int
			syscall
			move $t0, $v0		# $t0 = $v0
		
			# Get y input from the user, and store it in $t1
			la $a0, yPrompt		# $a0 equals "Y: "
			li $v0, 4		# print_string
			syscall
			li $v0, 5		# input_int
			syscall
			move $t1, $v0		# $t1 equals $v0
		
			# Print "User played (x, y)."
			la $a0, userPlayedPrompt
			li $v0, 4		# print_string
			syscall
			li $a0, '('		
			li $v0, 11		# print_char	
			syscall			
			move $a0, $t0		
			li $v0, 1		# print_int
			syscall	
			li $a0, ','	
			li $v0, 11		# print_char
			syscall
			move $a0, $t1
			li $v0, 1		# print_int
			syscall
			li $a0, ')'
			li $v0, 11		# print_char
			syscall
			li $a0 '.'
			syscall
			la $a0, newLine
			li $v0, 4		# print_string
			syscall
		
			# Gets the index of array the user wants to play a move on.
			addi $t2, $zero, 3
			mul $t2, $t1, $t2
			add $t2, $t2, $t0
		
			# If board($t2) != ' ', then move is invalid
			# bne board($t2), ' ', 
			
			move $a0, $t3
			sb $a0, board($t2)
			
			# If $t3 = X, then $t3 = O. Else, $t3 = X
			beq $t3, 'O', changeToX
			
			li $t3, 'O'
			j while
			
			changeToX:
				li $t3, 'X'
				j while
			
		end:
			# End of main
			li $v0, 10
			syscall
	

	drawBoard:
		li $v0, 4
		la $a0, xAxis
		syscall
		
		la $a0, newLine
		syscall
		
		li $v0, 11
		li $a0, '0'
		syscall
		
		addi $t0, $zero, 0
		lb $a0, board($t0)
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		li $v0, 4
		
		la $a0, newLine
		syscall
		
		li $v0, 11
		li $a0, '1'
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		li $v0, 4
		
		la $a0, newLine
		syscall
		
		li $v0, 11
		la $a0, '2'
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		addi $t0, $t0, 1
		lb $a0, board($t0)
		syscall
		
		jr $ra
		
