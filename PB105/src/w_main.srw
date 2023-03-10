$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type st_icon from statictext within w_main
end type
type st_sleep from statictext within w_main
end type
type st_msg from statictext within w_main
end type
type st_name from statictext within w_main
end type
type cb_show from commandbutton within w_main
end type
type em_sleep from editmask within w_main
end type
type ddplb_icon from dropdownpicturelistbox within w_main
end type
type sle_msg from singlelineedit within w_main
end type
type sle_name from singlelineedit within w_main
end type
end forward

global type w_main from window
integer width = 2318
integer height = 748
boolean titlebar = true
string title = "Toast Notification~'s Utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_icon st_icon
st_sleep st_sleep
st_msg st_msg
st_name st_name
cb_show cb_show
em_sleep em_sleep
ddplb_icon ddplb_icon
sle_msg sle_msg
sle_name sle_name
end type
global w_main w_main

type variables
n_cst_systemtray in_systemtray
n_cst_systemtray_callback in_callback

end variables
forward prototypes
public subroutine wf_set_notification_message (string as_title, string as_msg, icon a_icon, integer ai_messageboxtimeout)
end prototypes

public subroutine wf_set_notification_message (string as_title, string as_msg, icon a_icon, integer ai_messageboxtimeout);n_cst_systemtray_shared ln_shared1

SharedObjectRegister("n_cst_systemtray_shared","thread1")
SharedObjectGet("thread1", ln_shared1)


//If there is a Notification on the screen, I delete it.
If in_systemtray.of_get_systemtray_active() = True Then
	in_systemtray.of_delete_from_systemtray (This, False )
End If

in_systemtray.of_add_to_systemtray (This )
in_systemtray.of_set_notification_message (This, as_title, as_msg, a_icon)

//We use a Shared Object to be able to remove the notification after a few seconds in a different thread
ln_shared1.Post  of_delete_from_systemtray ( ai_MessageBoxTimeout, in_callback )

SharedObjectUnRegister("thread1")

end subroutine

on w_main.create
this.st_icon=create st_icon
this.st_sleep=create st_sleep
this.st_msg=create st_msg
this.st_name=create st_name
this.cb_show=create cb_show
this.em_sleep=create em_sleep
this.ddplb_icon=create ddplb_icon
this.sle_msg=create sle_msg
this.sle_name=create sle_name
this.Control[]={this.st_icon,&
this.st_sleep,&
this.st_msg,&
this.st_name,&
this.cb_show,&
this.em_sleep,&
this.ddplb_icon,&
this.sle_msg,&
this.sle_name}
end on

on w_main.destroy
destroy(this.st_icon)
destroy(this.st_sleep)
destroy(this.st_msg)
destroy(this.st_name)
destroy(this.cb_show)
destroy(this.em_sleep)
destroy(this.ddplb_icon)
destroy(this.sle_msg)
destroy(this.sle_name)
end on

event open;
// For notification handling
in_systemtray	 = 	Create  n_cst_systemtray
in_callback = Create n_cst_systemtray_callback
in_callback.of_register(this)

ddplb_icon.SelectItem(2)


end event

event closequery;If in_systemtray.of_get_systemtray_active() = True Then
	in_systemtray.of_delete_from_systemtray (This, False )
End If
Destroy in_systemtray
Destroy in_callback


end event

type st_icon from statictext within w_main
integer x = 91
integer y = 324
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Icon"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_sleep from statictext within w_main
integer x = 1591
integer y = 332
integer width = 311
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show Time"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_msg from statictext within w_main
integer x = 91
integer y = 196
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Message"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_name from statictext within w_main
integer x = 91
integer y = 68
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Title"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_show from commandbutton within w_main
integer x = 1550
integer y = 460
integer width = 576
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Show Notification"
end type

event clicked;String		ls_name				
String		ls_msg			
Int			li_sleep			
icon le_icon
Time lt_time1, lt_time2

ls_name			=	sle_name.text
ls_msg			=	sle_msg.text
li_sleep			=	integer(em_sleep.text)

CHOOSE CASE ddplb_icon.text
	CASE "StopSign"
		le_icon = StopSign!
	CASE "Information"
		le_icon = Information!
	CASE "None"
		le_icon = None!
	CASE "Exclamation"
		le_icon = Exclamation!
END CHOOSE

wf_set_notification_message (ls_name, ls_msg, le_icon, li_sleep)			

end event

type em_sleep from editmask within w_main
integer x = 1943
integer y = 324
integer width = 174
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "5"
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
string minmax = "0~~10"
end type

type ddplb_icon from dropdownpicturelistbox within w_main
integer x = 421
integer y = 324
integer width = 558
integer height = 400
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string item[] = {"StopSign","Information","None","Exclamation"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2,3,4}
string picturename[] = {"StopSign!","Information!","NotFound!","Exclamation!"}
long picturemaskcolor = 536870912
end type

type sle_msg from singlelineedit within w_main
integer x = 411
integer y = 180
integer width = 1705
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "This is a notification message..."
borderstyle borderstyle = stylelowered!
end type

type sle_name from singlelineedit within w_main
integer x = 411
integer y = 48
integer width = 1705
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Title Notification"
borderstyle borderstyle = stylelowered!
end type

