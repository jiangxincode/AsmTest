     .model small
     .stack
     .DATA

      HANDLE    DW ?
      filename1  db 'd:\fff.txt',0
      outrec db '1234567890987654321'
   .code
   .startup
      mov ah,3ch
      mov cx,0
      lea dx,filename1
      int 21h
      jc error
      mov handle,ax
      mov ah,40h
      mov bx,handle
      mov cx,10
      lea dx,outrec
      int 21h
      error:
      .exit 0
   end

