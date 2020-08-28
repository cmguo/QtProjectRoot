; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ############################ ��ʼ��������� ####################################
;�����ھ��
Var Dialog


!define FISHDEBUG   "${COMPRESSOR}"

SetCompressor ${COMPRESSOR}

RequestExecutionLevel admin


;############################# ����nsh�ű� ######################################

!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "nsDialogs.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "MUI2.nsh"
!include "WordFunc.nsh"
!include "Library.nsh"


; ########################### ��װ�����ʼ���峣�� ###############################
!define PRODUCT_NAME "������"
!define PRODUCT_PUBLISHER "prod_xkt"
!define PRODUCT_NAME_EN  "prod_xkt"
!define MUI_ICON ".\deploy\logo.png"
!define MUI_UNICON ".\deploy\logo.png"



!define PRODUCT_MAIN_EXE          "interactionclass.exe"
;��ʾ��
!define ERROR_MESSAGE           "��װ������ȷ������������"
;Ԥ����������ռ��С(M)��ע�����Ϊ��ʵ��С���������жϿռ��Ƿ��á�
!define REQUIRED_SPACE  "150"
;���廥������
!define MyMutex_Install     "MyMutex_Install"
!define MyMutex_UnInstall   "MyMutex_UnInstall"

!define Unstall_KeyPath "Software\Microsoft\Windows\CurrentVersion\Uninstall\"

;Languages �����ʹ��MUI���Զ���setupͼ���ʧЧ�ˡ�
!insertmacro MUI_LANGUAGE "SimpChinese"


!ifdef x64
    !define PROGRAM_FILES_DIR  $PROGRAMFILES64
!else
    !define PROGRAM_FILES_DIR  $PROGRAMFILES
!endif


;############################ ��װ�ļ����� ############################
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${BUILD_DIR}\${EXE_NAME}"
InstallDir "${PROGRAM_FILES_DIR}\${PRODUCT_NAME_EN}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
;
ShowInstDetails show
ShowUnInstDetails show
BrandingText " "

;############################ ��װ���� ################################
;�Զ���ҳ��
Page custom MyPage
;��װ���Ƚ���
Page instfiles "" MyInstallNow
;�Զ���ж��ҳ��
UninstPage   custom     un.MyUninstallPage
;ж�ؽ��Ƚ���
UninstPage   instfiles	""	un.MyUninstallNow

;############################ �ؼ�Section����� #######################
/*�����ļ���������ݷ�ʽ*/



Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  
  
  File /r ${PRODUCT_FILES}

	SetShellVarContext all
	;������ʼ�˵�����
 	CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
	;���������ݷ�ʽ
	CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
	
	;��������С����д��ע���
	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
 	IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "EstimatedSize" "$0"
  
    ;ע���д·��
  WriteRegStr HKCU "Software\${PRODUCT_NAME}" "" $INSTDIR

SectionEnd

Section -AdditionalIcons
	;��˾��������
  ;WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  ;��ʼ�˵�-��˾��������
  ;CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  ;��ʼ�˵�-ж�س����ݷ�ʽ
  SetShellVarContext all
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
	;�����˳�����
  WriteUninstaller "$INSTDIR\uninst.exe"
  
  ;ж����Ϣע���
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "UninstallString" '"$INSTDIR\uninst.exe"'
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayIcon" '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "Publisher" "${PRODUCT_PUBLISHER}"
  ;WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "HelpLink" "${PRODUCT_WEB_SITE}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayVersion" "${PRODUCT_VERSION}"
		/*
  	  ж��ע���-��ѡ����
	  InstallLocation (string) - Installation directory ($INSTDIR)
		DisplayIcon (string) - Path, filename and index of of the icon that will be displayed next to your application name
		Publisher (string) - (Company) name of the publisher
		ModifyPath (string) - Path and filename of the application modify program
		InstallSource (string) - Location where the application was installed from
		ProductID (string) - Product ID of the application
		Readme (string) - Path (File or URL) to readme information
		RegOwner (string) - Registered owner of the application
		RegCompany (string) - Registered company of the application
		HelpLink (string) - Link to the support website
		HelpTelephone (string) - Telephone number for support
		URLUpdateInfo (string) - Link to the website for application updates
		URLInfoAbout (string) - Link to the application home page
		DisplayVersion (string) - Displayed version of the application
		VersionMajor (DWORD) - Major version number of the application
		VersionMinor (DWORD) - Minor version number of the application
		NoModify (DWORD) - 1 if uninstaller has no option to modify the installed application
		NoRepair (DWORD) - 1 if the uninstaller has no option to repair the installation
		SystemComponent (DWORD) - Set 1 to prevents display of the application in the Programs List of the Add/Remove Programs in the Control Panel.
		EstimatedSize (DWORD) - The size of the installed files (in KB)
		Comments (string) - A comment describing the installer package
	*/

