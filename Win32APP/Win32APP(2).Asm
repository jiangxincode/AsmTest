.386
.model flat,stdcall
.const
IDD_DLG_MAIN   equ 1000
IDC_EDT_OUTPUT   equ 1003
IDC_EDT_FIRST   equ 1001
IDC_EDT_SECOND   equ 1002
IDC_BTN_OUTPUT   equ 1007
IDC_BTN_EXITAPP   equ 1008
.data
       szExitApp db   "你真的要退出程序吗？",0
       szTitle   db   "对话框程序",0
       ;将两个字符串合并为一个的格式化字符串。
       szFormat   db   "%s%s", 0
       hInstance dd   ?     ;程序实例句柄
      
.code
DlgProc proc uses ebx esi edi hwnd, uMsg, wParam, lParam
      
       ;定义了三个局部数组，类型均为字节型
       LOCAL @szBuffer1[256]:byte
       LOCAL @szBuffer2[256]:byte
       LOCAL @szOutputBuf[512]:byte
      
       mov       eax, uMsg
       .if    eax == WM_INITDIALOG  
              ;这里编写窗口初始化的代码，下面是将三个局部数组清零
              invoke RtlZeroMemory, addr @szBuffer1, sizeof @szBuffer1
              invoke RtlZeroMemory, addr @szBuffer2, sizeof @szBuffer2
              invoke RtlZeroMemory, addr @szOutputBuf, sizeof @szOutputBuf
      
       .elseif eax == WM_COMMAND
              mov       eax, wParam
              .if   ax == IDC_EDT_FIRST
                     ;这里编写处理第一个文本框的代码
              .elseif    ax == IDC_EDT_SECOND
                     ;这里编写处理第二个文本框的代码
              .elseif    ax == IDC_BTN_OUTPUT
                     ;先获取两个文本框的文本，分别保存在@szBuffer1和@szBuffer2中
                     ;然后通过格式化函数wsprintf将两个文本合并，最后输出到第三个文本框中。
                     invoke GetDlgItemText, hwnd, IDC_EDT_FIRST, addr @szBuffer1, sizeof @szBuffer1
                     invoke GetDlgItemText, hwnd, IDC_EDT_SECOND, addr @szBuffer2, sizeof @szBuffer2
                     invoke wsprintf, addr @szOutputBuf, addr szFormat, addr @szBuffer1, addr @szBuffer2
                     invoke SetDlgItemText, hwnd, IDC_EDT_OUTPUT, addr @szOutputBuf
              .elseif    ax == IDC_BTN_EXITAPP
                     invoke SendMessage, hwnd, WM_CLOSE, 0, 0
              .endif
       .elseif    eax == WM_CLOSE
              ;这里处理程序退出代码
              invoke MessageBox, hwnd, addr szExitApp, addr szTitle, MB_ICONQUESTION or MB_YESNO
              .if    al == IDYES
                     invoke EndDialog, hwnd, NULL
              .endif
      .else
              mov       eax, FALSE
              ret
       .endif
       mov       eax, TRUE
       ret
DlgProc endp
;程序入口点
start:
       ;获取实例句柄
       invoke   GetModuleHandle, NULL
       mov       hInstance, eax
       ;调用对话框函数来显示对话框。
       invoke DialogBoxParam, hInstance, IDD_DLG_MAIN, NULL, offset DlgProc, NULL
       invoke ExitProcess, NULL
end start
