;haziqali
;hajirauzair
;meshalcheema
;//////////////////////////////////////////////SUPER MARIO///////////////////////////////////////////////////////////////
.model small
.stack 100h
.data
;/////////////////////////////////////////////////ALLL VARIABLES USED/////////////////////////////////////////////////////
delay_Time dw ?
Background_Colour db 0011b
level dw 1

scores dw 0
scores_x_axis db 0
scores_y_axis db 0
scoresStr db 'S',0Fh,'c',0Fh,'o',0Fh,'r',0Fh,'e',0Fh,'s',0Fh,':',0Fh,' ',0Fh

lives dw 3
lives_x_axis db 152
lives_y_axis db 0
livesStr db 'L',0Fh,'i',0Fh,'v',0Fh,'e',0Fh,'s',0Fh,':',0Fh,' ',0Fh

coded db 'C', 0Fh,'o', 0Fh,'e', 0Fh,'f', 0Fh,'e', 0Fh,' ', 0Fh
by db 'b', 0Fh,'y', 0Fh,' ', 0Fh
meshal db 'M', 0Fh,'e', 0Fh,'s', 0Fh,'h', 0Fh,'a', 0Fh,'l', 0Fh,' ', 0Fh
haziq db '&', 0Fh,' ', 0Fh,'H', 0Fh,'a', 0Fh,'z', 0Fh,'i', 0Fh,'q', 0Fh
hajira  db '&', 0Fh,' ', 0Fh,'H', 0Fh,'a', 0Fh,'j', 0Fh,'i', 0Fh,'r', 0Fh,'a', 0Fh

LOST db 'Y', 0Fh,'0', 0Fh,'U', 0Fh,' ', 0Fh,'L', 0Fh,'0', 0Fh,'S', 0Fh,'T', 0Fh
ENDLIVE db 'L', 0Fh,'I', 0Fh,'V', 0Fh,'E', 0Fh,'S', 0Fh,'=', 0Fh,'0', 0Fh

YOU db 'Y', 0Fh,'0', 0Fh,'U', 0Fh,' ', 0Fh,'W', 0Fh,'I', 0Fh,'N', 0Fh


rules db"RULES OF SUPERMARIO$"
rules1 db "*)There are 3 levels of this game$"
rules2 db "*)Jump over the hurdles to cross them$"
rules3 db "*)Dont collide with Enemies, else you will die$"
rules4 db "*)To kill Enemies, jump over them!$"
rules5 db "*)Don't let Monsters fire catch you$"
rules6 db "*)Reach castle, to win the game$"
      
base_x_axis dw 0
base_y_axis dw 345
tempBaseX dw ?
tempBaseY dw ?

resetMario_x_axis dw 25
resetMario_y_axis dw 301
mario_x_axis dw ?
mario_y_axis dw ?
mario_left dw ?
mario_right dw ?
mario_down dw ?
mario_up dw ?

a dw 0
b dw 0
d db 0
e db 0
f db 0
jump dw 0
temp_x_axis dw ?
temp_y_axis dw ?
counter dw 0
levelEnd dw 615
buffer_x_axis db 8
buffer_y_axis db 0
buffer DB 50 DUP("$")

hurdle1_left dw ?
hurdle1_right dw ?
hurdle1_up dw ?
hurdle2_left dw ?
hurdle2_right dw ?
hurdle2_up dw ?
hurdle3_left dw ?
hurdle3_right dw ?
hurdle3_up dw ?

rectX dw ?
rectY dw ?
rectLength dw ?
rectWidth dw ?
rectColor db ?	

enemy_x_axis dw ?
enemy_y_axis dw ?
enemy1_x_axis dw 175
enemy1_y_axis dw 303
enemy2_x_axis dw 439
enemy2_y_axis dw 303
enemy_left dw ?
enemy_right dw ?
enemy_up dw ?
enemy1_left dw ?
enemy1_right dw ?
enemy1_up dw ?
enemy2_left dw ?
enemy2_right dw ?
enemy2_up dw ?
enemyCheck1 dw 0
enemyCheck2 dw 0
enemy1Collision dw 0
enemy2Collision dw 0

monster_x_axis dw 510
monster_y_axis dw 20
monster_up dw ?
monster_down dw ?
monster_right dw ?
monster_left dw ?
tempMonsterX dw ?
tempMonsterY dw ?
monsterCheck dw 0

fire_x_axis dw ?
fire_y_axis dw ?
fire_up dw ?
fire_down dw ?
fire_left dw ?
fire_right dw ?
tempFire_x_axis dw ?
tempFire_y_axis dw ?
fireCheck dw 0

castle_x_axis dw 544
castle_y_axis dw 237
tempCastle_x_axis dw ?
tempCastle_y_axis dw ?
;/////////////////////////////////////////////////////////MACROS DEFINED////////////////////////////////////////////////////
.code
;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateRectangle MACRO x,y,len,wdth,colr
	mov bx, x
	mov rectX, bx
	mov bx, y
	mov rectY, bx
	mov bx, len
	mov rectLength, bx
	mov bx, wdth
	mov rectWidth, bx
	mov bl, colr
	mov rectColor, bl
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
resetBase MACRO
	mov bx,base_x_axis
	mov tempBaseX, bx
	mov bx,base_y_axis
	mov tempBaseY,bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateMario MACRO x,y
	mov bx, x
	mov mario_x_axis, bx
	mov bx, y
	mov mario_y_axis, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateEnemy MACRO x,y
	mov bx, x
	mov enemy_x_axis, bx
	mov bx, y
	mov enemy_y_axis, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateEnemy1 MACRO
	mov bx, enemy_left
	mov enemy2_left, bx
	mov bx, enemy_right
	mov enemy2_right, bx
	mov bx, enemy_up
	mov enemy2_up, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateEnemy2 MACRO
	mov bx, enemy_left
	mov enemy1_left, bx
	mov bx, enemy_right
	mov enemy1_right, bx
	mov bx, enemy_up
	mov enemy1_up, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateMonster MACRO x,y
	mov bx, x
	mov monster_x_axis, bx
	mov bx, y
	mov monster_y_axis, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
resetMonster MACRO
	mov bx, monster_x_axis
	mov tempMonsterX, bx
	mov bx, monster_y_axis
	mov tempMonsterY, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
updateFire MACRO x,y
	mov bx, x
	mov fire_x_axis, bx
	mov bx, y
	mov fire_y_axis, bx
ENDM
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
resetFire MACRO
	mov bx, fire_x_axis
	mov tempFire_x_axis, bx
	mov bx, fire_y_axis
	mov tempFire_y_axis, bx
ENDM
;.......................................................................................................................................
resetCastle MACRO
	mov bx,castle_x_axis
	mov tempCastle_x_axis,bx
	mov bx,castle_y_axis
	mov tempCastle_y_axis,bx
ENDM
 ;///////////////////////////////////////////////MAINPROC////////////////////////////////////////////////////////////
