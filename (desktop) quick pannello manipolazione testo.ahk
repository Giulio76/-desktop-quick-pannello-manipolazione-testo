#Requires AutoHotkey v2.0
#SingleInstance Force
TraySetIcon "(desktop) quick pannello manipolazione testo - icon.ico"



; Include the Neutron library
#Include include/neutron.ahk

; Create a new NeutronWindow and navigate to our HTML page
neutron := NeutronWindow()
	.OnEvent("close", (neutron) => ExitApp())
	.Load("(desktop) quick pannello manipolazione testo - html.html")
	; Show the Neutron window
	.Show(, "(desktop) quick pannello manipolazione testo") ;windows title

; FileInstall all your dependencies, but put the FileInstall lines somewhere
; they won't ever be reached.
if false {
	FileInstall "(desktop) quick pannello manipolazione testo - html.html", "*"
	FileInstall "include/w3.css", "*"   
    FileInstall "include/w3-colors-2021.css", "*"
    FileInstall "include/w3-colors-2020.css", "*"
    FileInstall "include/w3.js", "*"

}

;HWND
global active_id
	   active_id := WinGetID("A")

;modifiche alle dimenzioni della finestra
; precedente WinMove 1400, 7, 500, 560, "ahk_id " active_id
WinMove (200)/2, A_ScreenHeight-800-50, A_ScreenWidth-200, 800, "ahk_id " active_id
;WinSetStyle "-0xC00000", "ahk_id " active_id
;WinSetRegion "15-0 495-0 510-15 510-615 495-630 15-630 0-615 0-15" , "ahk_id " active_id
;;WinSetAlwaysOnTop 1, "ahk_id " active_id
WinHide "ahk_id " active_id



;toggle show hide
HotIfWinActive "ahk_id " active_id
Hotkey "Escape", fn_hide
HotIfWinActive

fn_hide(HotkeyName)
{
	WinHide "ahk_id " active_id
}



;ricorda che il il tasto assegnato è PAUSE

;msgbox "hotkey = PAUSE toggle show/hide "


;--------------------------------
return
;--------------------------------
;--------------------------------

;--- HOTKEY ---------------------
~#NumPad0::
{
    WinShow "ahk_id " active_id
	sleep 100
	WinActivate "ahk_id " active_id	
	
}






;;##### PULSANTI ################################################

btn_con_i_parametri(neutron, event, strIncA) {
;;con i parametri
}
btn_senza_parametri(neutron, event) {
;;senza parametri
}



btn_pannello_stringhe_11(neutron, event) {
;;clear
;;msgbox 'clear'
    neutron.qs("#elm_textarea").value := ''
}


btn_pannello_stringhe_31(neutron, event) {
;paste
    A_Clipboard := A_Clipboard
    neutron.qs("#elm_textarea").value := A_Clipboard
}


btn_pannello_stringhe_34(neutron, event) {
;copy 2 clipboard
    A_Clipboard := neutron.qs("#elm_textarea").value 
}


;;trova e sostituisci stringhe
btn_pannello_stringhe_21(neutron, event) {
;;senza parametri
    strA := neutron.qs("#elm_textarea").value    
    strE := neutron.qs("#elm_sost_cerca").value    
    strA := strReplace(strA, strE , "")
    neutron.qs("#elm_textarea").value := strA     
}
btn_pannello_stringhe_22(neutron, event) {
;;senza parametri
    strA := neutron.qs("#elm_textarea").value    
    strE := neutron.qs("#elm_sost_cerca").value
    strF := neutron.qs("#elm_sost_con").value    
    strA := strReplace(strA, strE , strF)
    neutron.qs("#elm_textarea").value := strA     
}



btn_sostutisci_indicati(neutron, event, strIncA, strIncB) {
;; strIncA e strIncB sono le stringhe che chiedo di sostituire di soloito singoli caratteri
; ok msgbox strIncA ' ' strIncB

    strE := ""
    strF := ""
    
    if ( strIncA = "tab") 
        strE := "`t"    
    if ( strIncB = "tab") 
        strF := "`t"
    
    if ( strIncA = "accapo") 
        strE := "`n"    
    if ( strIncB = "accapo") 
        strF := "`n"
    
    if ( strIncA = "sterl") 
        strE := "£"    
    if ( strIncB = "sterl") 
        strF := "£"
    
    if ( strIncA = "virgola") 
        strE := ","    
    if ( strIncB = "virgola") 
        strF := ","

    if ( strIncA = "virgolette") 
        strE := '"'    
    if ( strIncB = "virgolette") 
        strF := '"'
    
    if ( strIncA = "space") 
        strE := " "    
    if ( strIncB = "space") 
        strF := " "
            
    if ( strIncA = "par") 
        strE := "§"    
    if ( strIncB = "par") 
        strF := "§"

    if ( strIncA = "esponente") 
        strE := "^"    
    if ( strIncB = "esponente") 
        strF := "^"

    if ( strIncA = "apice") 
        strE := "'"    
    if ( strIncB = "apice") 
        strF := "'"        
        
        
        

    ;;solo in ingresso
    if ( strIncA = "virg_8221") 
        strE := CHR(8221)     

    if ( strIncA = "virg_8220") 
        strE := CHR(8220)     

    if ( strIncA = "apice_8217") 
        strE := CHR(8217)     





    ;;;msgbox strE ' ' strIncB



        

    strA := neutron.qs("#elm_textarea").value
    ;;strA := strReplace(strA, "`t" , "")
    strA := strReplace(strA, strE , strF)
    neutron.qs("#elm_textarea").value := strA
    
}










