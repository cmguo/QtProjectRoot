; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; ############################ 初始化定义变量 ####################################
;主窗口句柄
Var Dialog


!define FISHDEBUG   "${COMPRESSOR}"

SetCompressor ${COMPRESSOR}

RequestExecutionLevel admin


;############################# 引入nsh脚本 ######################################

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


; ########################### 安装程序初始定义常量 ###############################
!define PRODUCT_NAME "晓课堂"
!define PRODUCT_PUBLISHER "prod_xkt"
!define PRODUCT_NAME_EN  "prod_xkt"
!define MUI_ICON ".\deploy\logo.ico"
!define MUI_UNICON ".\deploy\logo.ico"



!define PRODUCT_MAIN_EXE          "interactionclass.exe"
;提示语
!define ERROR_MESSAGE           "安装包不正确，请重新下载"
;预计软件所需空间大小(M)，注册表中为真实大小，仅用于判断空间是否够用。
!define REQUIRED_SPACE  "150"
;定义互斥名称
!define MyMutex_Install     "MyMutex_Install"
!define MyMutex_UnInstall   "MyMutex_UnInstall"

!define Unstall_KeyPath "Software\Microsoft\Windows\CurrentVersion\Uninstall\"

;Languages 如果不使用MUI，自定义setup图标就失效了。
!insertmacro MUI_LANGUAGE "SimpChinese"


!ifdef x64
    !define PROGRAM_FILES_DIR  $PROGRAMFILES64
!else
    !define PROGRAM_FILES_DIR  $PROGRAMFILES
!endif


;############################ 安装文件定义 ############################
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "${BUILD_DIR}\${EXE_NAME}"
InstallDir "${PROGRAM_FILES_DIR}\${PRODUCT_NAME_EN}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
;
ShowInstDetails show
ShowUnInstDetails show
BrandingText " "

;############################ 安装界面 ################################
;自定义页面
Page custom MyPage
;安装进度界面
Page instfiles "" MyInstallNow
;自定义卸载页面
UninstPage   custom     un.MyUninstallPage
;卸载进度界面
UninstPage   instfiles	""	un.MyUninstallNow