;.......................................................................................................................................
main proc
	mov ax, @data
	mov ds, ax
    NEXT_LEVEL:
    mov ah, 0h		; graphical mode
	mov al, 10h		; screen size 640x333 
	int 10h
	.if level == 1
		mov ah, 4H; changing background color
		mov al, 0
		mov cx, 0
		mov dh, 80
		mov dl, 80
		mov bh, 0000b
		int 10h
		call drawSuperMario

		mov d, 18
		mov e, 33

		mov ax,SEG coded		; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF coded)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET coded		; string offset
		int 10h

		add e, 6

		mov ax,SEG by			; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF by)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET by		; string offset
		int 10h

	

        mov d, 20
		mov e, 24
		
		mov ax,SEG meshal		; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF meshal)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET meshal		; string offset
		int 10h

		add e, 7

		mov ax,SEG haziq		; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF haziq)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET haziq	; string offset
		int 10h
        
		mov e,40

		mov ax,SEG hajira			; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF hajira)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET hajira		; string offset
		int 10h
		call Delay
        call delay
        
		.else
		mov ah, 06h		; changing background color
		mov al, 0
		mov cx, 0
		mov dh, 80
		mov dl, 80
		mov bh, 0
		int 10h
	
		call Delay
       .endif
   
    ;rules
    mov ah, 06h		;changing background color
    mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, 0000b
	int 10h
    lea dx,offset rules
    mov ah,09
    int 21h
    call delay
    call newline
    lea dx,offset rules1
    mov ah,09
    int 21h
    call delay
    call newline
    lea dx,offset rules2
    mov ah,09
    int 21h
    call delay
    call newline
    lea dx,offset rules3
    mov ah,09
    int 21h
    call delay
    call newline
    lea dx,offset rules4
    mov ah,09
    int 21h
    call delay
    call newline
    lea dx,offset rules5
    mov ah,09
    int 21h
    call delay
    call newline
    lea dx,offset rules6
    mov ah,09
    int 21h
    call delay
    call delay
    mov ah, 06h		;changing background color
	mov al, 0
	mov cx, 0
	mov dh, 80
	mov dl, 80
	mov bh, Background_Colour
	int 10h
   
   .if level != 3
		call drawFlag
	.else
		call drawCastle
	.endif
	call drawHurdles
    call drawFloor
	mov cx, resetMario_x_axis
	mov mario_x_axis, cx
	mov cx, resetMario_y_axis
	mov mario_y_axis, cx

	.if level == 2
		
		updateEnemy enemy1_x_axis,enemy1_y_axis
		updateEnemy1
		call drawEnemy
	
		updateEnemy enemy2_x_axis,enemy2_y_axis
		updateEnemy2
		call drawEnemy
	.endif

	.if level == 3
		mov levelEnd, 600
	
		mov enemyCheck1,0
		mov enemyCheck2,0
		mov enemy1Collision, 0
		mov enemy2Collision, 0
		mov enemy1_x_axis, 175
		mov enemy1_y_axis, 303
		mov enemy2_x_axis, 439
		mov enemy2_y_axis, 303
		inc lives
        updateEnemy enemy1_x_axis,enemy1_y_axis
		updateEnemy1
		call drawEnemy
	
		updateEnemy enemy2_x_axis,enemy2_y_axis
		updateEnemy2
		call drawEnemy
	.endif

	_infiniteLoop:
		.if level == 2
			call enemyMovement
			call enemyCollisionTest
		.elseif level == 3
			call enemyMovement
				call monsterMovement
			call enemyCollisionTest
		.endif

		call print
		updateMario mario_x_axis,mario_y_axis
		call drawMario
       jmp KEY_CHECKER
       KEY_CHECKER:		; checking whether a key is pressed or not
			mov ah,11h
			int 16h
			jnz checkKey	
     back:
	loop _infiniteLoop
	
	checkKey:				; taking pressed key out of the buffer
		mov ah,10h
		int 16h


	;In below all checks I am comparing scan codes of the up,down,left,right and esc keys
		CHECKING_RIGHT_KEY:
				cmp ah,4dh
				jne CHECKING_LEFT_KEY

				mov ax, mario_right
				add ax, 5
				mov bx, mario_left
				add bx, 5
				mov cx, mario_down

				cmp ax, levelEnd
				jge levelCompleted
		
				.if ax > hurdle1_left && bx < hurdle1_right
					.if cx > hurdle1_up
						mov jump, 1
						jmp dontMoveRight
					.endif
				.endif

				.if ax > hurdle2_left && bx < hurdle2_right
					.if cx > hurdle2_up
						mov jump, 2
						jmp dontMoveRight
					.endif
				.endif

				.if ax > hurdle3_left && bx < hurdle3_right
					.if cx > hurdle3_up
						mov jump, 3
						jmp dontMoveRight
					.endif
				.endif
		
				; move down when over hurdle (opposite one)
				.if ax < hurdle2_left && bx > hurdle1_left
					.if cx <= hurdle1_up
						mov jump, 1
					.endif
				.endif

				.if ax < hurdle3_left && bx > hurdle2_left
					.if cx <= hurdle2_up
						mov jump, 2
					.endif
				.endif

				.if ax < 620 && bx > hurdle3_left
					.if cx <= hurdle3_up
						mov jump, 3
					.endif
				.endif


				; move down when over hurdle
				.if ax < hurdle2_left && bx > hurdle1_right && jump == 1
					mov jump, -1
					mov cx, 10
					l1:
						add mario_y_axis, 5
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						sub mario_y_axis, 5
						call removeMario
						add mario_y_axis, 5
						updateMario mario_x_axis, mario_y_axis
						call drawMario

						.if level >= 2
							call enemyCollisionTest
						.endif

					loop l1
				.endif

				.if ax < hurdle3_left && bx > hurdle2_right && jump == 2
					mov jump, -1
					mov cx, 10
					l2:
						add mario_y_axis, 8
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						sub mario_y_axis, 8
						call removeMario
						add mario_y_axis, 8
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						.if level >= 2
							call enemyCollisionTest
						.endif
					loop l2
				.endif

				.if ax < 620 && bx > hurdle3_right && jump == 3
					mov jump, -1
					mov cx, 10
					l3:
						add mario_y_axis, 7
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						sub mario_y_axis, 7
						call removeMario
						add mario_y_axis, 7
						updateMario mario_x_axis, mario_y_axis
						call drawMario

						.if level >= 2
							call enemyCollisionTest
						.endif

					loop l3
				.endif

				.if level == 2
					call enemyMovement
				.elseif level == 3
					call enemyMovement
						call monsterMovement
					
				.endif
				call print

				moveRight::
					add mario_x_axis,5
					updateMario mario_x_axis,mario_y_axis
					call drawMario
					sub mario_x_axis,5
					call removeMario
					call cR
					add mario_x_axis,5
					updateMario mario_x_axis,mario_y_axis
					call drawMario
					
				dontMoveRight:
					jmp back
 
		CHECKING_LEFT_KEY:
				cmp ah,4bh
				jne CHECKING_UP_KEY

				mov ax, mario_right
				mov bx, mario_left
				mov cx, mario_down


				cmp bx, 0
				jle dontMoveLeft

				sub bx, 5
		
				.if bx < hurdle1_right && ax > hurdle1_left
					.if cx > hurdle1_up
						mov jump, 11
						jmp dontMoveLeft
					.endif
				.endif

				.if bx < hurdle2_right && ax > hurdle2_left
					.if cx > hurdle2_up
						mov jump, 22
						jmp dontMoveLeft
					.endif
				.endif

				.if bx < hurdle3_right  && ax > hurdle3_left
					.if cx > hurdle3_up
						mov jump, 33
						jmp dontMoveLeft
					.endif
				.endif

				; move down when over hurdle (opposite one)
				.if bx < hurdle1_right && ax > hurdle1_left
					.if cx <= hurdle1_up
						mov jump, 11
					.endif
				.endif

				.if bx < hurdle2_right && ax > hurdle2_left
					.if cx <= hurdle2_up
						mov jump, 22
					.endif
				.endif

				.if bx < hurdle3_right && ax > hurdle3_left
					.if cx <= hurdle3_up
						mov jump, 33
					.endif
				.endif


				; move down when over hurdle, left arrow
				.if ax < hurdle1_left && bx > 0 && jump == 11
					mov jump, -1
					mov cx, 10
					l11:
						add mario_y_axis, 5
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						sub mario_y_axis, 5
						call removeMario
						add mario_y_axis, 5
						updateMario mario_x_axis, mario_y_axis
						call drawMario

						.if level >= 2
							call enemyCollisionTest
						.endif
					loop l11
				.endif

				.if bx > hurdle1_right && ax < hurdle2_left && jump == 22
					mov jump, -1
					mov cx, 10
					l22:
						add mario_y_axis, 8
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						sub mario_y_axis, 8
						call removeMario
						add mario_y_axis, 8
						updateMario mario_x_axis, mario_y_axis
						call drawMario

						.if level >= 2
							call enemyCollisionTest
						.endif
					loop l22
				.endif

				.if bx > hurdle2_right && ax < hurdle3_left && jump == 33
					mov jump, -1
					mov cx, 10
					l33:
						add mario_y_axis, 7
						updateMario mario_x_axis, mario_y_axis
						call drawMario
						sub mario_y_axis, 7
						call removeMario
						add mario_y_axis, 7
						updateMario mario_x_axis, mario_y_axis
						call drawMario
				
						.if level >= 2
							call enemyCollisionTest
						.endif
					loop l33
				.endif
		
				.if level == 2
					call enemyMovement
				.elseif level == 3
					call enemyMovement
			
					
				.endif
				call print

				 moveLeft::
					sub mario_x_axis, 5
					updateMario mario_x_axis,mario_y_axis
					call drawMario
					add mario_x_axis, 5
					call removeMario
					call cR
					sub mario_x_axis, 5
					updateMario mario_x_axis,mario_y_axis
					call drawMario

				 dontMoveLeft:
					jmp back
 
		CHECKING_UP_KEY:
				cmp ah,48h
				jne CHECKING_ESC_KEY

				mov ax, mario_down

				.if ax <= hurdle1_up
					jmp dontJumpUp
				.endif

				mov cx, 20
				while1:
					

					.if level == 2
						call enemyMovement
				
					.elseif level == 3
						call enemyMovement
							call monsterMovement
	
				
					.endif

					sub mario_y_axis, 5
					updateMario mario_x_axis, mario_y_axis
					call drawMario
					add mario_y_axis, 5
					call removeMario
					call cR
					sub mario_y_axis, 5
					updateMario mario_x_axis, mario_y_axis
					call drawMario

					call print
					call hurdleJumps
				loop while1

				mov cx, 20
				while2:
					

					.if level == 2
						call enemyMovement
						call enemyCollisionTest
					.elseif level == 3
						call enemyMovement
							call monsterMovement
						call enemyCollisionTest
		
					.endif

					add mario_y_axis, 5
					updateMario mario_x_axis, mario_y_axis
					call drawMario
					sub mario_y_axis, 5
					call removeMario
					call cR
					add mario_y_axis, 5
					updateMario mario_x_axis, mario_y_axis
					call drawMario
					
					call print
					call hurdleJumps
				loop while2
		
				 dontJumpUp:
					jmp back
  
		 CHECKING_ESC_KEY:
				 cmp ah,01h
				 jne back
		
				_exit:
					mov ah, 0h	;graphical mode exit
					int 16h
		
					.exit

	LevelCompleted::
		mov ah, 06h		; changing background color
		mov al, 0
		mov cx, 0
		mov dh, 80
		mov dl, 80
		mov bh, 0
		int 10h

		.if level == 1
			add scores, 1000
			inc lives
		.elseif level == 2
			add scores, 2000
		.elseif level == 3
			add scores, 3000
		.endif
		mov ax, scores
		mov counter, 0					; counter = no of total digits in a number
		__while:
			mov dx, 0					; pushing mod of ax
			mov cx, 10
			div cx
			push dx
			inc counter
			cmp ax, 0					; if (ax == 0) break
			JLE _next1
		JMP __while

		_next1:
			mov si, 0
			mov cx, counter				; cx = no of digits
			_loop:
				pop ax					; because we need no. as it was
				add ax, 48				; ascii...
				mov buffer[si], al
				inc si
				mov buffer[si], 0001b	; color of string
				inc si
			loop _loop

			;scores_str
			mov ax,SEG scoresStr		; set ES segment
			mov es,ax
			mov ah,13h					; write string
			mov al,2					; write mode
			mov bh,0					; video page
			mov cx,(SIZEOF scoresStr)/2
			mov dh,14				; start row
			mov dl,34				; start column
			mov bp,OFFSET scoresStr		; string offset
			int 10h

			;scores
			mov ax,SEG buffer			; set ES segment
			mov es,ax
			mov ah,13h					; write string
			mov al,2					; write mode
			mov bh,0					; video page
			mov cx,counter
			mov dh,14				; start row
			mov dl,42 				; start column
			mov bp,OFFSET buffer		; string offset
			int 10h
		call Delay


		.if level == 3
			mov ah, 06h		; changing background color
			mov al, 0
			mov cx, 0
			mov dh, 80
			mov dl, 80
			mov bh, 0
			int 10h
              call drawYouWin


		mov ax, scores
		mov counter, 0					; counter = no of total digits in a number
		_while:
			mov dx, 0					; pushing mod of ax
			mov cx, 10
			div cx
			push dx
			inc counter
			cmp ax, 0					; if (ax == 0) break
			JLE next1
		JMP _while

		next1:
			mov si, 0
			mov cx, counter				; cx = no of digits
			loop1:
				pop ax					; because we need no. as it was
				add ax, 48				; ascii...
				mov buffer[si], al
				inc si
				mov buffer[si], 0001b	; color of string
				inc si
			loop loop1

			;scores_str
			mov ax,SEG scoresStr		; set ES segment
			mov es,ax
			mov ah,13h					; write string
			mov al,2					; write mode
			mov bh,0					; video page
			mov cx,(SIZEOF scoresStr)/2
			mov dh,14				; start row
			mov dl,34				; start column
			mov bp,OFFSET scoresStr		; string offset
			int 10h

			;scores
			mov ax,SEG buffer			; set ES segment
			mov es,ax
			mov ah,13h					; write string
			mov al,2					; write mode
			mov bh,0					; video page
			mov cx,counter
			mov dh,14				; start row
			mov dl,42 				; start column
			mov bp,OFFSET buffer		; string offset
			int 10h
			call Delay
			jmp _exit
		.else
			inc level
			jmp NEXT_LEVEL
		.endif

