.model small
.stack
.data
string db'Hello,Everybody !',0dh,0ah,'$'
.code
.STARTUP
mov dx,offset string
mov ah,9
int 21h
.EXIT 0
end
