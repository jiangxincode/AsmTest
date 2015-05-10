;画4行4列的表格
.model     small
.data
.stack    100h
.code
.startup
main    proc    far

    mov    ax,0600h
    mov    bh,0
    mov    cx,0
    mov    dx,184fh
    int    10h
    ;清屏

    mov    ah,0
    mov    al,12h
    int    10h
    ;设置显示模式

    mov    ah,02h
    mov    bh,0
    mov    dh,29
    mov    dl,29
    int    10h
    ;设置光标
    mov    dx,29
    mov    cx,29

huaL:    mov    ah,0ch
    mov    bh,0
    mov    al,2
    int    10h

    inc    dx
    cmp    dx,330
    jbe    huaL
    mov    dx,29
    add    cx,100
    cmp    cx,330
    jb    huaL

    mov    dx,29
    mov    cx,29
huaH:
    mov    ah,0ch
    mov    bh,0
    mov    al,2
    int    10h
    inc    cx
    cmp    cx,330
    jbe    huaH
    mov    cx,29
    add    dx,100
    cmp    dx,330
    jb    huaH

    ;设置光标
    ret
    main    endp
.exit 0
end