main endp
;////////////////////////////////////////////////PROCEDURES FOR CREATION,MOVEMENT,COLLISION////////////////////////////////////
;.......................................................................................................................................
cR proc USES ax bx cx dx
	mov bx, mario_right
	.if level == 3 && bx >= castle_x_axis 
		call drawCastle
	.endif

	ret
cR endp
;.......................................................................................................................................
hurdleJumps proc USES ax bx cx dx

	mov ax, mario_down

	.if jump == 1 && ax <= hurdle1_up
		jmp moveRight
	.elseif jump == 2 && ax <= hurdle2_up
		jmp moveRight
	.elseif jump == 3 && ax <= hurdle3_up
		jmp moveRight
	.endif

	.if jump == 11 && ax <= hurdle1_up
		jmp moveLeft
	.elseif jump == 22 && ax <= hurdle2_up
		jmp moveLeft
	.elseif jump == 33 && ax <= hurdle3_up
		jmp moveLeft
	.endif

	_exit:
		ret
hurdleJumps endp
;.................................................................................................................................
enemyCollisionTest proc USES ax bx cx dx

	mov cx, mario_down

	.if cx == 333
		jmp SIDE_COLLISIONS
	.endif 

	UPSIDE_COLLISION:
	.if	cx >= enemy_up && cx < 330
		mov ax, mario_right
		sub ax, 2
		mov bx, mario_left

		.if enemy1Collision == 0
			.if ax > enemy1_left && ax < enemy1_right || bx > enemy1_left && bx < enemy1_right
				mov enemy1Collision, 1

				.if enemyCheck1 == 1
					call removeEnemy
					inc enemy1_x_axis
					updateEnemy enemy1_x_axis, enemy1_y_axis
					updateEnemy1
					call removeEnemy
					sub enemy1_x_axis, 2
					updateEnemy enemy1_x_axis, enemy1_y_axis
					updateEnemy1
					call removeEnemy

				.else
					call removeEnemy
					dec enemy1_x_axis
					updateEnemy enemy1_x_axis, enemy1_y_axis
					updateEnemy1
					call removeEnemy
					add enemy1_x_axis, 2
					updateEnemy enemy1_x_axis, enemy1_y_axis
					updateEnemy1
					call removemyeEnemy
				.endif

				mov enemy1_left, 0
				mov enemy1_right, 0
				mov enemy1_up, 0

				add scores, 100
				jmp _exit
			.endif
		.endif

		.if enemy2Collision == 0
			mov ax, mario_right
			sub ax, 2
			mov bx, mario_left

			.if ax > enemy2_left && ax < enemy2_right || bx > enemy2_left && bx < enemy2_right
				mov enemy2Collision, 1

				.if enemyCheck2 == 1
					call removeEnemy
					inc enemy2_x_axis
					updateEnemy enemy2_x_axis, enemy2_y_axis
					updateEnemy2
					call removeEnemy
					sub enemy2_x_axis, 2
					updateEnemy enemy2_x_axis, enemy2_y_axis
					updateEnemy2
					call removeEnemy

				.else
					call removeEnemy
					dec enemy2_x_axis
					updateEnemy enemy2_x_axis, enemy2_y_axis
					updateEnemy2
					call removeEnemy
					add enemy2_x_axis, 2
					updateEnemy enemy2_x_axis, enemy2_y_axis
					updateEnemy2
					call removeEnemy
				.endif

				mov enemy2_left, 0
				mov enemy2_right, 0
				mov enemy2_up, 0

				add scores, 100
				jmp _exit
			.endif
		.endif

	.endif

	SIDE_COLLISIONS:

	mov ax, mario_right
	sub ax, 2
	mov bx, mario_left
	mov cx, mario_down

	.if cx == 333
		
		mov si, enemy1_right
		add si, 18
		.if enemy1Collision == 0
			.if ax >= enemy1_left && ax < enemy1_right || bx >= enemy1_left && ax >= si
				call removeMario

				dec lives

				.if lives == 0
					call print
				.endif
				
				updateMario resetMario_x_axis, resetMario_y_axis		; resetting mario....enemy1 collision
				call drawMario
				
			.endif
		.endif

		mov si, enemy2_right
		add si, 18
		.if enemy2Collision == 0
			.if ax >= enemy2_left && ax < enemy2_right || bx >= enemy2_left && ax >= si
				call removeMario

				dec lives

				.if lives == 0
					call print
				.endif

				updateMario resetMario_x_axis, resetMario_y_axis		; resetting mario....enemy2 collision
				call drawMario
			.endif
		.endif
	.endif
	
	_exit:
		ret
enemyCollisionTest endp
;.......................................................................................................................................
enemyMovement proc USES ax bx cx dx
	; ENEMY-1 MOVEMENT
	.if enemy1Collision == 0
		.if enemyCheck1 == 0
			mov bx, enemy1_x_axis
			mov enemy_x_axis, bx
			call removeEnemy
			add enemy1_x_axis, 2
			updateEnemy enemy1_x_axis, enemy1_y_axis
			updateEnemy1
			call drawEnemy

			.if enemy1_x_axis == 279
				mov enemyCheck1, 1
			.endif

		.elseif enemyCheck1 == 1
			mov bx, enemy1_x_axis
			mov enemy_x_axis, bx
			call removeEnemy
			sub enemy1_x_axis, 2
			updateEnemy enemy1_x_axis, enemy1_y_axis
			updateEnemy1
			call drawEnemy

			.if enemy1_x_axis == 175
				mov enemyCheck1, 0
			.endif
		.endif

	.else
		mov enemy1_x_axis, 0
		.if enemyCheck1 == 0
			mov bx, enemy1_x_axis
			mov enemy_x_axis, bx
			call removeEnemy
			add enemy1_x_axis, 2
			updateEnemy enemy1_x_axis, enemy1_y_axis
			updateEnemy1

			.if enemy1_x_axis == 0
				mov enemyCheck1, 1
			.endif

		.elseif enemyCheck1 == 1
			mov bx, enemy1_x_axis
			mov enemy_x_axis, bx
			call removeEnemy
			sub enemy1_x_axis, 2
			updateEnemy enemy1_x_axis, enemy1_y_axis
			updateEnemy1

			.if enemy1_x_axis == 0
				mov enemyCheck1, 0
			.endif
		.endif
	.endif

	; ENEMY-2 MOVEMENT
	.if enemy2Collision == 0
		.if enemyCheck2 == 0
			mov bx, enemy2_x_axis
			mov enemy_x_axis, bx
			call removeEnemy
			sub enemy2_x_axis, 2
			updateEnemy enemy2_x_axis, enemy2_y_axis
			updateEnemy2
			call drawEnemy

			.if enemy2_x_axis == 345
				mov enemyCheck2, 1
			.endif

		.else
			mov bx, enemy2_x_axis
			mov enemy_x_axis, bx
			call removeEnemy
			add enemy2_x_axis, 2
			updateEnemy enemy2_x_axis, enemy2_y_axis
			updateEnemy2
			call drawEnemy

			.if enemy2_x_axis == 439
				mov enemyCheck2, 0
			.endif
		.endif
	.endif
	
	_exit:
		ret
