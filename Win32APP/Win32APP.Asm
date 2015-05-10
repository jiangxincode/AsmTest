.486
.model flat,stdcall
option casemap:none
.const
IDD_DLG_MAIN   equ 1000
IDC_EDT_OUTPUT   equ 1003
IDC_EDT_FIRST   equ 1001
IDC_EDT_SECOND   equ 1002
IDC_BTN_OUTPUT   equ 1007
IDC_BTN_EXITAPP   equ 1008
.data
       szExitApp db   "�����Ҫ�˳�������",0
       szTitle   db   "�Ի������",0
       ;�������ַ����ϲ�Ϊһ���ĸ�ʽ���ַ�����
       szFormat   db   "%s%s", 0
       hInstance dd   ?     ;����ʵ�����
      
.code
DlgProc proc uses ebx esi edi hwnd, uMsg, wParam, lParam
      
       ;�����������ֲ����飬���;�Ϊ�ֽ���
       LOCAL @szBuffer1[256]:byte
       LOCAL @szBuffer2[256]:byte
       LOCAL @szOutputBuf[512]:byte
      
       mov       eax, uMsg
       .if    eax == WM_INITDIALOG  
              ;�����д���ڳ�ʼ���Ĵ��룬�����ǽ������ֲ���������
              invoke RtlZeroMemory, addr @szBuffer1, sizeof @szBuffer1
              invoke RtlZeroMemory, addr @szBuffer2, sizeof @szBuffer2
              invoke RtlZeroMemory, addr @szOutputBuf, sizeof @szOutputBuf
      
       .elseif eax == WM_COMMAND
              mov       eax, wParam
              .if   ax == IDC_EDT_FIRST
                     ;�����д������һ���ı���Ĵ���
              .elseif    ax == IDC_EDT_SECOND
                     ;�����д�����ڶ����ı���Ĵ���
              .elseif    ax == IDC_BTN_OUTPUT
                     ;�Ȼ�ȡ�����ı�����ı����ֱ𱣴���@szBuffer1��@szBuffer2��
                     ;Ȼ��ͨ����ʽ������wsprintf�������ı��ϲ������������������ı����С�
                     invoke GetDlgItemText, hwnd, IDC_EDT_FIRST, addr @szBuffer1, sizeof @szBuffer1
                     invoke GetDlgItemText, hwnd, IDC_EDT_SECOND, addr @szBuffer2, sizeof @szBuffer2
                     invoke wsprintf, addr @szOutputBuf, addr szFormat, addr @szBuffer1, addr @szBuffer2
                     invoke SetDlgItemText, hwnd, IDC_EDT_OUTPUT, addr @szOutputBuf
              .elseif    ax == IDC_BTN_EXITAPP
                     invoke SendMessage, hwnd, WM_CLOSE, 0, 0
              .endif
       .elseif    eax == WM_CLOSE
              ;���ﴦ�������˳�����
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
;������ڵ�
start:
       ;��ȡʵ�����
       invoke   GetModuleHandle, NULL
       mov       hInstance, eax
       ;���öԻ���������ʾ�Ի���
       invoke DialogBoxParam, hInstance, IDD_DLG_MAIN, NULL, offset DlgProc, NULL
       invoke ExitProcess, NULL
end start