SectionEnd



;Uninstaller Section

Section "Uninstall"
   SetShellVarContext all
  ;ִ��uninstall.exe
  Delete "$SMSTARTUP\${PRODUCT_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"

  SetShellVarContext all
  RMDir /r /REBOOTOK "$SMPROGRAMS\${PRODUCT_NAME}"

  SetShellVarContext current
  RMDir /r /REBOOTOK "$SMPROGRAMS\${PRODUCT_NAME}"
  
  SetRebootFlag false
  RMDir /r /REBOOTOK "$INSTDIR"
  ;DeleteRegKey ${PRODUCT_ROOT_KEY} "${PRODUCT_SUB_KEY}"

  SetRebootFlag false
  DeleteRegKey HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}"

  Delete "$INSTDIR\Uninstall.exe"
  ;RMDir "$INSTDIR"
  DeleteRegKey /ifempty HKCU "Software\${PRODUCT_NAME}"
  
SectionEnd

;############################ ��װ���̺������� ############################



; Э�����ӵ����������
Function OnLinkAgreementClick
  	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONELINKAGREEMENT"
FunctionEnd

;�Զ��尲װ
Function OnCustomInstallClick
 setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONECUSTOMINSTALL"
FunctionEnd

; ���ٰ�װ��ť�����������
Function OnBtnInstallClick
 ;setupdll::NSISScriptSendMessage $Dialog "WM_SJONEINSTALL"
 	;ֹͣ��Ϣѭ��
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

; ͬ��Э�鸴ѡ������������
Function OnChkAgreementClick
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONECHECKSTATUS"
FunctionEnd
; Э��ҳ��ȷ����ť�����������
Function OnAgreementSureClick
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTWOSURE"
FunctionEnd
;�Զ���ѡ��ҳ�淵����һ��
Function OnPreviousClick
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEPREVIOUS"
FunctionEnd

;���·��
Function OnChangePathClick
		;���ļ��Ի���
		setupdll::NSISOpenFolderDialog /NOUNLOAD "��ѡ��װĿ¼"
		Pop $0
		
		${If} $0 == "-1"
		${Else}
      StrCpy $INSTDIR "$0\${PRODUCT_NAME_EN}"
      ;���ô��̿ռ�
			${GetRoot} $INSTDIR $1
			${DriveSpace} $1 "/D=F /S=M" $2
			setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEFREESPACE" "$2"
			;��������ռ��С
			setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEREQUIREDSPACE" "${REQUIRED_SPACE}"
			;Ĭ�ϰ�װ·��
			setupdll::SetControlProperties /NOUNLOAD "SEdit" "edit_choose_url" "text" $INSTDIR
   ${EndIf}
FunctionEnd


Function OnChange                             
	MessageBox MB_OK|MB_ICONEXCLAMATION  "ָ����װ�ķ���ʣ��ռ䲻�㣬������ѡ������������װ��"

FunctionEnd