enemyMovement endp
;.................................................................................................................................
fireCollisionTest proc USES ax bx cx dx
	
	mov ax, mario_right
	sub ax, 2
	mov bx, mario_left
	mov cx, mario_up

	.if ax >= fire_left && ax <= fire_right || bx <= fire_right && bx >= fire_left || ax >= fire_right && bx <= fire_left
		.if cx <= fire_down
			mov fireCheck, 1
			
			call removeFire
			
			.if monsterCheck == 0
				mov bx, monster_x_axis
				add bx, 9
				mov cx, monster_y_axis
				add cx, 27
				updateFire bx,cx

			.else
				mov bx, monster_x_axis
				add bx, 18
				mov cx, monster_y_axis
				add cx, 27
				updateFire bx,cx
			.endif

			call removeMario
			dec lives

			.if lives == 0
				call print
			.endif

			.if jump >= 1 
				mov jump, -1
			.endif

			updateMario resetMario_x_axis, resetMario_y_axis		; resetting mario...
			call drawMario
		.endif
	.endif

	mov ax, fire_right
	mov bx, fire_left
	mov cx, fire_down
	mov dx, fire_up
_exit:
		ret
fireCollisionTest endp
;.......................................................................................................................................
monsterMovement proc USES ax bx cx dx
	.if monsterCheck == 0
		sub monster_x_axis, 4
		updateMonster monster_x_axis, monster_y_axis
		call drawMonster
		add monster_x_axis, 4
		call removeMonster
		sub monster_x_axis, 4
		updateMonster monster_x_axis, monster_y_axis
		call drawMonster
		
		mov ax, monster_right
		sub ax, 16
		mov bx, monster_left
		add bx, 16

		.if fire_y_axis == 0
			mov bx, monster_x_axis
			add bx, 9
			mov cx, monster_y_axis
			add cx, 27
			
			updateFire bx,cx
		.endif

		.if monster_x_axis <= 10
			mov monsterCheck, 1
		.endif

	.else
		add monster_x_axis, 4
		updateMonster monster_x_axis, monster_y_axis
		call drawMonster
		sub monster_x_axis, 4
		call removeMonster
		add monster_x_axis, 4
		updateMonster monster_x_axis, monster_y_axis
		call drawMonster

		.if fire_y_axis == 0
			mov bx, monster_x_axis
			add bx, 18
			mov cx, monster_y_axis
			add cx, 27
			
			updateFire bx,cx
		.endif

		.if monster_x_axis >= 520
			mov monsterCheck, 0
		.endif
	.endif

	call fireMovement
	call fireCollisionTest

	_exit:
		ret
monsterMovement endp
;................................................................................................................................
fireMovement proc USES ax bx cx dx

	add fire_y_axis, 4
	updatefire fire_x_axis, fire_y_axis
	call drawfire
	sub fire_y_axis, 4
	call removeFire
	add fire_y_axis, 4
	updatefire fire_x_axis, fire_y_axis
	call drawfire
	
	mov ax, fire_right
	mov bx, fire_left
	mov cx, fire_down

	.if ax >= hurdle1_left && ax < hurdle1_right || bx <= hurdle1_right && bx > hurdle1_left
		.if cx >= hurdle1_up
			call removeFire
			mov fire_y_axis, 0
			updateRectangle 120,283,50,20,0001b	
			call drawRectangle
		.endif

	.elseif ax >= hurdle2_left && ax < hurdle2_right || bx <= hurdle2_right && bx > hurdle2_left
		.if cx >= hurdle2_up
			call removeFire
			mov fire_y_axis, 0
			updateRectangle 290,253,50,20,0001b
			call drawRectangle
		.endif

	.elseif ax >= hurdle3_left && ax < hurdle3_right || bx <= hurdle3_right && bx > hurdle3_left
		.if cx >= hurdle3_up
			call removeFire
			mov fire_y_axis, 0
			updateRectangle 450,263,50,20,0001b
			call drawRectangle
		.endif

	.else
		.if fire_up >= 300
			call removeFire
			mov fire_y_axis, 0
		.endif
	.endif

	_exit:
		ret
fireMovement endp
;..............................................................................................................................
newline proc
mov dl,10
mov ah,2h
int 21h
mov dl,13
mov ah,2h
int 21h
newline endp
;............................................................................................................................
drawRectangle proc USES ax bx cx dx
	mov a, 0
	mov cx, rectX
	mov dx, rectY
	_rectXLoop:
		mov b, 0
		push cx
		mov cx, rectX

		_rectYLoop:
				mov ah, 0ch
				mov al, rectColor
				int 10h
			_rectYUpdate:
				inc cx
				inc b
				mov bx, b
				cmp bx, rectLength
				JE _rectXUpdate
				JMP _rectYLoop
		_rectXUpdate:
			pop cx
			inc dx
			inc a
			mov bx, a
			cmp bx, rectWidth
			JE _exit
			JMP _rectXLoop

	_exit:
		ret
drawRectangle endp
;.......................................................................................................................................
removeRectangle proc USES ax bx cx dx
	mov a, 0
	mov cx, rectX
	mov dx, rectY
	_rectXLoop:
		mov b, 0
		push cx
		mov cx, rectX

		_rectYLoop:
				mov ah, 0ch
				mov al, Background_Colour
				int 10h
			_rectYUpdate:
				inc cx
				inc b
				mov bx, b
				cmp bx, rectLength
				JE _rectXUpdate
				JMP _rectYLoop
		_rectXUpdate:
			pop cx
			inc dx
			inc a
			mov bx, a
			cmp bx, rectWidth
			JE _exit
			JMP _rectXLoop

	_exit:
		ret
removeRectangle endp
;..........................................................................................................................
drawYouWin proc USES ax bx cx dx
	mov d, 20
		mov e, 24
		
		mov ax,SEG YOU	; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF YOU)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET YOU		; string offset
		int 10h

		add e, 7

	ret
drawYouWin endp
;................................................................................................................................
drawMario proc USES ax bx cx dx
	mov si, mario_x_axis
	mov di, mario_y_axis

	mov mario_up, di

	mov ax, mario_x_axis
	add ax, 20
	mov mario_right, ax

	mov ax, mario_y_axis
	add ax, 32
	mov mario_down, ax

	mov ax, mario_x_axis
	sub ax, 6
	mov mario_left, ax

	updateRectangle si, di, 12, 2, 0100b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 20, 2, 0100b
	call drawRectangle
	add di, 2
	updateRectangle si, di, 6, 2, 0110b
	call drawRectangle
	add si, 6
	updateRectangle si, di, 6, 8, 1111b
	call drawRectangle
	add si, 6
	updateRectangle si, di, 2, 4, 0000b
	call drawRectangle
	add si, 2
	updateRectangle si, di, 2, 4, 1111b
	call drawRectangle
	sub si, 16
	add di, 2
	updateRectangle si, di, 2, 6, 0110b
	call drawRectangle
	add si, 2
	updateRectangle si, di, 2, 4, 1111b
	call drawRectangle
	add si, 2
	updateRectangle si, di, 2, 4, 0110b
	call drawRectangle
	add si, 2
	updateRectangle si, di, 8, 2, 1111b
	call drawRectangle
	add si, 12
	updateRectangle si, di, 4, 2, 1111b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 2, 2, 0000b
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, 1111b
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 2, 2, 0110b
	call drawRectangle
	add si, 12
	updateRectangle si, di, 6, 2, 1111b
	call drawRectangle
	sub si, 4
	add di, 2
	updateRectangle si, di, 8, 2, 0000b
	call drawRectangle
	sub si, 10
	updateRectangle si, di, 8, 2, 1111b
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, 0110b
	call drawRectangle
	add si, 2
	add di, 2
	updateRectangle si, di, 16, 2, 1111b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 4, 2, 0100b
	call drawRectangle
	add si, 4
	updateRectangle si, di, 2, 6, 0001b
	call drawRectangle
	add si, 2
	updateRectangle si, di, 4, 4, 0100b
	call drawRectangle
	updateRectangle si, di, 8, 2, 0100b
	call drawRectangle
	add si, 4
	add di, 2
	updateRectangle si, di, 2, 2, 0001b
	call drawRectangle
	add si, 2
	updateRectangle si, di, 6, 2, 0100b
	call drawRectangle
	sub si, 14
	updateRectangle si, di, 6, 2, 0100b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 8, 2, 0100b
	call drawRectangle
	add si, 8
	updateRectangle si, di, 8, 2, 0001b
	call drawRectangle
	add si, 8
	updateRectangle si, di, 8, 2, 0100b
	call drawRectangle
	add di, 2
	updateRectangle si, di, 2, 2, 0001b
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, 1110b
	call drawRectangle
	sub si, 4
	updateRectangle si, di, 4, 2, 0001b
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, 1110b
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, 0001b
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, 0100b
	call drawRectangle
	add di, 2
	updateRectangle si, di, 2, 2, 1111b
	call drawRectangle
	sub di, 2
	sub si, 4
	updateRectangle si, di, 4, 6, 1111b
	call drawRectangle
	add si, 18
	updateRectangle si, di, 2, 2, 0100b
	call drawRectangle
	add di, 2
	updateRectangle si, di, 2, 2, 1111b
	call drawRectangle
	sub di, 2
	add si, 2
	updateRectangle si, di, 4, 6, 1111b
	call drawRectangle
	add di, 2
	sub si, 14
	updateRectangle si, di, 12, 2, 0001b
	call drawRectangle
	add di, 2
	sub si, 2
	updateRectangle si, di, 16, 2, 0001b
	call drawRectangle
	add di, 2
	updateRectangle si, di, 6, 2, 0001b
	call drawRectangle
	add si, 10
	updateRectangle si, di, 6, 2, 0001b
	call drawRectangle
	add di, 2
	sub si, 12
	updateRectangle si, di, 6, 2, 0110b
	call drawRectangle
	add si, 14
	updateRectangle si, di, 6, 2, 0110b
	call drawRectangle
	add di, 2
	updateRectangle si, di, 8, 2, 0110b
	call drawRectangle
	sub si, 16
	updateRectangle si, di, 8, 2, 0110b
	call drawRectangle

	_exit:
		ret
