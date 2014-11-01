 AREA prelab2, CODE, READWRITE

SysTick_Handler PROC
	EXPORT SysTick_Handler
	IMPORT msTicks		; import global variable
	LDR R0, =msTicks 	; load global variable's address
	LDR R1, [R0]		; load content in address onto R1
	ADD R1, R1, #1		; increase R1 by 1
	STR R1, [R0]		; store R1 into the address of the global var
	BX LR
	ENDP


square_elements PROC
	EXPORT square_elements
	;R0 = pointer to beginning of array
	;R1 = size of array
	MOV R2, #0			; initialize counter

square_elem_loop
	CMP R2, R1			; if counter == size array, branch LR
	BXEQ LR
	MUL R3, R2, R2		; calculate square and store in R3
	STR R3, [R0], #4	; store value in R3 into pointer and increase pointer address by one
	ADD R2, R2, #1		; increase counter
	B square_elem_loop	; branch to top of the loop
	ENDP


fibonacci PROC
	EXPORT fibonacci
	; R0 = pointer to beginning of array
	; R1 = size of array
	PUSH {R4-R6}
	MOV R2, #0			; initalize counter

	CMP R2, R1			; if the size of the array is 0, return to caller
	BXEQ LR 			;
	MOV R4, #1			; load first value into R4
	STR R4, [R0], #4	; store first value into first place in array and increase pointer by 4
	ADD R2, R2, #1 		;; R2=1
	CMP R2, R1			; if size of array is 1 jump to the loop in which the program will exit
	BEQ one_item

	MOV R5, #1			; load second value into R5
	STR R5, [R0], #4	; store second value into second place in array and increase pointer by 4
	ADD R2, R2, #1 		;; R2=2

one_item

fibonacci_loop			; start of the loop
	CMP R2, R1			; compare if counter == size of array
	BEQ exitloop			; if so, return to caller
	ADD R6, R5, R4		; calculate newest number and store in R6
	ADD R4, R5, #0			; move content in R5 to R4
	ADD R5, R6, #0			; move content in R6 to R5
	STR R5, [R0], #4	; Store value in R5 (new value) into current empty place in array
	ADD R2, R2, #1		; increase counter
	B fibonacci_loop	; go back to top of loop
	ENDP

exitloop
	POP {R4-R6}
	BX LR
	
dot_product PROC
	EXPORT dot_product
	;R0 points to array a
	;R1 points to array b
	;R2 has size of arrays
	PUSH {R4-R6}
	MOV R3, #0 ; initialize counter
	MOV R6, #0 ; initialize result

dot_loop
	CMP R3, R2
	BEQ exit_dot
	LDR R4, [R0], #4
	LDR R5, [R1], #4
	MLA R6, R4, R5, R6 ; Multiply R4 by R5 and add it to the current value of R6 and store it in R6
	ADD R3, R3, #1
	B dot_loop
	ENDP
exit_dot
	MOV R0, R6
	POP {R4-R6}
	BX LR


blink PROC
	EXPORT blink
	IMPORT msTicks
	IMPORT LED_Out
	PUSH {R4-R10}
	LDR R9, =LED_Out
	LDR R1, =msTicks
	LDR R5, [R1]
	MOV R6, #0		; current time
	MOV R10, #0x5 	; LED initial value:0101

blink_loop
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;calculate time elapsed;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;
	LDR R7, [R1]
	SUB R5, R7, R5 	; msTick difference since last check
	ADD R6, R6, R5 	; add to current time
	MOV R5, R7		;
	CMP R6, R0		; check if current time equals period
	BGE time_to_toggle
	; else loop
	B blink_loop

time_to_toggle
	MOV R6, #0		; reset current time
	EOR R10, R10, #0xF ; calculate new value
	PUSH {LR, R0-R3}
	MOV R0, R10	; new led Value
	BLX R9
	POP {LR, R0-R3}
	B blink_loop
	ENDP
	
	
	
;blink PROC
	;EXPORT blink
	;IMPORT msTicks
	;IMPORT LED_Out
	
	;PUSH {R4-R11}

	;LDR R9, =LED_Out
	;LDR R1, =msTicks
	;LDR R5, [R1]

	;MOV R6, #0		; current time
	;MOV R10, #0x5 	; LED initial value:0101
	
	;; Turn on LED
	;PUSH {R0}
	;MOV R0, R10
	;BLX R9
	;POP {R0}

;blink_loop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;calculate time elapsed;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	;; Reload msTicks
	;LDR R1, =msTicks
	;LDR R7, [R1]
	
	;SUB R5, R7, R5 	; msTick difference since last check
	;ADD R6, R6, R5 	; add to current time
	;MOV R5, R7		;
	
	;CMP R6, R0		; check if current time equals period
	;BGE time_to_toggle
	;; else loop
	;B blink_loop

;time_to_toggle
	;MOV R6, #0		; reset current time
	;EOR R10, R10, #0xF ; calculate new value

	;PUSH {LR, R0, R1, R2, R3}
	;MOV R0, R10	; new led Value
	;BLX R9
	;POP {LR, R0, R1, R2, R3}
	;B blink_loop
	;ENDP
	

 END