$PBExportHeader$w_notifications.srw
forward
global type w_notifications from window
end type
type st_1 from statictext within w_notifications
end type
type gb_1 from groupbox within w_notifications
end type
end forward

global type w_notifications from window
integer x = 1056
integer y = 484
integer width = 896
integer height = 444
boolean titlebar = true
string title = "Warning"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 80269524
boolean palettewindow = true
st_1 st_1
gb_1 gb_1
end type
global w_notifications w_notifications

forward prototypes
public function integer of_settext (string as)
end prototypes

public function integer of_settext (string as);//====================================================================
// Function: w_notifications.of_settext()
//--------------------------------------------------------------------
// Description: Set text
//--------------------------------------------------------------------
// Arguments:
// 	string	as	
//--------------------------------------------------------------------
// Returns:  integer, -1 = failure, 0  = no action, 1  = success 
//--------------------------------------------------------------------
// Author:	PB.BaoGa		Date: 2021/05/28
//--------------------------------------------------------------------
// Usage: w_notifications.of_settext ( string as )
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


st_1.Text = as

Return 1

end function

on w_notifications.create
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.gb_1}
end on

on w_notifications.destroy
destroy(this.st_1)
destroy(this.gb_1)
end on

type st_1 from statictext within w_notifications
integer x = 50
integer y = 56
integer width = 773
integer height = 272
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_notifications
integer width = 859
integer height = 368
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 80269524
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