drawMario endp


;.......................................................................................................................................
removeMario proc USES ax bx cx dx
	mov si, mario_x_axis
	mov di, mario_y_axis

	updateRectangle si, di, 12, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 20, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add si, 6
	updateRectangle si, di, 6, 8, Background_Colour
	call drawRectangle
	add si, 6
	updateRectangle si, di, 2, 4, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 2, 4, Background_Colour
	call drawRectangle
	sub si, 16
	add di, 2
	updateRectangle si, di, 2, 6, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 2, 4, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 2, 4, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 12
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	add si, 12
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	sub si, 4
	add di, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 10
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	add si, 2
	add di, 2
	updateRectangle si, di, 16, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	add si, 4
	updateRectangle si, di, 2, 6, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 4, 4, Background_Colour
	call drawRectangle
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 4
	add di, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	sub si, 14
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 8
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 8
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 4
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub di, 2
	sub si, 4
	updateRectangle si, di, 4, 6, Background_Colour
	call drawRectangle
	add si, 18
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub di, 2
	add si, 2
	updateRectangle si, di, 4, 6, Background_Colour
	call drawRectangle
	add di, 2
	sub si, 14
	updateRectangle si, di, 12, 2, Background_Colour
	call drawRectangle
	add di, 2
	sub si, 2
	updateRectangle si, di, 16, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add si, 10
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add di, 2
	sub si, 12
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add si, 14
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 16
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle

	_exit:
		ret
removeMario endp
;.......................................................................................................................................
drawEnemy proc USES ax bx cx dx
	mov si, enemy_x_axis
	mov di, enemy_y_axis
	
	mov ax, enemy_x_axis
	add ax, 20
	mov enemy_right, ax

	mov ax, enemy_x_axis
	sub ax, 12
	mov enemy_left, ax

	mov ax, enemy_y_axis
	mov enemy_up, ax

	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si,di,12,2, 0110b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si,di,16,2, 0110b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si,di,20,2, 0110b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si,di,2,2, 0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,4,2, 0000b
	call drawRectangle
	add si, 4
	updateRectangle si,di,12,2, 0110b
	call drawRectangle
	add si, 12
	updateRectangle si,di,4,2, 0000b
	call drawRectangle
	add si, 4
	updateRectangle si,di,2,2, 0110b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si,di,6,2, 0110b
	call drawRectangle
	sub si, 2
	updateRectangle si,di,2,8, 1111b
	call drawRectangle
	sub si, 2
	updateRectangle si,di,2,6, 0000b
	call drawRectangle
	sub si, 8
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	sub si, 2
	updateRectangle si,di,2,6, 0000b
	call drawRectangle
	sub si, 2
	updateRectangle si,di,2,8, 1111b
	call drawRectangle
	sub si, 6
	updateRectangle si,di,6,2, 0110b
	call drawRectangle
	add di, 2
	updateRectangle si,di,6,2, 0110b
	call drawRectangle
	add si, 10
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	add si, 12
	updateRectangle si,di,6,2, 0110b
	call drawRectangle
	add di, 2
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	sub si, 6
	updateRectangle si,di,2,2, 1111b
	call drawRectangle
	sub si, 4
	updateRectangle si,di,4,2, 0110b
	call drawRectangle
	sub si, 2
	updateRectangle si,di,2,2, 1111b
	call drawRectangle
	sub si, 12
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	add di, 2
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	add si, 8
	updateRectangle si,di,6,2, 1111b
	call drawRectangle
	add si, 6
	updateRectangle si,di,4,2, 0110b
	call drawRectangle
	add si, 4
	updateRectangle si,di,6,2, 1111b
	call drawRectangle
	add si, 6
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	add di, 2
	sub si, 24
	updateRectangle si,di,32,2, 0110b
	call drawRectangle
	add si, 2
	add di, 2
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	add si, 8
	updateRectangle si,di,12,2, 1111b
	call drawRectangle
	add si, 12
	updateRectangle si,di,8,2, 0110b
	call drawRectangle
	sub si, 14
	updateRectangle si,di,16,2, 1111b
	call drawRectangle
	add di, 2
	updateRectangle si,di,16,2, 1111b
	call drawRectangle
	sub si, 4
	updateRectangle si,di,4,6, 0000b
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si,di,2,4, 0000b
	call drawRectangle
	sub di, 2
	add si, 2
	add si, 20
	updateRectangle si,di,4,6, 0000b
	call drawRectangle
	add di, 2
	add si, 2
	updateRectangle si,di,4,4, 0000b
	call drawRectangle
	sub si, 6
	updateRectangle si,di,4,4, 0000b
	call drawRectangle
	sub si, 8
	updateRectangle si,di,8,4, 1111b
	call drawRectangle
	sub si, 4
	updateRectangle si,di,4,4, 0000b
	call drawRectangle
	sub si, 4
	add di, 4
	updateRectangle si,di,10,2, 0000b
	call drawRectangle
	add si, 14
	updateRectangle si,di,10,2, 0000b
	call drawRectangle


	_exit:
		ret
drawEnemy endp
;.......................................................................................................................................
removeEnemy proc USES ax bx cx dx
	mov si, enemy_x_axis
	mov di, enemy_y_axis

	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 12, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 16, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 20, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	add si, 2
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	add si, 4
	updateRectangle si, di, 12, 2, Background_Colour
	call drawRectangle
	add si, 12
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	add si, 4
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 8, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 6, Background_Colour
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 6, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 8, Background_Colour
	call drawRectangle
	sub si, 6
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add si, 10
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 12
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 6
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 4
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	sub si, 2
	updateRectangle si, di, 2, 2, Background_Colour
	call drawRectangle
	sub si, 12
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 8
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add si, 6
	updateRectangle si, di, 4, 2, Background_Colour
	call drawRectangle
	add si, 4
	updateRectangle si, di, 6, 2, Background_Colour
	call drawRectangle
	add si, 6
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add di, 2
	sub si, 24
	updateRectangle si, di, 32, 2, Background_Colour
	call drawRectangle
	add si, 2
	add di, 2
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	add si, 8
	updateRectangle si, di, 12, 2, Background_Colour
	call drawRectangle
	add si, 12
	updateRectangle si, di, 8, 2, Background_Colour
	call drawRectangle
	sub si, 14
	updateRectangle si, di, 16, 2, Background_Colour
	call drawRectangle
	add di, 2
	updateRectangle si, di, 16, 2, Background_Colour
	call drawRectangle
	sub si, 4
	updateRectangle si, di, 4, 6, Background_Colour
	call drawRectangle
	sub si, 2
	add di, 2
	updateRectangle si, di, 2, 4, Background_Colour
	call drawRectangle
	sub di, 2
	add si, 2
	add si, 20
	updateRectangle si, di, 4, 6, Background_Colour
	call drawRectangle
	add di, 2
	add si, 2
	updateRectangle si, di, 4, 4, Background_Colour
	call drawRectangle
	sub si, 6
	updateRectangle si, di, 4, 4, Background_Colour
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 8, 4, Background_Colour
	call drawRectangle
	sub si, 4
	updateRectangle si, di, 4, 4, Background_Colour
	call drawRectangle
	sub si, 4
	add di, 4
	updateRectangle si, di, 10, 2, Background_Colour
	call drawRectangle
	add si, 14
	updateRectangle si, di, 10, 2, Background_Colour
	call drawRectangle

	_exit:
		ret
removeEnemy endp
;.......................................................................................................................................