;��ʼ��װ
Function OnInstall
		
	strcpy $0 ""
	System::Call 'setupdll::GetTextEditStr() t().r8'
	
	 StrCpy $INSTDIR $8
   ${GetRoot} "$INSTDIR" $R3
     StrCpy $R0 "$R3\"
   ${DriveSpace} "$R3\" "/D=F /S=M" $R0  
   
   #��ȡָ���̷���ʣ����ÿռ䣬/D=Fʣ��ռ䣬 /S=M��λ���ֽ�
   ${If} $R0 == 0  
	MessageBox MB_OK|MB_ICONEXCLAMATION  "��������Ч�İ�װ·����"
	Abort
	${ElseIf} $R0 < 160 
   #110������װ����Ҫռ�õ�ʵ�ʿռ䣬��λ��MB
    MessageBox MB_OK|MB_ICONEXCLAMATION  "ָ����װ�ķ���ʣ��ռ䲻�㣬������ѡ������������װ��"
	Abort
	${Else}
	
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
	Abort
   ${endif}
	
	;StrCpy $INSTDIR $8
   ;${GetRoot} "$INSTDIR" $R8
     ;StrCpy $R0 "$R8\"
   ;${DriveSpace} "$R8\" "/D=F /S=M" $R0                  #��ȡָ���̷���ʣ����ÿռ䣬/D=Fʣ��ռ䣬 /S=M��λ���ֽ�
   ;${If} $R0 < 150                                #110������װ����Ҫռ�õ�ʵ�ʿռ䣬��λ��MB
	;MessageBox MB_OK|MB_ICONEXCLAMATION $INSTDIR
    ;${else}
	;MessageBox MB_OK|MB_ICONEXCLAMATION  $R8
				;ֹͣ��Ϣѭ��
		;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
   ;${endif}

FunctionEnd

;�������������",��ɲ���ʼ���г���(��Ϣѭ���Ѿ�ֹͣ��������������ֱ�Ӳ�������)
Function OnFinishRun
	;�򿪳�������
	;Exec '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
  setupdll::ClosePage /NOUNLOAD
FunctionEnd

Function OnFinishRunEx
  setupdll::ClosePage /NOUNLOAD
FunctionEnd

;�رճ���
Function OnClose
  setupdll::NSISMessageBox /NOUNLOAD 3 "ȷ��Ҫȡ����װ��" "��ʾ��"
  Pop $0
  ${If} $0 == "1"
    ;�رճ���
	  setupdll::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd


Function MyPage

	;�������
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С


	;/////��ʼ������/////
	setupdll::InitWindow /NOUNLOAD "$PLUGINSDIR"
	Pop $Dialog
	
	;/////�󶨿ؼ���ű�������Ӧ��ϵ//////
	
	setupdll::FindChildByName /NOUNLOAD "link_agreement"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnLinkAgreementClick
		setupdll::BindControlAndNSISScript /NOUNLOAD  "link_agreement" $0
	${EndIf}

	setupdll::FindChildByName /NOUNLOAD  "btn_custominstall"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnCustomInstallClick
		setupdll::BindControlAndNSISScript /NOUNLOAD  "btn_custominstall" $0
	${EndIf}

	setupdll::FindChildByName /NOUNLOAD "btn_install"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnBtnInstallClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_install" $0
	${EndIf}


	setupdll::FindChildByName /NOUNLOAD "chk_agreement"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnChkAgreementClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "chk_agreement" $0
	${EndIf}
	
	setupdll::FindChildByName /NOUNLOAD "btn_agreement_sure"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnAgreementSureClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_agreement_sure" $0
	${EndIf}
	
	setupdll::FindChildByName /NOUNLOAD "btn_choose_previous"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnPreviousClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_choose_previous" $0
	${EndIf}

  setupdll::FindChildByName /NOUNLOAD "btn_choose_changedir"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnChangePathClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_choose_changedir" $0
	${EndIf}
	
  setupdll::FindChildByName /NOUNLOAD "edit_choose_url"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnChange
		setupdll::BindControlAndNSISScript /NOUNLOAD "edit_choose_url" $0
	${EndIf}

 setupdll::FindChildByName /NOUNLOAD "btn_choose_install"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnInstall
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_choose_install" $0
	${EndIf}
	
	setupdll::FindChildByName /NOUNLOAD "btn_finish_feel"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnFinishRun
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_finish_feel" $0
	${EndIf}
	
		;setupdll::FindChildByName /NOUNLOAD "btn_finish_finish"
	;Pop $0
	;${If} $0 == "-1"
	;	MessageBox MB_OK ERROR_MESSAGE
	;${Else}
	;	GetFunctionAddress $0 OnFinishRunEx
	;	setupdll::BindControlAndNSISScript /NOUNLOAD "btn_finish_finish" $0
	;${EndIf}
	
	
	setupdll::FindChildByName /NOUNLOAD "btn_close"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close" $0
	${EndIf}
	
	setupdll::FindChildByName /NOUNLOAD "btn_close_agree"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_agree" $0
	${EndIf}
	
		setupdll::FindChildByName /NOUNLOAD "btn_close_choose"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_choose" $0
	${EndIf}
	
			setupdll::FindChildByName /NOUNLOAD "btn_close_unstart"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_unstart" $0
	${EndIf}
	
			setupdll::FindChildByName /NOUNLOAD "btn_close_finish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_finish" $0
	${EndIf}
	
				setupdll::FindChildByName /NOUNLOAD "btn_close_unchoose"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_unchoose" $0
	${EndIf}
	
					setupdll::FindChildByName /NOUNLOAD "btn_close_unfinish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_unfinish" $0
	${EndIf}

	;��ʼ����ť״̬
	setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "0"
	setupdll::SetControlProperties /NOUNLOAD  "SImageButton" "btn_install" "enable" "true"
	setupdll::SetControlProperties /NOUNLOAD  "SImageButton" "btn_custominstall" "enable" "true"
	setupdll::SetControlProperties /NOUNLOAD  "SCheckBox" "chk_agreement" "checked" "false"
	
	;/////��ʼ������/////

	;���ô��̿ռ�
	${GetRoot} $INSTDIR $0
	${DriveSpace} $0 "/D=F /S=M" $2
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEFREESPACE" "$2"
	
	;��������ռ��С
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEREQUIREDSPACE" "${REQUIRED_SPACE}"
	
	;Ĭ�ϰ�װ·��
	setupdll::SetControlProperties /NOUNLOAD "SEdit" "edit_choose_url" "text" $INSTDIR
	
	;/////��ʾ����/////
	setupdll::ShowPage /NOUNLOAD

