;;; на любой строке после точки с запятой - комментарии
;;; это служебная информация, чтобы эта программа могла запуститься

section	.text
	global _start
_start:

;;; здесь начинается собственно программа
    mov al, [num1]  ; загрузи (MOVe) в регистр A число из памяти по адресу num1
	mov	bl, [num2]  ; загрузи в регистр B число из памяти по адресу num2
_again:
	cmp al, bl      ; сравни числа (CoMPare)
	jl _done        ; если меньше (Jump if Less) - перейти на метку _done
	sub al, bl      ; уменьши (SUBtract) число в регистре А на число в регистре B (то есть в A будет A-B)
	jmp _again      ; перейди (JuMP) к метке _again
_done:
	mov [num3], al  ; помести (MOVe) результат из регистра A в ячейку по адресу num3

;;; а это всё нужно для того, чтобы вывести результат
;;; это будет работать корректно только если результат меньше 10
	add al, '0'
	mov [num3], al
	mov ecx, num3
	mov edx, 1
	mov	ebx, 1
	mov	eax, 4
	int	0x80       ; это системный вызов, см. дальше про них

;;; и завершаем программу
	mov	eax, 1
	int	0x80       ; и это тоже системный вызов

section	.data
;;; здесь мы задаём имена для ячеек памяти

num1	db	7 ; сюда положим одно число
num2    db  3 ; сюда другое
num3    db  0 ; а здесь будет результат