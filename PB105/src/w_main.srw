$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_2 from commandbutton within w_main
end type
type rb_veryfast from radiobutton within w_main
end type
type rb_fast from radiobutton within w_main
end type
type rb_normal from radiobutton within w_main
end type
type rb_slow from radiobutton within w_main
end type
type rb_veryslow from radiobutton within w_main
end type
type st_1 from statictext within w_main
end type
type sle_1 from singlelineedit within w_main
end type
type cb_1 from commandbutton within w_main
end type
type gb_1 from groupbox within w_main
end type
end forward

global type w_main from window
integer x = 1056
integer y = 484
integer width = 1568
integer height = 828
boolean titlebar = true
string title = "Notifications Window Object"
boolean controlmenu = true
boolean minbox = true
long backcolor = 80269524
cb_2 cb_2
rb_veryfast rb_veryfast
rb_fast rb_fast
rb_normal rb_normal
rb_slow rb_slow
rb_veryslow rb_veryslow
st_1 st_1
sle_1 sle_1
cb_1 cb_1
gb_1 gb_1
end type
global w_main w_main

type variables
nvo_notifications inv_notifications
end variables

on w_main.create
this.cb_2=create cb_2
this.rb_veryfast=create rb_veryfast
this.rb_fast=create rb_fast
this.rb_normal=create rb_normal
this.rb_slow=create rb_slow
this.rb_veryslow=create rb_veryslow
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.rb_veryfast,&
this.rb_fast,&
this.rb_normal,&
this.rb_slow,&
this.rb_veryslow,&
this.st_1,&
this.sle_1,&
this.cb_1,&
this.gb_1}
end on

on w_main.destroy
destroy(this.cb_2)
destroy(this.rb_veryfast)
destroy(this.rb_fast)
destroy(this.rb_normal)
destroy(this.rb_slow)
destroy(this.rb_veryslow)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_main
integer x = 878
integer y = 576
integer width = 553
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Glide in message"
end type

event clicked;If IsValid( inv_notifications ) Then
	inv_notifications.of_GlideIn( )
End If


end event

type rb_veryfast from radiobutton within w_main
integer x = 622
integer y = 384
integer width = 375
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Very Fast"
boolean checked = true
end type

type rb_fast from radiobutton within w_main
integer x = 242
integer y = 384
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fast"
end type

type rb_normal from radiobutton within w_main
integer x = 987
integer y = 288
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Normal"
end type

type rb_slow from radiobutton within w_main
integer x = 622
integer y = 288
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Slow"
end type

type rb_veryslow from radiobutton within w_main
integer x = 242
integer y = 280
integer width = 343
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Very slow"
end type

type st_1 from statictext within w_main
integer x = 27
integer y = 40
integer width = 274
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Message:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_main
integer x = 320
integer y = 32
integer width = 1115
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Programmingmethodsit.com"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_main
integer x = 110
integer y = 576
integer width = 553
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Glide out message"
end type

event clicked;Integer li_speed

If Not IsValid( inv_notifications ) Then
	inv_notifications = Create nvo_notifications
End If


If rb_veryslow.Checked Then
	li_speed = inv_notifications.VERYSLOW
ElseIf rb_slow.Checked Then
	li_speed = inv_notifications.SLOW
ElseIf rb_normal.Checked Then
	li_speed = inv_notifications.NORMAL
ElseIf rb_fast.Checked Then
	li_speed = inv_notifications.FAST
ElseIf rb_veryfast.Checked Then
	li_speed = inv_notifications.VERYFAST
End If

inv_notifications.of_GlideOut( sle_1.Text, li_speed )


end event

type gb_1 from groupbox within w_main
integer x = 183
integer y = 192
integer width = 1243
integer height = 320
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gliding speed"
end type