FunctionEnd

Function MyInstallNow

	
	;�������
  ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С

	;�л���ͼ
	;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTABSETSEL" "3"
	;��ʼ����ͼƬ
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_PLAYIMAGE" "1500"
	setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "3"

   ;�󶨽���
  setupdll::BindingProgress  /NOUNLOAD "pg_installing"
  	
	;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

Function CreateMutex
	;��鰲װ����
	ReCheck:
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R1 ?e'
	Pop $R0
	System::Call 'kernel32::CloseHandle(i R1) i.s'
	;���ж�ػ��⣺
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_UnInstall}") i .R3 ?e'
	Pop $R2
	System::Call 'kernel32::CloseHandle(i R3) i.s'
	;�жϰ�װ/ж�ػ���Ĵ���
	${If} $R0 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "��װ�����Ѿ����У�" IdRetry ReCheck
		Quit
	${ElseIf} $R2 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "ж�س����Ѿ����У�" IdRetry ReCheck
		Quit
	${Else}
		;������װ���⣺
		System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R1 ?e'
		Pop $R0
		StrCmp $R0 0 +2
		Quit
	${EndIf}
FunctionEnd

Function .onInit

	FindProcDLL::FindProc "interactionclass.exe"
    IntCmp $R0 1 0 no_run
    MessageBox MB_ICONSTOP "��װ�����⵽ ${PRODUCT_NAME} �������У���ر�֮���ٰ�װ��"
    Quit
	no_run:
	
	;����UI������Ҫ����Դ
	InitPluginsDir
	File `/ONAME=$PLUGINSDIR\setupdll.dll` `deploy\setupdll.dll`
	File `/ONAME=$PLUGINSDIR\soui-sys-resource.dll` `deploy\soui-sys-resource.dll`
	File `/ONAME=$PLUGINSDIR\ui.dll` `deploy\ui.dll`
  
	;�����򻥳�
	Call CreateMutex

FunctionEnd

;############################################ж��############################################
Function un.OnClose
  setupdll::NSISMessageBox /NOUNLOAD 3 "ȷ��Ҫȡ��ж����" "��ʾ��"
  Pop $0
  ${If} $0 == "1"
    ;�رճ���
	  setupdll::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd
;ж�ص�һҳ������һҳ
Function un.OnBtnNextClick
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJUNSTALLSTARTNEXT"
FunctionEnd

Function un.OnBtnCancellClick
	setupdll::NSISMessageBox /NOUNLOAD 3 "ȷ��Ҫȡ��ж����" "��ʾ��"
  Pop $0
  ${If} $0 == "1"
    ;�رճ���
	  setupdll::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd

Function un.OnUnstallClick
		;ֹͣ��Ϣѭ��
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

Function un.OnFinishClick
  setupdll::ClosePage /NOUNLOAD
  DeleteRegKey /ifempty HKCU "Software\${PRODUCT_NAME}"
FunctionEnd

Function un.MyUninstallPage
  ;�������
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С

	;/////��ʼ������/////
	setupdll::InitWindow /NOUNLOAD "$PLUGINSDIR"
	Pop $Dialog

	;�л���ж�ؽ���
	setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "5"
	;������С����ť
	setupdll::SetControlProperties /NOUNLOAD "SImageButton" "btn_min" "visible" "false"
	;��ʾж�ر���
	setupdll::SetControlProperties /NOUNLOAD "SStatic" "txt_titlename" "text" "Sha Monk MM UnInstall Guide"

	;�󶨹رհ�ť
	setupdll::FindChildByName /NOUNLOAD "btn_close"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close" $0
	${EndIf}
	
		setupdll::FindChildByName /NOUNLOAD "btn_close_agree"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_agree" $0
	${EndIf}
	
			setupdll::FindChildByName /NOUNLOAD "btn_close_choose"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_choose" $0
	${EndIf}
	
				setupdll::FindChildByName /NOUNLOAD "btn_close_finish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_finish" $0
	${EndIf}
	
			setupdll::FindChildByName /NOUNLOAD "btn_close_unstart"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_unstart" $0
	${EndIf}
	
				setupdll::FindChildByName /NOUNLOAD "btn_close_unchoose"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_unchoose" $0
	${EndIf}
	
		setupdll::FindChildByName /NOUNLOAD "btn_close_unfinish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnClose
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_close_unfinish" $0
	${EndIf}
	
	
	;/////��һҳ��/////
	;����һҳ
	setupdll::FindChildByName /NOUNLOAD "btn_unstallstart_next"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnBtnNextClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallstart_next" $0
	${EndIf}
	setupdll::FindChildByName /NOUNLOAD "btn_unstallchoose_previous"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnBtnCancellClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_previous" $0
	${EndIf}
	;/////�ڶ�ҳ��/////
	;ȡ����ť
	setupdll::FindChildByName /NOUNLOAD "btn_unstallchoose_previous2"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnBtnCancellClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_previous2" $0
	${EndIf}
	;ж�ذ�ť
		setupdll::FindChildByName /NOUNLOAD "btn_unstallchoose_unnstall"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnUnstallClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_unnstall" $0
	${EndIf}
	;////���һ��ҳ��/////
	;��ɰ�ť
	setupdll::FindChildByName /NOUNLOAD "btn_unstallfinish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnFinishClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallfinish" $0
	${EndIf}
	
	;��ȡҪж�ص�Ŀ¼
	ReadRegStr $0 HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "InstallLocation"
  ;��ʾж�ص�Ŀ¼
	setupdll::SetControlProperties /NOUNLOAD "SEdit" "edit_unstallchoose_url" "text" "$0"

	;/////��ʾ����/////
	setupdll::ShowPage /NOUNLOAD
FunctionEnd

Function un.MyUninstallNow
	;�������
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;�ı��Զ��崰���С

	;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTABSETSEL" "7"
  setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "7"
  setupdll::BindingProgress  /NOUNLOAD "pg_unstalling"
  
FunctionEnd

Function un.onInit

	;�������Ƿ���������
	FindProcDLL::FindProc "interactionclass.exe"
    Pop $R0
    IntCmp $R0 1 0 no_run
    MessageBox MB_ICONSTOP "ж�س����⵽ ${PRODUCT_NAME} �������У���ر�֮����ж�أ�"
    Quit
    no_run:
  ;����UI������Ҫ����Դ
	InitPluginsDir
	File `/ONAME=$PLUGINSDIR\setupdll.dll` `deploy\setupdll.dll`
	File `/ONAME=$PLUGINSDIR\ui.dll` `deploy\ui.dll`
	File `/ONAME=$PLUGINSDIR\soui-sys-resource.dll` `deploy\soui-sys-resource.dll`

FunctionEnd
