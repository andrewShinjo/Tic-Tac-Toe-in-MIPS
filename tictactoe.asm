.data
	xAxis: .asciiz " 012"
	newLine: .asciiz "\n"
	xPrompt: .asciiz "X: "
	yPrompt: .asciiz "Y: "
	userPlayedPrompt: .asciiz "User played "
	illegalMovePrompt: .asciiz "The move is illegal.\n"
	board: .byte  ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
	moveNumberPrompt: .asciiz "The move number is "
	moveNumber: .byte 0
	gameWonPrompt: .asciiz "Game won!\n"
.text	
	main:
	li $s7, 'X'
		
	while:
	
	jal drawBoard
		
	jal getXInput 			# Store x-input into $s0
	jal getYInput 			# Store y-input into $s1
	jal printMovePlayedPrompt 	# Prints "User played (x, y)."

	# Transform (x,y) to array index and store into $s2
	addi $s2, $zero, 3
	mul $s2, $s1, $s2
	add $s2, $s2, $s0
			
	jal validateMove # if move is legal, continue. Otherwise, return to while.
	jal playMove	
	
	jal incrementMoveNumber
	jal printMoveNumber
	
	jal changePiece
	jal checkIfPlayerWon

	j while
			
		end:
		# End of main
		li $v0, 10
		syscall
		 
		# Helper procedures
		
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
		la $a0, newLine
		li $v0, 4		# print_string
		syscall
		syscall
		jr $ra
		
		getXInput:
		la $a0, xPrompt		# $a0 = "X: "
		li $v0, 4		# print_string
		syscall
		li $v0, 5		# input_int
		syscall
		move $s0, $v0		# $s0 = $v0
		jr $ra
		
		getYInput:
		la $a0, yPrompt		# $a0 equals "Y: "
		li $v0, 4		# print_string
		syscall
		li $v0, 5		# input_int
		syscall
		move $s1, $v0		# $s1 = $v0
		jr $ra
		
		printMovePlayedPrompt:
		la $a0, userPlayedPrompt
		li $v0, 4		# print_string
		syscall
		li $a0, '('		
		li $v0, 11		# print_char	
		syscall			
		move $a0, $s0		
		li $v0, 1		# print_int
		syscall	
		li $a0, ','	
		li $v0, 11		# print_char
		syscall
		move $a0, $s1
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
		jr $ra
		
		validateMove:
		lb $t7, board($s2)
		bne $t7, ' ', illegalMove
		jr $ra
		illegalMove:
		la $a0, illegalMovePrompt
		li $v0, 4		# print_string
		syscall
		j while
		
		playMove:
		move $a0, $s7
		sb $a0, board($s2)
		jr $ra
		
		incrementMoveNumber:
		lb $t7, moveNumber
		addi $t7, $t7, 1
		sb $t7, moveNumber
		jr $ra
		
		changePiece:
		beq $s7, 'O', changeToX
		li $s7, 'O'
		j while
		changeToX:
		li $s7, 'X'
		j while
		
		printMoveNumber:
		li $v0, 4
		la $a0, moveNumberPrompt
		syscall
		
		li $v0, 1
		lb $a0, moveNumber
		syscall
		
		li $v0, 11
		li $a0, '.'
		syscall
		
		li $v0, 4
		la $a0, newLine
		syscall 
		
		jr $ra
		
	checkIfPlayerWon:
	# Check if board[0] == board[1] == board[2]
	addi $t4, $zero, 0
	lb $t5, board($t4)	# t5 = board[0]
	addi $t4, $zero, 1	
	lb $t6, board($t4)	# t6 = board[1]
	
	and $t7, $t5, $t6	# t7 = board[0] && board[1]
	addi $t4, $zero, 2
	lb $t5, board($t4)	# t5 = board[2]
	and $t7, $t5, $t7	# t7 = board[0] && board[1] && board[2]
	
	beq $t7, $t5, gameWon
	
	jr $ra
	
	gameWon:
	la $a0, gameWonPrompt
	li $v0, 4
	syscall
	j end
	
	
	
	
	