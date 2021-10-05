.data
	xAxis: .asciiz " 012"
	y0: .asciiz "0"
	y1: .asciiz "1"
	y2: .asciiz "2"
	newLine: .asciiz "\n"
	xPrompt: .asciiz "X: "
	yPrompt: .asciiz "Y: "
	board: .byte  ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '
.text
	main:
		# Print xPrompt
		li $v0, 4
		la $a0, xPrompt
		syscall
		
		# Read integer input
		li $v0, 5
		syscall
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		
		# End of main
		li $v0, 10
		syscall
	
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
		