;############################ 关键Section代码段 #######################
/*程序文件、创建快捷方式*/



Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  
  
  File /r ${PRODUCT_FILES}

	SetShellVarContext all
	;创建开始菜单内容
 	CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
	;创建桌面快捷方式
	CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
	
	;计算程序大小，并写入注册表
	${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
 	IntFmt $0 "0x%08X" $0
  WriteRegDWORD HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "EstimatedSize" "$0"
  
    ;注册表写路径
  WriteRegStr HKCU "Software\${PRODUCT_NAME}" "" $INSTDIR
  ; 删除指定缓存目录
  	RMDir /r /REBOOTOK "$LOCALAPPDATA\xktclass\cache"
	RMDir /r /REBOOTOK "$LOCALAPPDATA\xktclass\upgrade"

SectionEnd

Section -AdditionalIcons
	;公司官网链接
  ;WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  ;开始菜单-公司官网链接
  ;CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  ;开始菜单-卸载程序快捷方式
  SetShellVarContext all
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
	;创建退出程序
  WriteUninstaller "$INSTDIR\uninst.exe"
  
  ;卸载信息注册表
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "UninstallString" '"$INSTDIR\uninst.exe"'
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayIcon" '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "Publisher" "${PRODUCT_PUBLISHER}"
  ;WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "HelpLink" "${PRODUCT_WEB_SITE}"
  WriteRegStr HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "DisplayVersion" "${PRODUCT_VERSION}"
		/*
  	  卸载注册表-可选参数
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
  ;执行uninstall.exe
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

;############################ 安装过程函数定义 ############################



; 协议链接点击处理函数
Function OnLinkAgreementClick
  	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONELINKAGREEMENT"
FunctionEnd

;自定义安装
Function OnCustomInstallClick
 setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONECUSTOMINSTALL"
FunctionEnd

; 快速安装按钮点击处理函数
Function OnBtnInstallClick
 ;setupdll::NSISScriptSendMessage $Dialog "WM_SJONEINSTALL"
 	;停止消息循环
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

; 同意协议复选框点击处理函数
Function OnChkAgreementClick
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJONECHECKSTATUS"
FunctionEnd
; 协议页面确定按钮点击处理函数
Function OnAgreementSureClick
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTWOSURE"
FunctionEnd
;自定义选择页面返回上一步
Function OnPreviousClick
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEPREVIOUS"
FunctionEnd

;变更路径
Function OnChangePathClick
		;打开文件对话框
		setupdll::NSISOpenFolderDialog /NOUNLOAD "请选择安装目录"
		Pop $0
		
		${If} $0 == "-1"
		${Else}
      StrCpy $INSTDIR "$0\${PRODUCT_NAME_EN}"
      ;可用磁盘空间
			${GetRoot} $INSTDIR $1
			${DriveSpace} $1 "/D=F /S=M" $2
			setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEFREESPACE" "$2"
			;软件所需空间大小
			setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEREQUIREDSPACE" "${REQUIRED_SPACE}"
			;默认安装路径
			setupdll::SetControlProperties /NOUNLOAD "SEdit" "edit_choose_url" "text" $INSTDIR
   ${EndIf}
FunctionEnd


Function OnChange                             
	MessageBox MB_OK|MB_ICONEXCLAMATION  "指定安装的分区剩余空间不足，请重新选择其它分区安装！"

FunctionEnd


;开始安装
Function OnInstall
		
	strcpy $0 ""
	System::Call 'setupdll::GetTextEditStr() t().r8'
	
	 StrCpy $INSTDIR $8
   ${GetRoot} "$INSTDIR" $R3
     StrCpy $R0 "$R3\"
   ${DriveSpace} "$R3\" "/D=F /S=M" $R0  
   
   #获取指定盘符的剩余可用空间，/D=F剩余空间， /S=M单位兆字节
   ${If} $R0 == 0  
	MessageBox MB_OK|MB_ICONEXCLAMATION  "请输入有效的安装路径！"
	Abort
	${ElseIf} $R0 < 160 
   #110即程序安装后需要占用的实际空间，单位：MB
    MessageBox MB_OK|MB_ICONEXCLAMATION  "指定安装的分区剩余空间不足，请重新选择其它分区安装！"
	Abort
	${Else}
	
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
	Abort
   ${endif}
	
	;StrCpy $INSTDIR $8
   ;${GetRoot} "$INSTDIR" $R8
     ;StrCpy $R0 "$R8\"
   ;${DriveSpace} "$R8\" "/D=F /S=M" $R0                  #获取指定盘符的剩余可用空间，/D=F剩余空间， /S=M单位兆字节
   ;${If} $R0 < 150                                #110即程序安装后需要占用的实际空间，单位：MB
	;MessageBox MB_OK|MB_ICONEXCLAMATION $INSTDIR
    ;${else}
	;MessageBox MB_OK|MB_ICONEXCLAMATION  $R8
				;停止消息循环
		;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
   ;${endif}

FunctionEnd

;点击“立即体验",完成并开始运行程序(消息循环已经停止，不会阻塞，可直接操作界面)
Function OnFinishRun
	;打开程序运行
	;Exec '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
  setupdll::ClosePage /NOUNLOAD
FunctionEnd

Function OnFinishRunEx
  setupdll::ClosePage /NOUNLOAD
FunctionEnd

;关闭程序
Function OnClose
  setupdll::NSISMessageBox /NOUNLOAD 3 "确认要取消安装吗？" "提示："
  Pop $0
  ${If} $0 == "1"
    ;关闭程序
	  setupdll::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd


Function MyPage

	;解决闪屏
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;改变自定义窗体大小


	;/////初始化窗口/////
	setupdll::InitWindow /NOUNLOAD "$PLUGINSDIR"
	Pop $Dialog
	
	;/////绑定控件与脚本函数对应关系//////
	
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

	;初始化按钮状态
	setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "0"
	setupdll::SetControlProperties /NOUNLOAD  "SImageButton" "btn_install" "enable" "true"
	setupdll::SetControlProperties /NOUNLOAD  "SImageButton" "btn_custominstall" "enable" "true"
	setupdll::SetControlProperties /NOUNLOAD  "SCheckBox" "chk_agreement" "checked" "false"
	
	;/////初始化数据/////

	;可用磁盘空间
	${GetRoot} $INSTDIR $0
	${DriveSpace} $0 "/D=F /S=M" $2
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEFREESPACE" "$2"
	
	;软件所需空间大小
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTHREEUPDATEREQUIREDSPACE" "${REQUIRED_SPACE}"
	
	;默认安装路径
	setupdll::SetControlProperties /NOUNLOAD "SEdit" "edit_choose_url" "text" $INSTDIR
	
	;/////显示窗口/////
	setupdll::ShowPage /NOUNLOAD

FunctionEnd

Function MyInstallNow

	
	;解决闪屏
  ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;改变自定义窗体大小

	;切换视图
	;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTABSETSEL" "3"
	;开始播放图片
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_PLAYIMAGE" "1500"
	setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "3"

   ;绑定进度
  setupdll::BindingProgress  /NOUNLOAD "pg_installing"
  	
	;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

Function CreateMutex
	;检查安装互斥
	ReCheck:
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R1 ?e'
	Pop $R0
	System::Call 'kernel32::CloseHandle(i R1) i.s'
	;检查卸载互斥：
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_UnInstall}") i .R3 ?e'
	Pop $R2
	System::Call 'kernel32::CloseHandle(i R3) i.s'
	;判断安装/卸载互斥的存在
	${If} $R0 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "安装程序已经运行！" IdRetry ReCheck
		Quit
	${ElseIf} $R2 != 0
		MessageBox MB_RetryCancel|MB_ICONEXCLAMATION "卸载程序已经运行！" IdRetry ReCheck
		Quit
	${Else}
		;创建安装互斥：
		System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MyMutex_Install}") i .R1 ?e'
		Pop $R0
		StrCmp $R0 0 +2
		Quit
	${EndIf}
FunctionEnd

Function .onInit

	FindProcDLL::FindProc "interactionclass.exe"
    IntCmp $R0 1 0 no_run
    MessageBox MB_ICONSTOP "安装程序检测到 ${PRODUCT_NAME} 正在运行，请关闭之后再安装！"
    Quit
	no_run:
	
	;加载UI界面需要的资源
	InitPluginsDir
	File `/ONAME=$PLUGINSDIR\setupdll.dll` `deploy\setupdll.dll`
	File `/ONAME=$PLUGINSDIR\soui-sys-resource.dll` `deploy\soui-sys-resource.dll`
	File `/ONAME=$PLUGINSDIR\ui.dll` `deploy\ui.dll`
  
	;检查程序互斥
	Call CreateMutex

FunctionEnd

;############################################卸载############################################
Function un.OnClose
  setupdll::NSISMessageBox /NOUNLOAD 3 "确认要取消卸载吗？" "提示："
  Pop $0
  ${If} $0 == "1"
    ;关闭程序
	  setupdll::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd
;卸载第一页进入下一页
Function un.OnBtnNextClick
	setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJUNSTALLSTARTNEXT"
FunctionEnd

Function un.OnBtnCancellClick
	setupdll::NSISMessageBox /NOUNLOAD 3 "确认要取消卸载吗？" "提示："
  Pop $0
  ${If} $0 == "1"
    ;关闭程序
	  setupdll::ClosePage /NOUNLOAD
	${EndIf}
FunctionEnd

Function un.OnUnstallClick
		;停止消息循环
		setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJMSGLOOPSTOP"
FunctionEnd

Function un.OnFinishClick
  setupdll::ClosePage /NOUNLOAD
  DeleteRegKey /ifempty HKCU "Software\${PRODUCT_NAME}"
FunctionEnd

Function un.MyUninstallPage
  ;解决闪屏
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;改变自定义窗体大小

	;/////初始化窗口/////
	setupdll::InitWindow /NOUNLOAD "$PLUGINSDIR"
	Pop $Dialog

	;切换到卸载界面
	setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "5"
	;隐藏最小化按钮
	setupdll::SetControlProperties /NOUNLOAD "SImageButton" "btn_min" "visible" "false"
	;显示卸载标题
	setupdll::SetControlProperties /NOUNLOAD "SStatic" "txt_titlename" "text" "Sha Monk MM UnInstall Guide"

	;绑定关闭按钮
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
	
	
	;/////第一页面/////
	;绑定下一页
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
	;/////第二页面/////
	;取消按钮
	setupdll::FindChildByName /NOUNLOAD "btn_unstallchoose_previous2"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnBtnCancellClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_previous2" $0
	${EndIf}
	;卸载按钮
		setupdll::FindChildByName /NOUNLOAD "btn_unstallchoose_unnstall"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnUnstallClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallchoose_unnstall" $0
	${EndIf}
	;////最后一个页面/////
	;完成按钮
	setupdll::FindChildByName /NOUNLOAD "btn_unstallfinish"
	Pop $0
	${If} $0 == "-1"
		MessageBox MB_OK ERROR_MESSAGE
	${Else}
		GetFunctionAddress $0 un.OnFinishClick
		setupdll::BindControlAndNSISScript /NOUNLOAD "btn_unstallfinish" $0
	${EndIf}
	
	;获取要卸载的目录
	ReadRegStr $0 HKLM "${Unstall_KeyPath}${PRODUCT_NAME_EN}" "InstallLocation"
  ;显示卸载的目录
	setupdll::SetControlProperties /NOUNLOAD "SEdit" "edit_unstallchoose_url" "text" "$0"

	;/////显示窗口/////
	setupdll::ShowPage /NOUNLOAD
FunctionEnd

Function un.MyUninstallNow
	;解决闪屏
 	ShowWindow $HWNDPARENT ${SW_HIDE}
	${NSW_SetWindowSize} $HWNDPARENT 0 0 ;改变自定义窗体大小

	;setupdll::NSISScriptSendMessage /NOUNLOAD $Dialog "WM_SJTABSETSEL" "7"
  setupdll::SetControlProperties /NOUNLOAD "STabCtrl" "tab_main" "curSel" "7"
  setupdll::BindingProgress  /NOUNLOAD "pg_unstalling"
  
FunctionEnd

Function un.onInit

	;检测进程是否正在运行
	FindProcDLL::FindProc "interactionclass.exe"
    Pop $R0
    IntCmp $R0 1 0 no_run
    MessageBox MB_ICONSTOP "卸载程序检测到 ${PRODUCT_NAME} 正在运行，请关闭之后再卸载！"
    Quit
    no_run:
  ;加载UI界面需要的资源
	InitPluginsDir
	File `/ONAME=$PLUGINSDIR\setupdll.dll` `deploy\setupdll.dll`
	File `/ONAME=$PLUGINSDIR\ui.dll` `deploy\ui.dll`
	File `/ONAME=$PLUGINSDIR\soui-sys-resource.dll` `deploy\soui-sys-resource.dll`

FunctionEnd

