.data
	xAxis: .asciiz " 012"
	y0: .asciiz "0"
	y1: .asciiz "1"
	y2: .asciiz "2"
	newLine: .asciiz "\n"
	xPrompt: .asciiz "X: "
	yPrompt: .asciiz "Y: "
	board: .byte  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'
.text
	main:
		# Get x input from the user, and store it in $t0
		la $a0, xPrompt		# $a0 equals "X: "
		jal printString		# Prints $a0
		jal getIntegerInput	# $v0 equals X input from user
		move $t0, $v0		# $t0 equals $v0
		
		# Get y input from the user, and store it in $t1
		la $a0, yPrompt		# $a0 equals "Y: "
		jal printString		# Prints string stored in $a0
		jal getIntegerInput	# $v0 equals Y input from user
		move $t1, $v0		# $t1 equals $v0
		
		# Print (x, y)
		li $a0, '('		
		li $v0, 11		
		syscall			
		move $a0, $t0		
		jal printInteger	
		li $a0, ','	
		li $v0, 11	
		syscall
		move $a0, $t1
		jal printInteger
		li $a0, ')'
		li $v0, 11
		syscall
		
		la $a0, newLine
		jal printString
		
		addi $t2, $zero, 3
		mul $t2, $t0, $t2
		add $t2, $t2, $t1
		
		li $v0, 11
		lb $a0, board($t2)
		syscall
		
		
		# End of main
		li $v0, 10
		syscall
	
	printInteger:
		li $v0, 1		# Sets syscall to print the integer stored in $a0
		syscall			# Prints integer stored in $a0
		jr $ra			# Returns to main
	
	printString:
		li $v0, 4		# Sets syscall to print the string stored in $a0
		syscall			# Prints string stored in $a0
		jr $ra			# Returns to main
	
	getIntegerInput:
		li $v0, 5		# Sets syscall to get an integer input from the user
		syscall			# $v0 equals integer input from the user
		jr $ra 			# Returns to main
	drawBoard:
		li $v0, 4
		la $a0, xAxis
		syscall
		
		la $a0, newLine
		syscall
		
		la $a0, y0
		syscall
		
		li $v0, 11
		
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
		
		la $a0, y1
		syscall
		
		li $v0, 11
		
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
		
		la $a0, y2
		syscall
		
		li $v0, 11
		
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
		