;.......................................................................................................................................
drawFlag proc USES ax bx cx dx
	updateRectangle 620,50,5,300,1010b		; pole
	call drawRectangle
	
	

	; FLAG
	mov si, 565
	mov di, 55
	updateRectangle si,di,52,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,49,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,46,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,43,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,40,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,37,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,34,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,31,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,28,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,25,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,22,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,19,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,16,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,13,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,10,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,7,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,4,2,1110b
	call drawRectangle
	add si, 3
	add di, 2
	updateRectangle si,di,1,2,1110b
	call drawRectangle


	; BASE
	mov si, 610
	mov di, 331
	updateRectangle si,di,23,2,0110b
	call drawRectangle
	add si, 23
	updateRectangle si,di,2,2,0110b
	call drawRectangle

	sub di, 2
	mov si, 610
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,19,2,0110b
	call drawRectangle
	add si, 19
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,2,2,0110b
	call drawRectangle

	sub di, 2
	mov si, 610
	updateRectangle si,di,4,2,0110b
	call drawRectangle
	add si, 4
	updateRectangle si,di,15,2,0110b
	call drawRectangle
	add si, 15
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,4,2,0110b
	call drawRectangle
	
	sub di, 2
	mov si, 610
	updateRectangle si,di,6,2,0110b
	call drawRectangle
	add si, 6
	updateRectangle si,di,11,2,0110b
	call drawRectangle
	add si, 11
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,6,2,0110b
	call drawRectangle

	sub di, 10
	mov si, 610
	updateRectangle si,di,8,10,0110b
	call drawRectangle
	add si, 8
	updateRectangle si,di,10,10,0110b
	call drawRectangle
	add si, 9
	updateRectangle si,di,8,10,0110b
	call drawRectangle

	sub di, 2
	mov si, 610
	updateRectangle si,di,6,2,0110b
	call drawRectangle
	add si, 6
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,10,2,0110b
	call drawRectangle
	add si, 9
	updateRectangle si,di,8,2,0110b
	call drawRectangle

	sub di, 2
	mov si, 610
	updateRectangle si,di,4,2,0110b
	call drawRectangle
	add si, 4
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,14,2,0110b
	call drawRectangle
	add si, 13
	updateRectangle si,di,6,2,0110b
	call drawRectangle

	sub di, 2
	mov si, 610
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,18,2,0110b
	call drawRectangle
	add si, 17
	updateRectangle si,di,4,2,0110b
	call drawRectangle

	sub di, 2
	mov si, 610
	updateRectangle si,di,2,2,0110b
	call drawRectangle
	add si, 2
	updateRectangle si,di,22,2,0110b
	call drawRectangle
	add si, 21
	updateRectangle si,di,2,2,0110b
	call drawRectangle

	_exit:
		ret
drawFlag endp
removeMonster proc USES ax bx cx dx
	;----------------row1
	resetmonster
	add tempmonsterx ,6
	updaterectangle tempmonsterx, tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,28
	updaterectangle tempmonsterx, tempmonstery,6,2,Background_Colour
	call drawrectangle

	;-------------------row2
	resetmonster
	add tempmonsterx,4
	add tempmonstery,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx,20
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle

	add tempmonsterx,2
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle

	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------row 3
	resetmonster
	add tempmonsterx ,2
	add tempmonstery,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,26
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------row 4
	resetmonster
	add tempmonstery,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,32
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;--------------------------------------row5
	resetmonster
	add tempmonstery,8
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,28
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-----------------------------row6
	resetmonster
	add tempmonstery,8
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,18
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;---------------------------row 7
	resetmonster
	add tempmonstery,10
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------------row 8
	resetmonster
	add tempmonstery,12
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,16,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,16
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,16,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,16
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;---------------------row9
	resetmonster
	add tempmonstery ,14
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	;--------------------------row 10
	resetmonster
	add tempmonstery ,16
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;---------------------------------row11
	resetmonster
	add tempmonstery ,18
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,12,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,12,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;---------------------------row 12
	resetmonster
	add tempmonstery ,20
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------row 13
	resetmonster
	add tempmonstery ,22
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,10,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------row 14
	resetmonster
	add tempmonstery ,24
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,10,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,10,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------------row 15
	resetmonster
	add tempmonstery ,26
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle

	;-----------------------------------row 16
	resetmonster
	add tempmonstery ,28
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,8,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------row 17
	resetmonster
	add tempmonstery ,30
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,34,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,34
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-----------------------row 18
	resetmonster
	add tempmonstery ,32
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------------row 19
	resetmonster
	add tempmonstery ,34
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,12,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery ,6,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,12,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;------------------------row 19
	resetmonster
	add tempmonstery ,36
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,12,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,12,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;----------------------row 20
	resetmonster
	add tempmonstery ,38
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery ,4,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,22,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,22
	updaterectangle tempmonsterx,tempmonstery,4,2,Background_Colour
	call drawrectangle
	;------------------------row 21
	resetmonster
	add tempmonstery ,40
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,18,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,18
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;----------------------row 21
	resetmonster
	add tempmonstery ,42
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,18,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,18
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	;-------------------------row 22,23
	resetmonster
	add tempmonstery ,44
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle

	resetmonster
	add tempmonstery ,46
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	;---------------------------------row 24
	resetmonster
	add tempmonstery ,48
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery, 10,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle

	resetmonster
	add tempmonstery ,50
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle

	resetmonster
	add tempmonstery ,52
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery ,2,2,Background_Colour
	call drawrectangle
	add tempmonsterx ,16
	updaterectangle tempmonsterx,tempmonstery,2,2,Background_Colour
	call drawrectangle

	_exit:
		ret
removeMonster endp
;.......................................................................................................................................
drawHurdles proc USES ax bx cx dx
	;updateRectangle X,Y,length,width,color

	;...first hurdle
	updateRectangle 120,283,50,20,0001b		; head...dark blue color
	call drawRectangle
	updateRectangle 130,303,30,40,0001b		; body...dark blue color
	call drawRectangle

	;...second hurdle
	updateRectangle 290,253,50,20,0001b		; head...dark blue color
	call drawRectangle
	updateRectangle 300,273,30,60,0001b		; body...dark blue color
	call drawRectangle

	;...third hurdle
	updateRectangle 450,263,50,20,0001b		; head...dark blue color
	call drawRectangle
	updateRectangle 460,283,30,50,0001b		; body...dark blue color
	call drawRectangle	

	mov hurdle1_left, 120 
	mov hurdle1_right, 170
	mov hurdle1_up, 283

	mov hurdle2_left, 290
	mov hurdle2_right, 340
	mov hurdle2_up, 253

	mov hurdle3_left, 450
	mov hurdle3_right, 500
	mov hurdle3_up, 263

	_exit:
		ret
drawHurdles endp
;.................................................................................................................................
drawFire proc USES ax bx cx dx
	
	

	resetFire
	add tempFire_y_axis,12
	add tempFire_x_axis,9
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,14
	call drawrectangle

	resetFire
	add tempFire_y_axis,15
	add tempFire_x_axis,6
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,6
	call drawrectangle

	resetFire
	add tempFire_y_axis,18
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle

	resetFire
	add  tempFire_y_axis,21
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle

	resetFire
	add tempFire_y_axis,24
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,14
	call drawrectangle
	add tempFire_x_axis,6
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle

	resetFire
	add tempFire_y_axis,27
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,14
	call drawrectangle
	add tempFire_x_axis,6
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle

	resetFire
	add tempFire_y_axis,30
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,14
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,6
	call drawrectangle

	;initializing boundaries of fire...
	resetFire
	mov bx, tempFire_y_axis
	mov fire_up, bx

	mov bx, tempFire_x_axis
	mov fire_left, bx

	mov bx, tempFire_y_axis
	add bx,33
	mov fire_down, bx
	mov bx, tempFire_x_axis
	add bx,18
	mov fire_right, bx

	_exit:
		ret
drawFire endp
;...............................................................................................................................
;..................................................................................................................................
removeFire proc USES ax bx cx dx
	resetFire
	add tempFire_x_axis,9
	add tempFire_y_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	resetFire
	add tempFire_y_axis,6
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	resetFire
	add tempFire_y_axis,9
	add tempFire_x_axis,9
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,9
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle

	resetFire
	add tempFire_y_axis,12
	add tempFire_x_axis,9
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,Background_Colour
	call drawrectangle

	resetFire
	add tempFire_y_axis,15
	add tempFire_x_axis,6
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,Background_Colour
	call drawrectangle

	resetFire
	add tempFire_y_axis,18
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle

	resetFire
	add  tempFire_y_axis,21
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle

	resetFire
	add tempFire_y_axis,24
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,6
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle

	resetFire
	add tempFire_y_axis,27
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,6,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,6
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle

	resetFire
	add tempFire_y_axis,30
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle
	add tempFire_x_axis,3
	updaterectangle tempFire_x_axis,tempFire_y_axis,3,3,Background_Colour
	call drawrectangle

	_exit:
		ret