btn_pannello_top_entita(neutron, event) {
;; ord
    strA := neutron.qs("#elm_entita").value
    msgbox ORD(strA)        
}

btn_pannello_top_entita_html(neutron, event) {
;; ord
    strA := neutron.qs("#elm_entita").value
    A_Clipboard := '&#' ORD(strA) ';'        
}






;; trattamenti -------------------
btn_trattamenti(neutron, event, strIncA) {
;;strIncA è il codice che rapresenta

    strA := neutron.qs("#elm_textarea").value

    ; Controllo della scelta
    if (strIncA = "101") {
        ; excel 2 jsmtx
        ;;adatto il contenuto della tavola che ha le colonne matrice che iniziano cono [ soltanto
        ;; MsgBox Hai scelto la prima opzione!
        ;; strA := strReplace(strA, '`t' , '')
        ;; sostituzioni, da excel a matrice javascript
        ;; ci sono solo tab e [] intorno alla riga 
        ;; tab 2 ^ (btn)
        strA := strReplace(strA, '`t' , '^')
        ;; [^ 2 ["
        strA := strReplace(strA, '[^' , '[""')
        ;; ], 2 "],
        strA := strReplace(strA, '],' , '""],')
        ;; ^ 2 ","
        strA := strReplace(strA, '^' , '"",""')
        
        ;; @ 250502_152521
        strA := strReplace(strA, '"",""];' , '""],')        
        strA := strReplace(strA, '= ["""",""' , '= [""')
        
        ;;trattamento virgolette 
        strA := strReplace(strA, CHR(8221) , '"')        
        strA := strReplace(strA, CHR(8220) , '"')
        strA := strReplace(strA, CHR(8217) , "'")
        
        
        
    } else if (strIncA = "102") {
        ;; trattamento da excel che ha le colonne con [" 
        
        strA := strReplace(strA, '`t' , '"",""')
        ;;strA := strReplace(strA, '`r`n' , '`r`n[""')
        strA := strReplace(strA, '`n' , '""],`n[""')
        strA := '[""' strA   
        
        ;;trattamento virgolette 
        strA := strReplace(strA, CHR(8221) , '"')        
        strA := strReplace(strA, CHR(8220) , '"')
        strA := strReplace(strA, CHR(8217) , "'")
                
        
        
    } else if (strIncA = "103") {
        ;; MsgBox Hai scelto la terza opzione!
        strA := strReplace(strA, '\' , '/')
    } else if (strIncA = "104") {
        ;; MsgBox Hai scelto la terza opzione!
        strA := strReplace(strA, '/' , '\')        
    
    } else if (strIncA = "105") {
        ;; MsgBox Hai scelto la terza opzione!
        strA := strReplace(strA, '><' , '>' CHR(163) '<')


    } else if (strIncA = "106") {
        ;; MsgBox Hai scelto la terza opzione!
        strA := strReplace(strA, '`n' , "' +" "`n" "'")        
        
        strA := "'" strA "'"             
    
    } else if (strIncA = "107") {
        ;; MsgBox Hai scelto la terza opzione!
        strA := strReplace(strA, '`n' , '""`n""')        
        
        strA := '""" strA """'    

    } else if (strIncA = "108") {
        
        strB := ""
        Loop parse, strA, "`n"
        {
            ;;MsgBox "Color number " A_Index " is " A_LoopField
            ;; A_LoopField
             ;;cerco l'ultimo \
            FoundPos := InStr(A_LoopField, "\", false, -1 )            
            NewStr := SubStr(A_LoopField, FoundPos+1)
            strB := strB '`n' '""' NewStr '""' 
                    
                    ;;msgbox %strB%
        }
   
        ;;strA := strReplace(strB, "`n' , '""`n""')        
        
        strA := strReplace(strB, '""""' , '')
        
        strA := strReplace(strA, '`n' , ' ')  
        
        strA := "whisper --language Italian " strA    
        
    
    
    } else if (strIncA = "109") {        
        ;; sostituisci il doppio accapo con un accapo solo
        strA := strReplace(strA, '`n`n' , '`n')    
    
    
 
    
    } else {
        ;; MsgBox Nessuna opzione valida selezionata.
    }    
    



    neutron.qs("#elm_textarea").value := strA


}

























;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
;funzioni condivise
;-------------------------------------------------------------------------------------------------
data_ora_adesso()
{
    TimeStringData := FormatTime(, "yyMMdd")
    TimeStringOra := FormatTime(, "HHmmss")
    TimeString := TimeStringData "_" TimeStringOra
    return TimeString
}
;-------------------------------------------------------------------------------------------------

;-------------------------------------------------------------------------------------------------
notifica_sonora()
{
	;SoundBeep 1250, 100
    SoundBeep 750, 100
}
;-------------------------------------------------------------------------------------------------