removeFire endp
;.......................................................................................................................................
print proc USES ax bx cx dx	
	mov ax, scores
	mov counter, 0					; counter = no of total digits in a number
	while1:
		mov dx, 0					; pushing mod of ax
		mov cx, 10
		div cx
		push dx
		inc counter
		cmp ax, 0					; if (ax == 0) break
		JLE next1
	JMP while1

	next1:
		mov si, 0
		mov cx, counter				; cx = no of digits
		loop1:
			pop ax					; because we need no. as it was
			add ax, 48				; ascii...
			mov buffer[si], al
			inc si
			mov buffer[si], 0001b	; color of string
			inc si
		loop loop1

		;scores_str
		mov ax,SEG scoresStr		; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,2					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF scoresStr)/2
		mov dh,scores_y_axis				; start row
		mov dl,scores_x_axis				; start column
		mov bp,OFFSET scoresStr		; string offset
		int 10h

		;scores
		mov ax,SEG buffer			; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,2					; write mode
		mov bh,0					; video page
		mov cx,counter
		mov dh,buffer_y_axis				; start row
		mov dl,buffer_x_axis 				; start column
		mov bp,OFFSET buffer		; string offset
		int 10h

		;lives_str
		mov ax,SEG livesStr			; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,2					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF livesStr)/2
		mov dh,lives_y_axis				; start row
		mov dl,lives_x_axis				; start column
		mov bp,OFFSET livesStr		; string offset
		int 10h

		mov ax, lives
		mov counter, 0					; counter = no of total digits in a number
		while2:
			mov dx, 0					; pushing mod of ax
			mov cx, 10
			div cx
			push dx
			inc counter
			cmp ax, 0					; if (ax == 0) break
			JLE next2
		JMP while2

		next2:
			mov si, 0
			mov cx, counter				; cx = no of digits
			loop2:
				pop ax					; because we need no. as it was
				add ax, 48				; ascii...
				mov buffer[si], al
				inc si
				mov buffer[si], 0001b	; color of string
				inc si
			loop loop2
			
		;lives
		mov ax,SEG buffer			; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,2					; write mode
		mov bh,0					; video page
		mov cx,counter
		mov dh,0					; start row
		mov dl,159 					; start column
		mov bp,OFFSET buffer		; string offset
		int 10h

		.if lives == 0
			mov ah, 06h		; changing background color
			mov al, 0
			mov cx, 0
			mov dh, 80
			mov dl, 80
			mov bh, 0
			int 10h
			
			
			call Delay
			mov d, 10
		mov e, 33

		mov ax,SEG LOST		; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF LOST)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET LOST	; string offset
		int 10h
 
 
        mov d,12
		add e,33

		mov ax,SEG ENDLIVE	; set ES segment
		mov es,ax
		mov ah,13h					; write string
		mov al,02h					; write mode
		mov bh,0					; video page
		mov cx,(SIZEOF ENDLIVE)/2
		mov dh,d				; start row
		mov dl,e				; start column
		mov bp,OFFSET ENDLIVE		; string offset
		int 10h
		call Delay
		call Delay
		call Delay
			.exit
		.endif

	_exit:
		ret
print endp
;.......................................................................................................................................
drawcastle	proc Uses ax bx cx dx
	
	resetCastle
	sub tempCastle_y_axis,1
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,4,14
	call drawrectangle
	resetCastle
	sub tempCastle_y_axis,1
	add tempCastle_x_axis,45
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,4,4
	call drawrectangle
	resetCastle
	sub tempCastle_y_axis,1
	add tempCastle_x_axis,78
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,4,14
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,3
	add tempCastle_x_axis,9
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,6
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,3
	add tempCastle_x_axis,51
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,6
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,3
	add tempCastle_x_axis,84
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,6
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,6
	add tempCastle_x_axis,9
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,6
	add tempCastle_x_axis,51
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,6
	add tempCastle_x_axis,84
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,9
	add tempCastle_x_axis,6
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,3,0
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,9
	add tempCastle_x_axis,48
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,3,0
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,9
	add tempCastle_x_axis,81
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,3,0
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,12
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,15,15,0
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,12
	add tempCastle_x_axis,45
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,15,15,0
	call drawrectangle
	resetCastle
	add tempCastle_y_axis,12
	add tempCastle_x_axis,78
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,15,15,0
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,27
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,90,9,0
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,36
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,0
	call drawrectangle
	add tempCastle_x_axis,3
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,3,3,4
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,39
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,96,15,4
	call drawrectangle

	resetCastle
	add tempCastle_y_axis,54
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,27,42,4
	call drawrectangle

	resetCastle
	add tempCastle_x_axis,27
	add tempCastle_y_axis,54
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,39,12,0
	call drawrectangle
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,42,0
	call drawrectangle
	add tempCastle_x_axis,33
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,9,42,0
	call drawrectangle
	add tempCastle_x_axis,9
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,27,42,4
	call drawrectangle
	add tempCastle_y_axis,12
	sub tempCastle_x_axis,33
	updaterectangle tempCastle_x_axis,tempCastle_y_axis,24,30,7
	call drawrectangle

	_exit:
		ret
drawcastle endp
;................................................................................................................................
drawFloorBlock proc USES ax bx cx dx
	resetBase
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 8, 1, 6
	call drawrectangle

	add tempBaseX, 8
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 4, 1, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 2, 3, 4 *

	resetBase
	add tempBaseY, 1

	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 8, 3, 6
	call drawrectangle

	add tempBaseX, 8
	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 4, 3, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	; ------------*row 5 *

	resetBase
	add tempBaseY, 3

	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 8, 1, 6
	call drawrectangle

	add tempBaseX, 8
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 3, 1, 6
	call drawrectangle

	add tempBaseX, 3
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 6 *

	resetBase
	add tempBaseY, 4

	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 8, 1, 6
	call drawrectangle

	add tempBaseX, 8
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 4, 1, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 7 *

	resetBase
	add tempBaseY, 5

	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 6, 1, 6
	call drawrectangle

	add tempBaseX, 6
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 4, 1, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 8, 9, 10 *

	resetBase
	add tempBaseY, 6

	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 8, 3, 6
	call drawrectangle

	add tempBaseX, 8
	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 4, 3, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 3, 6
	call drawrectangle

	; ------------*row 11 *

	resetBase
	add tempBaseY, 9

	updaterectangle tempBaseX, tempBaseY, 2, 1, 6
	call drawrectangle

	add tempBaseX, 2
	updaterectangle tempBaseX, tempBaseY, 6, 1, 6
	call drawrectangle

	add tempBaseX, 6
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 5, 1, 6
	call drawrectangle

	add tempBaseX, 5
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 12 *

	resetBase
	add tempBaseY, 10

	updaterectangle tempBaseX, tempBaseY, 2, 1, 6
	call drawrectangle

	add tempBaseX, 2
	updaterectangle tempBaseX, tempBaseY, 2, 1, 6
	call drawrectangle

	add tempBaseX, 2
	updaterectangle tempBaseX, tempBaseY, 4, 1, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 5, 1, 6
	call drawrectangle

	add tempBaseX, 5
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 13 *

	resetBase
	add tempBaseY, 11

	updaterectangle tempBaseX, tempBaseY, 1, 1,6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 2, 1, 6
	call drawrectangle

	add tempBaseX, 2
	updaterectangle tempBaseX, tempBaseY, 4, 1, 6
	call drawrectangle

	add tempBaseX, 4
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 6, 1, 6
	call drawrectangle

	add tempBaseX, 6
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 14 *

	resetBase
	add tempBaseY, 12

	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 3, 1, 6
	call drawrectangle

	add tempBaseX, 3
	updaterectangle tempBaseX, tempBaseY, 3, 1, 6
	call drawrectangle

	add tempBaseX, 3
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 6, 1, 6
	call drawrectangle

	add tempBaseX, 6
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	; ------------*row 15 *

	resetBase
	add tempBaseY, 13

	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 6, 1, 6
	call drawrectangle

	add tempBaseX, 3
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 5, 1, 6
	call drawrectangle

	add tempBaseX, 5
	updaterectangle tempBaseX, tempBaseY, 2, 1, 6
	call drawrectangle

	; ------------*row 16 *

	resetBase
	add tempBaseY, 14

	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 6, 1, 6
	call drawrectangle

	add tempBaseX, 6
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle


	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 1, 1, 6
	call drawrectangle

	add tempBaseX, 1
	updaterectangle tempBaseX, tempBaseY, 3, 1, 6
	call drawrectangle

	add tempBaseX, 6
	updaterectangle tempBaseX, tempBaseY, 2, 1, 6
	call drawrectangle

	; ------------*end of rows*
	
	_exit:
		ret
drawFloorBlock endp
;.......................................................................................................................................
drawFloor proc USES ax bx cx dx
	mov cx, 43
	floor1:
		call drawFloorBlock
		add base_x_axis, 15
	loop floor1

	mov base_x_axis, 0
	sub base_y_axis, 12
	mov cx, 43
	floor2:
		call drawFloorBlock
		add base_x_axis, 15
	loop floor2

	add base_y_axis, 12
	mov base_x_axis, 0

	_exit:
		ret
drawFloor endp
;................................................................................................................................
drawMonster proc USES ax bx cx dx
	
	;-row 1
	resetmonster
	add tempmonstery,10
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,14,2,4
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;--row 2
	resetmonster
	add tempmonstery,12
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,16,2,4
	call drawrectangle
	add tempmonsterx ,16
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,16,2,4
	call drawrectangle
	add tempmonsterx ,16
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;row3
	resetmonster
	add tempmonstery ,14
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,14,2,4
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,4
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	;--row 4
	resetmonster
	add tempmonstery ,16
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,4
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,14,2,4
	call drawrectangle
	add tempmonsterx ,14
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;-row5
	resetmonster
	add tempmonstery ,18
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,12,2,4
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,12,2,4
	call drawrectangle
	add tempmonsterx ,12
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;-row 6
	resetmonster
	add tempmonstery ,20
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;--row 7
	resetmonster
	add tempmonstery ,22
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,10,2,4
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;--row 8
	resetmonster
	add tempmonstery ,24
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,10,2,4
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,10,2,4
	call drawrectangle
	add tempmonsterx ,10
	updaterectangle tempmonsterx,tempmonstery,4,2,4
	call drawrectangle
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;-row 9
	resetmonster
	add tempmonstery ,26
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle

	;-row 10
	resetmonster
	add tempmonstery ,28
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,6,2,4
	call drawrectangle
	add tempmonsterx ,6
	updaterectangle tempmonsterx,tempmonstery,8,2,4
	call drawrectangle
	add tempmonsterx ,8
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;-row 11
	resetmonster
	add tempmonstery ,30
	add tempmonsterx ,4
	updaterectangle tempmonsterx,tempmonstery ,2,2,4
	call drawrectangle
	add tempmonsterx ,2
	updaterectangle tempmonsterx,tempmonstery,34,2,4
	call drawrectangle
	add tempmonsterx ,34
	updaterectangle tempmonsterx,tempmonstery,2,2,4
	call drawrectangle
	;initializing bounderies...
	resetMonster
	mov bx, tempMonsterX
	mov monster_left, bx

	mov bx, tempMonsterY
	mov monster_up, bx

	mov bx, tempMonsterX
	add bx, 46
	mov monster_right, bx

	mov bx, tempMonsterY
	add bx, 56
	mov monster_down, bx
     _exit:
     ret
drawMonster endp
;.......................................................................................................................................
drawSuperMario proc USES ax bx cx dx
	mov temp_x_axis, 160
	mov temp_y_axis, 50
	;..................M..........................................................
	mov al, 4H	; color
    mov temp_x_axis, 155
	mov temp_y_axis, 140
    mov si, temp_x_axis; reset x
	mov di, temp_y_axis; reset y
	add si, 4
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	add si, 44
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	add di, 4
	sub si, 4
	updateRectangle si, di, 20, 4, al
	call drawRectangle
	sub si, 32
	updateRectangle si, di, 20, 4, al
	call drawRectangle
	add di, 4
	sub si, 8
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 12
	updateRectangle si, di, 8, 44, al
	call drawRectangle
	add si, 12
	updateRectangle si, di, 4, 16, al
	call drawRectangle
	add si, 16
	updateRectangle si, di, 4, 16, al
	call drawRectangle
	add si, 8
	updateRectangle si, di, 8, 44, al
	call drawRectangle
	add si, 16
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 4
	sub si, 4
	updateRectangle si, di, 4, 36, al
	call drawRectangle
	add di, 8
	sub si, 24
	updateRectangle si, di, 4, 24, al
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 4, 24, al
	call drawRectangle
	sub di, 8
	sub si, 24
	updateRectangle si, di, 4, 36, al
	call drawRectangle
	add di, 16
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	add si, 52
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	sub si, 24
	add di, 12
	updateRectangle si, di, 4, 20, al
	call drawRectangle
	sub si, 32
	add di, 8
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 8
	add di, 4
	updateRectangle si, di, 12, 4, al
	call drawRectangle
	sub si, 8
	add di, 4
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	sub si, 4
	add di, 8
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	add si, 44
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	add si, 4
	sub di, 8
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	add si, 4
	sub di, 4
	updateRectangle si, di, 12, 4, al
	call drawRectangle
	add si, 16
	sub di, 4
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	;........A......................................
	mov al, 4H	; color
    add temp_x_axis, 76
	mov temp_y_axis, 140
    mov si, temp_x_axis; reset x
	mov di, temp_y_axis; reset y
	add si, 16
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	add di, 4
	add si, 8
	updateRectangle si, di, 16, 4, al
	call drawRectangle
	add di, 4
	add si, 4
	updateRectangle si, di, 8, 12, al
	call drawRectangle
	sub si, 16
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 4
	add si, 4
	updateRectangle si, di, 4, 16, al
	call drawRectangle
	add di, 8
	add si, 8
	updateRectangle si, di, 4, 12, al
	call drawRectangle
	add si, 8
	updateRectangle si, di, 8, 12, al
	call drawRectangle
	add di, 12
	add si, 4
	updateRectangle si, di, 8, 12, al
	call drawRectangle
	add di, 12
	add si, 4
	updateRectangle si, di, 8, 12, al
	call drawRectangle
	add di, 8
	add si, 8
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 4
	sub si, 12
	updateRectangle si, di, 20, 4, al
	call drawRectangle
	add di, 8
	sub si, 4
	updateRectangle si, di, 20, 4, al
	call drawRectangle
	sub si, 32
	updateRectangle si, di, 20, 4, al
	call drawRectangle
	sub di, 8
	add si, 4
	updateRectangle si, di, 20, 4, al
	call drawRectangle
	sub di, 4
	add si, 8
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	sub si, 8
	sub di, 4
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 12
	sub di, 4
	updateRectangle si, di, 4, 12, al
	call drawRectangle
	add si, 8
	updateRectangle si, di, 12, 4, al
	call drawRectangle
	add si, 8
	updateRectangle si, di, 4, 12, al
	call drawRectangle
	sub si, 8
	sub di, 8
	updateRectangle si, di, 12, 4, al
	call drawRectangle
	sub di, 20
	updateRectangle si, di, 4, 12, al
	call drawRectangle
	sub si, 4
	add di, 12
	updateRectangle si, di, 4, 16, al
	call drawRectangle
	sub si, 8
	sub di, 4
	updateRectangle si, di, 4, 12, al
	call drawRectangle
	sub si, 4
	add di, 12
	updateRectangle si, di, 4, 12, al
	call drawRectangle
	;...R....................
	mov al, 4H	; color
    add temp_x_axis, 60
	mov si, temp_x_axis; reset x
	mov di, temp_y_axis; reset y
	add si, 4
	updateRectangle si, di, 40, 4, al
	call drawRectangle
	add di, 4
	add si, 8
	updateRectangle si, di, 12, 4, al
	call drawRectangle
	add si, 32
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	add di, 20
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	sub di, 16
	add si, 4
	updateRectangle si, di, 8, 16, al
	call drawRectangle
	sub si, 20
	updateRectangle si, di, 12, 4, al
	call drawRectangle
	sub si, 12
	updateRectangle si, di, 8, 44, al
	call drawRectangle
	sub si, 12
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 4
	add si, 4
	updateRectangle si, di, 4, 36, al
	call drawRectangle
	add si, 32
	updateRectangle si, di, 4, 8, al
	call drawRectangle
	add di, 8
	sub si, 4
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	mov si, temp_x_axis
	add di, 8
	add si, 8
	updateRectangle si, di, 36, 4, al
	call drawRectangle
	add di, 20
	sub si, 4
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 8
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	add di, 8
	sub si, 4
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	sub di, 12
	add si, 12
	updateRectangle si, di, 16, 4, al
	call drawRectangle
	mov si, temp_x_axis
	mov di, temp_y_axis
	add si, 40
	add di, 32
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	add si, 4
	add di, 4
	updateRectangle si, di, 8, 20, al
	call drawRectangle
	sub si, 8
	add di, 4
	updateRectangle si, di, 4, 20, al
	call drawRectangle
	add di, 20
	add si, 4
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 4
	add si, 4
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	sub di, 8
	add si, 4
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	mov si, temp_x_axis
	mov di, temp_y_axis
	add si, 36
	add di, 20
	updateRectangle si, di, 4, 4,0h
	call drawRectangle

	;...I..............................................
	mov al, 4H	; color
    add temp_x_axis, 64
	mov si, temp_x_axis; reset x
	mov di, temp_y_axis; reset y
	add si, 4
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	add di, 4
	add si, 8
	updateRectangle si, di, 16, 4, al
	call drawRectangle
	add di, 4
	add si, 4
	updateRectangle si, di, 8, 44, al
	call drawRectangle
	sub si, 12
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 4
	add di, 4
	updateRectangle si, di, 4, 36, al
	call drawRectangle
	add di, 20
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	sub si, 4
	add di, 16
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 4
	add si, 8
	updateRectangle si, di, 16, 4, al
	call drawRectangle
	add di, 4
	sub si, 8
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	add di, 8
	sub si, 4
	updateRectangle si, di, 28, 4, al
	call drawRectangle
    ;...O..........................................
	mov al, 4H ; color
    add temp_x_axis, 36
	mov si, temp_x_axis; reset x
	mov di, temp_y_axis; reset y
	add si, 24
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	add di, 4
	sub si, 8
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	add si, 36
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	add si, 4
	updateRectangle si, di, 4, 52, al
	call drawRectangle
	add di, 8
	updateRectangle si, di, 8, 36, al
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 4, 40, al
	call drawRectangle
	sub si, 36
	updateRectangle si, di, 8, 36, al
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 4, 40, al
	call drawRectangle
	sub di, 4
	add si, 4
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 8
	updateRectangle si, di, 4, 48, al
	call drawRectangle
	add si, 8
	updateRectangle si, di, 24, 4, al
	call drawRectangle
	mov si, temp_x_axis
	add di, 20
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 20
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add si, 32
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	add di, 24
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	sub si, 36
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	sub si, 8
	updateRectangle si, di, 4, 8, al
	call drawRectangle
	add di, 8
	add si, 4
	updateRectangle si, di, 8, 4, al
	call drawRectangle
	add si, 8
	add di, 4
	updateRectangle si, di, 32, 4, al
	call drawRectangle
	add si, 4
	sub di, 8
	updateRectangle si, di, 28, 4, al
	call drawRectangle
	add si, 28
	add di, 4
	updateRectangle si, di, 4, 4, al
	call drawRectangle
	ret
drawSuperMario endp
;.......................................................................................................................................
Delay proc USES ax bx cx dx
	mov ax, 00h
	int 1Ah
	mov delay_Time, dx
	add delay_Time, 20		; increase delay by increasing value
    _delay:
		mov ax, 00h
		int 1Ah
		cmp delay_Time, dx
		jge _delay
	_exit:
		ret
Delay endp
;.......................................................................................................................................
END MAIN
